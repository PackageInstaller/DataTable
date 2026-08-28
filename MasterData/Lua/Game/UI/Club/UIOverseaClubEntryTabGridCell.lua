-------------------------------------------------------------------------------
-- 社团 - 创建/修改社团弹窗 - 头像网格节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-28 02:04:11
-------------------------------------------------------------------------------

local CommonTabToggleLeftCell = import('Game.Behaviours.CommonTabToggleLeftCell')

---@class UIOverseaClubEntryTabGridCell : CommonTabToggleLeftCell
---@field Env                           	UIOverseaClubEntryTabGridCell         
---@field controller                    	Engine.Modules.LuaBehaviour             
local UIOverseaClubEntryTabGridCell = Class('UIOverseaClubEntryTabGridCell', CommonTabToggleLeftCell)


function UIOverseaClubEntryTabGridCell:__init()
    CommonTabToggleLeftCell.__init(self)
end


function UIOverseaClubEntryTabGridCell:__delete()
    CommonTabToggleLeftCell.__delete(self)
end


function UIOverseaClubEntryTabGridCell:Awake()
    CommonTabToggleLeftCell.Awake(self)
    self:SetCallBack(Bind(self, self.OnClickCellAreaHandler_))
end


function UIOverseaClubEntryTabGridCell:Start()
end


function UIOverseaClubEntryTabGridCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubEntryTabGridCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIOverseaClubEntryTabGridCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ClubListUnitDojo
function UIOverseaClubEntryTabGridCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData ClubListUnitDojo
function UIOverseaClubEntryTabGridCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIOverseaClubEntryTabGridCell:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubEntryTabGridCell:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


---@return boolean
function UIOverseaClubEntryTabGridCell:IsSelected()
    return checkBool(self.isSelected_)
end
---@param isSelect boolean
function UIOverseaClubEntryTabGridCell:SetSelected(isSelect)
    self.isSelected_ = checkBool(isSelect)
    self:UpdateSelectedState_()
end


---@return boolean
function UIOverseaClubEntryTabGridCell:IsShowRedPoint()
    return checkBool(self.isShowRedPoint_)
end
---@param isSelect boolean
function UIOverseaClubEntryTabGridCell:SetShowRedPoint(isShow)
    self.isShowRedPoint_ = checkBool(isShow)
    self:UpdateRedPointState_()
end


-------------------------------------------------
-- prifate

function UIOverseaClubEntryTabGridCell:UpdateCellInfo_()
    local cellData = self:GetCellData()
    local _lock
    if not isNull(cellData.lock) then
        _lock = cellData.lock
    end
    self:FreshBaseUI({
        text          = cellData.name,
        selectImgPath = cellData.bgPath,
        lock          = not isNull(_lock) and _lock() or nil
    })
end


function UIOverseaClubEntryTabGridCell:UpdateSelectedState_()
    self:FreshSelectStatus(self:IsSelected(), {})
    CfUtils.SetActive(self.Image, true)
    CfUtils.SetUISwitchImage(self.Image, self:IsSelected() and 2 or 1)
end


function UIOverseaClubEntryTabGridCell:UpdateRedPointState_()
    self:FreshRedPointStatus(self:IsShowRedPoint())
end


-------------------------------------------------
-- handler

function UIOverseaClubEntryTabGridCell:OnClickCellAreaHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex())
    end
end


return UIOverseaClubEntryTabGridCell
