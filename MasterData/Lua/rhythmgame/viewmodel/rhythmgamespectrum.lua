RhythmGameSpectrum = {}

local this = {
    itemList = nil,
    numList = nil,
    resId = "",
};

RhythmGameSpectrum.Init = function(spectrum)
    this.itemList = {};
    for i = 1, 49 do
        this.itemList[i] = spectrum:Find("Item" .. i):GetComponent("Image");
    end
    this.numList = {0};
    for i = 1, 12 do
        table.insert(this.numList, i / 12);
    end
    this.bandBuffMaxHeight = {}
    for i = 1, 64 do
        this.bandBuffMaxHeight[i] = 0.3
    end
end

RhythmGameSpectrum.SetData = function(resId)
    if (this.resId == resId) then return end
    
    this.resId = resId;
    local sprite = LuaMgr.GetSprite("RhythmGame", resId);
    local len = #this.itemList;
    for i = 1, len do
        this.itemList[i].sprite = sprite;
    end
end

RhythmGameSpectrum.Clear = function()
    local len = #this.itemList;
    for i = 1, len do
        this.itemList[i].fillAmount = 0;
    end
    this.resId = "";
end

RhythmGameSpectrum.Destroy = function()
    this.itemList = nil;
    this.numList = nil;
end

RhythmGameSpectrum.Update = function()
    local spectrumData = RhythmGameManager.Singleton.SpectrumData;
    local isPlaying = RhythmGameManager.Singleton.IsPlaying

    for i = 0, 50 do
        if spectrumData[i] > this.bandBuffMaxHeight[i + 1] then
            this.bandBuffMaxHeight[i + 1] = spectrumData[i]
        end
    end

    local len = #this.itemList;
    for i = 1, len do
        local curV = this.GetNum( spectrumData[i - 1] / this.bandBuffMaxHeight[i] * 1.5 );

        if not isPlaying then
            curV = 0
        end
        this.itemList[i].fillAmount = this.GetNum( curV  );
    end
end

this.GetNum = function(num)
    return num + 0.1








end