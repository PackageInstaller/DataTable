
------------ import ------------
---@type CardConfMgr
local cardConfMgr = CardConfMgr:GetInstance()
--- @type CommonTipsBoard
local CommonTipsBoard = import('Game.UI.Common.CommonTipsBoard')
------------ import ------------


------------ define ------------

------------ define ------------

--- from: Assets/BundleResources/Prefabs/CultivateOversea/CultivateOverseaRaceTips.prefab
---@class CardProgressionRaceTips
---@field Env                           	CardProgressionRaceTips                                     
---@field controller                    	Engine.Modules.LuaBehaviour | Engine.UI.UILuaDialog
---@field TextDesc                      	UnityEngine.UI.Text                     
---@field TextTitle                     	UnityEngine.UI.Text                     
---@field ImgRace                       	Engine.UI.RawImageAlterable             
---@field Arrow                         	UnityEngine.RectTransform               
---@field Bg                            	UnityEngine.RectTransform               
local CardProgressionRaceTips = Class('CardProgressionRaceTips', CommonTipsBoard)

function CardProgressionRaceTips:__init()
    CommonTipsBoard.__init(self)

end


function CardProgressionRaceTips:__delete()
    CommonTipsBoard.__delete(self)

end


function CardProgressionRaceTips:Awake()
    CommonTipsBoard.Awake(self)
end


function CardProgressionRaceTips:Start()
    CommonTipsBoard.Start(self)
end


function CardProgressionRaceTips:OnDestroy()
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

function CardProgressionRaceTips:FreshUI(raceId)
    ---@type RoleRaceVo
    local raceVo = cardConfMgr:GetRoleRaceVoById(raceId)
    self.ImgRace:LoadSprite(raceVo.icon)
    self.TextTitle.text = raceVo.name
    self.TextDesc.text  = raceVo.desc

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


return CardProgressionRaceTips
