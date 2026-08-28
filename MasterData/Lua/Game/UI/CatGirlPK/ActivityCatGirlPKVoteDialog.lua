--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKVoteDialog.prefab > name: ActivityCatGirlPKVoteDialog
---@class ActivityCatGirlPKVoteDialog
---@field Env                           	ActivityCatGirlPKVoteDialog             
---@field controller                    	Engine.UI.UILuaDialog                   
---@field BossDrawingNode               	Game.Native.Common.DrawingNode          	@ 0    
---@field SecondBgGroup                 	UnityEngine.RectTransform               	@ 1    
---@field OtherBgGroup                  	UnityEngine.RectTransform               	@ 2    
---@field FirstBgGroup                  	UnityEngine.RectTransform               	@ 3    
---@field CardTxtName                   	UnityEngine.RectTransform               	@ 4    
---@field TxtNum                        	UnityEngine.RectTransform               	@ 5    
---@field ImgGoodsIcon                  	UnityEngine.RectTransform               	@ 6    
---@field InputFieldNumber              	TMPro.TMP_InputField                    	@ 7    
---@field BtnAdd                        	UnityEngine.RectTransform               	@ 8    
---@field BtnMinusMin                   	UnityEngine.RectTransform               	@ 9    
---@field BtnAddMax                     	UnityEngine.RectTransform               	@ 10   
---@field BtnMinus                      	UnityEngine.RectTransform               	@ 11   
---@field ButtonVote                    	UnityEngine.RectTransform               	@ 12   
---@field VoteImgGoodsIcon              	UnityEngine.RectTransform               	@ 13   
---@field VoteText                      	UnityEngine.RectTransform               	@ 14   
---@field DialogBox                     	UnityEngine.RectTransform               	@ 15   
---@field DialogText                    	UnityEngine.RectTransform               	@ 16   
local ActivityCatGirlPKVoteDialog = Class('ActivityCatGirlPKVoteDialog')
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
local KTool = CS.Engine.Lib.KTool
function ActivityCatGirlPKVoteDialog:__init()
    self.characterArray = nil
    self.oneCardData = nil
    self.roleId = nil
    self.cardId = nil
    self.valueNum = 1
    self.sortIndex = nil
end


function ActivityCatGirlPKVoteDialog:__delete()
    self.characterArray = nil
    self.roleId = nil
    self.oneCardData = nil
    self.cardId = nil
    self.valueNum = nil
    self.sortIndex = nil
end


function ActivityCatGirlPKVoteDialog:Awake()
    SetButtonAction(self.BtnAdd,Bind(self, self.AddClick))
    SetButtonAction(self.BtnMinusMin,Bind(self, self.MinClick))
    SetButtonAction(self.BtnAddMax,Bind(self, self.MaxClick))
    SetButtonAction(self.BtnMinus,Bind(self, self.ReduceClick))
    SetButtonAction(self.ButtonVote,Bind(self, self.ButtonVoteClick))
    self.InputFieldNumber.onValueChanged:AddListener(Bind(self, self.OnValueChangedBuyNumInputHandler_))
