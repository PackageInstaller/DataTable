-------------------------------------------------------------------------------
-- 海外图鉴 - 入口主界面 - 入口节点
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2023-08-20 23:39:07
-------------------------------------------------------------------------------

--- from: Assets/BundleResources/Prefabs/IllustratedHandbook/IllustbookEntryBtnOptionNode.prefab
---@class IllustratedHandbookEntryOptionNode
---@field Env                           	IllustratedHandbookEntryOptionNode      
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field redPoint                      	UnityEngine.RectTransform               @ 红点节点
---@field newImg                        	UnityEngine.RectTransform               @ 新状态节点
---@field numText                       	UnityEngine.RectTransform               @ 数量文本
local IllustratedHandbookEntryOptionNode = Class('IllustratedHandbookEntryOptionNode')


function IllustratedHandbookEntryOptionNode:__init()
end


function IllustratedHandbookEntryOptionNode:__delete()
end


function IllustratedHandbookEntryOptionNode:Awake()
    self:SetTotalNum(0)
    self:SetCurrentNum(0)
    self:SetShowRedPoint(false)
    self:SetShowNewMark(false)
end


function IllustratedHandbookEntryOptionNode:Start()
end


function IllustratedHandbookEntryOptionNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


-------------------------------------------------
-- get / set

---@return integer
function IllustratedHandbookEntryOptionNode:GetCurrentNum()
    return checkInt(self.currentNum_)
end
function IllustratedHandbookEntryOptionNode:SetCurrentNum(number)
    self.currentNum_ = checkInt(number)
    self:UpdateProgressTxt_()
end


---@return integer
function IllustratedHandbookEntryOptionNode:GetTotalNum()
    return checkInt(self.totalNum_)
end
function IllustratedHandbookEntryOptionNode:SetTotalNum(number)
    self.totalNum_ = checkInt(number)
    self:UpdateProgressTxt_()
end


---@return boolean
function IllustratedHandbookEntryOptionNode:IsShowRedPoint()
    return checkBool(self.isShowRedPoint_)
end
function IllustratedHandbookEntryOptionNode:SetShowRedPoint(isShow)
    self.isShowRedPoint_ = checkBool(isShow)
    CfUtils.SetActive(self.redPoint, self:IsShowRedPoint())
end


---@return boolean
function IllustratedHandbookEntryOptionNode:IsShowNewMark()
    return checkBool(self.isShowNewMark_)
end
function IllustratedHandbookEntryOptionNode:SetShowNewMark(isShow)
    self.isShowNewMark_ = checkBool(isShow)
    CfUtils.SetActive(self.newImg, self:IsShowNewMark())
end


-------------------------------------------------
-- private

function IllustratedHandbookEntryOptionNode:UpdateProgressTxt_()
    local numTxtFormat = '<color=#62FFF6><size=70>%1</size></color>/%2'
    CfUtils.FillText(self.numText, string.fmt(numTxtFormat, self:GetCurrentNum(), self:GetTotalNum()))
end


return IllustratedHandbookEntryOptionNode
