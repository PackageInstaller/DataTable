---@type OverseaClubCatCarMgr
local Mgr = import("Game.UI.Club.CatCar.OverseaClubCatCarMgr"):GetInstance()
---@type OverseaClubCatCarUtils
local OverseaClubCatCarUtils = import("Game.UI.Club.CatCar.OverseaClubCatCarUtils")

--- from: Assets/BundleResources/Prefabs/OverClub/OverseaClubCatCarGradeNode.prefab > name: OverseaClubCatCarGradeNode
---@class OverseaClubCatCarGradeNode
---@field Env                           	OverseaClubCatCarGradeNode              
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field Slider                        	UnityEngine.UI.Slider                   	@ 0    
---@field Normal                        	UnityEngine.RectTransform               	@ 1    
---@field TextDesc                      	UnityEngine.RectTransform               	@ 2    
---@field BtnPreview                    	UnityEngine.RectTransform               	@ 3    
---@field ImgGrade1                     	UnityEngine.RectTransform               	@ 4    
---@field FInish                        	UnityEngine.RectTransform               	@ 5    
---@field Available                     	UnityEngine.RectTransform               	@ 6    
---@field BtnDrawReward                 	UnityEngine.RectTransform               	@ 7    
---@field ImgGrade2                     	UnityEngine.RectTransform               	@ 8    
local OverseaClubCatCarGradeNode = Class("OverseaClubCatCarGradeNode")

---@class OverseaClubCatCarGradeNode.InputData
---@field desc string 多少人到达
---@field grade number
---@field isDrawed boolean
---@field curPoints number
---@field carGo UnityEngine.Transform
---@field tipsBoard UnityEngine.Transform

function OverseaClubCatCarGradeNode:__init()
    self.controller = nil
end

function OverseaClubCatCarGradeNode:__delete()
    self.controller = nil
end

function OverseaClubCatCarGradeNode:Awake()
    SetButtonAction(self.BtnPreview,Bind(self,self.OnPreviewClick))
    SetButtonAction(self.BtnDrawReward,Bind(self,self.OnDrawRewardClick))
end

---@param inData OverseaClubCatCarGradeNode.InputData
function OverseaClubCatCarGradeNode:RefreshData(inData)
    self.inData = inData
    if self.controller.gameObject.activeSelf == true then
        self:RefreshUI()
    end
end

function OverseaClubCatCarGradeNode:RefreshUI()
    ---@type ClubCatCarSpeedGradeVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",self.inData.grade)
    local leftPoints = vo.mileage
    local rightPoints = vo.mileage * 3
    local curPoints = checkNumber(self.inData.curPoints)
    local voNext = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",self.inData.grade + 1)
    if voNext then
        rightPoints = voNext.mileage
    end
    self.Slider.value = (curPoints - leftPoints) / (rightPoints - leftPoints)

    if curPoints >= leftPoints and curPoints < rightPoints then
        --设置车的位置
        self.inData.carGo:SetParent(self.controller.transform)
        local pos = self.inData.carGo.anchoredPosition
        self.inData.carGo.anchoredPosition = Vector3(self.Slider.value * self.Slider:GetComponent("RectTransform").rect.width - 40,pos.y,pos.z)
        self.inData.carGo:SetParent(self.controller.transform.parent)
    end

    if self.inData.grade > 1 then
        CfUtils.FillText(self.TextDesc,self.inData.desc)    
    end
    
    if curPoints >= leftPoints and not self.inData.isDrawed then
        CfUtils.SetActive(self.Normal,false)
        CfUtils.SetActive(self.Available,true)
        --CfUtils.FillImage(self.ImgGrade2,OverseaClubCatCarUtils:GetGradeImgName_1(self.inData.grade))
        CfUtils.SetUISwitchImage(self.ImgGrade2,self.inData.grade)
    else
        CfUtils.SetActive(self.Normal,true)
        CfUtils.SetActive(self.Available,false)
        --CfUtils.FillImage(self.ImgGrade1,OverseaClubCatCarUtils:GetGradeImgName_1(self.inData.grade))
        CfUtils.SetUISwitchImage(self.ImgGrade1,self.inData.grade)
        CfUtils.SetActive(self.FInish,self.inData.isDrawed)
    end
end

function OverseaClubCatCarGradeNode:OnPreviewClick()
    ---@type ClubRewardTips
    local rewardTips = CfUtils.GetLuaScr(self.inData.tipsBoard,"Game.UI.Club.CatCar.Speed.ClubRewardTips")
    ---@type ClubCatCarSpeedGradeVo
    local vo = CfUtils.GetCfVo(AutoIds.IdSetting6281,"ClubCatCarSpeedGradeVo",self.inData.grade)
    ---@type ClubRewardTips.InputData
    local data = {}
    data.rewards = {}
    --for i, v in ipairs(vo.progressRewards) do
    --    table.insert(data.rewards, {goodsId = v, num = })
    --end
    for i = 1, #vo.progressRewards do
        table.insert(data.rewards, {goodsId = vo.progressRewards[i], num = vo.progressNumber[i]})
    end
    data.pos = self.BtnPreview.position
    rewardTips:RefreshData(data)
end

function OverseaClubCatCarGradeNode:OnDrawRewardClick()
    Mgr.Server:ReqDrawCarTrackRewards(self.inData.grade,function(data)
        self.inData.isDrawed = true
        self:RefreshUI()
    end)
end

return OverseaClubCatCarGradeNode