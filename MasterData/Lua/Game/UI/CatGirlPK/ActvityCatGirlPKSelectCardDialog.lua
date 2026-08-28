--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKArmedSelectDialog.prefab > name: ActivityCatGirlPKArmedSelectDialog
---@class ActvityCatGirlPKSelectCardDialog
---@field Env                           	ActvityCatGirlPKSelectCardDialog        
---@field controller                    	Engine.UI.UILuaDialog                   
---@field LoopList                      	Engine.UI.AutoFixSizeListView           	@ 0    
local ActvityCatGirlPKSelectCardDialog = Class('ActvityCatGirlPKSelectCardDialog')
local CellPath = "Game.UI.CatGirlPK.ActivityCatGirlPKRoleBigNode"
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
local UIModule = CS.Engine.UI.UIModule
function ActvityCatGirlPKSelectCardDialog:__init()
    self.characterArray = nil
    self.roleId = nil
end


function ActvityCatGirlPKSelectCardDialog:__delete()
    self.characterArray = nil
    self.roleId = nil
end


function ActvityCatGirlPKSelectCardDialog:Awake()
end


function ActvityCatGirlPKSelectCardDialog:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        local roleId = initParams.roleId

    end)
end
function ActvityCatGirlPKSelectCardDialog:OnShow()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        local roleId = initParams.roleId
        self.roleId = roleId
        self:LoopListRightRightView(roleId)
    end)
end



function ActvityCatGirlPKSelectCardDialog:LoopListRightRightView(roleId)
    self.characterArray = ActivityVoteComponent:GetSortCharacterId(roleId)
    if not self.LoopList.mLoopListView.IsListViewInit then
        self.LoopList:InitListView(#self.characterArray, Bind(self, self.OnGetItemByIndex))
    else
        GameUtils.ReloadData(self.LoopList, #self.characterArray)
        self.LoopList:MovePanelToItemIndex(0)
    end
end

function ActvityCatGirlPKSelectCardDialog:OnGetItemByIndex(cell, index)
    if index < 0 then return nil end
    ---@type ActivityCatGirlPKRoleBigNode
    local ENV =  CfUtils.GetLuaScr(cell.gameObject , CellPath)
    ENV:Refresh(self.characterArray[index+1] , index + 1 , ActivityVoteComponent:GetDojo().voteGoodsId, function (cardId)
        self:SelectCardId(cardId)
    end)
    return cell
end

function ActvityCatGirlPKSelectCardDialog:SelectCardId(cardId)
    UIModule.OpenDialog(
        { id = Constants.UITypeIds.ActivityCatGirlPKVoteDialog ,parameters = { roleId = self.roleId , cardId = cardId }},
        { 
            { id = Constants.UITypeIds.ActivityCatGirlPKCardAndRoleDialog },
            { id = Constants.UITypeIds.ActvityCatGirlPKSelectCardDialog } ,
            { id = Constants.UITypeIds.ActivityCatGirlPKMainPanel } ,
            { id = Constants.UITypeIds.UIActivityMainDialog } 
     }
    )
end
function ActvityCatGirlPKSelectCardDialog:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActvityCatGirlPKSelectCardDialog
