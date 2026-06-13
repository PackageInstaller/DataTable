local M = BaseClass("OtakuBridgeMoudule", require("Modules.OtakuBaseRoomModule"))
local OtakuRoomType = OtakuType.OtakuRoomType
local tInsert = table.insert

function M:__init()
end

function M:OnEnter()
    M.super.OnEnter(self)
    self.heromodelList = {}
    local roomDatas = OtakuRoomDataMgr:GetInstance():RoomDatasByRoomType(OtakuRoomType.EST_Bridge)
    self:GetRoleStudioCallback(roomDatas)
    GameHelper.DoPlayerAction(PlayerAction.OpenBridge)
end

function M:GetRoleStudioCallback(roleStudios)
    self.roomData = roleStudios[1]
    M.super.OnEnter(self, self.roomData)
    self:LoadScene("Mainscene02", Bind(self, self._LoadSceneComplete))
end

function M:_LoadSceneComplete(view)
    self._view = view
    self:CreateDirector(view.CameraNode)
    self:GetCameraDirector():CameraTranslation(0, 2269.795, 1.441854, 5.37, 4.485, -146.002, 0)
    self:UpdateRole()
    self:ShowUI("OtakuBridgePanel", self.roomData)
    self:Ready()
end

function M:UpdateRoom(roomData)
    self.roomData = roomData

    if self:CheckRole() == false then
        self:UpdateRole()
    end
end

function M:UpdateRole()
    self:ClearRole()
    local datalist = self.roomData.RoleLives
    local liveRoleLen = #datalist

    for i = 1, 5 do
        if i <= liveRoleLen then
            local id = datalist[i].HeroId
            self:CreateRole(id)
        end
    end
end

function M:ClearRole()
    for k, v in pairs(self.heromodelList) do
        if v then
            GameUtil.DestroyGo(v)
        end
    end

    self.heromodelList = {}
end

function M:CreateRole(id)
    if self.heromodelList[id] == nil then
        self.heromodelList[id] = GameHelper.CreateRole(id, false).gameObject
        self.heromodelList[id].transform.localPosition = Vector3.zero
        self.heromodelList[id].transform.localEulerAngles = Vector3.zero
        self.heromodelList[id].transform.localScale = Vector3.one
        OtakuHelper.AddWalkFSM(self.heromodelList[id], OtakuRoomType.EST_Bridge)
    end
end

function M:CheckRole()
    self._curRoleData = {}

    for k, v in pairs(self.heromodelList) do
        tInsert(self._curRoleData, k)
    end

    table.sort(self._curRoleData, SortRoleData)
    self._roleData = {}

    for i = 1, self.roomData.RoleLivesLength do
        tInsert(self._roleData, self.roomData.RoleLives[i].HeroId)
    end

    table.sort(self._roleData, SortRoleData)
    return GameHelper.tableEqual(self._curRoleData, self._roleData)
end

function M:OnExit()
    M.super.OnExit(self)
    UIContextMgr:GetInstance():Close("OtakuBridgePanel")
end

return M
