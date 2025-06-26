module("game.selectedHero.view.SelectedHeroView", Class.impl(View))

UIRes = UrlManager:getUIPrefabPath("selectedHero/SelectedHero.prefab")

panelType = 2 -- 窗口类型 1 全屏 2 弹窗
destroyTime = 0 -- 自动销毁时间-1默认 0即时销毁 999不销毁
isBlur = 1 -- 是否开启模糊背景（仅2弹窗面板有效，默认开启，0关闭）
isAdapta = 0 -- 是否开启适配刘海 0 否 1 是

-- 构造函数
function ctor(self)
    super.ctor(self)
    self:setTxtTitle(_TT(1363))
    self:setSize(1120, 520)
    --self.base_childGos["gBtnClose"]:SetActive(false)
    self:init()
end

-- 初始化
function configUI(self)
    self.title = self:getChildGO("TitleTxt"):GetComponent(ty.Text)
    self.titleCount = self:getChildGO("TitleCountTxt"):GetComponent(ty.Text)
    -- self.selectedCountTxt = self:getChildGO("SelectedCountTxt"):GetComponent(ty.Text)

    -- self.clearBtn = self:getChildGO("ClearBtn")
    -- self.cancleBtn = self:getChildGO("CancleBtn")
    self.confirmBtn = self:getChildGO("ConfirmBtn")

    -- self.clearTxt = self:getChildGO("ClearTxt"):GetComponent(ty.Text)
    -- self.cancleTxt = self:getChildGO("CancleTxt"):GetComponent(ty.Text)
    self.confirmTxt = self:getChildGO("ConfirmTxt"):GetComponent(ty.Text)

    self.scrollView = self:getChildGO("Scroll View"):GetComponent(ty.ScrollRect)
    self.mScrollContent = self:getChildTrans("Content")
end

function init(self)
    self.itemList = {}
    self.id = 0
end

function initViewText(self)
    -- self.clearTxt.text = _TT(4045)
    -- self.cancleTxt.text = _TT(2)
    self.confirmTxt.text = _TT(4047)
end

function active(self, args)
    super.active(self, args)
    self.title.text = args.name

    selectedHero.SelectedHeroManager:addEventListener(selectedHero.SelectedHeroManager.EVENT_HERO_SELECT, self.__onItemClick, self)
    GameDispatcher:addEventListener(EventName.DEACTIVE_SELECT_HERO_VIEW, self.DeActiveSelf, self)
    -- GameDispatcher:addEventListener(EventName.CLOSE_SELECT_HERO_VIEW, self.close, self)

    local vo = args
    self.id = vo.id
    self.effect = args.effectType
    selectedHero.SelectedHeroManager:setInit(vo)

    self.m_propsVo = vo

    self:__setContex()
    self:__updateInfo()
end

--反激活（销毁工作）
function deActive(self)
    GameDispatcher:removeEventListener(EventName.DEACTIVE_SELECT_HERO_VIEW, self.DeActiveSelf, self)
    -- GameDispatcher:removeEventListener(EventName.CLOSE_SELECT_HERO_VIEW, self.close, self)
    selectedHero.SelectedHeroManager:removeEventListener(selectedHero.SelectedHeroManager.EVENT_HERO_SELECT, self.__onItemClick, self)
    self.scrollView.horizontalNormalizedPosition = 0
    super.deActive(self)

    for i = 1, #self.itemList do
        self.itemList[i]:setIsSelect(false)
        self.itemList[i]:poolRecover()
    end
    self.itemList = {}
    selectedHero.SelectedHeroManager:clearAllData()
end

function DeActiveSelf(self, isActive)
    self:hideViewAndReshow()
    -- bag.BagManager.mOpenHeroDetail = not isActive
    -- self.UIRootNode.gameObject:SetActive(isActive)
end

function close(self)
    bag.BagManager.mOpenHeroDetail = false
    super.close(self)
end

function __updateInfo(self)
    local current = selectedHero.SelectedHeroManager:getCurrentCount()
    local max = selectedHero.SelectedHeroManager:getMaxCount()

    local have = self.m_propsVo.id ~= nil and self.m_propsVo.id ~= 0
    if have then
        self.titleCount.text = string.substitute(_TT(4041), max)
    else
        self.titleCount.text = _TT(149009)
    end

    self.confirmBtn:SetActive(have)

    -- if (current == max) then
    --     self.selectedCountTxt.text = string.substitute(_TT(4042), current, max)
    -- else
    --     self.selectedCountTxt.text = string.substitute(_TT(4043), current, max)
    -- end
    --if(current == max) then
    --    self.confirmBtn. = (current == max)
    --end
