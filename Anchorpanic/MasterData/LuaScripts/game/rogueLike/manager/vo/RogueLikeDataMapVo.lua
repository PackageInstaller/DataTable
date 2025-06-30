module("rogueLike.RogueLikeDataMapVo", Class.impl())

-- 格子信息
function parseData(self, cusData)
    -- self.row_num = cusData.row_num
    -- 其他参数暂无发现意义 未使用
    -- self.derviveCell = cusData.dervive_cell
    self.guard = cusData.guard_cfg

    self.spType = cusData.sp_type
    self.spEffect = cusData.sp_effect
end

function getSpEffString(self)
    if self.spType == 1 then
        return string.substitute(_TT(56080),self.spEffect)
    else
        return string.substitute(_TT(56081),self.spEffect)
    end
end

function getColRow(self, id)
    return self.guard[id].col_id, self.guard[id].row_id
end

function getNum(self, id)
    if #self.guard[id].derive_cells == 1 and type(self.guard[id].derive_cells[1]) == "number" then
        return self.guard[id].derive_cells[1]
    end
    return 0
end

--获取生成的规则
function getRule(self, id)
    return self.guard[id].derive_rule
end

--获取被生成的规则
function getChildRule(self,id)
    return self.guard[id].child_rule
end
return _M
 
--[[ 替换语言包自动生成，请勿修改！
]]
