-------------------------------------------------------------------------------
-- 海外图鉴 - 名词百科（组织势力、专有名词） - 关键词节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-21 00:20:00
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookProperNounDialog.prefab
---@class IllustratedHandbookProperNounWordCell
---@field Env                           	IllustratedHandbookProperNounWordCell   
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field lockNode                      	UnityEngine.RectTransform               @ 枷锁节点
---@field wordTxt                       	UnityEngine.RectTransform               @ 关键词文本
local IllustratedHandbookProperNounWordCell = Class('IllustratedHandbookProperNounWordCell')


function IllustratedHandbookProperNounWordCell:__init()
end


function IllustratedHandbookProperNounWordCell:__delete()
end


function IllustratedHandbookProperNounWordCell:Awake()
    SetButtonAction(self.controller.transform, Bind(self, self.OnClickWordCellHandler_))
end


function IllustratedHandbookProperNounWordCell:Start()
end


function IllustratedHandbookProperNounWordCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookProperNounWordCell:GetLuaIndex()
    return checkInt(self.luaIndex_)
end
---@param luaIndex integer
function IllustratedHandbookProperNounWordCell:SetLuaIndex(luaIndex)
    self.luaIndex_ = checkInt(luaIndex)
end


---@return IllustratedHandbookKeywordEncyDojo
function IllustratedHandbookProperNounWordCell:GetCellData()
    return checkTable(self.cellData_)
end
---@param cellData IllustratedHandbookKeywordEncyDojo
function IllustratedHandbookProperNounWordCell:SetCellData(cellData)
    self.cellData_ = checkTable(cellData)
    self:UpdateCellInfo_()
end


---@return fun(luaIndex:integer, cellData:IllustratedHandbookKeywordEncyDojo):void
function IllustratedHandbookProperNounWordCell:GetClickCellCB()
    return self.clickCellCallback_
end
---@param callback fun(luaIndex:integer, cellData:IllustratedHandbookKeywordEncyDojo):void
function IllustratedHandbookProperNounWordCell:SetClickCellCB(callback)
    self.clickCellCallback_ = callback
end


-------------------------------------------------
-- private

function IllustratedHandbookProperNounWordCell:UpdateCellInfo_()
    local encyDojo = self:GetCellData()

    if encyDojo.isUnlock then
        local encyVo = checkTable(encyDojo.encyVo)
        CfUtils.FillText(self.wordTxt, encyVo.name)
        CfUtils.SetActive(self.lockNode, false)
    else
        CfUtils.FillText(self.wordTxt, '')
        CfUtils.SetActive(self.lockNode, true)
    end
end


-------------------------------------------------
-- handler

function IllustratedHandbookProperNounWordCell:OnClickWordCellHandler_()
    if self:GetClickCellCB() then
        self:GetClickCellCB()(self:GetLuaIndex(), self:GetCellData())
    end
end


return IllustratedHandbookProperNounWordCell