end

function __onItemClick(self, args)
    selectedHero.SelectedHeroManager:setItemChange(args)
    self:__updateInfo()
end

function __setContex(self)
    local list = selectedHero.SelectedHeroManager:getDataList()

    if self.effect == UseEffectType.ADD_FREE_HEROGIFT then
        local canSelect = self.m_propsVo.id ~= nil and self.m_propsVo.id ~= 0
        self.base_childGos["gTxtTitle"]:GetComponent(ty.Text).text = _TT(1394)
        for i = 1, #list do
            local vo = props.PropsManager:getPropsConfigVo(list[i].tid)

            local item = selectedHero.SelectedHeroItem:poolGet()

            item:setData(self.mScrollContent, {vo, i, canSelect})

            table.insert(self.itemList, item)
        end
    else
        self.base_childGos["gTxtTitle"]:GetComponent(ty.Text).text = _TT(1363)
        table.sort(list, function(a, b)
            local isObtainA, _ = hero.HeroManager:getIsObtain(a.tid)
            local isObtainB, _ = hero.HeroManager:getIsObtain(b.tid)
            local heroVoA = hero.HeroManager:getHeroConfigVo(a.tid)
            local heroVoB = hero.HeroManager:getHeroConfigVo(b.tid)
            if isObtainA == isObtainB then
                if heroVoA.color == heroVoB.color then
                    return a.tid < b.tid
                else
                    return heroVoA.color > heroVoB.color
                end
            else
                return isObtainB
            end
        end)
        for i = 1, #list do
            local vo = props.PropsManager:getPropsConfigVo(list[i].tid)

            local item = selectedHero.SelectedHeroItem:poolGet()

            item:setData(self.mScrollContent, {vo, i})

            table.insert(self.itemList, item)
        end
    end

    if #list > 7 then
        gs.TransQuick:Pivot(self.mScrollContent, 0, 1)
        gs.TransQuick:Anchor(self.mScrollContent, 0, 1, 0, 1)
        gs.TransQuick:UIPos(self.mScrollContent, 0, 0)
        self.mScrollContent:GetComponent(ty.ContentSizeFitter).horizontalFit = gs.ContentSizeFitter.FitMode.PreferredSize
        self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).childAlignment = gs.TextAnchor.MiddleLeft
    else
        gs.TransQuick:Pivot(self.mScrollContent, 0.5, 0.5)
        gs.TransQuick:Anchor(self.mScrollContent, 0, 1, 1, 1)
        gs.TransQuick:UIPos(self.mScrollContent, 0, -90)
        self.mScrollContent:GetComponent(ty.ContentSizeFitter).horizontalFit = gs.ContentSizeFitter.FitMode.Unconstrained
        self.mScrollContent:GetComponent(ty.HorizontalLayoutGroup).childAlignment = gs.TextAnchor.MiddleCenter
    end

end

function addAllUIEvent(self)
    -- self:addUIEvent(self.cancleBtn, self.onClickClose)

    -- self:addUIEvent(self.clearBtn, self.__onClearClick)
    self:addUIEvent(self.confirmBtn, self.__onConfirmBtnClick)
end

-- function __onClearClick(self)
--     for i = 1, #self.itemList do
--         self.itemList[i]:setIsSelect(false)
--     end

--     selectedHero.SelectedHeroManager:clearSelectList()

--     self:__updateInfo()
-- end

function __onConfirmBtnClick(self)
    local current = selectedHero.SelectedHeroManager:getCurrentCount()
    local max = selectedHero.SelectedHeroManager:getMaxCount()

    if current ~= max then
        gs.Message.Show(_TT(4044))
    else
        local args = selectedHero.SelectedHeroManager:getSelectHero()
        GameDispatcher:dispatchEvent(
            EventName.USE_PROPS_BY_ID,
        {id = self.id, targetId = 0, count = 1, use_args = args})
        self:onClickClose()
    end
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
