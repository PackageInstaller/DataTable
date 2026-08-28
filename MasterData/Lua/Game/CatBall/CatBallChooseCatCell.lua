
--region global define

--endregion

--region import
---@type CatBallUtils
local CatBallUtils =  import("Game.CatBall.CatBallUtils")
---@type Engine.Lib.KTool
local KTool            = CS.Engine.Lib.KTool
--endregion

--region define
--endregion

--- from: Assets/BundleResources/Prefabs/FightTeam/CatBallChooseCardsCell.prefab
---@class CatBallChooseCatCell
---@field Env                           	CatBallChooseCatCell                    
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgNotGet                     	UnityEngine.RectTransform               
---@field ImgSelect                     	UnityEngine.CanvasGroup               
---@field ChoosePosText                 	TMPro.TextMeshProUGUI                   
---@field BtnDelete                     	UnityEngine.RectTransform               
---@field Choose                        	UnityEngine.CanvasGroup               
---@field StatusGroup                   	UnityEngine.RectTransform               
---@field CommonSmallCatBallNode        	UnityEngine.RectTransform               
local CatBallChooseCatCell = Class('CatBallChooseCatCell')

function CatBallChooseCatCell:__init()

end


function CatBallChooseCatCell:__delete()

end


function CatBallChooseCatCell:Awake()
end


function CatBallChooseCatCell:Start()
    SetButtonAction(self.BtnDelete, Bind(self, self.OnClickBtnDeleteAction))
end


function CatBallChooseCatCell:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


--region init 


--endregion 


--region logic 

---FreshUI
---@param catBallEntity CatBallEntity
function CatBallChooseCatCell:FreshUI(catBallEntity, playerCatId2Index, maxCount, isShow, isLimit)
    self._catBallEntity = catBallEntity
    self._maxCount      = maxCount
    local catEggDojo    = catBallEntity.dojo
    local id            = catEggDojo.id

    CatBallUtils.FreshCommonSmallCatBallNode(self.CommonSmallCatBallNode, catBallEntity, self._callback)

    self:FreshSelectState(isShow)
    self:FreshChooseShowState(maxCount, playerCatId2Index[id],nil,isLimit)

    self:FreshLimitStatus(isLimit)
end

function CatBallChooseCatCell:FreshLimitStatus(isLimit)
    KTool.SetActive(self.LimitMask.gameObject,isLimit)
end

function CatBallChooseCatCell:FreshSelectState(isShowStatus)
    --- ImgSelect：初始状态不显示 
    GameUtils.UpdateUIShowStateByCanvasGroup(self.ImgSelect, isShowStatus)
    
end

function CatBallChooseCatCell:FreshChooseShowState(maxSelectCount, teamIndex, isHideDel,isLimitCat)
    --- Choose：在编队中时显示
    --- Choose/BtnDelete：最大选择个数是1时不显示减号
    local isMulti = maxSelectCount > 1
    KTool.SetActive(self.BtnDelete.gameObject, isMulti and isHideDel ~= true)

    if isLimitCat then
        GameUtils.UpdateUIShowStateByCanvasGroup(self.Choose, false)
    else
        GameUtils.UpdateUIShowStateByCanvasGroup(self.Choose, teamIndex ~= nil)
    end

    KTool.SetActive(self.ChoosePosText.gameObject, isMulti)
    if isMulti then
        self.ChoosePosText.text = teamIndex
    end
end

--endregion 


--region get/set 

function CatBallChooseCatCell:SetCallback(callback)
    self._callback = callback
end

function CatBallChooseCatCell:SetDeleteCallback(callback)
    self._deleteCallback = callback
end

---endregion 


--region handler 

function CatBallChooseCatCell:OnClickBtnDeleteAction()
    if self._deleteCallback then
        local res = self._deleteCallback(self._catBallEntity)
        if res then
            self:FreshSelectState(false)
            self:FreshChooseShowState(self._maxCount, nil, true)
        end
    end
end

---endregion 


return CatBallChooseCatCell
