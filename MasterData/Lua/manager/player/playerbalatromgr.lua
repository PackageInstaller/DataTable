







PlayerBalatroMgr = {}
local this = {
    PlayerArchivesKey = nil,
    ArchivesData = nil
}

PlayerBalatroMgr.Init = function()
    this.PlayerArchivesKey = DataMgr.Player.uid .. "BALATRO_BRAND_DATA"
    PlayerBalatroMgr.InitArchives()
end


PlayerBalatroMgr.InitArchives = function()
    local archivesStr = PlayerPrefs.GetString(this.PlayerArchivesKey)
    if not archivesStr or archivesStr == "" then
        this.ArchivesData = {}
    else
        this.ArchivesData = json.decode(archivesStr)
    end
end

PlayerBalatroMgr.SetBalatroBrand = function(uid, brandID, isSelect)
    if not this.ArchivesData.SelectBrands then
        this.ArchivesData.SelectBrands = {}
    end
    local idStr = tostring(uid)
    if not this.ArchivesData.SelectBrands[idStr] then
        this.ArchivesData.SelectBrands[idStr] = {}
    end
    this.ArchivesData.SelectBrands[idStr].BrandID = brandID
    this.ArchivesData.SelectBrands[idStr].IsSelect = isSelect
    PlayerBalatroMgr.SaveArchives()
end

PlayerBalatroMgr.SaveArchives = function()
    PlayerPrefs.SetString(this.PlayerArchivesKey, json.encode(this.ArchivesData))
    PlayerPrefs.Save()
end

PlayerBalatroMgr.GetArchivesData = function()
    return this.ArchivesData or {}
end


