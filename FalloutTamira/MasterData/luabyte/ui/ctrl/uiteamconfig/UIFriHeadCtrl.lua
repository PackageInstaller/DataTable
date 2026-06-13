local CircularScrollViewItem = require("Framework.UI.Component.CircularScrollViewItem")
local UIFriHeadCtrl = BaseClass("UIFriHeadCtrl", CircularScrollViewItem)
local M = UIFriHeadCtrl
local EQuality = EnumConst.EQuality
--编队好友助战
function M:Init()
    self._view.HeroHeadItem.transform:onClick(Bind(self, self._OnClickItem))
    self._view.btnFri:onClick(Bind(self, self._OnFirClick))
end

function M:UpdateItem(data)
    self.data = data
    local skinId = GameHelper.HeroId2SkinId(data.heroId, data.skin)
    if data.skin == 0 then
        if self:_IsAwake(data.heroId, data.awake) then
            self._view.HeroHeadItem:SetHeroId(data.heroId, data.lv, 3)
        else
            self._view.HeroHeadItem:SetHeroId(data.heroId, data.lv, 1)
        end
    else
        self._view.HeroHeadItem:SetSkinId(skinId)
    end
    self.state = data.state
    self._view.HeroHeadItem:SetSelect(self.state)
    self._view.HeroHeadItem:SetHeroLevel(data.lv)
    self._view.stateBreak:Updata(self.data.rare, self.data.grade)
    self._view.tfSame:SetActive(self.data.isSame)
    self._view.labFriendName:SetText(self.data.nickName)
    self._view.btnFri:SetActive(not self.data.isFriends)
end

function M:_IsAwake(heroId, awake)
    local rare = ConfigHelper.GetCfgPropByLua("hero", heroId, "rare")
    if rare == EQuality.SSR then
        return awake == 6
    elseif rare == EQuality.SR then
        return awake == 3
    end
    return false
end

function M:_OnClickItem()
    if self.data.isSame then
        return
    end
    EventMgr:Broadcast(UIMessageNames.TEAM_CLICKFRIENDHERO, self.data.heroId, self.data.friendId, not self.state)
end

function M:_OnFirClick()
    EventMgr:Broadcast(UIMessageNames.TEAMCLICKNOTICEFRI, self.data.friendId, self.data.isFriends)
end

function M:_OnUpdateState(heroId, state)
    if self.data.heroId ~= heroId then
        return
    end
    self.state = state
    self._view.HeroHeadItem.select = self.state
end

function M:Dispose()
    M.super.Dispose(self)
end

return UIFriHeadCtrl
