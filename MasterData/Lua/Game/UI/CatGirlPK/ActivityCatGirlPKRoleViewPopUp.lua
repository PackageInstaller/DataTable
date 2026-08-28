--- lifecycle enable: __init -> Awake -> OnInitialize -> OnFocus(true) -> OnShow
--- lifecycle disable: OnFocus(false) -> OnHide -> OnFinalize -> __delete
--- from: Assets/BundleResources/Prefabs/ActivityCatGirlPK12003201/ActivityCatGirlPKRoleViewDialog.prefab > name: ActivityCatGirlPKRoleViewDialog
---@class ActivityCatGirlPKRoleViewPopUp
---@field Env                           	ActivityCatGirlPKRoleViewPopUp          
---@field controller                    	Engine.UI.UILuaDialog                   
---@field EmptyClose                    	UnityEngine.RectTransform               	@ 0    
---@field BtnClose                      	UnityEngine.RectTransform               	@ 1    
---@field LoopList                      	SuperScrollView.LoopGridView            	@ 2    
---@field TxtTitle1                     	UnityEngine.RectTransform               	@ 3    
---@field TxtTitle2                     	UnityEngine.RectTransform               	@ 4    
local ActivityCatGirlPKRoleViewPopUp = Class('ActivityCatGirlPKRoleViewPopUp')
---@type ActivityVoteComponent
local ActivityVoteComponent = GameUtils.GetEntityCompByType(ECSComponentType.Constants.ActivityVoteComponent)
local CellPath = "Game.UI.CatGirlPK.CatGirlPKRoleHeadSmallNode"
local UIModule = CS.Engine.UI.UIModule
function ActivityCatGirlPKRoleViewPopUp:__init()
    self.throughRoleData = nil -- 直接晋级的卡牌
end


function ActivityCatGirlPKRoleViewPopUp:__delete()
    self.throughRoleData = nil -- 直接晋级的卡牌
end


function ActivityCatGirlPKRoleViewPopUp:Awake()
    SetButtonAction(self.EmptyClose , function()
        UIModule.BackDialog()
    end)
    SetButtonAction(self.BtnClose , function() 
        UIModule.BackDialog()
    end)
end


function ActivityCatGirlPKRoleViewPopUp:OnInitialize()
    return CoWaitDo(function()
        local initParams = self.controller.Argument.parameters or {}
        local isThroughGame = checkInt(initParams.isThroughGame)
        if isThroughGame == 1 then
            CfUtils.WriteLocalData("ActivityCatGirlPKRoleViewPopUp_"  .. ActivityVoteComponent:GetDojo().currentRound .. "_" .. ActivityVoteComponent:GetActivityUuid())
        end 
        local matchTexts = {
            localize("筛选赛"),
            localize("淘汰赛"),
            localize("总决赛"),
        }
        local currentRound = checkInt(ActivityVoteComponent:GetDojo().currentRound) 
        CfUtils.FillText(self.TxtTitle1 , matchTexts[currentRound])
        if ActivityVoteComponent:GetDojo().currentRound == 1 and isThroughGame == 1 then
            self.throughRoleData  = ActivityVoteComponent:GetOneCharacterArray()
        else 
            CfUtils.FillText(self.TxtTitle2 , localize("参赛角色"))
            self.throughRoleData  = ActivityVoteComponent:GetVotesRoleRank()
        end
        self:InitGridView(table.count(self.throughRoleData))
    end)
end

function ActivityCatGirlPKRoleViewPopUp:InitGridView(count)
    if not self.LoopList.IsLoopListInit then
        self.LoopList:InitGridView(count, Bind(self, self.OnRefreshIndex))
    else
        GameUtils.ReloadData(self.LoopList, count)
    end
end
function ActivityCatGirlPKRoleViewPopUp:OnRefreshIndex(listView, index)
    if index < 0 then
        return nil
    end
    local cell = listView:NewListViewItem("CatGirlPKRoleViewCell")
    if isNotNull(cell) then
        local CatGirlPKRoleHeadSmallNode =  cell.transform:Find("CatGirlPKRoleHeadSmallNode")
        ---@type CatGirlPKRoleHeadSmallNode
        local scr = CfUtils.GetLuaScr(CatGirlPKRoleHeadSmallNode, CellPath)
        if scr then
            scr:ThroughGame(self.throughRoleData[index+1])
        end
    end
    return cell
end
function ActivityCatGirlPKRoleViewPopUp:OnFinalize()
    return CoWaitDo(function()
        self.controller = nil --删除lua层引⽤用到的c#对象
        self:Delete()
    end)
end


return ActivityCatGirlPKRoleViewPopUp
