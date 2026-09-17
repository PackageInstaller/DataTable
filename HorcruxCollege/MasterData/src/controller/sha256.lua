local var_0_0 = {}
local var_0_1 = 4294967296
local var_0_2 = 4294967296 - 1

local function var_0_3(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = setmetatable({}, var_1_0)

	function var_1_0.__index(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0(arg_2_1)

		var_1_1[arg_2_1] = var_2_0

		return var_2_0
	end

	return var_1_1
end

local function var_0_4(arg_3_0, arg_3_1)
	return function(arg_4_0, arg_4_1)
		local var_4_0 = 0
		local var_4_1 = 1

		while arg_4_0 ~= 0 and arg_4_1 ~= 0 do
			var_4_0 = var_4_0 + arg_3_0[arg_4_0 % arg_3_1][arg_4_1 % arg_3_1] * var_4_1
			arg_4_0 = (arg_4_0 - arg_4_0 % arg_3_1) / arg_3_1
			arg_4_1 = (arg_4_1 - arg_4_1 % arg_3_1) / arg_3_1
			var_4_1 = var_4_1 * arg_3_1
		end

		return var_4_0 + (arg_4_0 + arg_4_1) * var_4_1
	end
end

local var_0_5 = (function(arg_5_0)
	local var_5_0 = var_0_4(arg_5_0, 2)

	return var_0_4(var_0_3(function(arg_6_0)
		return var_0_3(function(arg_7_0)
			return var_5_0(arg_6_0, arg_7_0)
		end)
	end), 2^(arg_5_0.n or 1))
end)({
	[0] = {
		[0] = 0,
		1
	},
	{
		[0] = 1,
		0
	},
	n = 4
})

local function var_0_6(arg_8_0, arg_8_1, arg_8_2, ...)
	if arg_8_1 then
		arg_8_0 = arg_8_0 % var_0_1
		arg_8_1 = arg_8_1 % var_0_1

		local var_8_1 = var_0_5(arg_8_0, arg_8_1)

		if arg_8_2 then
			var_8_1 = var_0_6(var_8_1, arg_8_2, ...)
		end

		return var_8_1
	elseif arg_8_0 then
		return arg_8_0 % var_0_1
	else
		return 0
	end
end

local function var_0_7(arg_9_0, arg_9_1, arg_9_2, ...)
	if arg_9_1 then
		arg_9_0 = arg_9_0 % var_0_1
		arg_9_1 = arg_9_1 % var_0_1

		local var_9_1 = (arg_9_0 + arg_9_1 - var_0_5(arg_9_0, arg_9_1)) / 2

		if arg_9_2 then
			var_9_1 = bit32_band(var_9_1, arg_9_2, ...)
		end

		return var_9_1
	elseif arg_9_0 then
		return arg_9_0 % var_0_1
	else
		return var_0_2
	end
end

local function var_0_8(arg_10_0)
	return (-1 - arg_10_0) % var_0_1
end

local function var_0_9(arg_11_0, arg_11_1)
	if arg_11_1 < 0 then
		return lshift(arg_11_0, -arg_11_1)
	end

	return math.floor(arg_11_0 % 4294967296 / 2^arg_11_1)
end

local function var_0_10(arg_12_0, arg_12_1)
	if arg_12_1 > 31 or arg_12_1 < -31 then
		return 0
	end

	return var_0_9(arg_12_0 % var_0_1, arg_12_1)
end

local function var_0_11(arg_13_0, arg_13_1)
	if arg_13_1 < 0 then
		return var_0_10(arg_13_0, -arg_13_1)
	end

	return arg_13_0 * 2^arg_13_1 % 4294967296
end

local function var_0_12(arg_14_0, arg_14_1)
	arg_14_0 = arg_14_0 % var_0_1
	arg_14_1 = arg_14_1 % 32

	return var_0_10(arg_14_0, arg_14_1) + var_0_11(var_0_7(arg_14_0, 2^arg_14_1 - 1), 32 - arg_14_1)
end

local var_0_13 = {
	1116352408,
	1899447441,
	3049323471,
	3921009573,
	961987163,
	1508970993,
	2453635748,
	2870763221,
	3624381080,
	310598401,
	607225278,
	1426881987,
	1925078388,
	2162078206,
	2614888103,
	3248222580,
	3835390401,
	4022224774,
	264347078,
	604807628,
	770255983,
	1249150122,
	1555081692,
	1996064986,
	2554220882,
	2821834349,
	2952996808,
	3210313671,
	3336571891,
	3584528711,
	113926993,
	338241895,
	666307205,
	773529912,
	1294757372,
	1396182291,
	1695183700,
	1986661051,
	2177026350,
	2456956037,
	2730485921,
	2820302411,
	3259730800,
	3345764771,
	3516065817,
	3600352804,
	4094571909,
	275423344,
	430227734,
	506948616,
	659060556,
	883997877,
	958139571,
	1322822218,
	1537002063,
	1747873779,
	1955562222,
	2024104815,
	2227730452,
	2361852424,
	2428436474,
	2756734187,
	3204031479,
	3329325298
}

local function var_0_14(arg_15_0)
	return (string.gsub(arg_15_0, ".", function(arg_16_0)
		return string.format("%02x", string.byte(arg_16_0))
	end))
end

local function var_0_15(arg_17_0, arg_17_1)
	local var_17_0 = ""

	for iter_17_0 = 1, arg_17_1 do
		var_17_0 = string.char(arg_17_0 % 256) .. var_17_0
		arg_17_0 = (arg_17_0 - arg_17_0 % 256) / 256
	end

	return var_17_0
end

local function var_0_16(arg_18_0, arg_18_1)
	local var_18_0 = 0

	for iter_18_0 = arg_18_1, arg_18_1 + 3 do
		var_18_0 = var_18_0 * 256 + string.byte(arg_18_0, iter_18_0)
	end

	return var_18_0
end

local function var_0_17(arg_19_0, arg_19_1)
	local var_19_0 = 64 - (arg_19_1 + 9) % 64

	if 64 - (arg_19_1 + 9) % 64 == 64 then
		var_19_0 = 0
	end

	arg_19_1 = var_0_15(8 * arg_19_1, 8)
	arg_19_0 = arg_19_0 .. "\x80" .. string.rep("\x00", var_19_0) .. arg_19_1

	assert(#arg_19_0 % 64 == 0)

	return arg_19_0
end

local function var_0_18(arg_20_0)
	arg_20_0[1] = 1779033703
	arg_20_0[2] = 3144134277
	arg_20_0[3] = 1013904242
	arg_20_0[4] = 2773480762
	arg_20_0[5] = 1359893119
	arg_20_0[6] = 2600822924
	arg_20_0[7] = 528734635
	arg_20_0[8] = 1541459225

	return arg_20_0
end

local function var_0_19(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}

	for iter_21_0 = 1, 16 do
		var_21_0[iter_21_0] = var_0_16(arg_21_0, arg_21_1 + (iter_21_0 - 1) * 4)
	end

	for iter_21_1 = 17, 64 do
		var_21_0[iter_21_1] = var_21_0[iter_21_1 - 16] + var_0_6(var_0_12(var_21_0[iter_21_1 - 15], 7), var_0_12(var_21_0[iter_21_1 - 15], 18), var_0_10(var_21_0[iter_21_1 - 15], 3)) + var_21_0[iter_21_1 - 7] + var_0_6(var_0_12(var_21_0[iter_21_1 - 2], 17), var_0_12(var_21_0[iter_21_1 - 2], 19), var_0_10(var_21_0[iter_21_1 - 2], 10))
	end

	local var_21_1 = arg_21_2[1]
	local var_21_2 = arg_21_2[2]
	local var_21_3 = arg_21_2[3]
	local var_21_4 = arg_21_2[4]
	local var_21_5 = arg_21_2[5]
	local var_21_6 = arg_21_2[6]
	local var_21_7 = arg_21_2[7]
	local var_21_8 = arg_21_2[8]

	for iter_21_2 = 1, 64 do
		local var_21_9 = var_21_8 + var_0_6(var_0_12(var_21_5, 6), var_0_12(var_21_5, 11), var_0_12(var_21_5, 25)) + var_0_6(var_0_7(var_21_5, var_21_6), var_0_7(var_0_8(var_21_5), var_21_7)) + var_0_13[iter_21_2] + var_21_0[iter_21_2]

		var_21_1 = var_21_9 + (var_0_6(var_0_12(var_21_1, 2), var_0_12(var_21_1, 13), var_0_12(var_21_1, 22)) + var_0_6(var_0_7(var_21_1, var_21_2), var_0_7(var_21_1, var_21_3), var_0_7(var_21_2, var_21_3)))
		var_21_2 = var_21_1
		var_21_3 = var_21_2
		var_21_4 = var_21_3
		var_21_5 = var_21_4 + var_21_9
		var_21_6 = var_21_5
		var_21_7 = var_21_6
		var_21_8 = var_21_7
	end

	arg_21_2[1] = var_0_7(arg_21_2[1] + var_21_1)
	arg_21_2[2] = var_0_7(arg_21_2[2] + var_21_2)
	arg_21_2[3] = var_0_7(arg_21_2[3] + var_21_3)
	arg_21_2[4] = var_0_7(arg_21_2[4] + var_21_4)
	arg_21_2[5] = var_0_7(arg_21_2[5] + var_21_5)
	arg_21_2[6] = var_0_7(arg_21_2[6] + var_21_6)
	arg_21_2[7] = var_0_7(arg_21_2[7] + var_21_7)
	arg_21_2[8] = var_0_7(arg_21_2[8] + var_21_8)
end

local function var_0_20(arg_22_0)
	return arg_22_0:gsub("..", function(arg_23_0)
		return string.char(tonumber(arg_23_0, 16))
	end)
end

local var_0_21 = 64
local var_0_22 = {
	[string.char(0)] = string.char(92),
	[string.char(1)] = string.char(93),
	[string.char(2)] = string.char(94),
	[string.char(3)] = string.char(95),
	[string.char(4)] = string.char(88),
	[string.char(5)] = string.char(89),
	[string.char(6)] = string.char(90),
	[string.char(7)] = string.char(91),
	[string.char(8)] = string.char(84),
	[string.char(9)] = string.char(85),
	[string.char(10)] = string.char(86),
	[string.char(11)] = string.char(87),
	[string.char(12)] = string.char(80),
	[string.char(13)] = string.char(81),
	[string.char(14)] = string.char(82),
	[string.char(15)] = string.char(83),
	[string.char(16)] = string.char(76),
	[string.char(17)] = string.char(77),
	[string.char(18)] = string.char(78),
	[string.char(19)] = string.char(79),
	[string.char(20)] = string.char(72),
	[string.char(21)] = string.char(73),
	[string.char(22)] = string.char(74),
	[string.char(23)] = string.char(75),
	[string.char(24)] = string.char(68),
	[string.char(25)] = string.char(69),
	[string.char(26)] = string.char(70),
	[string.char(27)] = string.char(71),
	[string.char(28)] = string.char(64),
	[string.char(29)] = string.char(65),
	[string.char(30)] = string.char(66),
	[string.char(31)] = string.char(67),
	[string.char(32)] = string.char(124),
	[string.char(33)] = string.char(125),
	[string.char(34)] = string.char(126),
	[string.char(35)] = string.char(127),
	[string.char(36)] = string.char(120),
	[string.char(37)] = string.char(121),
	[string.char(38)] = string.char(122),
	[string.char(39)] = string.char(123),
	[string.char(40)] = string.char(116),
	[string.char(41)] = string.char(117),
	[string.char(42)] = string.char(118),
	[string.char(43)] = string.char(119),
	[string.char(44)] = string.char(112),
	[string.char(45)] = string.char(113),
	[string.char(46)] = string.char(114),
	[string.char(47)] = string.char(115),
	[string.char(48)] = string.char(108),
	[string.char(49)] = string.char(109),
	[string.char(50)] = string.char(110),
	[string.char(51)] = string.char(111),
	[string.char(52)] = string.char(104),
	[string.char(53)] = string.char(105),
	[string.char(54)] = string.char(106),
	[string.char(55)] = string.char(107),
	[string.char(56)] = string.char(100),
	[string.char(57)] = string.char(101),
	[string.char(58)] = string.char(102),
	[string.char(59)] = string.char(103),
	[string.char(60)] = string.char(96),
	[string.char(61)] = string.char(97),
	[string.char(62)] = string.char(98),
	[string.char(63)] = string.char(99),
	[string.char(64)] = string.char(28),
	[string.char(65)] = string.char(29),
	[string.char(66)] = string.char(30),
	[string.char(67)] = string.char(31),
	[string.char(68)] = string.char(24),
	[string.char(69)] = string.char(25),
	[string.char(70)] = string.char(26),
	[string.char(71)] = string.char(27),
	[string.char(72)] = string.char(20),
	[string.char(73)] = string.char(21),
	[string.char(74)] = string.char(22),
	[string.char(75)] = string.char(23),
	[string.char(76)] = string.char(16),
	[string.char(77)] = string.char(17),
	[string.char(78)] = string.char(18),
	[string.char(79)] = string.char(19),
	[string.char(80)] = string.char(12),
	[string.char(81)] = string.char(13),
	[string.char(82)] = string.char(14),
	[string.char(83)] = string.char(15),
	[string.char(84)] = string.char(8),
	[string.char(85)] = string.char(9),
	[string.char(86)] = string.char(10),
	[string.char(87)] = string.char(11),
	[string.char(88)] = string.char(4),
	[string.char(89)] = string.char(5),
	[string.char(90)] = string.char(6),
	[string.char(91)] = string.char(7),
	[string.char(92)] = string.char(0),
	[string.char(93)] = string.char(1),
	[string.char(94)] = string.char(2),
	[string.char(95)] = string.char(3),
	[string.char(96)] = string.char(60),
	[string.char(97)] = string.char(61),
	[string.char(98)] = string.char(62),
	[string.char(99)] = string.char(63),
	[string.char(100)] = string.char(56),
	[string.char(101)] = string.char(57),
	[string.char(102)] = string.char(58),
	[string.char(103)] = string.char(59),
	[string.char(104)] = string.char(52),
	[string.char(105)] = string.char(53),
	[string.char(106)] = string.char(54),
	[string.char(107)] = string.char(55),
	[string.char(108)] = string.char(48),
	[string.char(109)] = string.char(49),
	[string.char(110)] = string.char(50),
	[string.char(111)] = string.char(51),
	[string.char(112)] = string.char(44),
	[string.char(113)] = string.char(45),
	[string.char(114)] = string.char(46),
	[string.char(115)] = string.char(47),
	[string.char(116)] = string.char(40),
	[string.char(117)] = string.char(41),
	[string.char(118)] = string.char(42),
	[string.char(119)] = string.char(43),
	[string.char(120)] = string.char(36),
	[string.char(121)] = string.char(37),
	[string.char(122)] = string.char(38),
	[string.char(123)] = string.char(39),
	[string.char(124)] = string.char(32),
	[string.char(125)] = string.char(33),
	[string.char(126)] = string.char(34),
	[string.char(127)] = string.char(35),
	[string.char(128)] = string.char(220),
	[string.char(129)] = string.char(221),
	[string.char(130)] = string.char(222),
	[string.char(131)] = string.char(223),
	[string.char(132)] = string.char(216),
	[string.char(133)] = string.char(217),
	[string.char(134)] = string.char(218),
	[string.char(135)] = string.char(219),
	[string.char(136)] = string.char(212),
	[string.char(137)] = string.char(213),
	[string.char(138)] = string.char(214),
	[string.char(139)] = string.char(215),
	[string.char(140)] = string.char(208),
	[string.char(141)] = string.char(209),
	[string.char(142)] = string.char(210),
	[string.char(143)] = string.char(211),
	[string.char(144)] = string.char(204),
	[string.char(145)] = string.char(205),
	[string.char(146)] = string.char(206),
	[string.char(147)] = string.char(207),
	[string.char(148)] = string.char(200),
	[string.char(149)] = string.char(201),
	[string.char(150)] = string.char(202),
	[string.char(151)] = string.char(203),
	[string.char(152)] = string.char(196),
	[string.char(153)] = string.char(197),
	[string.char(154)] = string.char(198),
	[string.char(155)] = string.char(199),
	[string.char(156)] = string.char(192),
	[string.char(157)] = string.char(193),
	[string.char(158)] = string.char(194),
	[string.char(159)] = string.char(195),
	[string.char(160)] = string.char(252),
	[string.char(161)] = string.char(253),
	[string.char(162)] = string.char(254),
	[string.char(163)] = string.char(255),
	[string.char(164)] = string.char(248),
	[string.char(165)] = string.char(249),
	[string.char(166)] = string.char(250),
	[string.char(167)] = string.char(251),
	[string.char(168)] = string.char(244),
	[string.char(169)] = string.char(245),
	[string.char(170)] = string.char(246),
	[string.char(171)] = string.char(247),
	[string.char(172)] = string.char(240),
	[string.char(173)] = string.char(241),
	[string.char(174)] = string.char(242),
	[string.char(175)] = string.char(243),
	[string.char(176)] = string.char(236),
	[string.char(177)] = string.char(237),
	[string.char(178)] = string.char(238),
	[string.char(179)] = string.char(239),
	[string.char(180)] = string.char(232),
	[string.char(181)] = string.char(233),
	[string.char(182)] = string.char(234),
	[string.char(183)] = string.char(235),
	[string.char(184)] = string.char(228),
	[string.char(185)] = string.char(229),
	[string.char(186)] = string.char(230),
	[string.char(187)] = string.char(231),
	[string.char(188)] = string.char(224),
	[string.char(189)] = string.char(225),
	[string.char(190)] = string.char(226),
	[string.char(191)] = string.char(227),
	[string.char(192)] = string.char(156),
	[string.char(193)] = string.char(157),
	[string.char(194)] = string.char(158),
	[string.char(195)] = string.char(159),
	[string.char(196)] = string.char(152),
	[string.char(197)] = string.char(153),
	[string.char(198)] = string.char(154),
	[string.char(199)] = string.char(155),
	[string.char(200)] = string.char(148),
	[string.char(201)] = string.char(149),
	[string.char(202)] = string.char(150),
	[string.char(203)] = string.char(151),
	[string.char(204)] = string.char(144),
	[string.char(205)] = string.char(145),
	[string.char(206)] = string.char(146),
	[string.char(207)] = string.char(147),
	[string.char(208)] = string.char(140),
	[string.char(209)] = string.char(141),
	[string.char(210)] = string.char(142),
	[string.char(211)] = string.char(143),
	[string.char(212)] = string.char(136),
	[string.char(213)] = string.char(137),
	[string.char(214)] = string.char(138),
	[string.char(215)] = string.char(139),
	[string.char(216)] = string.char(132),
	[string.char(217)] = string.char(133),
	[string.char(218)] = string.char(134),
	[string.char(219)] = string.char(135),
	[string.char(220)] = string.char(128),
	[string.char(221)] = string.char(129),
	[string.char(222)] = string.char(130),
	[string.char(223)] = string.char(131),
	[string.char(224)] = string.char(188),
	[string.char(225)] = string.char(189),
	[string.char(226)] = string.char(190),
	[string.char(227)] = string.char(191),
	[string.char(228)] = string.char(184),
	[string.char(229)] = string.char(185),
	[string.char(230)] = string.char(186),
	[string.char(231)] = string.char(187),
	[string.char(232)] = string.char(180),
	[string.char(233)] = string.char(181),
	[string.char(234)] = string.char(182),
	[string.char(235)] = string.char(183),
	[string.char(236)] = string.char(176),
	[string.char(237)] = string.char(177),
	[string.char(238)] = string.char(178),
	[string.char(239)] = string.char(179),
	[string.char(240)] = string.char(172),
	[string.char(241)] = string.char(173),
	[string.char(242)] = string.char(174),
	[string.char(243)] = string.char(175),
	[string.char(244)] = string.char(168),
	[string.char(245)] = string.char(169),
	[string.char(246)] = string.char(170),
	[string.char(247)] = string.char(171),
	[string.char(248)] = string.char(164),
	[string.char(249)] = string.char(165),
	[string.char(250)] = string.char(166),
	[string.char(251)] = string.char(167),
	[string.char(252)] = string.char(160),
	[string.char(253)] = string.char(161),
	[string.char(254)] = string.char(162),
	[string.char(255)] = string.char(163)
}
local var_0_23 = {
	[string.char(0)] = string.char(54),
	[string.char(1)] = string.char(55),
	[string.char(2)] = string.char(52),
	[string.char(3)] = string.char(53),
	[string.char(4)] = string.char(50),
	[string.char(5)] = string.char(51),
	[string.char(6)] = string.char(48),
	[string.char(7)] = string.char(49),
	[string.char(8)] = string.char(62),
	[string.char(9)] = string.char(63),
	[string.char(10)] = string.char(60),
	[string.char(11)] = string.char(61),
	[string.char(12)] = string.char(58),
	[string.char(13)] = string.char(59),
	[string.char(14)] = string.char(56),
	[string.char(15)] = string.char(57),
	[string.char(16)] = string.char(38),
	[string.char(17)] = string.char(39),
	[string.char(18)] = string.char(36),
	[string.char(19)] = string.char(37),
	[string.char(20)] = string.char(34),
	[string.char(21)] = string.char(35),
	[string.char(22)] = string.char(32),
	[string.char(23)] = string.char(33),
	[string.char(24)] = string.char(46),
	[string.char(25)] = string.char(47),
	[string.char(26)] = string.char(44),
	[string.char(27)] = string.char(45),
	[string.char(28)] = string.char(42),
	[string.char(29)] = string.char(43),
	[string.char(30)] = string.char(40),
	[string.char(31)] = string.char(41),
	[string.char(32)] = string.char(22),
	[string.char(33)] = string.char(23),
	[string.char(34)] = string.char(20),
	[string.char(35)] = string.char(21),
	[string.char(36)] = string.char(18),
	[string.char(37)] = string.char(19),
	[string.char(38)] = string.char(16),
	[string.char(39)] = string.char(17),
	[string.char(40)] = string.char(30),
	[string.char(41)] = string.char(31),
	[string.char(42)] = string.char(28),
	[string.char(43)] = string.char(29),
	[string.char(44)] = string.char(26),
	[string.char(45)] = string.char(27),
	[string.char(46)] = string.char(24),
	[string.char(47)] = string.char(25),
	[string.char(48)] = string.char(6),
	[string.char(49)] = string.char(7),
	[string.char(50)] = string.char(4),
	[string.char(51)] = string.char(5),
	[string.char(52)] = string.char(2),
	[string.char(53)] = string.char(3),
	[string.char(54)] = string.char(0),
	[string.char(55)] = string.char(1),
	[string.char(56)] = string.char(14),
	[string.char(57)] = string.char(15),
	[string.char(58)] = string.char(12),
	[string.char(59)] = string.char(13),
	[string.char(60)] = string.char(10),
	[string.char(61)] = string.char(11),
	[string.char(62)] = string.char(8),
	[string.char(63)] = string.char(9),
	[string.char(64)] = string.char(118),
	[string.char(65)] = string.char(119),
	[string.char(66)] = string.char(116),
	[string.char(67)] = string.char(117),
	[string.char(68)] = string.char(114),
	[string.char(69)] = string.char(115),
	[string.char(70)] = string.char(112),
	[string.char(71)] = string.char(113),
	[string.char(72)] = string.char(126),
	[string.char(73)] = string.char(127),
	[string.char(74)] = string.char(124),
	[string.char(75)] = string.char(125),
	[string.char(76)] = string.char(122),
	[string.char(77)] = string.char(123),
	[string.char(78)] = string.char(120),
	[string.char(79)] = string.char(121),
	[string.char(80)] = string.char(102),
	[string.char(81)] = string.char(103),
	[string.char(82)] = string.char(100),
	[string.char(83)] = string.char(101),
	[string.char(84)] = string.char(98),
	[string.char(85)] = string.char(99),
	[string.char(86)] = string.char(96),
	[string.char(87)] = string.char(97),
	[string.char(88)] = string.char(110),
	[string.char(89)] = string.char(111),
	[string.char(90)] = string.char(108),
	[string.char(91)] = string.char(109),
	[string.char(92)] = string.char(106),
	[string.char(93)] = string.char(107),
	[string.char(94)] = string.char(104),
	[string.char(95)] = string.char(105),
	[string.char(96)] = string.char(86),
	[string.char(97)] = string.char(87),
	[string.char(98)] = string.char(84),
	[string.char(99)] = string.char(85),
	[string.char(100)] = string.char(82),
	[string.char(101)] = string.char(83),
	[string.char(102)] = string.char(80),
	[string.char(103)] = string.char(81),
	[string.char(104)] = string.char(94),
	[string.char(105)] = string.char(95),
	[string.char(106)] = string.char(92),
	[string.char(107)] = string.char(93),
	[string.char(108)] = string.char(90),
	[string.char(109)] = string.char(91),
	[string.char(110)] = string.char(88),
	[string.char(111)] = string.char(89),
	[string.char(112)] = string.char(70),
	[string.char(113)] = string.char(71),
	[string.char(114)] = string.char(68),
	[string.char(115)] = string.char(69),
	[string.char(116)] = string.char(66),
	[string.char(117)] = string.char(67),
	[string.char(118)] = string.char(64),
	[string.char(119)] = string.char(65),
	[string.char(120)] = string.char(78),
	[string.char(121)] = string.char(79),
	[string.char(122)] = string.char(76),
	[string.char(123)] = string.char(77),
	[string.char(124)] = string.char(74),
	[string.char(125)] = string.char(75),
	[string.char(126)] = string.char(72),
	[string.char(127)] = string.char(73),
	[string.char(128)] = string.char(182),
	[string.char(129)] = string.char(183),
	[string.char(130)] = string.char(180),
	[string.char(131)] = string.char(181),
	[string.char(132)] = string.char(178),
	[string.char(133)] = string.char(179),
	[string.char(134)] = string.char(176),
	[string.char(135)] = string.char(177),
	[string.char(136)] = string.char(190),
	[string.char(137)] = string.char(191),
	[string.char(138)] = string.char(188),
	[string.char(139)] = string.char(189),
	[string.char(140)] = string.char(186),
	[string.char(141)] = string.char(187),
	[string.char(142)] = string.char(184),
	[string.char(143)] = string.char(185),
	[string.char(144)] = string.char(166),
	[string.char(145)] = string.char(167),
	[string.char(146)] = string.char(164),
	[string.char(147)] = string.char(165),
	[string.char(148)] = string.char(162),
	[string.char(149)] = string.char(163),
	[string.char(150)] = string.char(160),
	[string.char(151)] = string.char(161),
	[string.char(152)] = string.char(174),
	[string.char(153)] = string.char(175),
	[string.char(154)] = string.char(172),
	[string.char(155)] = string.char(173),
	[string.char(156)] = string.char(170),
	[string.char(157)] = string.char(171),
	[string.char(158)] = string.char(168),
	[string.char(159)] = string.char(169),
	[string.char(160)] = string.char(150),
	[string.char(161)] = string.char(151),
	[string.char(162)] = string.char(148),
	[string.char(163)] = string.char(149),
	[string.char(164)] = string.char(146),
	[string.char(165)] = string.char(147),
	[string.char(166)] = string.char(144),
	[string.char(167)] = string.char(145),
	[string.char(168)] = string.char(158),
	[string.char(169)] = string.char(159),
	[string.char(170)] = string.char(156),
	[string.char(171)] = string.char(157),
	[string.char(172)] = string.char(154),
	[string.char(173)] = string.char(155),
	[string.char(174)] = string.char(152),
	[string.char(175)] = string.char(153),
	[string.char(176)] = string.char(134),
	[string.char(177)] = string.char(135),
	[string.char(178)] = string.char(132),
	[string.char(179)] = string.char(133),
	[string.char(180)] = string.char(130),
	[string.char(181)] = string.char(131),
	[string.char(182)] = string.char(128),
	[string.char(183)] = string.char(129),
	[string.char(184)] = string.char(142),
	[string.char(185)] = string.char(143),
	[string.char(186)] = string.char(140),
	[string.char(187)] = string.char(141),
	[string.char(188)] = string.char(138),
	[string.char(189)] = string.char(139),
	[string.char(190)] = string.char(136),
	[string.char(191)] = string.char(137),
	[string.char(192)] = string.char(246),
	[string.char(193)] = string.char(247),
	[string.char(194)] = string.char(244),
	[string.char(195)] = string.char(245),
	[string.char(196)] = string.char(242),
	[string.char(197)] = string.char(243),
	[string.char(198)] = string.char(240),
	[string.char(199)] = string.char(241),
	[string.char(200)] = string.char(254),
	[string.char(201)] = string.char(255),
	[string.char(202)] = string.char(252),
	[string.char(203)] = string.char(253),
	[string.char(204)] = string.char(250),
	[string.char(205)] = string.char(251),
	[string.char(206)] = string.char(248),
	[string.char(207)] = string.char(249),
	[string.char(208)] = string.char(230),
	[string.char(209)] = string.char(231),
	[string.char(210)] = string.char(228),
	[string.char(211)] = string.char(229),
	[string.char(212)] = string.char(226),
	[string.char(213)] = string.char(227),
	[string.char(214)] = string.char(224),
	[string.char(215)] = string.char(225),
	[string.char(216)] = string.char(238),
	[string.char(217)] = string.char(239),
	[string.char(218)] = string.char(236),
	[string.char(219)] = string.char(237),
	[string.char(220)] = string.char(234),
	[string.char(221)] = string.char(235),
	[string.char(222)] = string.char(232),
	[string.char(223)] = string.char(233),
	[string.char(224)] = string.char(214),
	[string.char(225)] = string.char(215),
	[string.char(226)] = string.char(212),
	[string.char(227)] = string.char(213),
	[string.char(228)] = string.char(210),
	[string.char(229)] = string.char(211),
	[string.char(230)] = string.char(208),
	[string.char(231)] = string.char(209),
	[string.char(232)] = string.char(222),
	[string.char(233)] = string.char(223),
	[string.char(234)] = string.char(220),
	[string.char(235)] = string.char(221),
	[string.char(236)] = string.char(218),
	[string.char(237)] = string.char(219),
	[string.char(238)] = string.char(216),
	[string.char(239)] = string.char(217),
	[string.char(240)] = string.char(198),
	[string.char(241)] = string.char(199),
	[string.char(242)] = string.char(196),
	[string.char(243)] = string.char(197),
	[string.char(244)] = string.char(194),
	[string.char(245)] = string.char(195),
	[string.char(246)] = string.char(192),
	[string.char(247)] = string.char(193),
	[string.char(248)] = string.char(206),
	[string.char(249)] = string.char(207),
	[string.char(250)] = string.char(204),
	[string.char(251)] = string.char(205),
	[string.char(252)] = string.char(202),
	[string.char(253)] = string.char(203),
	[string.char(254)] = string.char(200),
	[string.char(255)] = string.char(201)
}

function var_0_0.sha256(arg_24_0)
	arg_24_0 = var_0_17(arg_24_0, #arg_24_0)

	local var_24_0 = var_0_18({})

	for iter_24_0 = 1, #arg_24_0, 64 do
		var_0_19(arg_24_0, iter_24_0, var_24_0)
	end

	return var_0_14(var_0_15(var_24_0[1], 4) .. var_0_15(var_24_0[2], 4) .. var_0_15(var_24_0[3], 4) .. var_0_15(var_24_0[4], 4) .. var_0_15(var_24_0[5], 4) .. var_0_15(var_24_0[6], 4) .. var_0_15(var_24_0[7], 4) .. var_0_15(var_24_0[8], 4))
end

function var_0_0.sha256_binary(arg_25_0)
	return var_0_20(var_0_0.sha256(arg_25_0))
end

function var_0_0:hmac_sha256(arg_26_1)
	assert(type(self) == "string", "key passed to hmac_sha256 should be a string")
	assert(type(arg_26_1) == "string", "text passed to hmac_sha256 should be a string")

	if #self > var_0_21 then
		self = var_0_0.sha256_binary(self)
	end

	return var_0_0.sha256((self:gsub(".", var_0_22) .. string.rep(string.char(92), var_0_21 - #self)) .. var_0_0.sha256_binary((self:gsub(".", var_0_23) .. string.rep(string.char(54), var_0_21 - #self)) .. arg_26_1))
end

return var_0_0
