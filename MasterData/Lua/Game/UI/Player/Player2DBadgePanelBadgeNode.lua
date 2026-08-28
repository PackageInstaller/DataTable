-------------------------------------------------------------------------------
-- 个人信息面板 - 徽章页面 - 徽章节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-18 15:32:43
-------------------------------------------------------------------------------

local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')

--- from: Assets/BundleResources/Prefabs/PlayerNew/Player2DMainDialog.prefab > name: Cell
---@class Player2DBadgePanelBadgeNode
---@field Env                           	Player2DBadgePanelBadgeNode             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtCutTime                    	UnityEngine.RectTransform               
---@field ImgBgCutTime                  	UnityEngine.RectTransform               
---@field StatusLock                    	UnityEngine.RectTransform               
---@field ImgNew                        	UnityEngine.RectTransform               
---@field ImgIcon                       	UnityEngine.RectTransform               
---@field ImgCurrent                    	UnityEngine.RectTransform               
---@field ImgSelect                     	UnityEngine.RectTransform               
local Player2dBadgePanelBadgeNode = Class('Player2dBadgePanelBadgeNode')


function Player2dBadgePanelBadgeNode:__init()
end


function Player2dBadgePanelBadgeNode:__delete()
end


function Player2dBadgePanelBadgeNode:Awake()
    SetButtonAction(self.controller, Bind(self, self.OnClickBadgeButtonHandler_))
end


function Player2dBadgePanelBadgeNode:Start()
    self.eventHeadCountdown_ = Events.AddListener(Constants.EventNames.PlayerHeadLeftTimeCountdown, Bind(self, self.OnUpdateHeadTimeHandler_))
end


function Player2dBadgePanelBadgeNode:OnDestroy()
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
function Player2dBadgePanelBadgeNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function Player2dBadgePanelBadgeNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function Player2dBadgePanelBadgeNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function Player2dBadgePanelBadgeNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function Player2dBadgePanelBadgeNode:GetClickBadgeCB()
    return self.clickBadgeCallback_
end
---@param callback fun(luaIndex:integer):void
function Player2dBadgePanelBadgeNode:SetClickBadgeCB(callback)
    self.clickBadgeCallback_ = callback
end


-------------------------------------------------
-- public

function Player2dBadgePanelBadgeNode:UpdateSelectStatus(isSelect)
    CfUtils.SetActive(self.ImgSelect, isSelect)
end


function Player2dBadgePanelBadgeNode:UpdateNewMark()
    local cellData  = self:GetCellData()
    local badgeId   = checkInt(cellData.badgeId)
    local isShowNew = PlayerInfoUtils.CheckAvatarIsNew(badgeId)
    CfUtils.SetActive(self.ImgNew, isShowNew)
end


-------------------------------------------------
-- private

function Player2dBadgePanelBadgeNode:UpdateCellInfo_()
    local cellData = self:GetCellData()

    local badgeId  = checkInt(cellData.badgeId)
    local isShowed = checkBool(cellData.isShowed)
    local isSelect = checkBool(cellData.isSelect)
    local isLocked = checkBool(cellData.isLocked)
    self.isMySelf_ = checkBool(cellData.isMySelf)

    ---@type PlayerHeadAvatarVo
    self.avatarVo_ = PlayerInfoUtils.GetHeadAvatarVo(badgeId)
    CfUtils.FillImage(self.ImgIcon, self.avatarVo_.photoPath)
    
    -- update new mark
    self:UpdateNewMark()

    -- update status
    self:UpdateSelectStatus(isSelect)
    CfUtils.SetActive(self.ImgCurrent, isShowed) -- 是否 "展示中"
    CfUtils.SetActive(self.StatusLock, isLocked) -- 是否上锁

    -- update time
    self:UpdateCellTime_()
end


function Player2dBadgePanelBadgeNode:UpdateCellTime_()
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

function Player2dBadgePanelBadgeNode:OnClickBadgeButtonHandler_()
    if self:GetClickBadgeCB() then
        self:GetClickBadgeCB()(self:GetLuaIndex())
    end
end


function Player2dBadgePanelBadgeNode:OnUpdateHeadTimeHandler_()
    if self.avatarVo_ then
        self:UpdateCellTime_()
    end
end


return Player2dBadgePanelBadgeNode
