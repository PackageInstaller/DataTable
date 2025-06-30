module("fashion.FashionConfigVo", Class.impl())

function ctor(self)
    self:__init()
end

function __init(self)
    self.heroTid = nil
    self.sortIndex = nil
    self.fashionId = nil
    self.fashionType = nil
    self.costTid = nil
    self.model = nil
end

function parseConfigData(self, cusHeroTid, fashionType, cusData)
    self.heroTid = cusHeroTid
    self.sortIndex = cusData.sort
    self.fashionId = cusData.id
    self.fashionType = fashionType
    self.costTid = cusData.cost_tid
    self.model = cusData.model
    self.highModel = cusData.high_model
    self.hostelModel = cusData.hostel_model
    self.head = cusData.head
    self.imgbody = cusData.img_body
    self.imgpainting = cusData.img_painting
    self.fashionName = cusData.fashion_name
    self.fashionDsc = cusData.dsc
    self.fashionSeries = cusData.series
    self.fashionIcon = cusData.fashionIcon
    self.fashionCion = cusData.fashion_coin
    self.colour = cusData.colour
    self.tap = cusData.tap
end

function getUIModel(self)
    if self.highModel and self.highModel ~= "" then
        return self.highModel
    end
    return self.model
end

function getHostelModel(self)
    return self.hostelModel
end

--获取皮肤商店左上角色块的色值
function getColour(self)
    if self.colour == "" then
        self.colour = "ffffffff"
    end
    return self.colour .. "ff"
end

--获取头像路径
function getUrlHead(self)
    return self.head
end

--获取全身像路径
function getUrlBody(self)
    return self.imgbody
end

--获取原画
function getUrlPainting(self)
    return self.imgpainting
end

--获取半身像原画
function getFashionBodyIcon(self)
    return UrlManager:getHeroFashionBodyPath(self.model)
end

--获取时装名称
function getName(self)
    return _TT(self.fashionName)
end

--获取时装系列
function getFashionSeries(self)
    return _TT(self.fashionSeries)
end

--获取时装介绍
function getFashionDsc(self)
    return _TT(self.fashionDsc)
end

--获取战员名称
function getHeroName(self)
    return hero.HeroManager:getHeroConfigVo(self.heroTid).name
end

function getFshionCion(self)
    return self.fashionCion
end

return _M

--[[ 替换语言包自动生成，请勿修改！
]]
