require("RhythmGame/ViewModel/RhythmGameNoteClick")
require("RhythmGame/ViewModel/RhythmGameNoteLongPress")
require("RhythmGame/ViewModel/RhythmGameNoteContinuousClick")
require("RhythmGame/ViewModel/RhythmGameNoteBomb")
require("RhythmGame/ViewModel/RhythmGameNoteReverse")
require("RhythmGame/ViewModel/RhythmGameNoteHide")
require("RhythmGame/ViewModel/RhythmGameNoteDoubleClick")
require("RhythmGame/ViewModel/RhythmGameEvaluate")

RhythmGameUIMgr = {}

local this = {
    notePool = nil,
    noteClsMap = nil,
    notePos = Vector3(0,10000,0),
    evaluatePosList = nil, 
    evaluatePrefab = nil,
    evaluatePool = nil,
    evaluateList = nil,
};

RhythmGameUIMgr.Init = function(template)
    this.notePool = {};
    this.noteClsMap = {};
    this.noteClsMap[RhythmGameMgr.NoteType.OneOffType] = {cls=RhythmGameNoteClick, prefab=template:Find("NoteClick").gameObject};
    this.noteClsMap[RhythmGameMgr.NoteType.SpanType] = {cls=RhythmGameNoteLongPress, prefab=template:Find("NoteLongPress").gameObject};
    this.noteClsMap[RhythmGameMgr.NoteType.DoubleSpanType] = {cls=RhythmGameNoteContinuousClick, prefab=template:Find("NoteContinuousClick").gameObject};
    this.noteClsMap[RhythmGameMgr.NoteType.BombType] = {cls=RhythmGameNoteBomb, prefab=template:Find("NoteBomb").gameObject};
    this.noteClsMap[RhythmGameMgr.NoteType.ReverseType] = {cls=RhythmGameNoteReverse, prefab=template:Find("NoteReverse").gameObject};
    this.noteClsMap[RhythmGameMgr.NoteType.HideType] = {cls=RhythmGameNoteHide, prefab=template:Find("NoteHide").gameObject};
    this.noteClsMap[RhythmGameMgr.NoteType.DoubleClickType] = {cls=RhythmGameNoteDoubleClick, prefab=template:Find("NoteDoubleClick").gameObject}
    RhythmGameUIMgr.NotePos = this.notePos







end

RhythmGameUIMgr.Clear = function()
    this.ClearEvaluate();
end

RhythmGameUIMgr.Destroy = function()
    this.DestroyNote();
    this.noteClsMap = nil;
    this.DestroyEvaluate();
end


RhythmGameUIMgr.GetNote = function(noteType, parent, isLeft)
    local list = this.notePool[noteType];
    if (list ~= nil) then
        local len = #list;
        if (len > 0) then
            local item = list[len];
            list[len] = nil;
            if (parent ~= item.transform.parent) then
                item.transform:SetParent(parent, false);
            end
            item:SetDirection(isLeft);
            item.recycle = false
            return item;
        end
    end
    local note = this.noteClsMap[noteType];
    if (note ~= nil) then
        local item = note.cls.New(noteType, note.prefab, parent);
        item:SetDirection(isLeft);
        item.recycle = false
        return item;
    end
    return nil;
end


RhythmGameUIMgr.AddNote = function(item)
    local list = this.notePool[item.type];
    if (list == nil) then
        list = {};
        this.notePool[item.type] = list;
    end
    item:Clear();
    item.transform.localPosition = this.notePos;
    item.recycle = true
    table.insert(list, item);
end


this.DestroyNote = function()
    if (this.notePool ~= nil) then
        local len;
        for _, v in pairs(this.notePool) do
            len = #v;
            for i = 1, len do
                v[i]:Destroy();
            end
        end
        this.notePool = nil;
    end
end


RhythmGameUIMgr.Evaluate = function(type)
    local len = #this.evaluatePosList;
    local index = math.random(1, len);
    local posTF = this.evaluatePosList[index];
    local item = this.GetEvaluate(posTF);
    item:SetData(type);
    table.insert(this.evaluateList, item);
end


this.GetEvaluate = function(parent)
    local len = #this.evaluatePool;
    if (len > 0) then
        local item = this.evaluatePool[len];
        this.evaluatePool[len] = nil;
        if (parent ~= item.transform.parent) then
            item.transform:SetParent(parent, false);
        end
        return item;
    end
    return RhythmGameEvaluate.New(this.evaluatePrefab, parent);
end


RhythmGameUIMgr.AddEvaluate = function(item)
    item:Clear();
    table.insert(this.evaluatePool, item);
end


this.ClearEvaluate = function()
    if (this.evaluateList ~= nil) then
        local len = #this.evaluateList;
        for i = 1, len do
            this.evaluateList[i]:Clear();
        end
    end
end


this.DestroyEvaluate = function()
    if (this.evaluateList ~= nil) then
        local len = #this.evaluateList;
        for i = 1, len do
            this.evaluateList[i]:Destroy();
        end
        this.evaluateList = nil;
    end
    if (this.evaluatePool ~= nil) then
        local len = #this.evaluatePool;
        for i = 1, len do
            this.evaluatePool[i]:Destroy();
        end
        this.evaluatePool = nil;
    end
end


RhythmGameUIMgr.GetBatSound = function(id)
    local config;
    local batSounds = ConfigRhythmGameMgr.GetBatSounds();
    local len = #batSounds;
    for i = 1, len do
        config = batSounds[i];
        if (config.ID == id) then
            return config;
        end
    end
    return nil;
end


RhythmGameUIMgr.JudgeSound = function(judge, spanHited)
    local batSound = RhythmGameUIMgr.GetBatSound(RhythmGameMgr.mCurConfig.BatSound);
    if (batSound == nil) then return end
    
    local sound = "";
    if spanHited then
        sound = batSound.HoldOn
    elseif (judge == RhythmGameMgr.JudgeType.Perfect) then
        sound = batSound["PreciseS"];
    elseif (judge == RhythmGameMgr.JudgeType.Great) then
        sound = batSound["PreciseA"];
    elseif (judge == RhythmGameMgr.JudgeType.Good) then
        sound = batSound["PreciseB"];
    elseif (judge == RhythmGameMgr.JudgeType.Miss) then
        sound = batSound["Miss"];
    end
    local volume = ConfigRhythmGameMgr.GetMusicConstants().SoundEffect;
    AudioMgr.Singleton:PlayUISFX(string.format("Assets/_BundleResources/Audio/UI/%s.mp3", sound), false, volume);
end