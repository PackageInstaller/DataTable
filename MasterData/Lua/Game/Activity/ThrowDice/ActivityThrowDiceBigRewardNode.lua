--- from: Assets/BundleResources/Prefabs/Activity/ActivityMonopolyRewardBigNode140004.prefab > name: ActivityMonopolyRewardBigNode140004
---@class ActivityThrowDiceBigRewardNode
---@field Env                           	ActivityThrowDiceBigRewardNode          
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgBg                         	UnityEngine.RectTransform               	@ 0    
---@field BtnBuff                       	UnityEngine.RectTransform               	@ 1    
---@field UIFX_glowYellow               	UnityEngine.RectTransform               	@ 2    
---@field UIFX_glowPurple               	UnityEngine.RectTransform               	@ 3    
---@field GoodsImgIcon                  	UnityEngine.RectTransform               	@ 4    
---@field GoodsTxtNumIcon               	UnityEngine.RectTransform               	@ 5    
---@field DiceTxtIndex                  	UnityEngine.RectTransform               	@ 6    
---@field Get                           	UnityEngine.RectTransform               	@ 7    
---@field UIFX_glowBoom                 	UnityEngine.RectTransform               	@ 8    
---@field ImgBuff                       	UnityEngine.RectTransform               	@ 9    
---@field root                          	UnityEngine.RectTransform               	@ 10   
---@field BtnIcon                       	UnityEngine.RectTransform               	@ 11   
---@field Root                          	UnityEngine.RectTransform               	@ 12   
---@field TxtLevelNum                   	UnityEngine.RectTransform               	@ 13   
local ActivityThrowDiceBigRewardNode = Class('ActivityThrowDiceBigRewardNode')

local KTool = CS.Engine.Lib.KTool
function ActivityThrowDiceBigRewardNode:__init()

end


function ActivityThrowDiceBigRewardNode:__delete()
end


function ActivityThrowDiceBigRewardNode:Awake()

end

function ActivityThrowDiceBigRewardNode:RefreshUI(nowCellNum , currentIndex , vo ,buffGoodsId)
    self.currentIndex = currentIndex 
    if nowCellNum >= currentIndex then
        KTool.SetActive(self.Get , true)  
        CfUtils.StopAnimation(self.Root.gameObject , "ActivityMonopolyDialog_BtnBuff_Loop")
    else 
        CfUtils.PlayAnimation(self.Root.gameObject , "ActivityMonopolyDialog_BtnBuff_Loop")
        KTool.SetActive(self.Get , false)  
    end
    if not (vo.buff and table.count(vo.buff) > 2)  then
        KTool.SetActive(self.Root.parent , false)
        self.BtnIcon.transform:SetLocalX(0)
    else    
        self.BtnIcon.transform:SetLocalX(47.99995)
        KTool.SetActive(self.Root.parent , true)

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
    CfUtils.FillText(self.GoodsTxtNumIcon , "x" ..  vo.rewardData[1].num)
    CfUtils.FillText(self.TxtLevelNum , vo.level)
    CfUtils.FillImage(self.ImgBg , CfUtils.GetImageFullPath(vo.showType) )
    if #vo.buff > 2 then
        ---@type ThrowDiceBuffEffectVo
        local vo =  CfUtils.GetCfVo(AutoIds.IdSetting6601 , "ThrowDiceBuffEffectVo" , vo.buff[1])

        CfUtils.SetUISwitchImage(self.ImgBuff ,vo.quality)
        SetButtonAction(self.BtnBuff , function()
            local goodsVo = GoodsConfMgr:GetInstance():GetGoodsVoById(checkInt(buffGoodsId[vo.quality]))
            if isTable(goodsVo) then
                GameUtils.ShowCommonTipsBoard(self.BtnBuff.gameObject, goodsVo.name, goodsVo.desc, goodsVo.quality, goodsVo.id)
            end
        end)
    end
end

function ActivityThrowDiceBigRewardNode:GetReward()
    KTool.SetActive(self.Get , true) 
end


function ActivityThrowDiceBigRewardNode:Start()
end


function ActivityThrowDiceBigRewardNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityThrowDiceBigRewardNode
