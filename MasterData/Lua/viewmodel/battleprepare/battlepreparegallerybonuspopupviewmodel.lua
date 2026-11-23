require("ViewModel/BattlePrepare/Gallery_Bonus_Item")

local this = 
{
    vm = nil,
    current_index = nil,
    objs =
    {

        btn_1           = {path = "root/Middle/popup/Group/btn_group/btn_1", type = "GameObject"},
        btn_1_on_group  = {path = "root/Middle/popup/Group/btn_group/btn_1/on_group", type = "GameObject"},
        btn_1_off_group = {path = "root/Middle/popup/Group/btn_group/btn_1/off_group", type = "GameObject"},


        btn_2           = {path = "root/Middle/popup/Group/btn_group/btn_2", type = "GameObject"},
        btn_2_on_group  = {path = "root/Middle/popup/Group/btn_group/btn_2/on_group", type = "GameObject"},
        btn_2_off_group = {path = "root/Middle/popup/Group/btn_group/btn_2/off_group", type = "GameObject"},


        btn_3           = {path = "root/Middle/popup/Group/btn_group/btn_3", type = "GameObject"},
        btn_3_on_group  = {path = "root/Middle/popup/Group/btn_group/btn_3/on_group", type = "GameObject"},
        btn_3_off_group = {path = "root/Middle/popup/Group/btn_group/btn_3/off_group", type = "GameObject"},


        btn_4           = {path = "root/Middle/popup/Group/btn_group/btn_4", type = "GameObject"},
        btn_4_on_group  = {path = "root/Middle/popup/Group/btn_group/btn_4/on_group", type = "GameObject"},
        btn_4_off_group = {path = "root/Middle/popup/Group/btn_group/btn_4/off_group", type = "GameObject"},


        btn_5           = {path = "root/Middle/popup/Group/btn_group/btn_5", type = "GameObject"},
        btn_5_on_group  = {path = "root/Middle/popup/Group/btn_group/btn_5/on_group", type = "GameObject"},
        btn_5_off_group = {path = "root/Middle/popup/Group/btn_group/btn_5/off_group", type = "GameObject"},

        show_group      = {path = "root/Middle/popup/Group/show_group", type = "GameObject"},
        text_job        = {path = "root/Middle/popup/Group/show_group/text_job", type = "Text"},
        text_no_bonus   = {path = "root/Middle/popup/Group/show_group/text_no_bonus", type = "GameObject"},
    },         
}

local data = 
{

}

local command = 
{
    on_click_job_btn =
    {
        type = XLuaCommandType.Bool,
        execute = function(vm, isOn, param)
            this.on_click_job_btn(vm, isOn, param)
        end
    },

    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    }
}

local hook =
{
    before_awake = function(vm)
        this.init(vm)
    end,

    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end

        UITool.Parse(this.vm.behaviour.gameObject, this, this.objs)
        
        this.adjust_position(vm)
        this.init_job_config()
        this.init_hero_config()

        for i = 1, 5 do
            this["btn_" .. i .. "_on_group"]:SetActive(false)
            this["btn_" .. i .. "_off_group"]:SetActive(true)
        end
        this.show_group:SetActive(false)

        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/popup/Group/show_group/ui_scroll").gameObject)
        this.scrollView:SetParams(376, 251)
        this.scrollView:Clear(true)
        this.item_obj = vm.behaviour.transform:Find("template/item_obj").gameObject


        vm.behaviour.transform:Find("root/Middle/popup/Group/btn_group/btn_1"):GetComponent("Toggle").isOn = false
        vm.behaviour.transform:Find("root/Middle/popup/Group/btn_group/btn_1"):GetComponent("Toggle").isOn = true
    end,

    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_deactive()
    end,

    before_destroy = function(vm)
        UIScrollView.ClearItem("Gallery_Bonus_Item")
    end,
}

local strs = 
{
    [1] = LuaMgr.GetLangText("BattlePrepareGalleryBonusPopupViewModel_0"),
    [2] = LuaMgr.GetLangText("BattlePrepareGalleryBonusPopupViewModel_1"),
    [3] = LuaMgr.GetLangText("BattlePrepareGalleryBonusPopupViewModel_2"),
    [4] = LuaMgr.GetLangText("BattlePrepareGalleryBonusPopupViewModel_3"),
    [5] = LuaMgr.GetLangText("BattlePrepareGalleryBonusPopupViewModel_4"),
}

