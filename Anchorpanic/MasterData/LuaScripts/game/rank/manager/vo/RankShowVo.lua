module('game.rank.manager.vo.RankShowVo', Class.impl())

function parseConfigData(self, key, cusData)
    self.id = key
    self.subtype = cusData.subtype
    self.pageLangs = cusData.page_lang
    self.pageLang = self.pageLangs[1]
    self.funIds = cusData.function_id
    self.tapLangs = cusData.tap_lang
end

return _M