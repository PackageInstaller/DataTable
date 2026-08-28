--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyRewardNode140004.prefab > name: ActivityMonopolyRewardNode140004
---@class ActivityThrowDiceRewardNode
---@field Env                           	ActivityThrowDiceRewardNode             
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field BtnIcon                       	UnityEngine.RectTransform               	@ 0    
---@field GoodsTxtNumIcon               	UnityEngine.RectTransform               	@ 1    
---@field GoodsImgIcon                  	UnityEngine.RectTransform               	@ 2    
---@field DiceIndex                     	UnityEngine.RectTransform               	@ 3    
---@field Get                           	UnityEngine.RectTransform               	@ 4    
---@field UIFX_glowBoom                 	UnityEngine.RectTransform               	@ 5    
---@field root                          	UnityEngine.RectTransform               	@ 6    
---@field ImgBg                         	UnityEngine.RectTransform               	@ 7    
---@field TxtLevelNum                   	UnityEngine.RectTransform               	@ 8    
---@field TxtLevelNumRed                	UnityEngine.RectTransform               	@ 9    
local ActivityThrowDiceRewardNode = Class('ActivityThrowDiceRewardNode')

local KTool = CS.Engine.Lib.KTool
function ActivityThrowDiceRewardNode:__init()
    self.currentIndex = nil
end


function ActivityThrowDiceRewardNode:__delete()
end


function ActivityThrowDiceRewardNode:Awake()

end


function ActivityThrowDiceRewardNode:Start()

end

function ActivityThrowDiceRewardNode:RefreshUI(nowCellNum , currentIndex , vo )
    self.currentIndex = currentIndex 
    if nowCellNum >= currentIndex then
        KTool.SetActive(self.Get , true)  
    else 
        KTool.SetActive(self.Get , false)  
    end
    local goodsId = vo.rewardData[1].goodsId 
    local goodsPath = GoodsUtils.GetGoodsIconById(goodsId)
    CfUtils.FillImage(self.GoodsImgIcon , goodsPath , true)
    SetButtonAction(self.BtnIcon , function()
        local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(goodsId)
        if isTable(goodsVo) then
            GameUtils.ShowCommonTipsBoard(self.BtnIcon.gameObject, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
        end
    end)
    CfUtils.FillText(self.GoodsTxtNumIcon , "x" ..  vo.rewardData[1].num )
    CfUtils.FillImage(self.ImgBg , CfUtils.GetImageFullPath(vo.showType), true )
    if vo.showType == "189:activity_monopoly_cell1" then
        KTool.SetActive(self.TxtLevelNum , true)
        KTool.SetActive(self.TxtLevelNumRed , true)
        CfUtils.FillText(self.TxtLevelNum , vo.level)
        CfUtils.FillText(self.TxtLevelNumRed , "")
    else     
        KTool.SetActive(self.TxtLevelNum , true)
        KTool.SetActive(self.TxtLevelNumRed , true)
        CfUtils.FillText(self.TxtLevelNum ,"" )
        CfUtils.FillText(self.TxtLevelNumRed , vo.level)
    end
end

function ActivityThrowDiceRewardNode:GetReward()
    KTool.SetActive(self.Get , true) 
end

function ActivityThrowDiceRewardNode:OnDestroy()
    self.currentIndex = nil
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityThrowDiceRewardNode
