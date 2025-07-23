--[[ 
-----------------------------------------------------
@filename       : CovenantSkillPanel
@Description    : 盟约技能界面
@Author         : sxt
@GM             : GameDispatcher:dispatchEvent(EventName.OPEN_COVENANT_SKILL_PANEL)
@copyright      : (LY) 2021 雷焰网络
-----------------------------------------------------
]] module("covenant.CovenantSkillPanel", Class.impl(View))

-- 对应的ui文件
UIRes = UrlManager:getUIPrefabPath("covenant/CovenantSkillPanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isScreensave = 0

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setSize(2048,1200)
    self:setTxtTitle(_TT(29565))
    self:setBg("covenant_skill.jpg", false, "covenant")
end

-- 析构
function dtor(self)
end

function initData(self)
    self.mPrestigeItems = {}
    self.mSkillItems = {}
    self.mSkillItemList = {}
    self.mLockItems = {}
    self.mneedSkillItem = {}
    self.costItem = nil
    self.showVo = nil
    self.mScamera = nil
    self.mDelayUpdate = {}
    self.mDelayItemState = nil
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mSelectInfo = self:getChildGO("mSelectInfo")
    self.mTxtSelectSkillName = self:getChildGO("mTxtSelectSkillName"):GetComponent(ty.Text)
    self.mTxtSelectSkillLv = self:getChildGO("mTxtSelectSkillLv"):GetComponent(ty.Text)
    self.mSelectSkillNode = self:getChildGO("mSelectSkillNode"):GetComponent(ty.AutoRefImage)

    self.mTxtCurrentInfo = self:getChildGO("mTxtCurrentInfo"):GetComponent(ty.Text)
    self.mTxtCurrentDes = self:getChildGO("mTxtCurrentDes"):GetComponent(ty.Text)

    self.mTxtNextInfo = self:getChildGO("mTxtNextInfo"):GetComponent(ty.Text)
    self.mTxtNextDes = self:getChildGO("mTxtNextDes"):GetComponent(ty.Text)

    -- =============================未解锁=============================
    self.mLockInfo = self:getChildGO("mLockInfo")
    self.mTxtLock = self:getChildGO("mTxtLock"):GetComponent(ty.Text)
    self.mScrollUnLock = self:getChildGO("mScrollUnLock"):GetComponent(ty.ScrollRect)
    -- =============================解锁了=============================
    self.mUnLockInfo = self:getChildGO("mUnLockInfo")

    -- self.mTxtConstDes = self:getChildGO("mTxtConstDes"):GetComponent(ty.Text)
    self.mGroupBotBg = self:getChildGO("mGroupBotBg")
    self.mNodeProp = self:getChildTrans("mNodeProp")
    -- self.mTxtConstProp = self:getChildGO("mTxtConstProp"):GetComponent(ty.Text)

    self.mBtnLvUp = self:getChildGO("mBtnLvUp")
    self.mTxtLvUp = self:getChildGO("mTxtLvUp"):GetComponent(ty.Text)
    self.mImgCost = self:getChildGO("mImgCost"):GetComponent(ty.AutoRefImage)
    self.mTxtCost = self:getChildGO("mTxtCost"):GetComponent(ty.Text)
    -- =============================最大等级=============================
    self.mMaxInfo = self:getChildGO("mMaxInfo")
    self.mTxtMax = self:getChildGO("mTxtMax"):GetComponent(ty.Text)
    self.mScrollPrestige = self:getChildGO("mScrollPrestige"):GetComponent(ty.ScrollRect)
    -- =============================item=============================
    self.mSinglePrestigeItem = self:getChildGO("mSinglePrestigeItem")
    self.mSingleSkillItem = self:getChildGO("mSingleSkillItem")
    self.mSingleLockItem = self:getChildGO("mSingleLockItem")

    self.mGroupLine = self:getChildTrans("mGroupLine")

    self.mSelectInfo:SetActive(false)
    self.mScamera = gs.CameraMgr:GetSceneCamera().gameObject

    self:setGuideTrans("funcTips_covenant_skill", self:getChildTrans("mFunctionTips_skill"))
end

-- 激活
function active(self)
    super.active(self)
    self.mScamera:SetActive(false)
    MoneyManager:setMoneyTidList({MoneyTid.GOLD_COIN_TID, MoneyTid.COVENANT_GENE_POINT_TID})
    role.RoleManager:getRoleVo():addEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onUpdatePanel, self)
    GameDispatcher:addEventListener(EventName.UPDATE_COVENANTSKILL_PANEL, self.onUpdatePanel, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID },1)
    self:showView()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self.mScamera:SetActive(true)
    self.mScamera = nil
    MoneyManager:setMoneyTidList()
    role.RoleManager:getRoleVo():removeEventListener(role.RoleVo.CHANGE_PLAYER_MONEY, self.onUpdatePanel, self)
    GameDispatcher:removeEventListener(EventName.UPDATE_COVENANTSKILL_PANEL, self.onUpdatePanel, self)
    MoneyManager:setMoneyTidList({ MoneyTid.ANTIEPIDEMIC_SERUM_TID, MoneyTid.ITIANIUM_TID, MoneyTid.GOLD_COIN_TID },2)
    self:clearAllItems()
    self:removeAllDelay()
