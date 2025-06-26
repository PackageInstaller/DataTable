module("supercial.SupercialVo", Class.impl())

function parseData(self,id,data)
    self.id = id
    --self.prevId = data.prev_id
    self.postId = data.post_id
    self.type = data.type
    self.rewardDropid = data.reward_dropid
    self.showDropid = data.show_dropid
    self.price = data.price
    --self.detailId = data.detailId
    self.name = data.name
end


return _M