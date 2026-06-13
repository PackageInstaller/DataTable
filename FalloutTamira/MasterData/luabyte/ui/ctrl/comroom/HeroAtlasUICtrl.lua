-- 对应预制体 HeroAtlasUI
local M = BaseClass("HeroAtlasUICtrl", BaseUICtrl)
local eventId = UIMessageNames.HERO_ATLAS_REWARD_STATE_UPDATE

function M:Init()
    local ctrl = require("UI.Ctrl.ComRoom.HeroAtlasItemCtrl")
    local view = require("UI.View.ComRoom.HeroAtlasItemView")
    self._index = 0
    self._view.scrollHero:Init(ctrl, view)
    self._view.rectBack:onClick(Bind(self, self.Close))
    self._view.rectCollect:onClick(Bind(self, self.OnCollectClick))
    self._stateUpdateEvent = EventMgr:AddListener(eventId, Bind(self, self._RefRedPoint))
    self.bgNation = {
        "UI/SpritePics/profession/ui_icon_profession_00",
        "UI/SpritePics/nation/ui_icon_nation_1",
        "UI/SpritePics/nation/ui_icon_nation_2",
        "UI/SpritePics/nation/ui_icon_nation_3",
        "UI/SpritePics/nation/ui_icon_nation_4",
        "UI/SpritePics/nation/ui_icon_nation_5"
    }
    self.picPath = {
        "UI/SpritePics/soldier/ui_soldier_wz_00",
        "UI/SpritePics/soldier/ui_soldier_wz_05",
        "UI/SpritePics/soldier/ui_soldier_wz_02",
        "UI/SpritePics/soldier/ui_soldier_wz_04",
        "UI/SpritePics/soldier/ui_soldier_wz_03",
        "UI/SpritePics/soldier/ui_soldier_wz_01",
    }
end

--点击设置退出键
function M:OnDeviceBack()
    UIContextMgr:GetInstance():Back()
    return true
end

function M:OnEnter()
    self:_InitScrollView()
    self:_InitTabs()
    if PlotAtlasDataMgr:GetInstance():GetHeroAtlasOnOpen() then
        self._view.tfMask:SetActive(false)
    else
        PlotAtlasDataMgr:GetInstance():SetHeroAtlasOnOpen()
        self._view.animator.enabled = true
    end
end

function M:_RefRedPoint()
    self._view.redpoint:Check()
end

function M:_InitScrollView()
    self.heroData = PlotAtlasDataMgr:GetInstance():InitHeroData()
    local haveNums = self:_GetShowHeroData()
    self._view.scrollHero:SetDataList(self.heroData)
    self._view.imgNationType:SetPic(self.picPath[self._index + 1])
    self._view.StateNation:SetState(self._index + 1)
    self._view.imgNation:SetPic(self.bgNation[self._index + 1])
    local rate = haveNums / #self.heroData
    rate = math.floor(rate * 100)
    rate = rate >= 100 and 100 or rate
    self._view.txtHeroRate:SetText(rate .. "%")
end

function M:_InitTabs()
    self._view.tabClass:Init(0, Bind(self, self.OnClassFilterSelect))
end

function M:OnClassFilterSelect(index)
    if index == self._index then return end
    self._index = index

    self.heroData = PlotAtlasDataMgr:GetInstance():GetHeros(index)
    local haveNums = self:_GetShowHeroData()
    self._view.scrollHero:SetDataList(self.heroData)
    self._view.imgNationType:SetPic(self.picPath[self._index + 1])
    self._view.StateNation:SetState(self._index + 1)
    self._view.imgNation:SetPic(self.bgNation[self._index + 1])

    local rate = haveNums / #self.heroData
    rate = math.floor(rate * 100)
    rate = rate >= 100 and 100 or rate
    self._view.txtHeroRate:SetText(rate .. "%")
end

function M:_GetShowHeroData()
    local haveNums = 0
    for i = 1, #self.heroData do
        local tempHeroData = self.heroData[i]
        haveNums = tempHeroData.isCollect == 1 and haveNums + 1 or haveNums
        tempHeroData.id = i
    end
    return haveNums
end

function M:OnCollectClick()
    UIContextMgr:GetInstance():Show("HeroAtlasPopUpUI")
end

function M:OnDispose()
    PlotAtlasDataMgr:GetInstance():CheckOffNewFactionHeroRedPoint()
    IRedPointMgr:ForceCheck(RedPointConst.HeroGetTypeRedPointChecker)
    EventMgr:RemoveListener(eventId, self._stateUpdateEvent)
    self._view.scrollHero:Dispose()
    self._stateUpdateEvent = nil
    self._index = nil
    M.super.OnDispose(self)
end

return M
