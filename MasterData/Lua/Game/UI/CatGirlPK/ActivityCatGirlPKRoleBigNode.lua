--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/CatGirlPKRoleHeadBigNode.prefab > name: CatGirlPKRoleHeadBigNode
---@class ActivityCatGirlPKRoleBigNode
---@field Env                           	ActivityCatGirlPKRoleBigNode            
---@field controller                    	Engine.Modules.LuaBehaviour             
---@field ImgRole                       	UnityEngine.RectTransform               	@ 0    
---@field PKRankNode1                   	UnityEngine.RectTransform               	@ 1    
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 2    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 3    
---@field ImgNumber                     	UnityEngine.RectTransform               	@ 4    
---@field NotImgGoodsIcon               	UnityEngine.RectTransform               	@ 5    
---@field NotTxtNum                     	UnityEngine.RectTransform               	@ 6    
---@field PKRankNodeOther               	UnityEngine.RectTransform               	@ 7    
---@field ImgbgRank                     	UnityEngine.RectTransform               	@ 8    
---@field ImgbgRankOther                	UnityEngine.RectTransform               	@ 9    
---@field TxtName                       	UnityEngine.RectTransform               	@ 10   
---@field BtnRoot                       	UnityEngine.RectTransform               	@ 11   
---@field TwoTxtNum                     	UnityEngine.RectTransform               	@ 12   
---@field TwoImgGoodsIcon               	UnityEngine.RectTransform               	@ 13   
---@field TwoImgNumber                  	UnityEngine.RectTransform               	@ 14   
---@field PKRankNode2                   	UnityEngine.RectTransform               	@ 15   
local ActivityCatGirlPKRoleBigNode = Class('ActivityCatGirlPKRoleBigNode')
local KTool = CS.Engine.Lib.KTool
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
function ActivityCatGirlPKRoleBigNode:__init()
    self.cardId = nil
    self.callback = nil
end


function ActivityCatGirlPKRoleBigNode:__delete()
    self.cardId = nil
    self.callback = nil
end


function ActivityCatGirlPKRoleBigNode:Awake()
    SetButtonAction(self.BtnRoot , function ()
        if isNull(self.cardId) then
            return
        end
        if ActivityVoteComponent:GetDojo().status > 1 then
            GameUtils.Toast(localize("当前赛事投票已结束"))
            return
        end 
        -- 选择的卡牌
        self.callback(self.cardId)
    end)
end


function ActivityCatGirlPKRoleBigNode:Start()

end


function ActivityCatGirlPKRoleBigNode:Refresh(rankData , index , voteGoodsId ,callback )
    self.cardId = rankData.cardId
    -- local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , rankData.cardId)
    if index == 1 then
        -- local scale = (index == 1) and 0.7 or 0.48
        -- print(string.format( "UIAtlas/ActivityCatGirlPK12003201/activity_2024pk_no%s.png" , index))
        -- ---@type CardVo
        -- CfUtils.FillImage(self.ImgNumber.gameObject,string.format("UIAtlas/ActivityCatGirlPK12003201/activity_2024pk_no%s.png" , index), true )
        -- CfUtils.SetScale(self.PKRankNode1 , Vector3(scale,scale,scale)) 
        local goodsPath = GoodsConfMgr:GetInstance():GetPhotoPathById(voteGoodsId)
        CfUtils.FillImage(self.ImgGoodsIcon,goodsPath) 
        CfUtils.FillText(self.TxtNum , rankData.value)
        KTool.SetActive(self.PKRankNodeOther , false)
        KTool.SetActive(self.PKRankNode1 , true)
        KTool.SetActive(self.PKRankNode2 , false)
        CfUtils.SetUISwitchImage(self.ImgbgRank , index)
        KTool.SetActive(self.ImgbgRankOther , false)
        KTool.SetActive(self.ImgbgRank , true)
    elseif index == 2 or index == 3 then
        local goodsPath = GoodsConfMgr:GetInstance():GetPhotoPathById(voteGoodsId)
        ---@type CardVo
        CfUtils.FillImage(self.TwoImgNumber.gameObject,string.format("UIAtlas/ActivityCatGirlPK12003201/activity_2024pk_no%s.png" , index), true )
        CfUtils.FillImage(self.TwoImgGoodsIcon,goodsPath) 
        CfUtils.FillText(self.TwoTxtNum , rankData.value)
        KTool.SetActive(self.TwoPKRankNodeOther , false)
        KTool.SetActive(self.PKRankNode1 , false)
        KTool.SetActive(self.PKRankNode2 , true)
        -- CfUtils.SetUISwitchImage(self.ImgbgRank , index)
        KTool.SetActive(self.ImgbgRankOther , false)
        -- KTool.SetActive(self.ImgbgRank , true)
    else 
        local goodsPath = GoodsConfMgr:GetInstance():GetPhotoPathById(voteGoodsId)
        CfUtils.FillImage(self.NotImgGoodsIcon,goodsPath) 
        CfUtils.FillText(self.NotTxtNum , rankData.value)
        KTool.SetActive(self.PKRankNodeOther , true)
        KTool.SetActive(self.PKRankNode1 , false)  
        KTool.SetActive(self.PKRankNode2 , false)  
        KTool.SetActive(self.ImgbgRankOther , true)
        KTool.SetActive(self.ImgbgRank , false)
    end
    local cardSkin = checkNumber(rankData.defaultSkin)
    local cardSkinVo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", cardSkin)
    local path = checkString(cardSkinVo.cardHeadList)
    CfUtils.FillText(self.TxtName , cardSkinVo.name)
    CfUtils.FillImage(self.ImgRole , CfUtils.GetImageFullPath(path))
    self.callback = callback 
end

function ActivityCatGirlPKRoleBigNode:OnDestroy()
    self.controller = nil -- luaBehaviour 中 CSharp 对象
    self:Delete()
end


return ActivityCatGirlPKRoleBigNode
