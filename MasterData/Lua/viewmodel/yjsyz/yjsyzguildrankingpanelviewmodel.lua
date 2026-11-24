require("ViewModel/YJSYZ/YJSYZGuildRankingPanelRankItem")

local this =
{
    vm = nil,
}

local objs =
{
    rank_list_go = { path = "root/Middle/ui_scroll_ranking/Viewport/Content", type = "GameObject" },
    rank_item_go = { path = "template/item", type = "GameObject" },
    my_score_go = { path = "root/Middle/my_score", type = "GameObject"},
}

local data =
{

}

local command =
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

function this.init(vm)
    this.vm                 = vm
    this.gameObject         = this.vm.behaviour.gameObject

    UITool.Parse(this.gameObject, this, objs)
end

function this.on_before_active()
    this.gameObject = this.vm.behaviour.gameObject

    this.rank_list = UIListView.New(this.rank_list_go.transform)
    this.rank_list:Clear()

    this.set_rank_list()
    this.set_my_rank()
end

function this.on_before_deactive()
    if this.rank_list ~= nil then
        this.rank_list:Clear()
    end

    UIListView.ClearItem("YJSYZGuildRankingPanelRankItem")
end

function this.set_rank_list()
    this.rank_list:Clear()

    if DataMgr.Player.guildData == nil or DataMgr.Player.guildData.guildId == "" then

        return
    end

    local data_list = {}

    for i, v in ipairs(YJSYZHelper.get_rank_list_in_guild()) do
        local element = {}

        element.rank            = v.rank
        element.name            = v.name
        element.avatarid        = v.avatarid
        element.avatarframeid   = v.avatarframeid
        element.point           = v.point
        element.hero_list       = table.Copy(v.hero_list)

        local data = UIListData.GetData(this.rank_item_go, "YJSYZGuildRankingPanelRankItem", element)
        table.insert(data_list, data)
    end

    this.rank_list:SetData(data_list, true)
end

function this.set_my_rank()
    local my_rank = YJSYZHelper.get_my_rank_in_guild()
    if my_rank == nil or next(my_rank) == nil then
        this.my_score_go:SetActive(false)
        return
    end

    this.my_score_go:SetActive(true)

    local root = this.my_score_go.transform
    local text_rank = root:Find("rank/Text"):GetComponent("Text")
    local rank_1_go = root:Find("rank/bg/rank_1").gameObject
    local rank_2_go = root:Find("rank/bg/rank_2").gameObject
    local rank_3_go = root:Find("rank/bg/rank_3").gameObject
    local rank_go = root:Find("rank/bg/rank").gameObject
    local head = root:Find("name/head_icon/head"):GetComponent("RawImage")
    local frame = root:Find("name/head_icon/frame"):GetComponent("Image")
    local text_name = root:Find("name/text_name"):GetComponent("Text")
    local text_point = root:Find("point"):GetComponent("Text")
    local hero_list_go = this.my_score_go.transform:Find("hero_list")

    text_rank.text = tostring(my_rank.rank or 0)
    rank_1_go:SetActive(my_rank.rank == 1)
    rank_2_go:SetActive(my_rank.rank == 2)
    rank_3_go:SetActive(my_rank.rank == 3)
    rank_go:SetActive(my_rank.rank ~= 1 and my_rank.rank ~= 2 and my_rank.rank ~= 3)

    local avatarData = ConfigHelper.GetAvatarFrame(my_rank.avatarid) or ConfigHelper.GetAvatarFrame("SCJ101")
    head.texture = LuaMgr.GetTexture(ConfigHelper.GetHeadIconPath(avatarData.img, avatarData.imgId))
    PlayerAvatarFrameTool.SetAvatarFrame(frame, my_rank.avatarframeid or "20001")
    frame:SetNativeSize()
    text_name.text = tostring(my_rank.name or "")
    text_point.text = tostring(my_rank.point or 0)

    local hero_list = my_rank.hero_list or {}
    for i = 1, 6 do
        local hero_tr = hero_list_go:Find("hero_" .. i)
        if hero_tr ~= nil then
            local hero_id = hero_list[i]
            if hero_id == nil or hero_id == "" then
                hero_tr.gameObject:SetActive(false)
            else
                local icon = hero_tr:Find("icon"):GetComponent("RawImage")
                local rare = hero_tr:Find("icon/rare"):GetComponent("Image")
                local job = hero_tr:Find("zz"):GetComponent("Image")
                local hero_cfg = ConfigMgr.Config.characterTable[hero_id]
                if hero_cfg == nil then
                    hero_tr.gameObject:SetActive(false)
                else
                    hero_tr.gameObject:SetActive(true)
                    icon.texture = LuaMgr.GetTexture(ConfigHelper.GetCharacterAvatarPath(hero_id))
                    rare.sprite = LuaMgr.GetSprite("CommonRes", "ui_ty_kp_pz_" .. tostring(hero_cfg.rare))
                    job.sprite = LuaMgr.GetSprite("JobIcon", "job_" .. tostring(hero_cfg.job))
                end
            end
        end
    end
end

return vm(
    {
        data = data,
        command = command,
        hook = hook
    }
)