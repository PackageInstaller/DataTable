--[[ 
-----------------------------------------------------
@filename       : CovenantTalentPanel
@Description    : 盟约天赋
@date           : 2021-06-16 10:13:32
@Author         : Jacob
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]]
module('game.covenantTalent.view.CovenantTalentPanel', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenantTalent/CovenantTalentPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

--构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(750, 600)
    self:setBg("covenantTalentBg.jpg", false, "covenantTalent")
end
--析构  
function dtor(self)
end

function initData(self)
    self.mHelperId = 101

    self.mHelperItemData = {}
    self.mSchemeItemList = {}
end

-- 初始化
function configUI(self)
    self.mGroupHelper = self:getChildTrans("mGroupHelper")

    self.mGroupScheme = self:getChildTrans("mGroupScheme")
    self.mBtnReset = self:getChildGO("mBtnReset")
    self.mScrollRect = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    self.mImgCostProps1 = self:getChildGO("mImgCostProps1"):GetComponent(ty.AutoRefImage)
    self.mTxtGeneLab = self:getChildGO("mTxtGeneLab"):GetComponent(ty.Text)
    self.mTxtGeneRemaid = self:getChildGO("mTxtGeneRemaid"):GetComponent(ty.Text)
    self.mTxtGeneCount = self:getChildGO("mTxtGeneCount"):GetComponent(ty.Text)
    self.mTxtGeneUsed = self:getChildGO("mTxtGeneUsed"):GetComponent(ty.Text)
    self.mTxtLimit = self:getChildGO("mTxtLimit"):GetComponent(ty.Text)

    self.mGroupTips = self:getChildGO("mGroupTips")
    self.mGroupGeneTips = self:getChildTrans("mGroupGeneTips")
    self.mImgGeneLock = self:getChildGO("mImgGeneLock")
    self.mImgGeneIcon = self:getChildGO("mImgGeneIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtGeneName = self:getChildGO("mTxtGeneName"):GetComponent(ty.Text)
    self.mTxtGeneLvl = self:getChildGO("mTxtGeneLvl"):GetComponent(ty.Text)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)
    self.mBtnActive = self:getChildGO("mBtnActive")
    self.mBtnLvUp = self:getChildGO("mBtnLvUp")
    self.mTxtGeneUnlock = self:getChildGO("mTxtGeneUnlock"):GetComponent(ty.Text)
    self.mGroupFunc = self:getChildGO("mGroupFunc")
    self.mImgMaxLv = self:getChildGO("mImgMaxLv")
    self.mTxtGeneCostLab = self:getChildGO("mTxtGeneCostLab"):GetComponent(ty.Text)
    self.mTxtGeneCost = self:getChildGO("mTxtGeneCost"):GetComponent(ty.Text)
    self.mImgCostProps = self:getChildGO("mImgCostProps"):GetComponent(ty.AutoRefImage)
    self.mImgActivating = self:getChildGO("mImgActivating")
    self.mTxtActivating = self:getChildGO("mTxtActivating"):GetComponent(ty.Text)

    self.mGroupCost = self:getChildGO("mGroupCost")
    self.mImgMoneyIcon = self:getChildGO("mImgMoneyIcon"):GetComponent(ty.AutoRefImage)
    self.mTxtMoneyCost = self:getChildGO("mTxtMoneyCost"):GetComponent(ty.Text)

    self.mGroupOrderTips = self:getChildTrans("mGroupOrderTips")
    self.mTxtOrderName = self:getChildGO("mTxtOrderName"):GetComponent(ty.Text)
    self.mTxtOrderUnlock = self:getChildGO("mTxtOrderUnlock"):GetComponent(ty.Text)
end

--激活
function active(self, args)
    super.active(self, args)
    MoneyManager:setMoneyTidList({ MoneyTid.GOLD_COIN_TID, MoneyTid.COVENANT_GENE_POINT_TID })

    GameDispatcher:dispatchEvent(EventName.REQ_ALL_HELPER_GENE_INFO)

    -- covenantTalent.CovenantTalentManager:addEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_BAG_EQUIP_SELECT, self.onEquipListSelectHandler, self)
    covenantTalent.CovenantTalentManager:addEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_HELPER_GENE_UPDATE, self.onGeneUpdateHandler, self)
    covenant.CovenantManager:addEventListener(covenant.CovenantManager.EVENT_FORCES_UPDATE, self.updateRemaidGeneNum, self)
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onMoneyChange, self)

    local helperIdList = covenant.CovenantManager:getHelperIdList()
    self.mHelperId = args and args.helperId or helperIdList[1]
    self:updateHelperList()
    self:updateSchemeView()
    self:updateRemaidGeneNum()

    self.mImgCostProps:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.PLAYER_HELPER_EXP_TID), true)
    self.mImgCostProps1:SetImg(MoneyUtil.getMoneyIconUrlByTid(MoneyTid.PLAYER_HELPER_EXP_TID), true)
