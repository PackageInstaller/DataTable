
--region global define
local isNull    = isNull
local isNotNull = isNotNull

--endregion

--region import
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')

---@type CardProgressionSkillUtils
local CardProgressionSkillUtils = import("Game.CardProgression.CardProgressionSkillUtils")
---@type CardProgressionConstants
local CardProgressionConstants = import("Game.CardProgression.CardProgressionConstants")
--endregion

--region define
local CellName = "ComTipsFashionDetailsNode"
local CellPath = "Game.UI.Common.ComTipsFashionDetailsNode"
--endregion

--- from: Assets/BundleResources/Prefabs/Common/CommonTipsFashionDetails.prefab > name: CommonTipsFashionDetails
---@class CommonTipsFashionDetails
---@field Env                           	CommonTipsFashionDetails                
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Arrow                         	UnityEngine.RectTransform               	@ 0    
---@field Bg                            	UnityEngine.RectTransform               	@ 1    
---@field ImgAttribute                  	Engine.UI.ImageAlterable                	@ 2    
---@field TxtNum                        	TMPro.TextMeshProUGUI                   	@ 3    
---@field TxtTitle                      	UnityEngine.UI.Text                     	@ 4    
---@field LoopList                      	SuperScrollView.LoopListView2           	@ 5    
local CommonTipsFashionDetails = Class('CommonTipsFashionDetails', CommonTipsBoard)

function CommonTipsFashionDetails:__init()
    CommonTipsBoard.__init(self)    
end


function CommonTipsFashionDetails:__delete()
    CommonTipsBoard.__delete(self)
end


-- function CommonTipsFashionDetails:Awake()
--     CommonTipsBoard.Awake(self)
--     CommonTipsBoard.Init(self)
-- end


-- function CommonTipsFashionDetails:Start()
-- end

function CommonTipsFashionDetails:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param attribute SingleAttrTypeData
---@param dataList {skinId:number, level:number, attrV:number}[]
function CommonTipsFashionDetails:FreshUI(attribute, dataList)
    self.attribute = attribute
    self.dataList = dataList

    table.sort(dataList, function (a, b)
        return a.attrV > b.attrV
    end)

    self.ImgAttribute:LoadSprite(attribute.icon)
    self.TxtTitle.text = attribute.name
    self.TxtNum.text = attribute.attrNum

    self:FreshList()
end

function CommonTipsFashionDetails:FreshList()
    local maxNum = #self.dataList
    local LoopList = self.LoopList
    if not LoopList.IsListViewInit then
        LoopList:InitListView(maxNum, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(LoopList, maxNum)
    end
end

function CommonTipsFashionDetails:OnGetItemByIndex(loopListView, index)
    if index < 0 then
        return nil
    end

    local cell = loopListView:NewListViewItem(CellName)
    local luaB = GetLuaBehaviour(cell.gameObject, CellPath)
    if not cell.IsInitHandlerCalled then
        cell.IsInitHandlerCalled = true
        luaB:Init()
    end

    ---@type ComTipsFashionDetailsNode
    local env = luaB.Env

    local data = self.dataList[index + 1]
    env:FreshUI(self.attribute, data, index)

    return cell
end



--endregion 


--region get/set 


---endregion 


--region handler 


---endregion 


return CommonTipsFashionDetails
