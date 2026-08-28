--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKShortlistDialog.prefab > name: ActivityCatGirlPKShortlistDialog
---@class ActivityCatGirlPKCardAndRoleDialog
---@field Env                           	ActivityCatGirlPKCardAndRoleDialog      
---@field controller                    	Engine.UI.UILuaDialog                   
---@field TxtTime                       	UnityEngine.RectTransform               	@ 0    
---@field MatchTxtTitle                 	UnityEngine.RectTransform               	@ 1    
---@field BtnView                       	UnityEngine.RectTransform               	@ 2    
---@field LoopListRight                 	Engine.UI.AutoFixSizeListView           	@ 3    
---@field DownPanel1                    	UnityEngine.RectTransform               	@ 4    
---@field DownPanel2                    	UnityEngine.RectTransform               	@ 5    
---@field LeftGroup                     	UnityEngine.RectTransform               	@ 6    
---@field CatGirlPKRoleHeadMidNode1     	UnityEngine.RectTransform               	@ 7    
---@field CatGirlPKRoleHeadMidNode2     	UnityEngine.RectTransform               	@ 8    
---@field CatGirlPKRoleHeadMidNode3     	UnityEngine.RectTransform               	@ 9    
---@field LoopListRight2                	Engine.UI.AutoFixSizeListView           	@ 10   
local ActivityCatGirlPKCardAndRoleDialog = Class('ActivityCatGirlPKCardAndRoleDialog')
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
local CellPath = "Game.UI.CatGirlPK.CatGirlPKRoleHeadSmallNode"
local UIModule = CS.Engine.UI.UIModule
local KTool = CS.Engine.Lib.KTool
function ActivityCatGirlPKCardAndRoleDialog:__init()
    self.characterArray  = nil
    self.voteRoleRank = nil
end


function ActivityCatGirlPKCardAndRoleDialog:__delete()
    self.characterArray  = nil
    self.voteRoleRank = nil
end


function ActivityCatGirlPKCardAndRoleDialog:Awake()

end


function ActivityCatGirlPKCardAndRoleDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
    end)
end
function ActivityCatGirlPKCardAndRoleDialog:OnShow()
    return CoWaitDo(function()
        self:InitUI()
    end)
end

function ActivityCatGirlPKCardAndRoleDialog:InitUI()
    local dojo = ActivityVoteComponent:GetDojo()
    local currentRound = dojo.currentRound
    if currentRound == 1 then
        KTool.SetActive(self.DownPanel1.gameObject , true)
        KTool.SetActive(self.DownPanel2.gameObject , false)
        KTool.SetActive(self.BtnView , true)
        -- 走筛选赛
        self:LoopListRightView()
        SetButtonAction(self.BtnView , function ()
           -- 查看直接晋级的角色 
            self:OpenThroughGameDialog()
        end)
    else 
        KTool.SetActive(self.BtnView , false)
        self.voteRoleRank = ActivityVoteComponent:GetVotesRoleRank()
        --走淘汰赛和总决赛
        KTool.SetActive(self.DownPanel1.gameObject , false)
        KTool.SetActive(self.DownPanel2.gameObject , true)
        self:UpdateWeedOutThreeCell()
        self:LoopListRightView2()
    end
    self:UpdateTiteUI()
end
-- 查看直接晋级的角色
function ActivityCatGirlPKCardAndRoleDialog:OpenThroughGameDialog()
      UIModule.OpenDialog(
    { id = Constants.UITypeIds.ActivityCatGirlPKRoleViewDialog ,parameters = { isThroughGame = 1 }},
    {
        { id = Constants.UITypeIds.ActivityCatGirlPKCardAndRoleDialog } ,
        { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel } ,
        { id = Constants.UITypeIds.UIActivityMainDialog } 
    })
end

function ActivityCatGirlPKCardAndRoleDialog:UpdateTiteUI()
    local str =  ActivityVoteComponent:GetMatchTimeStr()
    CfUtils.FillText(self.TxtTime , str)
    local matchTexts = {
        localize("筛选赛"),
        localize("淘汰赛"),
        localize("总决赛"),
    }
    local currentRound = checkInt(ActivityVoteComponent:GetDojo().currentRound) 
    CfUtils.FillText(self.MatchTxtTitle , matchTexts[currentRound])