end

--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    MoneyManager:setMoneyTidList()
    -- covenantTalent.CovenantTalentManager:removeEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_BAG_EQUIP_SELECT, self.onEquipListSelectHandler, self)
    covenantTalent.CovenantTalentManager:removeEventListener(covenantTalent.CovenantTalentManager.COVENANT_TALENT_HELPER_GENE_UPDATE, self.onGeneUpdateHandler, self)
    covenant.CovenantManager:removeEventListener(covenant.CovenantManager.EVENT_FORCES_UPDATE, self.updateRemaidGeneNum, self)
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onMoneyChange, self)
    self:recoverListItem()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    self.mTxtGeneCostLab.text = _TT(29509)--"基因参数消耗："
    self.mTxtGeneLab.text = _TT(29510)--"基因参数"
    self.mTxtGeneRemaid.text = _TT(29511)--"剩余"
    self.mTxtLimit.text = _TT(29512)--"单个助手最多可使用40点基因参数"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnReset, self.onReset)
    self:addUIEvent(self.mGroupTips, self.closeTips)
    self:addUIEvent(self.mBtnActive, self.onActiveGene)
    self:addUIEvent(self.mBtnLvUp, self.onGeneLvUp)
end

function onMoneyChange(self)
    self:updateRemaidGeneNum()
end

-- 激活基因格子
function onActiveGene(self)
    GameDispatcher:dispatchEvent(EventName.REQ_ACTIVE_GROOVE, { helperId = self.mHelperId, grooveId = self.mBaseVo.id })
end
function onGeneLvUp(self)
    local isMaxLvl = covenantTalent.CovenantTalentManager:getGeneLvlIsMax(self.mHelperId, self.mBaseVo.id)
    if isMaxLvl then
        -- gs.Message.Show("已满级")
        gs.Message.Show(_TT(29513))
    else

        local geneData = covenantTalent.CovenantTalentManager:getGeneData(self.mHelperId, self.mBaseVo.id)
        local costData = self.mBaseVo:getSkillLvCost(geneData.lvl)

        if costData.gene > covenant.CovenantManager.remainGeneNum then
            -- gs.Message.Show("基因参数不足")
            gs.Message.Show(_TT(29514))
            return
        end
        if not MoneyUtil.judgeNeedMoneyCountByTid(costData.payId, costData.payNum, false, true) then
            return
        end
        GameDispatcher:dispatchEvent(EventName.REQ_GENE_LVL_UP, { helperId = self.mHelperId, grooveId = self.mBaseVo.id })
    end
end

-- 重置
function onReset(self)
    GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_TALENT_RESET, { helperId = self.mHelperId })
end

function onGeneUpdateHandler(self)
    self:updateSchemeView()
    if self.mBaseVo then
        self:onShowTalentInfo(self.mBaseVo)
    end
end

function updateHelperList(self)
    self:recoverListItem()
    local helperIdList = covenant.CovenantManager:getHelperIdList()
    for i, v in ipairs(helperIdList) do
        local item = SimpleInsItem:create(self:getChildGO("GroupHelperItem"), self.mGroupHelper, "CovenantTalentPanelHelperItem")
        item:getChildGO("mImgHelper"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getIconPath(string.format("helper/helperBody/helper_body_%s.png", v)), false)
        if i == 1 then
            self.mHelperItem = item
            item:getChildGO("mImgHelperSelect"):SetActive(true)
        else
            item:getChildGO("mImgHelperSelect"):SetActive(false)
        end
        item:addUIEvent("mGroupClick", function()
            self:onHelperSelect(v, item)
        end)
        self.mHelperItemData[i] = item
    end
end

function onHelperSelect(self, helperId, item)
    if self.mHelperItem then
        self.mHelperItem:getChildGO("mImgHelperSelect"):SetActive(false)
    end
    self.mHelperItem = item
    self.mHelperItem:getChildGO("mImgHelperSelect"):SetActive(true)
    self.mHelperId = helperId
    self.mScrollRect.horizontalNormalizedPosition = 0
    self:updateSchemeView()
end

-- 回收项
function recoverListItem(self)
    if self.mHelperItemData then
        for i, v in pairs(self.mHelperItemData) do
            v:poolRecover()
        end
    end
    self.mHelperItemData = {}
end

