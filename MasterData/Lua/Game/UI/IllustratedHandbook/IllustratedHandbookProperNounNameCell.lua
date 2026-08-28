-------------------------------------------------------------------------------
-- 海外图鉴 - 名词百科（组织势力、专有名词） - 名字节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-21 00:20:00
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookProperNounDialog.prefab
---@class IllustratedHandbookProperNounNameCell
---@field Env                           	IllustratedHandbookProperNounNameCell   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field newImg                        	UnityEngine.RectTransform               @ 新图标
---@field nameTxt                       	UnityEngine.RectTransform               @ 名字文本
---@field unlockNode                    	UnityEngine.RectTransform               @ 解锁节点
---@field lockedNode                    	UnityEngine.RectTransform               @ 枷锁节点
---@field selectNode                    	UnityEngine.RectTransform               @ 选中节点
---@field rootNodeBtn                   	UnityEngine.RectTransform               @ 按钮根节点
local IllustratedHandbookProperNounNameCell = Class('IllustratedHandbookProperNounNameCell')


function IllustratedHandbookProperNounNameCell:__init()
end


function IllustratedHandbookProperNounNameCell:__delete()
end


function IllustratedHandbookProperNounNameCell:Awake()
    SetButtonAction(self.rootNodeBtn, Bind(self, self.OnClickNameCellHandler_))
end


function IllustratedHandbookProperNounNameCell:Start()
end


function IllustratedHandbookProperNounNameCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookProperNounNameCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookProperNounNameCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return IllustratedHandbookKeywordEncyDojo
function IllustratedHandbookProperNounNameCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData IllustratedHandbookKeywordEncyDojo
function IllustratedHandbookProperNounNameCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer):void
function IllustratedHandbookProperNounNameCell:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer):void
function IllustratedHandbookProperNounNameCell:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


---@return boolean
function IllustratedHandbookProperNounNameCell:IsSelected()
    return checkBool(self.isSelected_)
end
---@param isSelect boolean
function IllustratedHandbookProperNounNameCell:SetSelected(isSelect)
    self.isSelected_ = checkBool(isSelect)
    self:UpdateSelectedState_()
end


---@return boolean
function IllustratedHandbookProperNounNameCell:IsNewMark()
    return checkBool(self.isNewMark_)
end
---@param isNewMark boolean
function IllustratedHandbookProperNounNameCell:SetNewMark(isNewMark)
    self.isNewMark_ = checkBool(isNewMark)
    self:UpdateNewMarkState_()
end


-------------------------------------------------
-- private

function IllustratedHandbookProperNounNameCell:UpdateCellInfo_()
    local encyDojo = self:GetCellData()
    self:SetNewMark(encyDojo.isNewMark)

    if encyDojo.isUnlock then
        local encyVo = checkTable(encyDojo.encyVo)
        CfUtils.FillText(self.nameTxt, encyVo.name)
        CfUtils.SetActive(self.lockedNode, false)
        CfUtils.SetActive(self.unlockNode, true)
    else
        CfUtils.FillText(self.nameTxt, '')
        CfUtils.SetActive(self.lockedNode, true)
        CfUtils.SetActive(self.unlockNode, false)
    end
end


function IllustratedHandbookProperNounNameCell:UpdateSelectedState_()
    CfUtils.SetActive(self.selectNode, self:IsSelected())
    CfUtils.SetUISwitchText(self.nameTxt, self:IsSelected() and 2 or 1)
end


function IllustratedHandbookProperNounNameCell:UpdateNewMarkState_()
    CfUtils.SetActive(self.newImg, self:IsNewMark())
end


-------------------------------------------------
-- handler

function IllustratedHandbookProperNounNameCell:OnClickNameCellHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex())
    end
end


return IllustratedHandbookProperNounNameCell