end

function removeAllDelay(self)
    for k,v in pairs(self.mDelayUpdate) do
        LoopManager:removeFrameByIndex(v)
    end
    self.mDelayUpdate = {}
    if (self.mDelayItemState) then
        LoopManager:removeFrameByIndex(self.mDelayItemState)
        self.mDelayItemState = nil
    end
end

function onUpdatePanel(self)
    self:updateItemSate()
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    self.mTxtCurrentInfo.text = _TT(29534)--"当前效果"
    self.mTxtNextInfo.text = _TT(29535)--"下级效果"
    self.mTxtLock.text = _TT(29536)--"解锁条件"
    self.mTxtLvUp.text = _TT(1040)--"升级"
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnLvUp, self.onLvlUpClick)
end

function getAdaptWidth(self)
    local posGap = 30;
    local screenW, _ = ScreenUtil:getRealSize()
    local screenGap = 1624 - screenW;
    local screenScale = screenGap <= 0 and 0 or screenGap / (1624 - 1334);
    screenScale = math.min(screenScale, 1);
    return posGap * screenScale
end

function showView(self)
    self.currentPrestige = covenant.CovenantManager:getPerstigeStage()
    local talentData = covenant.CovenantManager:getForcesTalentAllData()
    self:clearAllItems()
    local temp = 1
    for line, data in pairs(talentData) do
        local function addItem()
            local item = SimpleInsItem:create(self.mSinglePrestigeItem, self.mScrollPrestige.content, "CovenantSkillPanelmSinglePrestigeItem")
            local text = data[1].needStage
            if(text < 10) then 
                text = "0"..text
            end
            item:getChildGO("mTxtPrestige"):GetComponent(ty.Text).text = text 
            item:getChildGO("mTxt1"):GetComponent(ty.Text).text = _TT(29537)--"阶声望"
            for i = 1, #data do
                local col = data[i].column
                local tran = item:getChildTrans("mSingleSkillContent")
                local skillItem = SimpleInsItem:create(self.mSingleSkillItem, tran, "CovenantSkillPanelmSingleSkillItem")
                --(140 - self:getAdaptWidth())
                skillItem:setPos(col * (140 - 11) , -48)
                skillItem:getTrans().name = "mSingleSkillItem" .. data[i].id
                local skillVo = fight.SkillManager:getSkillRo(data[i].skillId)
                local skillNode = skillItem:getChildGO("mSkillNode"):GetComponent(ty.AutoRefImage)
                skillNode:SetImg(UrlManager:getSkillIconPath(skillVo:getIcon()), false)
                
                local function clickSkillItemFun()
                    self:updateSelectedSkillInfo(data[i])
                end
                skillItem:addUIEvent("mBtnClick", clickSkillItemFun)
                self.mSkillItems[data[i].id] = skillItem
                table.insert(self.mSkillItemList,{item = skillItem,data = data[i]})
            end
            table.insert(self.mPrestigeItems, item)
            if (self.mDelayUpdate[temp]) then
                LoopManager:removeFrameByIndex(self.mDelayUpdate[temp])
                self.mDelayUpdate[temp] = nil
            end
        end
        self.mDelayUpdate[temp] = LoopManager:addFrame(temp, 1, self, addItem)
        temp = temp + 1 
    end
    self.mDelayItemState = LoopManager:addFrame(temp, 1, self, self.updateItemSate)
end

