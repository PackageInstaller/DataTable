
------------ import ------------
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
local KTool = CS.Engine.Lib.KTool
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaCardCareerDescView.prefab
---@class CardProgressionCardCareerDescTips
---@field Env                           	CardProgressionCardCareerDescTips                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field Arrow                         	UnityEngine.RectTransform               
---@field Bg                            	UnityEngine.RectTransform               
---@field EventReceive                  	UnityEngine.RectTransform               
---@field TxtDesc4                      	UnityEngine.UI.Text                     
---@field TxtDesc3                      	UnityEngine.UI.Text                     
---@field TxtDesc2                      	UnityEngine.UI.Text                     
---@field TxtDesc1                      	UnityEngine.UI.Text                     
local CardProgressionCardCareerDescTips = Class('CardProgressionCardCareerDescTips', CommonTipsBoard)

function CardProgressionCardCareerDescTips:__init()

    CommonTipsBoard.__init(self)
end


function CardProgressionCardCareerDescTips:__delete()

    CommonTipsBoard.__delete(self)
end


function CardProgressionCardCareerDescTips:Awake()
    CommonTipsBoard.Awake(self)
    CommonTipsBoard.Init(self)
end


-- function CardProgressionCardCareerDescTips:Start()
-- end


function CardProgressionCardCareerDescTips:OnDestroy()
    CommonTipsBoard.OnDestroy(self)
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


---------------------------------------------------
--- init begin --
---------------------------------------------------

function CardProgressionCardCareerDescTips:InitValue()
    CommonTipsBoard.InitValue(self)

    --- 2. 初始化 属性克制数据
    --- 属性克制  2021.05.26 zzy 让改回 读表
    local t = {Constants.CardAttrType.Fire, Constants.CardAttrType.Light, Constants.CardAttrType.Dark}
    local descList = {}
    local t1 = {}
    for i, id in ipairs(t) do
        local desc, desc1 = cardConfMgr:GetCardAttrDescByType(id)
        if i == 1 then
            table.insert(descList, desc)
            table.insert(descList, desc1)
        else
            t1[1], t1[2] = desc, desc1
            table.insert(descList, table.concat(t1, "\n"))
        end
        
    end
    -- self._careerDataList = dataList
    self._attributeRestraintList = descList
end

function CardProgressionCardCareerDescTips:FreshUI()
    for i, desc in ipairs(self._attributeRestraintList) do
        ---@type UnityEngine.UI.Text
        local node = self[string.format("TxtDesc%s", i)]
        if node then
            
            node.text = desc
        end
    end
end



---------------------------------------------------
--- init end --
---------------------------------------------------


---------------------------------------------------
--- logic begin --
---------------------------------------------------


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


return CardProgressionCardCareerDescTips