function this.init(vm)
    this.vm = vm
end
function this.on_before_deactive()
    this.current_index = nil

    this.btn_1           = nil
    this.btn_1_on_group  = nil
    this.btn_1_off_group = nil

    this.btn_2           = nil
    this.btn_2_on_group  = nil
    this.btn_2_off_group = nil

    this.btn_3           = nil
    this.btn_3_on_group  = nil
    this.btn_3_off_group = nil

    this.btn_4           = nil
    this.btn_4_on_group  = nil
    this.btn_4_off_group = nil

    this.btn_5           = nil
    this.btn_5_on_group  = nil
    this.btn_5_off_group = nil

    this.show_group     = nil
    this.text_job       = nil
    this.text_no_bonus  = nil
    this.hero_config    = nil

    this.scrollView:Clear(true)
end

function this.on_click_job_btn(vm, isOn, param)
    print("this.on_click_job_btn")
    print(isOn)
    print(param)

    local index = param

    if isOn == false then
        this["btn_" .. index .. "_on_group"]:SetActive(false)
        this["btn_" .. index .. "_off_group"]:SetActive(true)
    else
        if this.current_index == nil or this.current_index ~= index then
            this["btn_" .. index .. "_on_group"]:SetActive(true)
            this["btn_" .. index .. "_off_group"]:SetActive(false)
            this.current_index = index

            this.set_data(index)
        end
    end
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.BattlePrepareGalleryBonusPopupViewModel);
end

function this.adjust_position(vm)
    local btn               = vm.behaviour.Params[0]
    local popup             = vm.behaviour.transform:Find("root/Middle/popup")
    local parent_transform  = popup.transform.parent
    local pos               = parent_transform:InverseTransformPoint(btn.transform.position)
    
    pos = Vector2(pos.x + 250, pos.y + 220)
    popup.transform.anchoredPosition = pos
end



function this.init_job_config()
    if TableIsNull(this.characterJob) then
        local tempJob = {}
        this.redList = {}
        this.characterJob = {}
        for key, value in pairs(ConfigMgr.Config.jobs) do
            tempJob = {job = tonumber(value.id),name = LuaMgr.GetLangText(value.NameLan)}
            this.redList[tempJob.job] = 0
            table.insert(this.characterJob,tempJob)
        end
        table.sort(this.characterJob,function(lhs, rhs)
            return lhs.job < rhs.job
        end)
    end
end



function this.init_hero_config()
    this.hero_config = {}
    local config = nil
    local tempData = {}
    local heroData = nil
    local typeKey = nil
    local starBool = nil

    for key,value in pairs(ConfigMgr.Config.BestiarySupplyMap) do
        config = ConfigMgr.Config.characterTable[key]
        if not TableIsNull(config) and value.Switch == 1 then
            heroData = DataMgr.Player.characters[key]
            if this.hero_config[config.job] == nil then
                this.hero_config[config.job] = {}
            end
            tempData = {id = key,rare = config.rare,name = LuaMgr.GetLangText(config.namelan),needLevel = value.Level,attr = value.Provide}
            if TableIsNull(heroData) then
                tempData.state = 6
                tempData.level = 0
                tempData.star = 0
                tempData.skin = key.."001"
            else
                tempData.level = heroData.level
                tempData.star = heroData.star
                typeKey = key.."_level_"..value.Level
                if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                    tempData.state = heroData.level >= value.Level and 1 or 5
                    if tempData.state == 1 then
                        this.redList[config.job] = this.redList[config.job] + 1
                    end
                elseif DataMgr.Player.jobExtraAttr[typeKey] ~= nil then

                    starBool = false
                    for i = 1, 6 do
                        if i <= heroData.star and value.Provide[i + 1] ~= "" then
                            typeKey = key.."_star_"..i
                            if DataMgr.Player.jobExtraAttr[typeKey] == nil then
                                starBool = true
                                tempData.state = 2
                                this.redList[config.job] = this.redList[config.job] + 1
                                break
                            end
                        end
                    end

                    if not starBool then
                        typeKey = key.."_brilliant_1"
                        local curRare = HeroMgr.GetHeroNowRare(key)
                        if DataMgr.Player.jobExtraAttr[typeKey] == nil and curRare >= 5 then
                            tempData.state = 3
                            this.redList[config.job] = this.redList[config.job] + 1
                        else
                            tempData.state = 4
                        end
                    end
                end
                tempData.skin = heroData.curSkin
            end
            tempData.jobName = this.characterJob[config.job].name
            table.insert(this.hero_config[config.job],tempData)
        end
    end
    for i = 1, #this.hero_config do
        table.sort(this.hero_config[i],this.hero_sort)
    end
