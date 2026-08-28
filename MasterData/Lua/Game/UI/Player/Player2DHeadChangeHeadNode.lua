-------------------------------------------------------------------------------
-- 玩家换头像弹窗 - 头像节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-12-16 17:09:34
-------------------------------------------------------------------------------

local PlayerInfoUtils = import('Game.UI.Player.PlayerInfoUtils')

--- from: Assets/BundleResources/Prefabs/PlayerNew/Player2DHeadChooseDialog.prefab > name: Cell1
---@class Player2DHeadChangeHeadNode
---@field Env                           	Player2DHeadChangeHeadNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtCutTime                    	UnityEngine.RectTransform               
---@field ImgBgCutTime                  	UnityEngine.RectTransform               
---@field ImgNew                        	UnityEngine.RectTransform               
---@field StatusLock                    	UnityEngine.RectTransform               
---@field ImgSelect                     	UnityEngine.RectTransform               
---@field ImgCurrent                    	UnityEngine.RectTransform               
---@field CommonPlayerHeadNode          	UnityEngine.RectTransform               
local Player2DHeadChangeHeadNode = Class('Player2DHeadChangeHeadNode')


function Player2DHeadChangeHeadNode:__init()
    ---@type CommonPlayerHeadNode
    self.headNodeEnv_ = nil
end


function Player2DHeadChangeHeadNode:__delete()
    self.headNodeEnv_ = nil
end


function Player2DHeadChangeHeadNode:Awake()
    self.headNodeEnv_ = CfUtils.GetLuaScr(self.CommonPlayerHeadNode, Constants.UILuaTablePath.ComPlayerHead)
    SetButtonAction(self.controller, Bind(self, self.OnClickHeadButtonHandler_))
end


function Player2DHeadChangeHeadNode:Start()
    self.eventHeadCountdown_ = Events.AddListener(Constants.EventNames.PlayerHeadLeftTimeCountdown, Bind(self, self.OnUpdateHeadTimeHandler_))
end


function Player2DHeadChangeHeadNode:OnDestroy()
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
function Player2DHeadChangeHeadNode:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function Player2DHeadChangeHeadNode:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return table
function Player2DHeadChangeHeadNode:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData table
function Player2DHeadChangeHeadNode:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function Player2DHeadChangeHeadNode:GetClickHeadCB()
    return self.clickHeadCallback_
end
---@param callback fun(luaIndex:integer):void
function Player2DHeadChangeHeadNode:SetClickHeadCB(callback)
    self.clickHeadCallback_ = callback
end


-------------------------------------------------
-- private

function Player2DHeadChangeHeadNode:UpdateCellInfo_()
    local cellData = self:GetCellData()

    local itemId    = checkInt(cellData.itemId)
    local itemType  = checkInt(cellData.itemType)
    local isCurrent = checkBool(cellData.isCurrent)
    local isSelect  = checkBool(cellData.isSelect)
    local isLocked  = checkBool(cellData.isLocked)
    self.isMySelf_  = checkBool(cellData.isMySelf)
    self.avatarVo_  = PlayerInfoUtils.GetHeadAvatarVo(itemId)

    -- update headNode
    if itemType == Constants.PlayerAvatarItemType.Avatar then 
        self.headNodeEnv_:FreshHeadIcon(itemId, true)
    elseif itemType == Constants.PlayerAvatarItemType.AvatarFrame then
        self.headNodeEnv_:FreshFrame(itemId, true)
    elseif itemType == Constants.PlayerAvatarItemType.Gender then
        self.headNodeEnv_:FreshHeadIcon(itemId, true)
    else 
        printError("暂未支持")
    end

    -- update new mark
    CfUtils.SetActive(self.ImgNew, PlayerInfoUtils.CheckAvatarIsNew(itemId))

    -- update status
    CfUtils.SetActive(self.ImgCurrent, isCurrent)
    CfUtils.SetActive(self.ImgSelect, isSelect)
    CfUtils.SetActive(self.StatusLock, isLocked)

    -- update time
    self:UpdateCellTime_()
end


function Player2DHeadChangeHeadNode:UpdateCellTime_()
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

function Player2DHeadChangeHeadNode:OnClickHeadButtonHandler_()
    if self:GetClickHeadCB() then
        self:GetClickHeadCB()(self:GetLuaIndex())
    end
end


function Player2DHeadChangeHeadNode:OnUpdateHeadTimeHandler_()
    if self.avatarVo_ then
        self:UpdateCellTime_()
    end
end


return Player2DHeadChangeHeadNode
