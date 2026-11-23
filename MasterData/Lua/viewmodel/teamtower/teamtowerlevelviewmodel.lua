local this = 
{
    vm = nil,
    MonsterPath = "Assets/_BundleResources/Character/",
    levelConfig = nil,

    goodItems = {},
}
local uiGoodsItem=nil;
local rectGood = nil;
local uiSpineCharacter = nil;
local data =
{    
    normalLevel = true,
    bossLevel = false,
    monsterBodyPos = Vector3.zero,
    monsterBodyScale = Vector3.zero,
    monsterBodyPath = "",
    monsterName = "",
    buffList = {{icon = DefaultSprite,des = "",name = ""}},
    buff = "",
    floor = "",
    levelName = "",
    noReward = false,
    haveReward = true,
}
local objs = {
    uiGoodsItem = { path = "template/GoodsItem", type = "GoodsViewModel" },
    rectGood = { path = "root/Middle/levelInfo/rewards/Viewport/Content", type = "RectTransform" },
    animator = { path = "root", type = "Animator" },
    uiSpineCharacter = {path = "root/Middle/bossinfo/BossSpine/Body",type = "UISpineCharacter"},
};
local command = {
    StartCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            if not this.CheckBuffSelected()then
                return;
            end
            ActivityBattlePrepareMgr.SetMembers(ActivityKey.TeamTower, this.levelConfig.Dungeon)
            LuaMgr.ShowLuaPanel(UIName.ActivityBattlePrepareViewModel, ActivityKey.TeamTower)
        end
    },






}

local hook = {
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(this.vm.behaviour.gameObject, this, objs)
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
        vm.behaviour:UpdateTopBar("", this.OnBack);
        this.RefreshView()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then
            return
        end
    end,
    before_destroy = function(vm)
        this = nil;
    end
}

this.RefreshView = function()
    local towerId = TeamTowerMgr.GetCurChallengeTowerId()
    this.levelConfig = ConfigMgr.Config.TeamTowerFloorMap[towerId];
    this.vm.data.bossLevel = this.levelConfig.BossFloor == 1;
    this.vm.data.normalLevel = this.levelConfig.BossFloor == 0;
    if this.vm.data.bossLevel then
        this.animator:Play("ani_TeamTowerLevelPanel_root_002")
    end
    this.vm.data.floor = string.format(LuaMgr.GetLangText("TeamTowerLevelViewModel_0"),TeamTowerMgr.GetCurChallengeFloor());
    local dungeonConfig = ConfigMgr.Config.dungeonMap[this.levelConfig.Dungeon];
    this.vm.data.levelName = LuaMgr.GetLangText(dungeonConfig.NameLan)
    this.InitBuff()
    this.InitMonster()
    this.InitReward()

    if not this.CheckSuccessPopup() then
        this.CheckBuffSelected()
    end
end

this.CheckSuccessPopup = function()
    local floor = PlayerPrefs.GetInt(DataMgr.Player.uid .. "TeamTowerFloor",0)
    if (floor ~= tonumber(TeamTowerMgr.GetCurChallengeFloor()) and tonumber(TeamTowerMgr.GetCurChallengeTowerId()) ~= 1001) then
        LuaMgr.ShowLuaPanel(UIName.TeamTowerSuccessPopup,this.CheckBuffSelected)
        return true
    end
    return false
end

this.CheckBuffSelected = function()
    if TableIsNull(TeamTowerMgr.GetTeamTowerData().ChooseBuff) then
        return true
    end
    LuaMgr.ShowLuaPanel(UIName.TeamTowerSelectBuffPopUp)
    return false
end

this.InitMonster = function()
    local path = HeroManager.SetCharacterDrawing(this.uiSpineCharacter, this.levelConfig.MonsterRes[1], this.levelConfig.MonsterRes[1] .. "01")
    if path ~= "" then
        this.vm.data.monsterBodyPath = path
    end
    local x = tonumber(this.levelConfig.Offset[1])
    local y = tonumber(this.levelConfig.Offset[2])
    local scale = tonumber(this.levelConfig.Offset[3])
    this.vm.data.monsterBodyPos = Vector3(x, y, 0.0)
    this.vm.data.monsterBodyScale = Vector3(scale, scale, scale)
end

this.InitBuff = function()
    local buffStr = "";
    for i, v in ipairs(this.levelConfig.Buff) do
        local buffConfig = ConfigMgr.Config.TeamTowerBuffDescMap[v];
        if not IsNull(buffConfig) then
            local data = {};
            data.name = LuaMgr.GetLangText(buffConfig.BuffNameLan)

            data.des = LuaMgr.GetLangText(buffConfig.BuffDesLan)
            buffStr = buffStr .. data.des .. "\n"
        end
    end
    this.vm.data.buff = buffStr
end

this.InitReward = function()
    this.vm.data.haveReward = not IsNull(this.levelConfig.Reward) and #this.levelConfig.Reward > 0
    this.vm.data.noReward = IsNull(this.levelConfig.Reward)
    
    local len=0
    if not IsNull(this.levelConfig.Reward) then
        len = #this.levelConfig.Reward
    end
    for i = 1, len do
        if i>#this.goodItems then
            table.insert(this.goodItems,LuaMgr.InstantiateGO(this.uiGoodsItem.gameObject, this.rectGood, false):GetComponent("GoodsViewModel"))
        end

        SetActive(this.goodItems[i].gameObject,true);
        this.goodItems[i]:SetData(tostring(this.levelConfig.Reward[i].id),this.levelConfig.Reward[i].count,1,0.6,true)
    end

    for i = (len+1), #this.goodItems do
        SetActive(this.goodItems[i].gameObject,false)
    end
end

this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})