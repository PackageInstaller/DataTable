Algorithm = Algorithm
_staticClass("Algorithm")
Algorithm.COMPARE_LESS = 1
Algorithm.COMPARE_GREATER = 2
Algorithm.COMPARE_CUSTOM = 3

function Algorithm.LessComparer(object1, object2)
  if object1 < object2 then
    return 1
  elseif object2 < object1 then
    return -1
  else
    return 0
  end
end

function Algorithm.GreaterComparer(object1, object2)
  if object2 < object1 then
    return 1
  elseif object1 < object2 then
    return -1
  else
    return 0
  end
end