function updateItemSate(self)
    for k, v in pairs(self.mSkillItemList) do
        self:updateSingleSkillItem(v)
    end
    local childCount = self.mScrollPrestige.content.childCount
    -- self.mGroupLine:SetSiblingIndex(childCount - 1)
    --默认选中第一个
    if self.showVo == nil then
        local defId = sysParam.SysParamManager:getValue(964)
        for k, v in pairs(self.mSkillItemList) do
            if v.data.id == defId then
                self:updateSelectedSkillInfo(v.data)
            end
        end
    else
        self:updateSelectedSkillInfo()
    end

    if (self.mDelayItemState) then
        LoopManager:removeFrameByIndex(self.mDelayItemState)
        self.mDelayItemState = nil
    end
end

function updateSingleSkillItem(self, data)
    local item = data.item 
    local data = data.data
    local serverData = covenant.CovenantManager:getForcesTalentServerData(data.id)
    local lv = 0
    if serverData ~= nil then 
        lv = serverData.level
    end
    local talentVo = covenant.CovenantManager:getForcesTalentData(data.id)
    local maxLv = talentVo:getSkillMaxLv()
    local skillLvTxt = item:getChildGO("mTxtSkillLv"):GetComponent(ty.Text)
    skillLvTxt.text = lv .. "/" .. maxLv

    if #talentVo.needTalent > 0 then
        local needTalentId = talentVo.needTalent[1]
        local needTalentLevel = talentVo.needTalent[2]
        local serverData = covenant.CovenantManager:getForcesTalentServerData(needTalentId)
        data.isLock = talentVo.needStage > self.currentPrestige or needTalentLevel > serverData.level
        -- print(talentVo.needStage..self.currentPrestige.." "..needTalentLevel.." "..serverData.level)
        local needSkillItem = nil
        for i = 1, #self.mSkillItemList do
            if(self.mSkillItemList[i].data.id == needTalentId)then
                needSkillItem = self.mSkillItemList[i]
            end
        end
        if needSkillItem then
            local lineItem = self:getChildGO("mItem"..needTalentId)
            if(lineItem == nil) then
                logError("缺少线段"..needTalent)
            end
            local allLock = lineItem.transform:Find("mAllLock")
            local halfLock = lineItem.transform:Find("mHalfLock")
            local unLock = lineItem.transform:Find("mUnLock")

            if data.isLock then
                if needSkillItem.data.isLock then
                    allLock.gameObject:SetActive(true)
                    halfLock.gameObject:SetActive(false)
                    unLock.gameObject:SetActive(false)
                else
                    allLock.gameObject:SetActive(false)
                    halfLock.gameObject:SetActive(true)
                    unLock.gameObject:SetActive(false)
                end
            else
                allLock.gameObject:SetActive(false)
                halfLock.gameObject:SetActive(false)
                unLock.gameObject:SetActive(true)
            end
        end
    else
        data.isLock = talentVo.needStage > self.currentPrestige
    end

    local showUp = false
    if not data.isLock then 
        item:getChildGO("mSkillNode"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("ffffffff")
        item:getChildGO("mIsLock"):SetActive(false)
        if serverData.level < maxLv then
            local got = MoneyUtil.getMoneyCountByTid(MoneyTid.COVENANT_GENE_POINT_TID)
            local need = talentVo:getCostNum(serverData.level + 1).point   
            if got >= need then
                showUp = true
            end
        end
    else
        item:getChildGO("mSkillNode"):GetComponent(ty.AutoRefImage).color = gs.ColorUtil.GetColor("ffffff4c")
        item:getChildGO("mIsLock"):SetActive(true)
    end
    item:getChildGO("mImgSkillUp"):SetActive(showUp)
end

function updateSelectedSkillInfo(self, skillVo)
    if(skillVo ~= nil) then 
        self.showVo = skillVo
    end

    for k, v in pairs(self.mSkillItems) do
        if k == self.showVo.id then
            v:getChildGO("mIsSelect"):SetActive(true)
        else
            v:getChildGO("mIsSelect"):SetActive(false)
        end
    end

    local skillRo = fight.SkillManager:getSkillRo(self.showVo.skillId)
    local talentVo = covenant.CovenantManager:getForcesTalentData(self.showVo.id)
    local maxLv = talentVo:getSkillMaxLv()

    self.mTxtSelectSkillName.text = skillRo:getName()
    self.mSelectSkillNode:SetImg(UrlManager:getSkillIconPath(skillRo:getIcon()), false)

    local serverSkillData = covenant.CovenantManager:getForcesTalentServerData(self.showVo.id)

    self.mTxtSelectSkillLv.text = serverSkillData.level .. "/" .. maxLv

    self.mGroupBotBg:SetActive(true)
    -- 还没有解锁
    if self.showVo.isLock then
        self.mLockInfo:SetActive(true)
        self.mMaxInfo:SetActive(false)
        self.mUnLockInfo:SetActive(false)
        self:clearLockItem()
        local stageItem = SimpleInsItem:create(self.mSingleLockItem, self.mScrollUnLock.content, "CovenantSkillPanelmSingleLockItem")
        local color1 = "#ffffffff"
        if(talentVo.needStage > self.currentPrestige) then 
            stageItem:getChildGO("mTxtLockDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("888C8Fff")
            stageItem:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("covenant/convenant_techno_8.png"))
            color1 = "#D53529ff"
        else
            stageItem:getChildGO("mTxtLockDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("323232ff")
            stageItem:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("covenant/convenant_techno_7.png"))
            color1 = "#038008ff"
        end
        stageItem:getChildGO("mTxtLockDes"):GetComponent(ty.Text).text = _TT(29538, color1, talentVo.needStage)--"需要达到等阶:<color=#d53529>" .. talentVo.needStage.."</color>"

        table.insert(self.mLockItems, stageItem)

        if #talentVo.needTalent > 0 then
            local needTalentItem = SimpleInsItem:create(self.mSingleLockItem, self.mScrollUnLock.content, "CovenantSkillPanelmSingleLockItem")
            -- 是否满足TODO

            local needTalentId = talentVo.needTalent[1]
            local needTalentLevel = talentVo.needTalent[2]
            local serverData = covenant.CovenantManager:getForcesTalentServerData(needTalentId)
            local color2 = "#ffffffff"
            if(needTalentLevel > serverData.level) then 
                needTalentItem:getChildGO("mTxtLockDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("888C8Fff")
                needTalentItem:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("covenant/convenant_techno_8.png"))
                color2 = "#D53529ff"
            else
                needTalentItem:getChildGO("mTxtLockDes"):GetComponent(ty.Text).color = gs.ColorUtil.GetColor("323232ff")
                needTalentItem:getChildGO("mImgLock"):GetComponent(ty.AutoRefImage):SetImg(UrlManager:getPackPath("covenant/convenant_techno_7.png"))
                color2 = "#038008ff"
            end
            needTalentItem:getChildGO("mTxtLockDes"):GetComponent(ty.Text).text = _TT(29539, color2, talentVo.needTalent[2], fight.SkillManager:getSkillRo(covenant.CovenantManager:getForcesTalentData(talentVo.needTalent[1]).skillId):getName())-- "需要解锁:<color=#d53529>" .. talentVo.needTalent[2] .. "</color>级" .. talentVo.needTalent[1] .. "技能"
            table.insert(self.mLockItems, needTalentItem)
        end

        self.mTxtCurrentInfo.gameObject:SetActive(true)
        self.mTxtNextInfo.gameObject:SetActive(false)

        local list = {}
        for k, v in pairs(serverSkillData.nextShowValue) do
            table.insert(list, v / 100)
        end
        self.mTxtCurrentDes.text = string.substituteArr(skillRo:getDesc(), list)
    else
        self.mLockInfo:SetActive(false)

        if serverSkillData.level == maxLv then
            -- self.mUnLockInfo:SetActive(false)
            self.mGroupBotBg:SetActive(false)
            self.mMaxInfo:SetActive(true)

            -- 满级了 只显示现在等级的
            self.mTxtCurrentInfo.gameObject:SetActive(true)
            self.mTxtNextInfo.gameObject:SetActive(false)

            local list = {}
            for k, v in pairs(serverSkillData.preShowValue) do
                table.insert(list, v / 100)
            end
            self.mTxtCurrentDes.text = string.substituteArr(skillRo:getDesc(), list)
        else
            self.mUnLockInfo:SetActive(true)
            self.mMaxInfo:SetActive(false)

            if serverSkillData.level == 0 then
                self.mTxtCurrentInfo.gameObject:SetActive(true)
                self.mTxtNextInfo.gameObject:SetActive(false)

                local list = {}
                for k, v in pairs(serverSkillData.nextShowValue) do
                    table.insert(list, v / 100)
                end
                self.mTxtCurrentDes.text = string.substituteArr(skillRo:getDesc(), list)
            else
                self.mTxtCurrentInfo.gameObject:SetActive(true)
                self.mTxtNextInfo.gameObject:SetActive(true)

                local currentList = {}
                for k, v in pairs(serverSkillData.preShowValue) do
                    table.insert(currentList, v / 100)
                end
                self.mTxtCurrentDes.text = string.substituteArr(skillRo:getDesc(), currentList)
    
                local nextList = {}
                for k, v in pairs(serverSkillData.nextShowValue) do
                    table.insert(nextList, v / 100)
                end
                self.mTxtNextDes.text = string.substituteArr(skillRo:getDesc(), nextList)
            end

            self.mImgCost:SetImg(MoneyUtil.getMoneyIconUrlByTid(talentVo:getCostNum(serverSkillData.level + 1).payId), true)
            self.mTxtCost.text = talentVo:getCostNum(serverSkillData.level + 1).payNum
            local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(talentVo:getCostNum(serverSkillData.level + 1).payId, talentVo:getCostNum(serverSkillData.level + 1).payNum, false, false)
            if(isEnough) then 
                self.mTxtCost.color = gs.ColorUtil.GetColor("000000ff")
            else
                self.mTxtCost.color = gs.ColorUtil.GetColor("d53529ff")
            end

            if self.costItem then
                self.costItem:poolRecover()
            end
            self.costItem = nil
            self.costItem = PropsGrid:create(self.mNodeProp, {MoneyTid.COVENANT_GENE_POINT_TID, MoneyUtil.getMoneyCountByTid(MoneyTid.COVENANT_GENE_POINT_TID)}, 0.7)
            local got = MoneyUtil.getMoneyCountByTid(MoneyTid.COVENANT_GENE_POINT_TID)
            local need = talentVo:getCostNum(serverSkillData.level + 1).point
            self.costItem:setCount(got, need)
        end
    end
    self.mSelectInfo:SetActive(true)
end

function onLvlUpClick(self)
    if self.showVo == nil then
        return
    end
    local talentVo = covenant.CovenantManager:getForcesTalentData(self.showVo.id)
    local serverSkillData = covenant.CovenantManager:getForcesTalentServerData(self.showVo.id)

    local isEnough, tipStr = MoneyUtil.judgeNeedMoneyCountByTid(talentVo:getCostNum(serverSkillData.level + 1).payId, talentVo:getCostNum(serverSkillData.level + 1).payNum, false, false)
    local geneIsEnough = MoneyUtil.judgeNeedMoneyCountByTid(MoneyTid.COVENANT_GENE_POINT_TID, talentVo:getCostNum(serverSkillData.level + 1).point, false, false)

    if isEnough and geneIsEnough then
        GameDispatcher:dispatchEvent(EventName.REQ_COVENANT_SKILL_UP, {skillId = self.showVo.id})
    else
        gs.Message.Show(_TT(29540))
    end
end

function clearAllItems(self)
    -- skill会以prestige为父对象 先删skill
    self:clearSkillItems()
    self:clearSkillList()
    self:clearPrestigeItems()   
    self:clearneedSkillItem() 
    if self.costItem then
        self.costItem:poolRecover()
    end
    self.costItem = nil
end

function clearPrestigeItems(self)
    for i = 1, #self.mPrestigeItems do
        self.mPrestigeItems[i]:poolRecover()
    end
    self.mPrestigeItems = {}
end

function clearSkillList(self)
    self.mSkillItemList = {}
end

function clearSkillItems(self)
    for k, v in pairs(self.mSkillItems) do
        v:poolRecover()
    end
    self.mSkillItems = {}
end

function clearLockItem(self)
    for i = 1, #self.mLockItems do
        self.mLockItems[i]:poolRecover()
    end
    self.mLockItems = {}
end

function clearneedSkillItem(self)
    for i = 1, #self.mneedSkillItem do
        self.mneedSkillItem[i]:poolRecover()
    end
    self.mneedSkillItem = {}
end


function onCloseAllCall(self)
    super.onCloseAllCall(self)
    self:playerClose()
end

function onClickClose(self)
    super.onClickClose(self)
    self:playerClose()    
end

function playerClose(self)
    GameDispatcher:dispatchEvent(EventName.CUSTOM_CONVENANT_SCENE_CHANGE)
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