end
-- 投票事件
function ActivityCatGirlPKVoteDialog:ButtonVoteClick()
    if ActivityVoteComponent:GetDojo().status == 2 then
        GameUtils.Toast(localize("投票结算中"))
        return
    end

    if ActivityVoteComponent:GetDojo().status == 3 then
        GameUtils.Toast(localize("当前赛事投票已结束"))
        return
    end
    local goodsId =  ActivityVoteComponent:GetVoteGoodsId()
    local num = GoodsUtils.GetThingNo(goodsId)
    if self.valueNum > num then
        GameUtils.Toast(localize("道具不足"))
        return
    end
    GameUtils.Request(Interfaces.ActivityVoteVote , {activityUuid = ActivityVoteComponent:GetActivityUuid() ,cardId = self.cardId , num = self.valueNum }, function(request, response)
        if checkNumber(response.errCode) ~= 0 then return end
        GoodsUtils.ConsumeGoods({{goodsId = ActivityVoteComponent:GetVoteGoodsId() , num = self.valueNum}} , true)
        local myVoteNum = ActivityVoteComponent:GetDojo().myVoteNum
        ActivityVoteComponent:GetDojo().myVoteNum = myVoteNum + 1 
        self.oneCardData.value = self.valueNum + self.oneCardData.value 
        GameUtils.Request(Interfaces.ActivityVoteHome , {activityUuid = ActivityVoteComponent:GetActivityUuid() } ,  function(request, response)
            if checkNumber(response.errCode) ~= 0 then return end
            ActivityVoteComponent:InitData(ActivityVoteComponent:GetActivityUuid(), response.data)
            ---@type ActivityVoteComponent
            local dojo =  ActivityVoteComponent:GetDojo()
            if dojo.currentRound == 1 then
                self.characterArray = ActivityVoteComponent:GetSortCharacterId(self.roleId)
                for k, v in pairs(self.characterArray) do
                    if v.cardId == self.cardId then
                        self.sortIndex = k 
                        self.oneCardData = v
                        self:RefreshCardSkinId(v.defaultSkin)
                        break
                    end
                end
            else
                local voteRank =  ActivityVoteComponent:GetVotesRoleRank()
                for k, v in pairs(voteRank) do
                    if checkInt(v.cardId)  == self.cardId then
                        self.sortIndex = k 
                        ---@type CardVo
                        local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' ,v.cardId)
                        v.defaultSkin = cardVo.defaultSkin
                        self.oneCardData = v
                        self:RefreshCardSkinId(cardVo.defaultSkin)
                        break
                    end
                end
            end
            self:UpdateUI()
        end)
    end)
end

function ActivityCatGirlPKVoteDialog:RefreshCardSkinId(skinId)
    self.BossDrawingNode:Execute(skinId)
end

---@param targetNum integer
function ActivityCatGirlPKVoteDialog:OnValueChangedBuyNumInputHandler_(targetNum)
    self:ChangeTextNum(checkInt(targetNum))
end


function ActivityCatGirlPKVoteDialog:ChangeTextNum(num)
    local goodsId = ActivityVoteComponent:GetVoteGoodsId()
    local ownNum = GoodsUtils.GetThingNo(goodsId)
    if num >1 and  num > ownNum then
        num  = ownNum > 1 and ownNum or 1
        self.InputFieldNumber.text = tostring(num)  
        self.valueNum = num 
        GameUtils.Toast(localize("道具不足"))
        return
    end
    self.valueNum = num 
    self.InputFieldNumber.text = tostring(num) 
end

function ActivityCatGirlPKVoteDialog:AddClick()
    local num = checkInt(self.InputFieldNumber.text) 
    num = num +1
    self:ChangeTextNum(num)
end

function ActivityCatGirlPKVoteDialog:ReduceClick()
    local num = checkInt(self.InputFieldNumber.text)
    num  = num > 1 and num -1 or 1
    self:ChangeTextNum(num) 
end

function ActivityCatGirlPKVoteDialog:MinClick()
    self:ChangeTextNum(1)
end

function ActivityCatGirlPKVoteDialog:MaxClick()
    local goodsId = ActivityVoteComponent:GetVoteGoodsId()
    local ownNum = GoodsUtils.GetThingNo(goodsId)
    ownNum =  ownNum > 0 and ownNum or 1
    self:ChangeTextNum(ownNum)
end

function ActivityCatGirlPKVoteDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
    end)
end

