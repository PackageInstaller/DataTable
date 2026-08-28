--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/RecommendTeam/RecommendTeamDialog.prefab > name: RecommendTeamDialog
---@class RecommendTeamCardDialog
---@field Env                           	RecommendTeamCardDialog                 
---@field controller                    	Engine.UI.UILuaDialog                   
---@field CellNode                      	UnityEngine.RectTransform               	@ 0    
---@field BtnReward                     	UnityEngine.RectTransform               	@ 1    
---@field AlreadyReceive                	UnityEngine.RectTransform               	@ 2    
---@field CanReceive                    	UnityEngine.RectTransform               	@ 3    
---@field TitleTextDesc                 	UnityEngine.RectTransform               	@ 4    
---@field CommonTabToggleLeft           	UnityEngine.RectTransform               	@ 5    
---@field CardLayout                    	UnityEngine.RectTransform               	@ 6    
---@field UIFX_ReceiveAward             	UnityEngine.RectTransform               	@ 7    
---@field redPoint                      	UnityEngine.RectTransform               	@ 8    
local RecommendTeamCardDialog = Class('RecommendTeamCardDialog')
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
local Config = {
    [1] = {
        text  = "开荒必备",
        selectImgPath = "Arts/Icons/HomeLabel/tab_ico_recommend.png"  ,
        textColor = {--这个字段被弃用，改为由switchText控制
             default = "#C5C5C5",
             selected = "#000000"
        }, 
        redPointStrNode = Constants.RedPointConst.RecommendCardMainPlot,
        func = function(config , index)
            self:RefreshMainPlot(config , index)
        end
    }
    
}
function RecommendTeamCardDialog:__init()
    self.CellNodes = {}
end


function RecommendTeamCardDialog:__delete()
    self.CellNodes = nil
end


function RecommendTeamCardDialog:RefreshMainPlot(config , index)
    ---@type RecommendTeamCardVo[]
    local RecommendTeamCardVos =  CfUtils.GetWholeVo(AutoIds.IdSetting8937 ,"RecommendTeamCardVo")
    for voIndex, cardVo in ipairs(RecommendTeamCardVos) do
        if not self.CellNodes[voIndex+1] then
            self.CellNodes[voIndex+1] = CfUtils.InstantiateGo(self.CellNode , self.CellNode.transform.parent)
        end
        KTool.SetActive(self.CellNodes[voIndex+1].gameObject , true)
        ---@type RecommendTeamCardNode
        local Env = CfUtils.GetLuaScr(self.CellNodes[voIndex+1] , "Game.Main.RecommendTeamCard.RecommendTeamCardNode") 
        Env:Refresh(cardVo)
    end     
    ---@type RecommendTeamCardParamterVo
    local RecommendTeamCardParamterVo = CfUtils.GetCfVo(AutoIds.IdSetting8938 ,"RecommendTeamCardParamterVo", "3")
    CfUtils.FillText(self.TitleTextDesc, RecommendTeamCardParamterVo.txt)
    self:UpdateBtnReward(Constants.RedPointConst.RecommendCardMainPlot)
    SetButtonAction(self.CanReceive , function ()
        GameUtils.Request(Interfaces.OverseaDrawRecommendReward , {}, function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            local data = response.data
            GoodsUtils.DrawRewards(data.rewards)
            UIModule.OpenDialog({ id = Constants.UITypeIds.UICommonRewardPop, parameters = { rewards = data.rewards } })
            GameUtils.SetRedPointNum(Constants.RedPointConst.RecommendCardMainPlot,0)
            GameUtils.InvokeRedPointCallBack(Constants.RedPointConst.RecommendCardMainPlot)
            self:UpdateBtnReward(Constants.RedPointConst.RecommendCardMainPlot)
        end)
    end)
end

function RecommendTeamCardDialog:UpdateBtnReward(redName)
    local num =  GameUtils.GetRedPointNum(Constants.RedPointConst.RecommendCardMainPlot)
    if num > 0 then
        KTool.SetActive(self.BtnReward.gameObject , true)
        KTool.SetActive(self.redPoint , true)
        KTool.SetActive(self.AlreadyReceive , false)
        KTool.SetActive(self.CanReceive , true)
        KTool.SetActive(self.UIFX_ReceiveAward , true)
    else 
        KTool.SetActive(self.BtnReward.gameObject , true)
        KTool.SetActive(self.redPoint , false)
        KTool.SetActive(self.CanReceive , false)
        KTool.SetActive(self.UIFX_ReceiveAward , false)
        KTool.SetActive(self.AlreadyReceive , true)
    end
end

function RecommendTeamCardDialog:Awake()
    
end


function RecommendTeamCardDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        self._leftToggleScr = CfUtils.GetLuaScr(self.CommonTabToggleLeft, "Game.Behaviours.CommonTabToggleLeft")
        if self._leftToggleScr then
            self._leftToggleScr:FillToggles(Config , 1)
            self:RefreshMainPlot(Config[1] , 1)
        end
    end)
end

function RecommendTeamCardDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return RecommendTeamCardDialog