end

function this.hero_sort(lhs, rhs)
    if lhs.state ~= rhs.state then
        return lhs.state < rhs.state
    elseif lhs.level ~= rhs.level then
        return (lhs.level / lhs.needLevel) > (rhs.level / rhs.needLevel)
    elseif lhs.rare ~= rhs.rare then
        return lhs.rare > rhs.rare
    else
        return lhs.id > rhs.id
    end    
end

function this.get_attr_list(job)
    job = tonumber(job)
    local attrList = {}
    local attr = nil
    local attrName,attrValue,attrType,iconName = nil,nil,nil,nil
    local sort,index = nil,0
    local typeKey = nil
    for i = 1, #this.hero_config[job] do
        if this.hero_config[job][i].state == 4 or this.hero_config[job][i].state == 2 or this.hero_config[job][i].state == 3 then
            for j = 1, #this.hero_config[job][i].attr do
                attr = nil
                if j == 1 then
                    attr = ConfigMgr.Config.talentBankMap[this.hero_config[job][i].attr[j]]
                elseif j > 1 and j <= 7 then

                    if this.hero_config[job][i].attr[j] ~= "" then
                        typeKey = this.hero_config[job][i].id.."_star_"..j - 1
                        if DataMgr.Player.jobExtraAttr[typeKey] ~= nil then
                            attr = ConfigMgr.Config.talentBankMap[this.hero_config[job][i].attr[j]]
                        end
                    end
                else

                    if this.hero_config[job][i].attr[j] ~= "" then
                        typeKey = this.hero_config[job][i].id.."_brilliant_1"
                        if DataMgr.Player.jobExtraAttr[typeKey] ~= nil then
                            attr = ConfigMgr.Config.talentBankMap[this.hero_config[job][i].attr[j]]
                        end
                    end
                end
                if not TableIsNull(attr) and attr.type == 2 then
                    attrName,attrValue,attrType,iconName = ConfigHelper.GetAttrNameStr(attr.id)

                    if attrList[iconName] == nil then
                        sort = ConfigMgr.Config.BestiarySSortMap[iconName]
                        index = sort == nil and 0 or sort.Sort
                        attrList[iconName] = {name = attrName,value = tonumber(attrValue),type = attrType,icon = iconName,index = index}
                    else
                        attrList[iconName].value = attrList[iconName].value + tonumber(attrValue)
                    end
                end
            end
        end
    end
    return attrList  
end



function this.sort_attr_list(tempList)
    local attrList = {}
    for key,value in pairs(tempList) do
        table.insert(attrList,value)
    end
    table.sort(attrList,
    function (lhs, rhs) 
            return lhs.index < rhs.index 
        end
    )
    return attrList
end

function this.set_data(index)
    this.text_job.text = strs[tonumber(index)]
    this.show_group:SetActive(true)
    this.scrollView:Clear(true)

    local attr_list = this.get_attr_list(index)
    attr_list = this.sort_attr_list(attr_list)

    if #attr_list > 0 then
        this.text_no_bonus:SetActive(false)
        this.scrollView.gameObject:SetActive(true)
    
        local data_list = {}

        for i = 1, #attr_list do
            local data = table.Copy(attr_list[i])
            local scroll_data = UIScrollData.GetData(this.item_obj, "Gallery_Bonus_Item", 372, 32, data)
            table.insert(data_list, scroll_data)
        end

        this.scrollView:SetParams(376, 251)
        this.scrollView:SetData(data_list, true)
    else
        this.text_no_bonus:SetActive(true)
        this.scrollView.gameObject:SetActive(false) 
    end
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)