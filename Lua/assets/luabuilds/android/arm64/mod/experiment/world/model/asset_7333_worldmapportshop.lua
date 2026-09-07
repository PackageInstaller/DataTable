local WorldMapPortShop = class("WorldMapPortShop", import("...BaseEntity"))

WorldMapPortShop.Fields = {
	items = "table",
	expiredTime = "number"
}

function WorldMapPortShop:Setup()
	return
end

function WorldMapPortShop:IsValid()
	return self.expiredTime >= pg.TimeMgr.GetInstance():GetServerTime()
end

return WorldMapPortShop
