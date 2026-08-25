local M = {}

function M.table_move(a1, f, e, t, a2)
  if a2 then
    for i = f, e do
      local i_a2 = t + (i - f)
      if i >= 1 and i <= #a1 and i_a2 >= 1 then
        a2[i_a2] = a1[i]
      end
    end
  else
    local temp = {}
    for i = f, e do
      table.insert(temp, a1[i])
    end
    for i, v in pairs(temp) do
      local i_new = t + i - 1
      if i_new >= 1 then
        a1[i_new] = v
      end
    end
  end
end

return M
