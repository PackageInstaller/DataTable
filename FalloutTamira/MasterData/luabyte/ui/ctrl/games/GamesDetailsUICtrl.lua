local GamesDetailsUICtrl = BaseClass("GamesDetailsUICtrl", BaseUICtrl)
local M = GamesDetailsUICtrl


function M:_OpenGame()
    UIContextMgr:GetInstance():Show(GamesHelper.GameName(self._data.id))
end


function M:_GameView(view)
    self._game = view
    self._game:SetParent(self._view.game.transform)
    self._game:Reset()
    self._gameAnimator = self._game:FindComponent(typeof(CS.UnityEngine.Animator))
end


function M:_InitGamePrefab()
    ResourceManager:GetInstance():InstanceView(GamesHelper.GamePrefabPath(self._data.id), function (go)
        self:_GameView(go)
    end)
end


function M:_RefreshData()
    self._distoryData = GamesDataMgr:GetInstance():GameDistroy(self._data.id) or {}
    self._distoryData.Score = self._distoryData.Score or 0
    self._distoryData.SpanTime = self._distoryData.SpanTime or 0
    self._view.text1Value:SetText(tostring(self._distoryData.Score))
    self._view.text2Value:SetText(GamesHelper.TimeString(self._distoryData.SpanTime))
end


function M:Init()   
    self._game = nil
    self._gameAnimator = nil

    self._view.text1Text:SetText(700)
    self._view.text2Text:SetText(701)
    self._view.closeBtn:onClick(Bind(self, self._OnClickClose))
    self._view.startBtn:onClick(function (go) self:_OpenGame() end)

    self._dataRefresh = EventMgr:AddListener(UIMessageNames.GAME_DATAREFRESH, Bind(self, self._OnRefreshData))
end


function M:OnEnter(id)
    self._data = ConfigHelper.GetCfg('gameMachine', id)

    self._view.nameText:SetText(self._data.name)
    self._view.descText:SetText(self._data.dec)

    self:_RefreshData()
    self:_InitGamePrefab()
end


function M:_OnRefreshData()
    self:_RefreshData()
end


function M:_OnClickClose()
    self:Close()
end


function M:OnClose()
    -- self._data = nil
    self._gameAnimator = nil

    if self._game then
        self._game:Destory()
        self._game = nil
    end
end


function M:OnDispose()
    EventMgr:RemoveListener(UIMessageNames.GAME_DATAREFRESH, self._dataRefresh)
    M.super.OnDispose(self)
end










return GamesDetailsUICtrl
