--[[ 
-----------------------------------------------------
@filename       : FightResultFailView
@Description    : 战斗结算失败界面
@date           : 2021年1月22日 17:52:02
@Author         : Jacob
@copyright      : (LY) 2020 雷焰网络
-----------------------------------------------------
]]
module('fightUI.FightResultFailView', Class.impl(View))

--对应的ui文件
UIRes = UrlManager:getUIPrefabPath("figthtResult/FightResultFailView.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = -1 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗
isAdapta = 0
isBlur = 0 --是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）

--构造函数
function ctor(self)
    super.ctor(self)
end
--析构  
function dtor(self)
end

function initData(self)
    self.mCodeList = { { funcId = funcopen.FuncOpenConst.FUNC_ID_HERO, linkId = LinkCode.Hero }, { funcId = funcopen.FuncOpenConst.FUNC_ID_HERO_EQUIP, linkId = LinkCode.Hero }, { funcId = funcopen.FuncOpenConst.FUNC_ID_HERO_BRACELETS, linkId = LinkCode.Hero } }
    self.mLinkBtnList = {}
    self.isLink = false
    self.mItemList = {}
    self.mEleItemList = {}
    self.mFightEleItem = {}
    self.mNextNode = nil
end

-- 初始化
function configUI(self)
    -- self.mBtnHeroLink = self:getChildGO("mBtnHeroLink")
    -- self.mGroupLink = self:getChildTrans("mGroupLink")
    -- self.mTxtDes = self:getChildGO("mTxtDes"):GetComponent(ty.Text)
    -- self.mPreviewBtn = self:getChildGO("mPreViewBtn")
    self.mWeakGroup = self:getChildGO("mWeakGroup")
    self.mEleGroup = self:getChildTrans("mEleGroup")
    self.mEle = self:getChildGO("mEle")
    self.mCommandGroup = self:getChildTrans("mCommandGroup")
    self.mTxtCommandTitle = self:getChildGO("mTxtCommandTitle")
    self.mGroupNext = self:getChildGO("mGroupNext")
    self.mTxtCommandTitle2 = self:getChildGO("mTxtCommandTitle2")
    self.mTxtWeak = self:getChildGO("mTxtWeak"):GetComponent(ty.Text)
    self.progressWidth = self.mTxtCommandTitle.transform:Find("Image"):GetComponent(ty.RectTransform).sizeDelta.x
end

--激活
function active(self, args)
    super.active(self, args)
    self.resultData = args.resultData
    self.battleType = args.battleType
    self.battleFieldID = args.battleFieldID
    self.preResultData = fight.FightManager:getPreResultData()
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.updateView, self)
    self:updateView()
    self.isCanClose = false
    self:setTimeout(1, function()
        self.isCanClose = true
    end)
end
--反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    self:clearItemList()
    self:sendFightOver()
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.updateView, self)
    --self.mImgMask.alpha = 0
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
    -- self:setBtnLabel(self.aa, 10001, "按钮")
    -- self.mTxtDes.text = '-点击屏幕继续-'
    self.mTxtWeak.text = _TT(3083)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    -- self:addUIEvent(self.mPreviewBtn, self.onPreviewClick)
    -- UI事件管理(关闭界面会自动移除)
    -- self:addUIEvent(self.aa,self.onClick)
end

function onClickClose(self)
    if self.isCanClose then
        super.onClickClose(self)
    end
end

function onPreviewClick(self)
    -- GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PREVIEW_SHOW)
end

-- 关闭界面发送通知
function sendFightOver(self)
    if not self.isLink then
        GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_PANEL_OVER, { isWin = false })
    end
end

