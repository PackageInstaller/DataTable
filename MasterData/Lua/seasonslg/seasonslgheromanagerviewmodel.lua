_G.package.loaded["ViewModel/Hero/HeroManagerCommon"] = nil
local commonData = require("ViewModel/Hero/HeroManagerCommon")

commonData.data.seasonLevel = ""

local this = commonData.this

commonData.command.seasonLevelUpCommand = {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.OnClickSeasonLevel(param)
        end
    }

this.OnClickSeasonLevel = function(param)
    if this.isDraging or this.isAssisHero then
        return
    end
    LuaMgr.ShowLuaPanel(UIName.SeasonSLGHeroUpLevelViewModel)
end

this.GetTalentBankID = function(character)
    local seasonLevel = ConfigCharacterMgr.GetSeasonalHeroLevel(character.id)
    local seasonLevelConfig = ConfigCharacterMgr.GetSeasonalHeroLevelConfig(character.id,seasonLevel)
    return seasonLevelConfig and seasonLevelConfig.TalentBankID or nil
end

local oldSetAttribute = this.SetAttribute
this.SetAttribute = function(character)
    oldSetAttribute(character)
    local seasonLevel = ConfigCharacterMgr.GetSeasonalHeroLevel(character.id)
    this.vm.data.seasonLevel = tostring(seasonLevel)
end

commonData.hook.before_awake = function(vm)
    this.vm = vm;
    RedMgr.Singleton:RegisterViewModel(UIName.SeasonSLGHeroManagerViewModel);
    this.msgTransform = vm.behaviour.transform:Find("root/Left/Group/Msg")
    this.dragPageTr = vm.behaviour.transform:Find("root/Middle/DragPage")
    this.leftRect = vm.behaviour.transform:Find("root/Left"):GetComponent("RectTransform")
    this.rightRect = vm.behaviour.transform:Find("root/Right"):GetComponent("RectTransform")
end

return vm(commonData)