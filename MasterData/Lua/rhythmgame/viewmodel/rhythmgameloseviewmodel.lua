local this = {
    typeStr = nil,
};

local objs = {
    animator = { path = "root", type = "UIAnimator" },
    restartBtn = { path = "root/Middle/Restart", type = "Button" },
    exitBtn = { path = "root/Middle/Exit", type = "Button" },
    name = { path = "root/Middle/Lose/Name", type = "Text" },
    level = { path = "root/Middle/Lose/Level/Text", type = "Text" },
    coverIcon = { path = "root/Middle/Lose/Cover/Icon", type = "Image" },
};


this.SetData = function()
    local musicConfig,typeStr = PlayerRhythmGameMgr.GetMusicConfig();
    this.typeStr = typeStr
    this.name.text = musicConfig.name;
    this.level.text = LuaMgr.GetLangText("RhythmGameLoseViewModel_0") .. musicConfig.rank;
    local musicSong = ConfigRhythmGameMgr.GetMusicSongByEventId(musicConfig.id,typeStr);
    if (musicSong ~= nil) then
        local albumConfig = ConfigRhythmGameMgr.GetAlbumConfig(musicSong.album,typeStr);
        if (albumConfig ~= nil) then
            local str = string.sub(albumConfig.icon,1,-2)                
            this.coverIcon.sprite = LuaMgr.GetSprite("RhythmGame", str.."0");
        end
    end
end


this.OnClickRestart = function()
    LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameRestart);
    LuaMgr.HidePanel(UIName.RhythmGameLoseViewModel);
end


this.OnClickExit = function()
    ConfigRhythmGameMgr.ShowMusicPanel(this.typeStr)   
    LuaMgr.HidePanel(UIName.RhythmGameLoseViewModel);
end

local command = {}
local data = {}

local hook = {
    before_awake = function(vm)
        UITool.Parse(vm.behaviour.gameObject, this, objs);
        LuaMgr.AddClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.AddClick(this.exitBtn, this.OnClickExit);
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        
        this.SetData();
        LuaMgr.ShowTouchEffect();
        LuaMgr.InvokeUIEventListeners(UIEventConst.RhythmGameTouchEffect, false);
        this.animator.AnimationName = "ani_RhythmGamelosePanel_Middle";
    end,
    before_deactive = function(vm)        
        this.coverIcon.sprite = nil;
        this.typeStr = nil
    end,
    before_destroy = function(vm)
        LuaMgr.RemoveClick(this.restartBtn, this.OnClickRestart);
        LuaMgr.RemoveClick(this.exitBtn, this.OnClickExit);
    end
}

return vm({
    data = data,
    command = command,
    hook = hook
})