end
function ActivityCatGirlPKCardAndRoleDialog:UpdateWeedOutThreeCell()
    ---@type UnityEngine.RectTransform
    local cells = {self.CatGirlPKRoleHeadMidNode1 , self.CatGirlPKRoleHeadMidNode2 , self.CatGirlPKRoleHeadMidNode3 }
    for i = 1 , #cells do
        local transform = cells[i].transform
        local cardTxt = transform:Find("TxtName")
        local ImgGoodsIcon = transform:Find("PKRankNode/VoteGroup/ImgGoodsIcon/ImgGoodsIcon")
        local TxtNum = transform:Find("PKRankNode/VoteGroup/TxtNum")
        local ImgRole = transform:Find("Mask/ImgRole")
        ---@type CardVo
        local cardVo = CfUtils.GetCfVo(AutoIds.IdSetting28, 'CardVo' , self.voteRoleRank[i].cardId)
        ---@type CardSkinVo
        local cardSkinVo = CfUtils.GetCfVo(AutoIds.IdSetting113, "CardSkinVo", cardVo.defaultSkin)
        CfUtils.FillImage(ImgRole , CfUtils.GetImageFullPath(cardSkinVo.cardHeadList))
        CfUtils.FillText(TxtNum , self.voteRoleRank[i].value)
        CfUtils.FillText(cardTxt , cardSkinVo.name)
        CfUtils.FillImage(ImgGoodsIcon , GoodsConfMgr:GetInstance():GetPhotoPathById(ActivityVoteComponent:GetVoteGoodsId()))
        SetButtonAction(cells[i], function ()
            if ActivityVoteComponent:GetDojo().status > 1 then
                GameUtils.Toast(localize("当前赛事投票已结束"))
                return
            end 
            self:SetCardId(self.voteRoleRank[i].cardId)
        end)
    end
end


--走筛选赛
function ActivityCatGirlPKCardAndRoleDialog:LoopListRightView()
    self.characterArray = ActivityVoteComponent:GetAllCharacterArray()
    if not self.LoopListRight.mLoopListView.IsListViewInit then
        self.LoopListRight:InitListView(#self.characterArray, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.LoopListRight, #self.characterArray)
        self.LoopListRight:MovePanelToItemIndex(0)
    end
end

--走淘汰赛
function ActivityCatGirlPKCardAndRoleDialog:LoopListRightView2()
    local count = #self.voteRoleRank
    if count > 3 then
        count = count -3 
        if not self.LoopListRight2.mLoopListView.IsListViewInit then
            local cardId = checkInt(CfUtils.GetLocalData("VOTE_CARD_ID", 0))
            local index = 0
            if cardId > 0  then
                local rank = ActivityVoteComponent:GetVotesRoleRank()
                for k, v in pairs(rank) do
                    if checkInt(v.cardId) == cardId then
                        index = k 
                        break
                    end
                end
            end
            if index == 0  then
                self.LoopListRight2:InitListView(count, Bind(self, self.OnGetItemByIndex2))
            else 
                self.LoopListRight2:InitListView(count, Bind(self, self.OnGetItemByIndex2) , { 
                    mTargetIndex =  math.floor((index - 4 )/4) 
                } , nil , 0)
            end
        else
            GameUtils.ReloadData(self.LoopListRight2, count)
            self.LoopListRight2:MovePanelToItemIndex(0)
        end
    end
    
end
function ActivityCatGirlPKCardAndRoleDialog:OnGetItemByIndex(cell, index)
    if index < 0 then return nil end
    ---@type CatGirlPKRoleHeadSmallNode
    local ENV =  CfUtils.GetLuaScr(cell.gameObject , CellPath)
    ENV:filterRefresh(self.characterArray[index+1] , function (roleId)        
        self:SelectCharacterId(roleId)
    end)
    return cell
end
function ActivityCatGirlPKCardAndRoleDialog:OnGetItemByIndex2(cell, index)
    if index < 0 then return nil end
    ---@type CatGirlPKRoleHeadSmallNode
    local ENV =  CfUtils.GetLuaScr(cell.gameObject , CellPath)
    ENV:WeedOutRefresh(self.voteRoleRank[index + 4] ,index + 4 , function (cardId)
        self:SetCardId(cardId)
    end)
    return cell
end

function ActivityCatGirlPKCardAndRoleDialog:SetCardId(cardId)
    CfUtils.WriteLocalData("VOTE_CARD_ID" , cardId)
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKVoteDialog ,parameters = {  cardId = cardId }},
        { 
            { id = Constants.UITypeIds.ActivityCatGirlPKCardAndRoleDialog },
            { id = Constants.UITypeIds.ActvityCatGirlPKSelectCardDialog } ,
            { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel } ,
            { id = Constants.UITypeIds.UIActivityMainDialog } 
        }
    )
end

function ActivityCatGirlPKCardAndRoleDialog:SelectCharacterId(roleId)
    UIModule.OpenDialog(
    { id = Constants.UITypeIds.ActvityCatGirlPKSelectCardDialog ,parameters = { roleId = roleId }},
    {
        { id = Constants.UITypeIds.ActivityCatGirlPKCardAndRoleDialog } ,
        { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel } ,
        { id = Constants.UITypeIds.UIActivityMainDialog } 
    })
end

function ActivityCatGirlPKCardAndRoleDialog:OnFocus(focus)
    if focus then
        local voteGoodsId = ActivityVoteComponent:GetVoteGoodsId()
        CfUtils.RefreshTopGoods({voteGoodsId})
    end
end
function ActivityCatGirlPKCardAndRoleDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityCatGirlPKCardAndRoleDialog
