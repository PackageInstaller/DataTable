-------------------------------------------------------------------------------
-- 通用战斗力提示框
-- 
-- Author: kaishiqi <zhangkai@funtoygame.com>
-- 
-- Create: 2024-02-26 17:09:21
-------------------------------------------------------------------------------


------------ import ------------
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
------------ import ------------

------------ define ------------
------------ define ------------


--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')

--- from: Assets/BundleResources/Prefabs/Common/CommonPowerTips.prefab > name: CommonPowerTips
---@class CommonPowerTips : CommonTipsBoard
---@field Env                           	CommonPowerTips                         
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Arrow                         	UnityEngine.RectTransform               	@ 0    
---@field Bg                            	UnityEngine.RectTransform               	@ 1    
---@field Node                          	UnityEngine.RectTransform               	@ 2    
---@field ArmedImageNode                	UnityEngine.RectTransform               	@ 3    
---@field TitleText                     	UnityEngine.RectTransform               	@ 4    
local CommonPowerTips = Class('CommonPowerTips', CommonTipsBoard)


function CommonPowerTips:__init()
    CommonTipsBoard.__init(self)
end


function CommonPowerTips:__delete()
    CommonTipsBoard.__delete(self)
end


function CommonPowerTips:Awake()
    CommonTipsBoard.Awake(self)
    CommonTipsBoard.Init(self)
end


function CommonPowerTips:Start()
    CommonTipsBoard.Start(self)
end


function CommonPowerTips:OnDestroy()
    CommonTipsBoard.OnDestroy(self)

    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------

---@param title string
---@param data table[] @ { { name : string, value : number }, ... }
function CommonPowerTips:FreshUI(title, data)
    CfUtils.FillText(self.TitleText, tostring(title))
    self._dataList = checkTable(data)
    self:UpdateAdditionListView_()
end


function CommonPowerTips:UpdateAdditionListView_()
    local parent = self.Bg.gameObject
    local node = self.Node.gameObject
    for index, value in ipairs(self._dataList) do
        local nodeGo = parent:AddChild(node)
        nodeGo.name  = 'additionNode_' .. index
        CfUtils.SetActive(nodeGo.transform:Find('ImgBackGround'), true)
        CfUtils.SetActive(nodeGo, true)
        self:UpdateAdditionListNode_(nodeGo, value, index)
    end
end


---@param nodeGo UnityEngine.GameObject
function CommonPowerTips:UpdateAdditionListNode_(nodeGo, data, index)
    CfUtils.FillText(nodeGo.transform:Find('TxtName'), tostring(data.name))
    CfUtils.FillText(nodeGo.transform:Find('TxtNumber'), string.format('+%s', checkNumber(data.value)))
    CfUtils.SetCanvasGroupAlpha(nodeGo.transform:Find('ImgBackGround'), index % 2)
end

---------------------------------------------------
--- logic end --
---------------------------------------------------


---------------------------------------------------
--- get/set begin ---
---------------------------------------------------


---------------------------------------------------
--- get/set end ---
---------------------------------------------------


---------------------------------------------------
--- handler begin ---
---------------------------------------------------


---------------------------------------------------
--- handler end ---
---------------------------------------------------


return CommonPowerTips