function updateView(self)
    --TweenFactory:canvasGroupAlphaTo(self.mImgMask, 0, 0.8, 6)
    if (self.battleType == PreFightBattleType.DupTactivs or #self.preResultData.heroData == 0) then
        self.mWeakGroup:SetActive(false)
        return
    end

    if (self.battleType == PreFightBattleType.Friend) then
        self.mWeakGroup:SetActive(false)
        return
    end

    for k, v in pairs(self.preResultData.heroData) do
        local heroVo = hero.HeroManager:getHeroVo(v.heroId)
        if heroVo and heroVo:checkIsPreData() then
            return
        end
    end
    self:clearItemList()
    -- for i, data in ipairs(self.mCodeList) do
    --     if funcopen.FuncOpenManager:isOpen(data.funcId) then
    --         local item = SimpleInsItem:create(self.mBtnHeroLink, self.mGroupLink, "FightResultFailLinkBtn")

    --         local vo = funcopen.FuncOpenManager:getFuncOpenData(data.funcId)
    --         item:getChildGO("mTxtLink"):GetComponent(ty.Text).text = vo.name

    --         -- if data.funcId == funcopen.FuncOpenConst.FUNC_ID_HERO then
    --         --     item:getChildGO("mTxtLink"):GetComponent(ty.Text).text = _TT(3059)
    --         -- else
    --         --     item:getChildGO("mTxtLink"):GetComponent(ty.Text).text = _TT(3060)
    --         -- end

    --         local img = item.m_go:GetComponent(ty.AutoRefImage)
    --         img:SetImg(UrlManager:getPackPath(string.format("fight_result/combat_tips_btn_%s.png", data.funcId)), true)
    --         self:addOnClick(item.m_go, function()
    --             self:linkHandler(data.linkId)
    --         end)
    --         table.insert(self.mLinkBtnList, item)
    --     end
    -- end
    local dupVo = formation.FormationManager:getDupVo(self.battleType, tonumber(self.battleFieldID))
    if (not dupVo) then
        logError("副本缺失，类型：", self.battleType, " 副本号", self.battleFieldID)
        return
    end
    local commandLv = dupVo.suggestLevel[2]
    local failedConfigVo = fightUI.FightFailedUIData:getFailedTipData(commandLv)
    local suggestEle = dupVo.suggestEle
    for k, v in pairs(suggestEle) do
        local eleItem = SimpleInsItem:create(self.mEle, self.mEleGroup, "FightFaildEleItem")
        local img = eleItem:getGo():GetComponent(ty.AutoRefImage)
        img:SetImg(UrlManager:getHeroEleTypeIconUrl(v), true)
        table.insert(self.mEleItemList, eleItem)
    end

    local cusLv = 0
    if #self.preResultData.heroData > 0 then
        local allLv = 0
        if commandLv <= 60 then
            for k, v in pairs(self.preResultData.heroData) do
                allLv = allLv + v.lvl
            end
            cusLv = math.floor(allLv / #self.preResultData.heroData)
        else
            for k, v in pairs(self.preResultData.heroData) do
                allLv = allLv < v.lvl and v.lvl or allLv
            end
            cusLv = allLv
        end
        local itemLv = SimpleInsItem:create(self.mTxtCommandTitle, self.mCommandGroup, "commandGroupItem")
        local text = itemLv:getGo():GetComponent(ty.Text)
        local mTxtCommand = itemLv:getChildGO("mTxtCommand")
        local commandTxt = mTxtCommand:GetComponent(ty.Text)
        local progress = itemLv:getChildGO("mProgressLv"):GetComponent(ty.RectTransform)
        text.text = _TT(3084)
        commandTxt.text = _TT(3085) .. commandLv
        mTxtCommand:SetActive(true)
        local progressCount = cusLv / commandLv
        progressCount = progressCount > 1 and 1 or progressCount
        gs.TransQuick:SizeDelta01(progress, progressCount * self.progressWidth)
        table.insert(self.mItemList, itemLv)

        if failedConfigVo.markLevel > 0 then
            local curBraceletsLv = 0
            for k, v in pairs(self.preResultData.heroData) do
                local heroBracelets = hero.HeroManager:getHeroVo(v.heroId):getEquipByPos(7)
                if heroBracelets then
                    curBraceletsLv = curBraceletsLv + heroBracelets.strengthenLvl
                end
            end
            curBraceletsLv = math.floor(curBraceletsLv / #self.preResultData.heroData)
            local itemLv = SimpleInsItem:create(self.mTxtCommandTitle, self.mCommandGroup, "commandGroupItem")
            local text = itemLv:getGo():GetComponent(ty.Text)
            local mTxtCommand = itemLv:getChildGO("mTxtCommand")
            local commandTxt = mTxtCommand:GetComponent(ty.Text)
            local progress = itemLv:getChildGO("mProgressLv"):GetComponent(ty.RectTransform)
            text.text = _TT(3086)
            mTxtCommand:SetActive(false)
            local progressCount = curBraceletsLv / failedConfigVo.markLevel
            progressCount = progressCount > 1 and 1 or progressCount
            gs.TransQuick:SizeDelta01(progress, progressCount * self.progressWidth)
            table.insert(self.mItemList, itemLv)
        end

        if failedConfigVo.equipLevel > 0 then
            local curEquipLv = 0
            for k, v in pairs(self.preResultData.heroData) do
                curEquipLv = curEquipLv + hero.HeroManager:getHeroVo(v.heroId):getEquipAllLv()
            end
            curEquipLv = math.floor(curEquipLv / #self.preResultData.heroData)
            local itemLv = SimpleInsItem:create(self.mTxtCommandTitle, self.mCommandGroup, "commandGroupItem")
            local text = itemLv:getGo():GetComponent(ty.Text)
            local mTxtCommand = itemLv:getChildGO("mTxtCommand")
            local commandTxt = mTxtCommand:GetComponent(ty.Text)
            local progress = itemLv:getChildGO("mProgressLv"):GetComponent(ty.RectTransform)
            text.text = _TT(3087)
            mTxtCommand:SetActive(false)
            local progressCount = curEquipLv / failedConfigVo.equipLevel
            progressCount = progressCount > 1 and 1 or progressCount
            gs.TransQuick:SizeDelta01(progress, progressCount * self.progressWidth)
            table.insert(self.mItemList, itemLv)
        end

        self.mNextNode = SimpleInsItem:create(self.mGroupNext, self.mCommandGroup, "NextNode")
        local group = self.mNextNode:getChildTrans("mFightEleGroup")
        if #self.resultData.pos_effect <= 0 then
            local fightEleItem = SimpleInsItem:create(self.mTxtCommandTitle2, group, "fightElement")
            local text = fightEleItem:getGo():GetComponent(ty.Text)
            text.text = _TT(3088)
            table.insert(self.mFightEleItem, fightEleItem)
        else
            for k, v in pairs(self.resultData.pos_effect) do
                local fightEleItem = SimpleInsItem:create(self.mTxtCommandTitle2, group, "fightElement")
                local text = fightEleItem:getGo():GetComponent(ty.Text)
                local skillRo = fight.SkillManager:getSkillRo(v)
                text.text = skillRo:getDesc()
                table.insert(self.mFightEleItem, fightEleItem)
            end
        end
    end

end
function clearItemList(self)
    -- for i = #self.mLinkBtnList, 1, -1 do
    --     local item = self.mLinkBtnList[i]
    --     self:removeOnClick(item.m_go)
    --     table.remove(self.mLinkBtnList, i)
    -- end
    for k, v in pairs(self.mEleItemList) do
        v:poolRecover()
    end
    self.mEleItemList = {}

    for k, v in pairs(self.mItemList) do
        v:poolRecover()
    end
    self.mItemList = {}

    for k, v in pairs(self.mFightEleItem) do
        v:poolRecover()
    end
    self.mFightEleItem = {}

    if (self.mNextNode) then
        self.mNextNode:poolRecover()
        self.mNextNode = nil
    end
end

function linkHandler(self, id)
    -- self.isLink = true
    -- -- 战斗结算请求结束，指定跳转
    -- GameDispatcher:dispatchEvent(EventName.FIGHT_RESULT_REQ_LINK, { linkId = id })
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]