-- 核心item 包小威
local UICoreItemCtrl = BaseClass("UICoreItemCtrl")
local M = UICoreItemCtrl
local NumPicPath = EnumConst.NumPicPath

function M:__init(view)
    self._tempClickCore = EventMgr:AddListener(UIMessageNames.ROLE_DEVELOP_CLICKCORE, Bind(self, self.OnClickItem))
    self._view = view
    self._view.btn:onClick(Bind(self, self._OnClick))
end

function M:Update(data)
    self.data = data

    self.isActive = data.coreLevel >= data.id
    self._view.UIState:SetState(self.isActive and 2 or 1)

    self._view.imgNum:SetPic(NumPicPath .. data.id)
    local heroCores = ConfigHelper.GetCfgsByLua("heroCore", { heroId = data.heroId, coreLevel = data.id })

    if heroCores.Length <= 0 then
        Logger.LogError("配置错误")
        return
    end

    self._view.imgIcon:SetPic(heroCores[0].icon)
end

function M:_OnClick()
    EventMgr:Broadcast(UIMessageNames.ROLE_DEVELOP_CLICKCORE, self.data.id)
end

function M:OnClickItem(id)
    if id == self.data.id then
        self._view.UIState:SetState(self.isActive and 4 or 3)
    else
        self._view.UIState:SetState(self.isActive and 2 or 1)
    end
end

function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.ROLE_DEVELOP_CLICKCORE, self._tempClickCore)
    if self._view then
        self._view:OnDispose()
        self._view = nil
    end
end

return UICoreItemCtrl
