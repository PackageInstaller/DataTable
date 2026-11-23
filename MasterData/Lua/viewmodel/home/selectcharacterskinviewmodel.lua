require("ViewModel/Home/SelectCharacter_SkinList")
require("ViewModel/Home/SelectCharacter_SkinItem")
local this = {
    vm = nil,
    skinScrollViewList = nil,
    skinListItemObj = nil,
    skinItemObj = nil,
    selectSkinList = {},
    oldSelectList = {},
    selectCount = 0,
}

local itemContent = nil

local skinDatasCache = nil

local ROWCOUNT = 8

local data = {

}

local command = {
    confirmCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            local isChange = #this.selectSkinList ~= #this.oldSelectList
            if (not isChange) then
                for i, v in ipairs(this.selectSkinList) do
                    if (v ~= this.oldSelectList[i]) then
                        isChange = true
                        break
                    end
                end
            end
            if (not isChange) then
                LuaMgr.HidePanel(UIName.SelectCharacterSkinViewModel)
                return
            end
            ApiMgr.Request("select_background", { backgrounds = this.selectSkinList }, true, function(re)
                PlayerSkinMgr.UpdatePlayerSkinData(DataMgr.Player.backgroundData.BackgroundInfos)
                LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("1303"));
                HeroParameter.update_background = this.selectSkinList;
                LuaMgr.HidePanel(UIName.SelectCharacterSkinViewModel)
            end, nil, true);
        end
    },
    closeCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnBack()
        end
    },
}
local hook = {
    before_awake = function(vm)
        this.vm = vm;
        itemContent = this.vm.behaviour.transform:Find("root/Middle/Group/HeadScrollView")
        this.skinScrollViewList = UIScrollView.New(itemContent.gameObject);
        this.skinListItemObj = this.vm.behaviour.transform:Find("template/SkinListHeadItem").gameObject;
        this.skinItemObj = this.vm.behaviour.transform:Find("template/SkinItem").gameObject;
        this.selectCount = this.vm.behaviour.transform:Find("root/Middle/Group/SelectCount"):GetComponent("Text");
    end,
    before_active = function(vm)
        if (vm.behaviour.Params == nil) then return end
        this.selectSkinList = {}
        this.oldSelectList = {}
        local infos = DataMgr.Player.backgroundData.BackgroundInfos
        if infos ~= nil and #infos > 0 then
            for i, v in ipairs(infos) do
                local data = { CharacterID = v.CharacterID, Skin = v.Skin }
                if (v.Skin == nil or v.Skin == "" or v.Skin == "null") then
                    data = { CharacterID = v.CharacterID, Skin = v.CharacterID .. "001" }
                end
                table.insert(this.selectSkinList, data)
                table.insert(this.oldSelectList, data)
            end
        else
            LuaDebug.error("DataMgr.Player.backgroundData.BackgroundInfos数据为空，请检查相关逻辑")
        end
        local maxCount = ConfigMgr.Config.constants.CharacterLimit
        this.selectCount.text = string.format(LuaMgr.GetLangText("SelectCharacterSkinViewModel_0"), #this.selectSkinList,
            maxCount)
        this.SetCharactersSkinData()
        this.SetHeadScrollView()
    end,
    before_deactive = function(vm)
        if (vm.behaviour.Params == nil) then return end
    end,
    before_destroy = function()
        UIScrollView.ClearItem("SelectCharacter_SkinList")
        UIListView.ClearItem("SelectCharacter_SkinItem")
        this = nil
    end
}

this.SetCharactersSkinData = function()

    local characters = DataMgr.Player.characters

    local characterSkins = DataMgr.Player.characterSkins;
    local skinList = {}
    if characters ~= nil and characterSkins ~= nil then
        for k, v in pairs(characters) do
            local id = v.id
            table.insert(skinList, id .. "001");
            local skins = characterSkins[id]
            if skins ~= nil then
                for i, v in ipairs(skins) do
                    table.insert(skinList, v);
                end
            end
        end
    end
    table.sort(skinList, function(a, b) return a < b end)
    skinDatasCache = {}
    for i, v in ipairs(skinList) do
        local cfgSkin = ConfigHelper.GetHeroSkinConfig(v)
        if cfgSkin ~= nil then
            local skinItem = {
                index = i,
                skinId = v,
                characterId = cfgSkin.characterId,
                skinTex = LuaMgr.GetTexture(HeroManager.GetCharacterAvatar(cfgSkin.characterId, v)),
                isSelect = false,
                isTag = cfgSkin.highskin ~= nil and cfgSkin.highskin == 1,
            }
            table.insert(skinDatasCache, skinItem)
        end
    end
end

this.OnClickItem = function(index)
    local skinItem = this.skinScrollViewList.dataList[index.row].data[index.col]
    local maxCount = ConfigMgr.Config.constants.CharacterLimit
    local listIndex = this.FindIndex(this.selectSkinList, skinItem.skinId)
    if listIndex ~= -1 then
        if #this.selectSkinList <= 1 then
            LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26611"));
            return;
        end
        skinItem.isSelect = false;
        table.remove(this.selectSkinList, listIndex)
    elseif #this.selectSkinList >= maxCount then
        LuaMgr.ShowPanel(UIName.MessageTipsViewModel, ConfigMgr.LangGlobal("26610"));
    else
        skinItem.isSelect = true;
        local skinInfo = { CharacterID = skinItem.datas.characterId, Skin = skinItem.skinId }
        table.insert(this.selectSkinList, skinInfo)
    end

    this.selectCount.text = string.format(LuaMgr.GetLangText("SelectCharacterSkinViewModel_1"), #this.selectSkinList,
        maxCount)

    for i, v in pairs(this.skinScrollViewList.itemMap) do
        for p, m in ipairs(v.data) do
            if m.index.index == index.index then
                v:SetIndex(index.col, skinItem.isSelect)
                return
            end
        end
    end
end

this.SetHeadScrollView = function()
    this.skinScrollViewList:Clear(true);
    local rowNum = math.ceil(#skinDatasCache / ROWCOUNT);
    local list = {}
    for i = 1, rowNum do
        local skinList = {}
        local loc = 0;
        for j = ROWCOUNT * (i - 1) + 1, ROWCOUNT * i do
            if j <= #skinDatasCache then
                loc = loc + 1;
                local item = {
                    datas = skinDatasCache[j],
                    skinId = skinDatasCache[j].skinId,
                    skinTex = skinDatasCache[j].skinTex,
                    isTag = skinDatasCache[j].isTag,
                    index = { row = i, col = loc, index = j },
                    itemObj = this.skinItemObj,
                    callBack = this.OnClickItem,
                    isSelect = this.FindIndex(this.selectSkinList, skinDatasCache[j].skinId) ~= -1,
                }
                table.insert(skinList, item);
            end
        end
        local headData = UIScrollData.GetData(this.skinListItemObj, "SelectCharacter_SkinList", 966, 132, skinList);
        table.insert(list, headData);
    end
    this.skinScrollViewList:SetParams(966, 479)
    this.skinScrollViewList:SetData(list, true)
end

this.FindIndex = function(list, value)
    for i, v in ipairs(list) do
        if v.Skin == value then
            return i
        end
    end
    return -1
end


this.OnBack = function()
    LuaMgr.Back();
end

return vm({
    data = data,
    command = command,
    hook = hook
})