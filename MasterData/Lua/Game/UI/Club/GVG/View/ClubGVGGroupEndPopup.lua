
--region global define
local require   = require
local import    = import
local isNull    = isNull
local isNotNull = isNotNull
--endregion

--region import
local util             = require 'XLua.util'
local CoWait           = CS.Engine.Lib.CoWait

--endregion

--region define

--endregion

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubGvgGroupEndPopup.prefab > name: OverseaClubGvgGroupEndPopup
---@class ClubGVGGroupEndPopup
---@field Env                           	ClubGVGGroupEndPopup                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field TxtClubName                   	UnityEngine.UI.Text                     	@ 0    
---@field ImgIcon                       	Engine.UI.ImageAlterable                	@ 1    
---@field ClubTxtNumber                 	TMPro.TextMeshProUGUI                   	@ 2    
---@field PersonalTxtNumber             	TMPro.TextMeshProUGUI                   	@ 3    
---@field BtnSettlement                 	UnityEngine.RectTransform               	@ 4    
local ClubGVGGroupEndPopup = Class('ClubGVGGroupEndPopup')


function ClubGVGGroupEndPopup:__init()
end


function ClubGVGGroupEndPopup:__delete()
    self.controller = nil
end

--region init 

---@param parent UICultivateLevelUpFinishDialog
function ClubGVGGroupEndPopup:RefreshUI(params, parent)
    self:Request()
    self:InitAction()
end

function ClubGVGGroupEndPopup:Request()
    local res
    local completeCallback = function(request, response)
        if checkNumber(response.errCode) ~= 0 then 
            return 
        end

        local data = response.data
        self._clubRanking   = checkNumber(data.clubRanking)
        self._playerRanking = checkNumber(data.playerRanking)
        self._clubRecruit           = checkTable(data.clubRecruit)

        self:FreshUI()
        res = true
    end
    -- if true then
    --     local str = [[ {"clubRecruit":[{"atBuildingTimes":0,"avatar":6210019,"avatarFrame":6220030,"killPlayerNum":0,"level":128,"playerId":264070,"playerName":"家有五寶520","point":0},{"atBuildingTimes":0,"avatar":6200067,"avatarFrame":6220019,"killPlayerNum":0,"level":103,"playerId":3598092,"playerName":"赤櫻深靈","point":0},{"atBuildingTimes":0,"avatar":6210025,"avatarFrame":6220030,"killPlayerNum":0,"level":127,"playerId":1347313,"playerName":"堅果飽飽","point":0},{"atBuildingTimes":49,"avatar":6210008,"avatarFrame":6220008,"killPlayerNum":4,"level":123,"playerId":100569,"playerName":"PPDog","point":73},{"atBuildingTimes":146,"avatar":6210005,"avatarFrame":6220011,"killPlayerNum":3,"level":131,"playerId":1326079,"playerName":"zerolin086","point":163},{"atBuildingTimes":0,"avatar":6210025,"avatarFrame":6220019,"killPlayerNum":0,"level":130,"playerId":3486463,"playerName":"monyue","point":0},{"atBuildingTimes":48,"avatar":6210005,"avatarFrame":6220022,"killPlayerNum":0,"level":125,"playerId":391086,"playerName":"鬼飄羊","point":50},{"atBuildingTimes":50,"avatar":6200110,"avatarFrame":6200120,"killPlayerNum":3,"level":129,"playerId":111041,"playerName":"沉默的哈士奇","point":68},{"atBuildingTimes":0,"avatar":6210025,"avatarFrame":6200153,"killPlayerNum":0,"level":128,"playerId":154011,"playerName":"咐和君","point":0},{"atBuildingTimes":0,"avatar":6210025,"avatarFrame":6220022,"killPlayerNum":0,"level":126,"playerId":2436725,"playerName":"赤井秀喵","point":0},{"atBuildingTimes":0,"avatar":6210014,"avatarFrame":6220030,"killPlayerNum":0,"level":123,"playerId":895767,"playerName":"獅子毛","point":0},{"atBuildingTimes":0,"avatar":6200170,"avatarFrame":6220019,"killPlayerNum":0,"level":118,"playerId":463283,"playerName":"毛毛兒@","point":0},{"atBuildingTimes":0,"avatar":6210019,"avatarFrame":6220022,"killPlayerNum":0,"level":120,"playerId":146461,"playerName":"玥錵","point":0},{"atBuildingTimes":0,"avatar":6210015,"avatarFrame":6200114,"killPlayerNum":0,"level":127,"playerId":972460,"playerName":"昀棠","point":0},{"atBuildingTimes":0,"avatar":6210013,"avatarFrame":6200002,"killPlayerNum":0,"level":127,"playerId":897911,"playerName":"緋愷貓","point":0},{"atBuildingTimes":0,"avatar":6210015,"avatarFrame":6200114,"killPlayerNum":0,"level":121,"playerId":138797,"playerName":"狸猫换坤子","point":0},{"atBuildingTimes":0,"avatar":6210025,"avatarFrame":6220030,"killPlayerNum":0,"level":123,"playerId":127253,"playerName":"咖啡糖o","point":0},{"atBuildingTimes":0,"avatar":6200170,"avatarFrame":6200153,"killPlayerNum":0,"level":115,"playerId":296076,"playerName":"星星糖o","point":0}],"questGradeTaskProgress":[]} ]]
    --     local data = table.deserialize(str)
    --     data.clubRanking = 1
    --     data.playerRanking = 1
    --     completeCallback(nil, {data=  data, errCode = 0})
    --     return
    -- end
    
    GameUtils.Request(Interfaces.OverseaClubGVGClubSettlement, {}, completeCallback)

    local CoYield = CoYield
    while res == nil do
        CoYield()
    end
end

function ClubGVGGroupEndPopup:InitAction()
    SetButtonAction(self.BtnSettlement, Bind(self, self.OnClickBtnSettlement))
end

--endregion 


--region logic 

function ClubGVGGroupEndPopup:FreshUI()
    self.ClubTxtNumber.text = self._clubRanking
    self.PersonalTxtNumber.text = self._playerRanking
    local dojo = ClubUtils.GetClubComp():GetHomeDojo()
    self.TxtClubName.text = dojo.name

    local clubHeadVo = ClubUtils.GetClubHeadVo(dojo.avatar)
    self.ImgIcon:LoadSprite(clubHeadVo.photoPath)
end

--endregion 


--region get/set 


---endregion 


--region handler 

function ClubGVGGroupEndPopup:OnClickBtnSettlement()
    CfUtils.DialogOpen(Constants.UITypeIds.ClubGvgGroupFightMessageDialog, {clubRecruit = self._clubRecruit}, {
        UIArgs(Constants.UITypeIds.CultivateLevelUpSecondConfirmPanel),
    })

end

---endregion 


return ClubGVGGroupEndPopup