-- 更新基因参数数量
function updateRemaidGeneNum(self)
    local helperInfo = covenantTalent.CovenantTalentManager:getHelperInfo(self.mHelperId)
    if not helperInfo then
        return
    end
    self.mTxtGeneCount.text = covenant.CovenantManager.remainGeneNum
    -- self.mTxtGeneUsed.text = string.format("(已使用%s)", helperInfo.usedPoint)
    self.mTxtGeneUsed.text = _TT(29515, helperInfo.usedPoint)

    if helperInfo.usedPoint > 0 then
        self.mBtnReset:SetActive(true)
    else
        self.mBtnReset:SetActive(false)
    end

end

function updateSchemeView(self)
    self:recoverSchemeView()
    self:updateRemaidGeneNum()

    local upType = { 2, 6, 9, 11, 13, 15 }
    local downType = { 4, 7, 10, 12, 14, 16 }
    local baseData = covenantTalent.CovenantTalentManager:getTalentColData(self.mHelperId)
    local baseList = {}
    for k, v in pairs(baseData) do
        local data = { sort = k, list = v }
        table.insert(baseList, data)
    end
    table.sort(baseList, function(a, b)
        return a.sort < b.sort
    end)
    local index = 1
    for _, data in ipairs(baseList) do
        for i, v in ipairs(data.list) do
            local covenantTalentBaseVo = v
            local item = covenantTalent.CovenantTalentGeneItem:poolGet()
            item:setData(self.mGroupScheme, self.mHelperId, covenantTalentBaseVo)
            item:addEventListener(item.EVENT_SHOW_TALENT, self.onShowTalentInfo, self)
            local offY = 0
            offY = table.indexof(upType, covenantTalentBaseVo.style) ~= false and 97 or 0
            if offY == 0 then
                offY = table.indexof(downType, covenantTalentBaseVo.style) ~= false and -95 or 0
            end
            item:setPosition(50 + 174 * (index - 1), -150 + offY, 0)
            table.insert(self.mSchemeItemList, item)
        end
        index = index + 1
    end

    local item = self.mSchemeItemList[#self.mSchemeItemList]
    local w = item.UITrans.anchoredPosition.x + 100 + 640
    gs.TransQuick:SizeDelta01(self.mGroupScheme, w)
end
function recoverSchemeView(self)
    for i = 1, #self.mSchemeItemList do
        local item = self.mSchemeItemList[i]
        item:removeEventListener(item.EVENT_SHOW_TALENT, self.onShowTalentInfo, self)
        item:poolRecover()
    end
    self.mSchemeItemList = {}
end

function closeTips(self)
    self:showGeneTips()
    self:showOrderTips()
end

function showGeneTips(self, isShow)
    if isShow then
        self.mGroupTips:SetActive(true)
        self.mGroupGeneTips.gameObject:SetActive(true)
        TweenFactory:canvasGroupAlphaTo(self.mGroupGeneTips:GetComponent(ty.CanvasGroup), 0, 1, 0.2, gs.DT.Ease.Linear)
        TweenFactory:scaleTo(self.mGroupGeneTips, { x = 1.05, y = 1.05, z = 1.05 }, { x = 1, y = 1, z = 1 }, 0.4, gs.DT.Ease.Linear)
    else
        self.mGroupTips:SetActive(false)
        self.mGroupGeneTips.gameObject:SetActive(false)
        TweenFactory:scaleTo(self.mGroupGeneTips, { x = 1.1, y = 1.1, z = 1.1 }, { x = 1, y = 1, z = 1 }, 0.2, gs.DT.Ease.Linear)
        self.mBaseVo = nil
    end
end

function showOrderTips(self, isShow)
    if isShow then
        self.mGroupTips:SetActive(true)
        self.mGroupOrderTips.gameObject:SetActive(true)
        TweenFactory:canvasGroupAlphaTo(self.mGroupOrderTips:GetComponent(ty.CanvasGroup), 0, 1, 0.2, gs.DT.Ease.Linear)
        TweenFactory:scaleTo(self.mGroupOrderTips, { x = 1.05, y = 1.05, z = 1.05 }, { x = 1, y = 1, z = 1 }, 0.4, gs.DT.Ease.Linear)
    else
        self.mGroupTips:SetActive(false)
        self.mGroupOrderTips.gameObject:SetActive(false)
        TweenFactory:scaleTo(self.mGroupOrderTips, { x = 1.1, y = 1.1, z = 1.1 }, { x = 1, y = 1, z = 1 }, 0.2, gs.DT.Ease.Linear)
    end
end

function onShowTalentInfo(self, cusData)

    self.mBaseVo = cusData

    for i, item in ipairs(self.mSchemeItemList) do
        if item:getData().id == cusData.id then
            item:setSelectState(true)
        else
            item:setSelectState(false)
        end
    end

    self.mTxtGeneName.text = ""

    local geneData = covenantTalent.CovenantTalentManager:getGeneData(self.mHelperId, cusData.id)
    if covenantTalent.CovenantTalentManager:isOrderType(cusData.type) then
        -- 凹槽
        if geneData then
            GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_BAG_PANEL, { helperId = self.mHelperId, subType = cusData.type, slotPos = cusData.id })
            self.mBaseVo = nil
        else
            local grooveName = {}
            grooveName[2] = _TT(29516) --"攻击序列物凹槽"
            grooveName[3] = _TT(29517) -- "防御序列物凹槽"
            grooveName[4] = _TT(29518) --"效果序列物凹槽"
            self.mTxtOrderName.text = grooveName[self.mBaseVo.type]
            -- self.mTxtOrderUnlock.text = string.format("解锁条件:声望等阶%s阶", cusData.needPrestige)
            self.mTxtOrderUnlock.text = _TT(29519, cusData.needPrestige)
            self:showOrderTips(true)
        end

    else
        local skillVo = fight.SkillManager:getSkillRo(cusData.type)
        self.mTxtGeneName.text = skillVo:getName()
        self.mImgGeneIcon:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
        if #geneData.showValues > 0 then
            local list = {}
            for i, v in ipairs(geneData.showValues) do
                table.insert(list, v / 100)
            end
            self.mTxtSkill.text = string.substituteArr(skillVo:getDesc(), list)
        else
            self.mTxtSkill.text = string.substituteArr(skillVo:getDesc(), cusData:getSkillLvAttrs(geneData.lvl))
        end

        -- 基因
        if geneData and geneData.isUnLock == 1 then
            if covenantTalent.CovenantTalentManager:getGeneLvlIsMax(self.mHelperId, cusData.id) then
                self.mGroupFunc:SetActive(false)
                self.mImgMaxLv:SetActive(true)
            else
                self.mGroupFunc:SetActive(true)
                self.mImgMaxLv:SetActive(false)
            end
            self.mTxtGeneUnlock.text = ""

            local costData = cusData:getSkillLvCost(geneData.lvl)
            -- 升级消耗
            self.mTxtGeneCost.text = costData.gene
            self.mTxtGeneCost.color = gs.ColorUtil.GetColor((costData.gene < covenant.CovenantManager.remainGeneNum) and "000000FF" or "ed1941FF")
            -- 等级
            local maxLv = covenantTalent.CovenantTalentManager:getGeneMaxLvl(self.mHelperId, cusData.id)
            -- self.mTxtGeneLvl.text = string.format("LV.%s/%s", geneData.lvl, maxLv)
            self.mTxtGeneLvl.text = _TT(29520, geneData.lvl, maxLv)

            self.mImgMoneyIcon:SetImg(MoneyUtil.getMoneyIconUrlByTid(costData.payId), true)
            self.mTxtMoneyCost.text = costData.payNum
            self.mTxtMoneyCost.color = gs.ColorUtil.GetColor(MoneyUtil.judgeNeedMoneyCountByTid(costData.payId, costData.payNum, false, false) and "000000FF" or "ed1941FF")
            self.mGroupCost:GetComponent(ty.ContentSizeFitter):SetLayoutHorizontal()
            gs.LayoutRebuilder.ForceRebuildLayoutImmediate(self.mGroupCost.transform) --立即刷新

            -- local list = geneData.showValues
            -- self.mTxtSkill.text = string.substituteArr(skillVo:getDesc(), list)
            if geneData.isActive == 1 then
                self.mImgActivating:SetActive(true)
                self.mBtnActive:SetActive(false)
                self.mImgGeneLock:SetActive(false)
                self.mImgGeneIcon:GetComponent(ty.CanvasGroup).alpha = 1
            else
                self.mImgActivating:SetActive(false)
                self.mBtnActive:SetActive(true)
                self.mImgGeneLock:SetActive(true)
                self.mImgGeneIcon:GetComponent(ty.CanvasGroup).alpha = 0.3
            end
        else

            local maxLv = covenantTalent.CovenantTalentManager:getGeneMaxLvl(self.mHelperId, cusData.id)
            -- self.mTxtGeneLvl.text = string.format("LV.%s/%s", 1, maxLv)
            self.mTxtGeneLvl.text = _TT(29520, 1, maxLv)

            -- self.mTxtGeneUnlock.text = string.format("解锁条件:声望等阶%s阶", cusData.needPrestige)
            self.mTxtGeneUnlock.text = _TT(29519, cusData.needPrestige)
            self.mGroupFunc:SetActive(false)
            self.mImgGeneLock:SetActive(true)
            self.mImgMaxLv:SetActive(false)
            self.mImgActivating:SetActive(false)
            self.mBtnActive:SetActive(false)
            self.mImgGeneIcon:GetComponent(ty.CanvasGroup).alpha = 0.3
        end

        self:showGeneTips(true)
    end
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
