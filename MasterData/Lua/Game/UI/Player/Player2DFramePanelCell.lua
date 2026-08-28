-------------------------------------------------------------------------------
-- 个人信息面板 - 主题页面 - 徽章节点
-- 
-- Author: zou hanjie
-- 
-- Create: DateTime: 2024/05/06 16:28
-------------------------------------------------------------------------------

local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')

--- from: Assets/BundleResources/Prefabs/PlayerNew/Player2DMainDialog.prefab > name: Cell
---@class Player2DFramePanelCell
---@field Env                           	Player2DFramePanelCell                  
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtCutTime                    	UnityEngine.RectTransform               	@ 0    
---@field ImgBgCutTime                  	UnityEngine.RectTransform               	@ 1    
---@field StatusLock                    	UnityEngine.RectTransform               	@ 2    
---@field ImgNew                        	UnityEngine.RectTransform               	@ 3    
---@field ImgIcon                       	UnityEngine.RectTransform               	@ 4    
---@field ImgCurrent                    	UnityEngine.RectTransform               	@ 5    
---@field ImgSelect                     	UnityEngine.RectTransform               	@ 6    
local Player2DFramePanelCell = Class('Player2DFramePanelCell')


function Player2DFramePanelCell:__init()
end


function Player2DFramePanelCell:__delete()
end


function Player2DFramePanelCell:Awake()
    SetButtonAction(self.controller, Bind(self, self.OnClickFrameButtonHandler_))
end


function Player2DFramePanelCell:Start()
    self.eventHeadCountdown_ = Events.AddListener(Constants.EventNames.PlayerHeadLeftTimeCountdown, Bind(self, self.OnUpdateHeadTimeHandler_))
end


function Player2DFramePanelCell:OnDestroy()
    if self.eventHeadCountdown_ then
        Events.RemoveListener(Constants.EventNames.PlayerHeadLeftTimeCountdown, self.eventHeadCountdown_)
        self.eventHeadCountdown_ = nil
    end
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function Player2DFramePanelCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function Player2DFramePanelCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function Player2DFramePanelCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function Player2DFramePanelCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function Player2DFramePanelCell:GetClickFrameCB()
    return self.clickFrameCallback_
end
---@param callback fun(luaIndex:integer):void
function Player2DFramePanelCell:SetClickFrameCB(callback)
    self.clickFrameCallback_ = callback
end


-------------------------------------------------
-- public

function Player2DFramePanelCell:UpdateSelectStatus(isSelect)
    CfUtils.SetActive(self.ImgSelect, isSelect)
    CfUtils.SetActive(self.ImgCurrent, isSelect) -- 是否 "展示中"
end


function Player2DFramePanelCell:UpdateNewMark()
    local cellData  = self:GetCellData()
    local frameId   = checkInt(cellData.frameId)
    local isShowNew = PlayerInfoUtils.CheckAvatarIsNew(frameId)
    CfUtils.SetActive(self.ImgNew, isShowNew)
end


-------------------------------------------------
-- private

function Player2DFramePanelCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    local frameId  = checkInt(cellData.frameId)
    local isSelected = checkBool(cellData.isSelected)
    local isSelect = checkBool(cellData.isSelect)
    local isLocked = checkBool(cellData.isLocked)
    self.isMySelf_ = checkBool(cellData.isMySelf)

    ---@type PlayerHeadAvatarVo
    self.avatarVo_ = PlayerInfoUtils.GetHeadAvatarVo(frameId)
    CfUtils.FillImage(self.ImgIcon, self.avatarVo_.ThemethumbnailPath) -- 主题缩略图 (非正方形)
    
    -- update new mark
    self:UpdateNewMark()

    -- update status
    self:UpdateSelectStatus(isSelect)
    CfUtils.SetActive(self.ImgCurrent, isSelected) -- 是否 "展示中"
    CfUtils.SetActive(self.StatusLock, isLocked) -- 是否上锁

    -- update time
    self:UpdateCellTime_()
end




function Player2DFramePanelCell:UpdateCellTime_()
    if self.isMySelf_ then
        local headData = PlayerInfoUtils.GetItemHasByKind(self.avatarVo_.kind)[tostring(self.avatarVo_.id)] or {}
        local hasTime  = checkInt(headData.expirationTime) > 0
        CfUtils.SetActive(self.ImgBgCutTime, hasTime)
        if hasTime then
            CfUtils.FillText(self.TxtCutTime, CfUtils.GetTimeHMS10(math.max(checkInt(headData.leftSeconds), 0)))
        end
    else
        CfUtils.SetActive(self.ImgBgCutTime, false)
    end
end


-------------------------------------------------
-- handler

function Player2DFramePanelCell:OnClickFrameButtonHandler_()
    if self:GetClickFrameCB() then
        self:GetClickFrameCB()(self:GetLuaIndex())
    end
end


function Player2DFramePanelCell:OnUpdateHeadTimeHandler_()
    if self.avatarVo_ then
        self:UpdateCellTime_()
    end
end


return Player2DFramePanelCell
