-------------------------------------------------------------------------------
-- 社团 - 创建/修改社团弹窗 - 头像网格节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-07-28 02:04:11
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCreateAndModifyPopup.prefab
---@class UIOverseaClubCreateHeadGridCell
---@field Env                           	UIOverseaClubCreateHeadGridCell         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field clickArea                     	UnityEngine.RectTransform               @ 点击区域
---@field selectImg                     	UnityEngine.RectTransform               @ 选中图片
---@field headImg                       	UnityEngine.RectTransform               @ 头像图片
local UIOverseaClubCreateHeadGridCell = Class('UIOverseaClubCreateHeadGridCell')


function UIOverseaClubCreateHeadGridCell:__init()
end


function UIOverseaClubCreateHeadGridCell:__delete()
end


function UIOverseaClubCreateHeadGridCell:Awake()
    SetButtonAction(self.clickArea, Bind(self, self.OnClickCellAreaHandler_))
end


function UIOverseaClubCreateHeadGridCell:Start()
end


function UIOverseaClubCreateHeadGridCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function UIOverseaClubCreateHeadGridCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function UIOverseaClubCreateHeadGridCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return ClubListUnitDojo
function UIOverseaClubCreateHeadGridCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData ClubListUnitDojo
function UIOverseaClubCreateHeadGridCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function UIOverseaClubCreateHeadGridCell:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function UIOverseaClubCreateHeadGridCell:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


---@return boolean
function UIOverseaClubCreateHeadGridCell:IsSelected()
    return checkBool(self.isSelected_)
end
---@param isSelect boolean
function UIOverseaClubCreateHeadGridCell:SetSelected(isSelect)
    self.isSelected_ = checkBool(isSelect)
    self:UpdateSelectedState_()
end


-------------------------------------------------
-- prifate

function UIOverseaClubCreateHeadGridCell:UpdateCellInfo_()
    local cellData = self:GetCellData()

    ---@type PlayerHeadAvatarVo
    local headVo = checkTable(cellData.headVo)
    CfUtils.FillImage(self.headImg, headVo.photoPath)
end


function UIOverseaClubCreateHeadGridCell:UpdateSelectedState_()
    CfUtils.SetActive(self.selectImg, self:IsSelected())
end


-------------------------------------------------
-- handler

function UIOverseaClubCreateHeadGridCell:OnClickCellAreaHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex())
    end
end


return UIOverseaClubCreateHeadGridCell
