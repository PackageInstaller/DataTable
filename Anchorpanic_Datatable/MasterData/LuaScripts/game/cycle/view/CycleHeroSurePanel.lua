module("cycle.CycleHeroSurePanel", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("cycle/CycleHeroSurePanel.prefab")

destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
panelType = 2 -- 窗口类型 1 全屏 2 弹窗 -1无底图弹窗

isBlur = 0 

function ctor(self)
    super.ctor(self)
end

function initData(self)
    self.mSkillItems = {}
end

-- 初始化
function configUI(self)
    super.configUI(self)

    self.mTxtName = self:getChildGO("mTxtName"):GetComponent(ty.Text)
    self.mTxtLvDesc = self:getChildGO("mTxtLvDesc"):GetComponent(ty.Text)
    self.mTxtLv = self:getChildGO("mTxtLv"):GetComponent(ty.Text)
    self.mImgProfession = self:getChildGO("mImgProfession"):GetComponent(ty.AutoRefImage)
    self.mImgEleType = self:getChildGO("mImgEleType"):GetComponent(ty.AutoRefImage)

    self.mBtnSkill = self:getChildGO("mBtnSkill")
    self.mBtnSkillImg = self.mBtnSkill:GetComponent(ty.Image)
    self.mTxtSkill = self:getChildGO("mTxtSkill"):GetComponent(ty.Text)

    self.mBtnTalent = self:getChildGO("mBtnTalent")
    self.mBtnTalentImg = self.mBtnTalent:GetComponent(ty.Image)
    self.mTxtTalent = self:getChildGO("mTxtTalent"):GetComponent(ty.Text)


    self.mSkillScroll = self:getChildGO("mSkillScroll"):GetComponent(ty.ScrollRect)
    self.mBtnCancel = self:getChildGO("mBtnCancel")
    self.mBtnSure = self:getChildGO("mBtnSure")

end

function updateBtn(self)
    if self.isTalent == false then
        self.mBtnSkillImg.color = gs.ColorUtil.GetColor("35455Dff")
        self.mTxtSkill.color = gs.ColorUtil.GetColor("ffffffff")
        self.mBtnTalentImg.color = gs.ColorUtil.GetColor("232A36ff")
        self.mTxtTalent.color = gs.ColorUtil.GetColor("82898Cff")
    else
        self.mBtnSkillImg.color = gs.ColorUtil.GetColor("232A36ff")
        self.mTxtSkill.color = gs.ColorUtil.GetColor("82898Cff")
        self.mBtnTalentImg.color = gs.ColorUtil.GetColor("35455Dff")
        self.mTxtTalent.color = gs.ColorUtil.GetColor("ffffffff")
    end
end

-- 激活
function active(self, args)
    super.active(self, args)
    self.UIRootNode:SetParent(GameView.story, false)
    GameDispatcher:addEventListener(EventName.HERO_DATA_UPDATE, self.onUpdatePanel, self)
    self.isTalent = false
    self.mHeroVo = args.heroVo

    self:showPanel()
end

function onUpdatePanel(self)
    self:showPanel()
end

-- 反激活（销毁工作）
function deActive(self)
    super.deActive(self)
    GameDispatcher:removeEventListener(EventName.HERO_DATA_UPDATE, self.onUpdatePanel, self)
    self:clearSkillItems()

    GameDispatcher:dispatchEvent(EventName.UPDATE_CYCLE_HERO_SELECT_PANEL)
    
end

--[[ 
    初始化界面的静态文本，图片字
    每次打开界面都会重新读取，多语言切换时可以及时更新
]]
function initViewText(self)
end

-- UI事件管理(关闭界面会自动移除)
function addAllUIEvent(self)
    self:addUIEvent(self.mBtnSure,self.onBtnSureClick)
    self:addUIEvent(self.mBtnCancel, self.onClickCloseHandler)

    self:addUIEvent(self.mBtnTalent, self.mBtnTalentClick)
    self:addUIEvent(self.mBtnSkill, self.mBtnSkillClick)
end

function onBtnSureClick(self)
    local hopePoint = cycle.CycleManager:getResourceInfo().hope_point
    
    local hopeBase = cycle.CycleManager:getColorCostByColor(self.mHeroVo.color)
    local addValue = cycle.CycleManager:getEleCost(self.mHeroVo.eleType)
    local needHope = math.max(0, hopeBase + addValue)

    if needHope > hopePoint then
        gs.Message.Show(_TT(27547))
        return
    end

    local heroId = self.mHeroVo.id
    self.selectType, self.recuritType = cycle.CycleManager:getCurTicketAndType()
    if self.recuritType == RECUIT_TYPE.STEP then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_STEP_INFO, {
            step = CYCLE_STEP.SELECT_RECRUIT,
            args = {heroId}
        })
    elseif self.recuritType == RECUIT_TYPE.POSTWAR then
        local currentCellId = cycle.CycleManager:getCurrentCell()
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = currentCellId,
            args = {POSTWAR_TYPE.RECUIT, self.selectType, heroId}
        })
    elseif self.recuritType == RECUIT_TYPE.EVENT then
        local currentCellId = cycle.CycleManager:getCurrentCell()

        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_TRIGGER_EVENT_FINISH, {
            cellId = currentCellId,
            args = {heroId}
        })
    elseif self.recuritType == RECUIT_TYPE.SHOP then
        GameDispatcher:dispatchEvent(EventName.REQ_CYCLE_SHOP_RECRUIT_HERO, {
            heroId = heroId
        })
    end

    self:close()
end

function mBtnTalentClick(self)
    self.isTalent = true

    self:showPanel()
end

function mBtnSkillClick(self)
    self.isTalent = false

    self:showPanel()
end

function onClickCloseHandler(self)
    self:close()
end

function showPanel(self)
    if self.mHeroVo:checkIsPreData() then
        return
    end

    self:updateBtn()

    self.mTxtName.text = self.mHeroVo.name
    self.mTxtLv.text = self.mHeroVo.lvl
    self.mImgProfession:SetImg(UrlManager:getHeroJobSmallIconUrl(self.mHeroVo.professionType), false)
    self.mImgEleType:SetImg(UrlManager:getHeroEleTypeIconUrl(self.mHeroVo.eleType), false)

    self:clearSkillItems()
    local skillCount
    if self.isTalent then
        skillCount = self.mHeroVo.inBornSkill
    else
        skillCount = self.mHeroVo.activeSkillList
    end

    for i = 1, #skillCount do
        local skillVo
        if self.isTalent then
            skillVo = fight.SkillManager:getSkillRo(self.mHeroVo.inBornSkill[i])
        else
            skillVo = fight.SkillManager:getSkillRo(self.mHeroVo.activeSkillList[i])
        end
        local skillItem = cycle.CycleHeroSkillItem:poolGet()
        skillItem:setData(self.mSkillScroll.content, {
            heroVo = self.mHeroVo,
            skillVo = skillVo,
            isTalent = self.isTalent
        })
        table.insert(self.mSkillItems, skillItem)
    end

end

function clearSkillItems(self)
    for i = 1, #self.mSkillItems do
        self.mSkillItems[i]:poolRecover()
    end
    self.mSkillItems = {}
end

return _M
 
--[[ 替换语言包自动生成，请勿修改！
	语言包: _TT(27547):	"理智值不够"
]]