function ActivityCatGirlPKVoteDialog:UpdateUI()
    local goodsId = ActivityVoteComponent:GetVoteGoodsId()
    local goodsPath = GoodsConfMgr:GetInstance():GetPhotoPathById(goodsId)
    CfUtils.FillImage(self.ImgGoodsIcon ,goodsPath) 
    -- local ownNum = GoodsUtils.GetThingNo(goodsId)
    CfUtils.FillText(self.TxtNum , checkInt(self.oneCardData.value))
    if self.sortIndex == 1 then
       KTool.SetActive(self.FirstBgGroup.gameObject , true) 
       KTool.SetActive(self.SecondBgGroup.gameObject , false) 
       KTool.SetActive(self.OtherBgGroup.gameObject , false)
    elseif self.sortIndex == 2 or self.sortIndex == 3 then
        KTool.SetActive(self.FirstBgGroup.gameObject , false) 
        KTool.SetActive(self.SecondBgGroup.gameObject , true) 
        KTool.SetActive(self.OtherBgGroup.gameObject , false)
        local ImgNumber = self.SecondBgGroup.transform:Find("ImgNumber")
        CfUtils.SetUISwitchImage(ImgNumber.gameObject , self.sortIndex -1)
    else 
        KTool.SetActive(self.FirstBgGroup.gameObject , false) 
        KTool.SetActive(self.SecondBgGroup.gameObject , false) 
        KTool.SetActive(self.OtherBgGroup.gameObject , true)
       local TxtNo = self.OtherBgGroup.transform:Find("TxtNo")
       if isNotNull(TxtNo) then
            CfUtils.FillText(TxtNo.gameObject , "NO."  .. self.sortIndex)
       end
    end
    ---@type CardSkinVo
    local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", self.oneCardData.defaultSkin)
    CfUtils.FillText(self.CardTxtName,cardVo.name)
    self:UpdateVoteGoodsNum()
    ---@type RoleVoiceVo
    local vo =  RoleVoiceMgr:GetInstance():__PlayRoleVoiceByCardIdAndLevel(self.oneCardData.cardId, ActivityVoteComponent:GetDojo().homeLinesId ,nil , false , nil)
    CfUtils.FillText(self.DialogText , vo:GetDesk())
end
function ActivityCatGirlPKVoteDialog:UpdateVoteGoodsNum()
    local goodsId = ActivityVoteComponent:GetVoteGoodsId()
    local goodsPath = GoodsConfMgr:GetInstance():GetPhotoPathById(goodsId)
    CfUtils.FillImage(self.VoteImgGoodsIcon ,goodsPath)
    -- CfUtils.FillText(self.VoteText , self.valueNum)
end
function ActivityCatGirlPKVoteDialog:OnShow()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
    
        self.cardId = checkInt(initParams.cardId) 
        self.roleId = initParams.roleId  
        ---@type ActivityVoteComponent
        local dojo =  ActivityVoteComponent:GetDojo()
        if dojo.currentRound == 1 then
            self.characterArray = ActivityVoteComponent:GetSortCharacterId(self.roleId)
            for k, v in pairs(self.characterArray) do
                if v.cardId == self.cardId then
                    self.sortIndex = k 
                    self.oneCardData = v
                    self:RefreshCardSkinId(v.defaultSkin)
                    break
                end
            end
        else
            local voteRank =  ActivityVoteComponent:GetVotesRoleRank()
            for k, v in pairs(voteRank) do
                if checkInt(v.cardId)  == self.cardId then
                    self.sortIndex = k 
                    ---@type CardVo
                    local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' ,v.cardId)
                    v.defaultSkin = cardVo.defaultSkin
                    self.oneCardData = v
                    self:RefreshCardSkinId(cardVo.defaultSkin)
                    break
                end
            end
        end
        self:UpdateUI()
    end)
end

function ActivityCatGirlPKVoteDialog:OnFocus(focus)
    if focus then
        local voteGoodsId = ActivityVoteComponent:GetVoteGoodsId()
        CfUtils.RefreshTopGoods({voteGoodsId})
    end
end
function ActivityCatGirlPKVoteDialog:OnFinalize()
    return CoWaitDo(function()
        self.InputFieldNumber.onValueChanged:RemoveAllListeners()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityCatGirlPKVoteDialog
