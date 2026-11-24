require("ViewModel/YJSYZ/YJSYZChooseBuffPanelBuffItem")
require("ViewModel/YJSYZ/YJSYZChooseBuffPanelEnhancedBuffItem")

local this =
{
    vm = nil,
    buff_list = nil,
    enhanced_buff_list = nil,
    current_buff_id = "",
}

local data =
{

}

local objs =
{
    desc_go = { path = "root/Middle/desc", type = "GameObject" },
    not_desc_go = { path = "root/Middle/not_desc", type = "GameObject" },
    desc_buff_icon = { path = "root/Middle/desc/buff/icon", type = "Image" },
    desc_text_desc = { path = "root/Middle/desc/text_desc", type = "Text" },
    desc_text_buff_name = { path = "root/Middle/desc/Image/text_buff_name", type = "Text" },
    buff_item_go = { path = "template/buff", type = "GameObject" },
    buff_list_go = { path = "root/Middle/choose/ui_scroll_buff/Viewport/Content", type = "GameObject" },
    enhanced_buff_item_go = { path = "template/enhanced_buff", type = "GameObject" },
    enhanced_buff_list_go = { path = "root/Middle/ui_scroll_enhanced_buff/Viewport/Content", type = "GameObject" },
}

local command =
{
    btn_confirm =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.btn_confirm()
        end
    },
}

local hook =
{
    before_awake = function(vm)
        this.vm = vm
        UITool.Parse(this.vm.behaviour.gameObject, this, objs)
    end,
    before_active = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_active()
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_deactive()
    end,
    before_destroy = function(vm)

    end
}

function this.on_before_active()
    this.vm.behaviour:UpdateTopBar("", this.OnBack)

    this.current_buff_id = ""
    this.desc_go:SetActive(false)
    this.not_desc_go:SetActive(true)
    this.buff_list = UIListView.New(this.buff_list_go.transform)
    this.enhanced_buff_list = UIListView.New(this.enhanced_buff_list_go.transform)
    this.set_buff_list()
end

function this.on_before_deactive()
    if this.buff_list ~= nil then
        this.buff_list:Clear()
    end
    if this.enhanced_buff_list ~= nil then
        this.enhanced_buff_list:Clear()
    end
    UIListView.ClearItem("YJSYZChooseBuffPanelBuffItem")
    UIListView.ClearItem("YJSYZChooseBuffPanelEnhancedBuffItem")
end

function this.set_buff_list()
    if this.buff_list == nil or this.buff_item_go == nil then
        return
    end

    this.buff_list:Clear()

    local buff_id_list = YJSYZHelper.get_choose_buff_list() or {}
    local data_list = {}
    for i, buff_id in ipairs(buff_id_list) do
        local element = {}
        element.index = i
        element.buff_id = buff_id
        element.is_enhanced = this.get_is_enhanced_buff(buff_id)
        element.callback = this.OnClickBuffItemCallback

        local data = UIListData.GetData(this.buff_item_go, "YJSYZChooseBuffPanelBuffItem", element)
        table.insert(data_list, data)
    end

    this.buff_list:SetData(data_list, true)
end

function this.get_is_enhanced_buff(buff_id)
    local buff_config = ConfigMgr.Config.BossTowerBuffMap[tostring(buff_id)]
    if buff_config ~= nil and tonumber(buff_config.BasicBuff or 0) > 0 then
        return false
    end

    return true
end

function this.set_enhanced_buff_list(list)
    if this.enhanced_buff_list == nil or this.enhanced_buff_item_go == nil then
        return
    end

    this.enhanced_buff_list:Clear()

    local data_list = {}
    for i, v in ipairs(list or {}) do
        local element = {}
        element.index = i
        element.config = v
        element.buff_id = v.Id
        local data = UIListData.GetData(this.enhanced_buff_item_go, "YJSYZChooseBuffPanelEnhancedBuffItem", element)
        table.insert(data_list, data)
    end

    this.enhanced_buff_list:SetData(data_list, true)
end

function this.OnClickBuffItemCallback(element, buff_gameObject)
    if this.buff_list_go == nil or buff_gameObject == nil then
        return
    end
    this.current_buff_id = element.buff_id

    local parent = this.buff_list_go.transform
    for i = 0, parent.childCount - 1 do
        local child = parent:GetChild(i)
        local select_tr = child:Find("select")
        if select_tr ~= nil then
            select_tr.gameObject:SetActive(child.gameObject == buff_gameObject)
        end
    end

    local buff_config = ConfigMgr.Config.buffMap[tostring(element.buff_id)]
    if buff_config == nil then
        return
    end

    this.desc_go:SetActive(true)
    this.not_desc_go:SetActive(false)
    if buff_config.BuffIcon ~= nil then
        this.desc_buff_icon.sprite = LuaMgr.GetSprite("BuffIcon", buff_config.BuffIcon)
    end
    this.desc_text_buff_name.text = LuaMgr.GetLangText(buff_config.NameLan)
    this.desc_text_desc.text = LuaMgr.GetLangText(buff_config.DescriptionLan)

    local boss_tower_buff_config = ConfigMgr.Config.BossTowerBuffMap[tostring(element.buff_id)]
    local list = {}
    if boss_tower_buff_config ~= nil then
        local id_type = boss_tower_buff_config.IdType
        for _, v in pairs(ConfigMgr.Config.BossTowerBuffMap) do
            if v.Id ~= boss_tower_buff_config.Id
                and v.EnhanceId == id_type
                and v.IdType ~= boss_tower_buff_config.IdType then
                table.insert(list, v)
            end
        end
    end

    this.set_enhanced_buff_list(list)
end

function this.btn_confirm()
    if IsNullOrEmpty(this.current_buff_id) then
        LuaMgr.Back()
    else
        ApiMgr.Request("bossTower/chooseBuff", {Choose=this.current_buff_id} , true, function(result)
            LuaMgr.Back()
        end, function(code)

        end, true);
    end
end

function this.OnBack()
    LuaMgr.Back()
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)