require("ViewModel/Activity/Ranking_Item")

local this = 
{
    vm = nil,
    objs =
    {
        top1_head_gameObject    = {path = "root/Middle/top_head_item_1/head_icon", type = "GameObject"},
        top1_head_texture       = {path = "root/Middle/top_head_item_1/head_icon/head", type = "RawImage"},
        top1_head_frame         = {path = "root/Middle/top_head_item_1/head_icon/frame", type = "Image"},
        top1_power_group        = {path = "root/Middle/top_head_item_1/group1", type = "GameObject"},
        top1_power_text         = {path = "root/Middle/top_head_item_1/group1/Text", type = "Text"},
        top1_name_text          = {path = "root/Middle/top_head_item_1/Text", type = "Text"},

        top2_head_gameObject    = {path = "root/Middle/top_head_item_2/head_icon", type = "GameObject"},
        top2_head_texture       = {path = "root/Middle/top_head_item_2/head_icon/head", type = "RawImage"},
        top2_head_frame         = {path = "root/Middle/top_head_item_2/head_icon/frame", type = "Image"},
        top2_power_group        = {path = "root/Middle/top_head_item_2/group1", type = "GameObject"},
        top2_power_text         = {path = "root/Middle/top_head_item_2/group1/Text", type = "Text"},
        top2_name_text          = {path = "root/Middle/top_head_item_2/Text", type = "Text"},

        top3_head_gameObject    = {path = "root/Middle/top_head_item_3/head_icon", type = "GameObject"},
        top3_head_texture       = {path = "root/Middle/top_head_item_3/head_icon/head", type = "RawImage"},
        top3_head_frame         = {path = "root/Middle/top_head_item_3/head_icon/frame", type = "Image"},
        top3_power_group        = {path = "root/Middle/top_head_item_3/group1", type = "GameObject"},
        top3_power_text         = {path = "root/Middle/top_head_item_3/group1/Text", type = "Text"},
        top3_name_text          = {path = "root/Middle/top_head_item_3/Text", type = "Text"},

        my_rank_gameObject      = {path = "root/Middle/my_rank_item/head_icon", type = "GameObject"},
        my_rank_head_texture    = {path = "root/Middle/my_rank_item/head_icon/head", type = "RawImage"},
        my_rank_head_frame      = {path = "root/Middle/my_rank_item/head_icon/frame", type = "Image"},
        my_rank_power_text      = {path = "root/Middle/my_rank_item/power", type = "Text"},
        my_rank_rank_text       = {path = "root/Middle/my_rank_item/text_rank", type = "Text"},
        my_rank_name_text       = {path = "root/Middle/my_rank_item/text_name", type = "Text"},
    }
}

local data = 
{

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

        this.scrollView = UIScrollView.New(vm.behaviour.transform:Find("root/Middle/ui_scroll_rank").gameObject)
        this.itemObj = vm.behaviour.transform:Find("template/item").gameObject

        this.set_data(vm.behaviour.Params[0])
    end,
    before_deactive = function(vm)
        if vm.behaviour.Params == nil then
            return
        end
        this.on_before_deactive()
    end,
    before_destroy = function()
        this.scrollView:Clear(true)
        UIScrollView.ClearItem("Ranking_Item")
    end
}

local command = 
{
    on_click_back_btn =
    {
        type = XLuaCommandType.Void,
        execute = function(vm, param)
            this.on_click_back_btn()
        end
    }
}

function this.init(vm)
    this.vm = vm
end

function this.set_data(d)
    local data = d.data_list
    if #data >= 1 then
        this.set_top(data[1], 1, true)
    else
        this.set_top(data[1], 1, false)
    end

    if #data >= 2 then
        this.set_top(data[2], 2, true)
    else
        this.set_top(data[2], 2, false)
    end

    if #data >= 3 then
        this.set_top(data[3], 3, true)
    else
        this.set_top(data[3], 3, false)
    end

    this.scrollView:SetParams(636, 285)
    this.scrollView:Clear(true)

    if #data > 3 then
        local data_list = {}

        for i = 4, #data do
            local item_data = table.Copy(data[i])
            
            local scroll_data = UIScrollData.GetData(this.itemObj, "Ranking_Item", 636, 76, item_data)
            table.insert(data_list, scroll_data)
        end

        this.scrollView:SetData(data_list, true)
    end

    data = d.my_rank_data
    if data ~= nil then
        this.my_rank_gameObject:SetActive(true)
        this.my_rank_head_texture.enabled   = true
        this.my_rank_head_frame.enabled     = true
        this.my_rank_name_text.enabled      = true
        this.my_rank_power_text.enabled     = true
        this.my_rank_rank_text.enabled      = true

        local avatarData = ConfigHelper.GetAvatarFrame(data.avatarid) or ConfigHelper.GetAvatarFrame("SCJ101")
        this.my_rank_head_texture.texture   = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId))
        PlayerAvatarFrameTool.SetAvatarFrame(this.my_rank_head_frame, data.avatarframeid or "20001")
        this.my_rank_name_text.text         = tostring(data.name)
        this.my_rank_power_text.text        = tostring(data.power)
        this.my_rank_rank_text.text         = tostring(data.rank)
    else
        this.my_rank_gameObject:SetActive(false)
        this.my_rank_head_texture.enabled   = false
        this.my_rank_head_frame.enabled     = false
        this.my_rank_name_text.enabled      = false
        this.my_rank_power_text.enabled     = false
        this.my_rank_rank_text.enabled      = false
    end
end

function this.set_top(data, num, enabled)
    if enabled then
        local avatarData = ConfigHelper.GetAvatarFrame(data.avatarid) or ConfigHelper.GetAvatarFrame("SCJ101")
        this["top" .. num .. "_head_texture"].texture  = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId))
        PlayerAvatarFrameTool.SetAvatarFrame(this["top" .. num .. "_head_frame"], data.avatarframeid or "20001")
        this["top" .. num .. "_power_text"].text       = tostring(data.power)
        this["top" .. num .. "_name_text"].text        = tostring(data.name)
    end

    this["top" .. num .. "_head_gameObject"]:SetActive(enabled)
    this["top" .. num .. "_power_group"]:SetActive(enabled)
    this["top" .. num .. "_name_text"].enabled = enabled
end

function this.on_before_deactive()
    PlayerAvatarFrameTool.ClearImage(this.top1_head_frame)
    PlayerAvatarFrameTool.ClearImage(this.top2_head_frame)
    PlayerAvatarFrameTool.ClearImage(this.top3_head_frame)
    PlayerAvatarFrameTool.ClearImage(this.my_rank_head_frame)
    this.top1_head_gameObject    = nil
    this.top1_head_texture       = nil
    this.top1_head_frame         = nil
    this.top1_power_group        = nil
    this.top1_power_text         = nil
    this.top1_name_text          = nil

    this.top2_head_gameObject    = nil
    this.top2_head_texture       = nil
    this.top2_head_frame         = nil
    this.top2_power_group        = nil
    this.top2_power_text         = nil
    this.top2_name_text          = nil

    this.top3_head_gameObject    = nil
    this.top3_head_texture       = nil
    this.top3_head_frame         = nil
    this.top3_power_group        = nil
    this.top3_power_text         = nil
    this.top2_name_text          = nil

    this.my_rank_gameObject      = nil
    this.my_rank_head_texture    = nil
    this.my_rank_head_frame      = nil
    this.my_rank_power_text      = nil
    this.my_rank_rank_text       = nil
    this.my_rank_name_text       = nil
end

function this.on_click_back_btn()
    LuaMgr.HidePanel(UIName.ActivityBossChallengeRankingPopupViewModel)
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)