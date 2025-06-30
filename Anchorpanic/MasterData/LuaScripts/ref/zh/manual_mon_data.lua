-- from 087 怪物档案配置表.xlsx

local manual_mon_data=

{
	[1]={ model="6133", name="持枪混混", english="DAVIST", story="脏乱差地区随处可见的地痞流氓，拽拽地拿着不知从哪弄到手的手枪，手枪看起来非常像玩具模型，虽然看着很凶但实际上战斗力很差，色厉内荏。", hero_type=2, shadow="mon_archives_normal_6133.png", shadow_unlock="mon_archives_shadow_6133.png", dangerous=1, skill_list={300080,300086,3001}, type=1, special="对位优先", speed="较快", element={0}, weak_point={1,3}
},
	[2]={ model="6134", name="步枪手", english="Flanbine", story="经过专门训练的专业人士，装备着电磁突击步枪与轻装护甲，不是一般的民间人可以与其抗衡的对手。", hero_type=2, shadow="mon_archives_normal_6134.png", shadow_unlock="mon_archives_shadow_6134.png", dangerous=1, skill_list={300080,300086,3007}, type=1, special="后排优先", speed="较快", element={0}, weak_point={1,2}
},
	[3]={ model="6135", name="盾锤手", english="Batianta", story="经过专门训练的专业人士，装备防爆盾牌与破坏锤，在远程火力的支援下可以轻松撕开敌对方的防线。", hero_type=2, shadow="mon_archives_normal_6135.png", shadow_unlock="mon_archives_shadow_6135.png", dangerous=1, skill_list={301080,300086,3013}, type=1, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[4]={ model="6132", name="水管混混", english="DAVIST", story="脏乱差地区随处可见的地痞流氓，手持着不知从哪里拿来的铁管，虽然看着很凶但实际上战斗力很差，色厉内荏。", hero_type=2, shadow="mon_archives_normal_6132.png", shadow_unlock="mon_archives_shadow_6132.png", dangerous=1, skill_list={300080,300086,3019}, type=1, special="前排优先", speed="较快", element={0}, weak_point={1,5}
},
	[21]={ model="6101", name="“监视蝇”", english="DAVIST", story="神光重科生产的TxP09型飞行监视器，外观上采用了飞蝇的仿生设计，超清摄像镜头搭载于复眼位置，可为用户提供最实时、最清晰的实况。除了作为监视器之外，其具备一定的作战能力，必要时可作为作战单位参与战斗，但战斗力并不高，请用户谨慎使用。", hero_type=2, shadow="mon_archives_normal_6101.png", shadow_unlock="mon_archives_shadow_6101.png", dangerous=1, skill_list={321080,320086,3201}, type=2, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[22]={ model="6116", name="“工作犬”", english="Hillley", story="以老旧的零件拼接制成的粗糙构造体，可以遵循简单的AI指令行动，常以群聚的形式大量出现，因其外观与犬类有一定的相似之处故而得名，制造者未知。", hero_type=2, shadow="mon_archives_normal_6116.png", shadow_unlock="mon_archives_shadow_6116.png", dangerous=1, skill_list={321080,320086,3207}, type=2, special="前排优先", speed="较快", element={0}, weak_point={1,3}
},
	[23]={ model="6113", name="“山地行者”", english="RITA", story="神光重科旗下某子企业开发的一款户外工作机械，拥有优秀的越野能力，非常适合山地、矿洞等复杂地形的作业——当然，除了基本的勘探功能外，为了应付一些紧急情况，该款机型同样配备了自律作战系统，请用户依据实际情况灵活使用。", hero_type=2, shadow="mon_archives_normal_6113.png", shadow_unlock="mon_archives_shadow_6113.png", dangerous=1, skill_list={320080,320086,3213}, type=2, special="对位优先", speed="较快", element={0}, weak_point={1,2}
},
	[25]={ model="6146", name="“链锯”", english="DAVIST", story="神光重科旗下某子企业开发的一款林间工作器械，常用于切割，砍伐类的作业。除了基本的作业功能外，为应付一些紧急情况，该款机型同样配备了应急作战系统，请用户根据实际情况谨慎使用。", hero_type=2, shadow="mon_archives_normal_6146.png", shadow_unlock="mon_archives_shadow_6146.png", dangerous=1, skill_list={321080,320086,3225}, type=2, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[41]={ model="6115", name="冲击钻", english="DAVIST", story="调整者教团成员，推测其地位并不高，这类异变体主要为教团的工事项目进行劳作，他们的手部异变结构能够钻开坚硬的建筑外表与地表，是“开凿能手”。该类异变体仍保有人类的自我意识，但沉默寡言，不管和他们说什么都得不到回应。尽管如此，遇到了也请立马逃走，以免被其攻击。", hero_type=2, shadow="mon_archives_normal_6115.png", shadow_unlock="mon_archives_shadow_6115.png", dangerous=1, skill_list={340080,340086,3401}, type=3, special="前排优先", speed="较快", element={0}, weak_point={1,3}
},
	[42]={ model="6104", name="利爪上班族", english="Kalan Lisa", story="常见于要塞都市周边的异变体——从仍能分辨出的西装、领带和皮鞋上，可以很明显地判断出他们的身份——城市中整日忙碌在格子间的上班族。也许，在未受到污染之前，他们正谈成了一笔生意，通过了一个方案，获得了加薪……抑或是下班了赶着与家人相会……然而，在未知的命运降临时，一切，戛然而止。", hero_type=2, shadow="mon_archives_normal_6104.png", shadow_unlock="mon_archives_shadow_6104.png", dangerous=1, skill_list={340080,340086,3407}, type=3, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[43]={ model="6105", name="大力少女", english="Corina", story="被感染的人类少女，穿着舒适宽松的连衣裙。曾经的她也许天真活泼，也许斯文内向，但被污染变异，失去人性以后，现在的她只有狂暴、残虐。如果你对她心存仁慈，那么，在处理她的时候，下手请尽量痛快一些，不要弄脏她的连衣裙。", hero_type=2, shadow="mon_archives_normal_6105.png", shadow_unlock="mon_archives_shadow_6105.png", dangerous=1, skill_list={340080,340086,3413}, type=3, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[44]={ model="6126", name="迅猛虫", english="Alice", story="广泛分布于泰诺星各处的某种大型昆虫在被污染后呈现的形态，经常集群出现，当你看到一只迅猛虫，就说明它的周围一定有超过二十只以上的同类。会发出令人不快的“嚓嚓”声，还会往人的身上扑，不知怎的会给人极大的心理压力……", hero_type=2, shadow="mon_archives_normal_6126.png", shadow_unlock="mon_archives_shadow_6126.png", dangerous=1, skill_list={340080,340086,3419}, type=3, special="后排优先", speed="较快", element={0}, weak_point={1,3}
},
	[45]={ model="6149", name="异变技工", english="Alice", story="曾在克罗瓦德工厂中工作，但被突如其来的虚粒子风暴污染，变成了异变体的可怜人。因其丧失了理智，对往日的同事发起无差别攻击，因此只能用武器让他们得以安息。", hero_type=2, shadow="mon_archives_normal_6149.png", shadow_unlock="mon_archives_shadow_6149.png", dangerous=1, skill_list={342580,340086,3425}, type=3, special="血量最低", speed="较快", element={0}, weak_point={1,3}
},
	[46]={ model="6155", name="噬人榕", english="Alice", story="塞洛维森林中常见的植物，多生长于水边，受到污染后扔保留着原来的形态和鲜艳色彩，从花蕊中喷出能量攻击靠近的一切生物，美丽，但致命。", hero_type=2, shadow="mon_archives_normal_6155.png", shadow_unlock="mon_archives_shadow_6155.png", dangerous=1, skill_list={342980,340086,3429}, type=3, special="后排优先", speed="较快", element={0}, weak_point={1,4}
},
	[47]={ model="6158", name="传教士", english="Alice", story="维拉提亚古代的传教士，在漫长的岁月中已经失去了自我，只剩下向神明祈祷星辰之力的本能。", hero_type=2, shadow="mon_archives_normal_6158.png", shadow_unlock="mon_archives_shadow_6158.png", dangerous=1, skill_list={343380,340086,3433}, type=3, special="对位优先", speed="较快", element={0}, weak_point={0,5}
},
	[61]={ model="6114", name="宇宙鱿鱼", english="Alicia", story="名为“修格尔”的外星生物中的一种，外观好似海洋中的鱿鱼，但和鱿鱼不同的是——这东西绝对不能吃！", hero_type=2, shadow="mon_archives_normal_6114.png", shadow_unlock="mon_archives_shadow_6114.png", dangerous=1, skill_list={360080,360086,3601}, type=4, special="对位优先", speed="较快", element={0}, weak_point={1,2}
},
	[62]={ model="6119", name="盒蝎", english="Bianno", story="名为“修格尔”的外星生物中的一种，外形类似泰诺星的蝎子，但身体更像一个长尾巴的方盒。像是从脓疱里钻出来一般的尾刺上附有剧毒，被刺中的伤口将疼痛难忍，甚至致人死命。", hero_type=2, shadow="mon_archives_normal_6119.png", shadow_unlock="mon_archives_shadow_6119.png", dangerous=1, skill_list={360080,360086,3607}, type=4, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[63]={ model="6120", name="石飞蜓", english="DAVIST", story="名为“修格尔”的外星生物中的一种，外形类似泰诺星的蜻蜓，但身体由类似石块的不明物质构成。移动极为迅速，并且喜欢成群出现，即使是体格庞大的敌人也难以抵挡一拥而上的石飞蜓。", hero_type=2, shadow="mon_archives_normal_6120.png", shadow_unlock="mon_archives_shadow_6120.png", dangerous=1, skill_list={360080,360086,3613}, type=4, special="前排优先", speed="较快", element={0}, weak_point={1,2}
},
	[64]={ model="6137", name="怪奇人偶", english="DAVIST", story="外形形似人造土偶的修格尔生物，集群出现，会从其“口”中发射带有杀伤力的光线，同时还会发出怪音，有研究者称这种怪音是修格尔之间的语言，但这种论调并没有得到认证与支持。", hero_type=2, shadow="mon_archives_normal_6137.png", shadow_unlock="mon_archives_shadow_6137.png", dangerous=1, skill_list={360080,360086,3619}, type=4, special="后排优先", speed="较快", element={0}, weak_point={1,2}
},
	[65]={ model="6128", name="干扰者", english="DAVIST", story="名为“修格尔”的外星生物中的一种，形似泰诺星上的节肢动物，它们以细长的多足支撑躯体，中间类似“核心”的躯干被能够释放出干扰电子设备的特殊能量，据研究表明，该特殊能量与电磁波相似。", hero_type=2, shadow="mon_archives_normal_6128.png", shadow_unlock="mon_archives_shadow_6128.png", dangerous=1, skill_list={360080,360086,3625}, type=4, special="前排优先", speed="较快", element={0}, weak_point={1,5}
},
	[66]={ model="6156", name="长草", english="DAVIST", story="过去广泛生长在塞洛维沼泽里的植物被污染后呈现的形态，会在沼泽环境中伪装成正常植物的样子，一旦有生物触碰就会变得极具攻击性。", hero_type=2, shadow="mon_archives_normal_6156.png", shadow_unlock="mon_archives_shadow_6156.png", dangerous=1, skill_list={363180,360086,3631}, type=4, special="对位优先", speed="较快", element={0}, weak_point={1,4}
},
	[101]={ model="1801", name="佣兵·斥候型", english="Flanbine", story="流窜于各个城市之间的佣兵，常用面罩覆面以掩饰真实身份。行动极其迅捷，一旦被其盯上，极难摆脱。据说这群人的口头禅是——只要钱给得够多，什么单子都可以接。", hero_type=2, shadow="mon_archives_normal_1801.png", shadow_unlock="mon_archives_shadow_1801.png", dangerous=2, skill_list={400080,400086,4001,400101}, type=1, special="后排优先", speed="中", element={0}, weak_point={1,2}
},
	[102]={ model="1802", name="佣兵·压制型", english="Batianta", story="某佣兵团的压制型佣兵，该类佣兵配备强大的手持式格林炮，负责执行危险度较高的作战任务，但他们通常都戴着面具和兜帽，鲜少以真面目示人，在佣兵团内也甚为神秘，据说连重击面部也无法将其面具击落。", hero_type=2, shadow="mon_archives_normal_1802.png", shadow_unlock="mon_archives_shadow_1802.png", dangerous=2, skill_list={400080,400086,4007,400701}, type=1, special="对位优先", speed="中", element={0}, weak_point={1,3}
},
	[103]={ model="6122", name="佣兵·突击型", english="DAVIST", story="某佣兵团的突击型佣兵，该类佣兵使用长枪，擅长贴身作战，近距离取敌人首级。但突击型佣兵通常都由女性构成，拥有姣好的身材且满头银发，虽然她们长得一模一样，就像是克隆出来的复制人，但在佣兵团内仍然深得大家的追捧与喜爱，不过她们通常只听命于雇佣兵团团长，对其他人不屑一顾。", hero_type=2, shadow="mon_archives_normal_6122.png", shadow_unlock="mon_archives_shadow_6122.png", dangerous=2, skill_list={401080,400086,4013,401301}, type=1, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[104]={ model="6106", name="生体强化人·男", english="DAVIST", story="被多次非法改造的生体强化人，改造者为其植入了许多未批准投入使用的试验型机械部件，虽然极大地强化了战斗力，但也很大程度地破坏了其人类的正常躯体结构。因改造者个人的原因，并未对其躯体复原多加关注，因此全身都仅勉强依靠绷带包覆维持外形——“只要穿好衣服，就没人会看出你是什么东西”，改造者是这么对实验者叮嘱的。", hero_type=2, shadow="mon_archives_normal_6106.png", shadow_unlock="mon_archives_shadow_6106.png", dangerous=2, skill_list={401080,400086,4019,401901}, type=1, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[105]={ model="6108", name="生体强化人·女", english="DAVIST", story="被多次非法改造的生体强化人，改造者为其植入了许多不符合设计规格但能提升体格的机械部件。因改造者个人的审美原因，为了保留其人类正常的躯体外观，从而注入了多种非法的复原液，但脸部却被人为毁坏无法辨认，所以常年使用绷带包裹。", hero_type=2, shadow="mon_archives_normal_6108.png", shadow_unlock="mon_archives_shadow_6108.png", dangerous=2, skill_list={400080,400086,4025,402501}, type=1, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[106]={ model="6145", name="RET防化兵", english="Kalan Lisa", story="在特殊军队中服役的士兵，是经过专门训练的专业人士，用以抵御敌方入侵，经常出没在第一线的战区。能给自己以及后方的友军提供强大的护盾，保证作战安全。", hero_type=2, shadow="mon_archives_normal_6145.png", shadow_unlock="mon_archives_shadow_6145.png", dangerous=2, skill_list={401080,400086,4031,403101}, type=1, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[151]={ model="6103", name="“巡行机兵”", english="Corina", story="由神光重科生产的Ys-3型巡行机兵，是神光重科与伯基索米国防部合作生产的第一款机械人型兵器，主要作用于替代巡逻特警执行一些危险的突击任务。该巡行机兵的出现使得人力紧张的伯基索米军警压力骤减，备受大家的喜爱，但最大的缺陷就是造价过高，数量较少。", hero_type=2, shadow="mon_archives_normal_6103.png", shadow_unlock="mon_archives_shadow_6103.png", dangerous=2, skill_list={421080,420086,4201,420101}, type=2, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[152]={ model="6111", name="“巡林客”", english="Alice", story="智能等级较低的机器人，最早出现在塞洛维，设计的初衷是为了代替人类进行森林巡护作业，人们结合了当地的一些特色为其加上了简陋的装饰。身材较为矮小，移动速度不快，但是发射的箭矢速度很快而且能精准命中目标。", hero_type=2, shadow="mon_archives_normal_6111.png", shadow_unlock="mon_archives_shadow_6111.png", dangerous=2, skill_list={420080,420086,4207,420701}, type=2, special="对位优先", speed="中", element={0}, weak_point={1,2}
},
	[153]={ model="6141", name="鲁滨Ⅹ", english="Alicia", story="用以进行野外勘探、少量物资运输、家庭防卫、个人陪伴等多种领域的高级机械狗”鲁滨“系列的第十代产品，再次升级了心智系统，整体思考逻辑等同于十二岁左右的人类。", hero_type=2, shadow="mon_archives_normal_6141.png", shadow_unlock="mon_archives_shadow_6141.png", dangerous=2, skill_list={420080,420086,4213,421301}, type=2, special="后排优先", speed="中", element={0}, weak_point={1,2}
},
	[154]={ model="6143", name="“鬼兵”", english="Bianno", story="修格尔入侵战争结束后，泰诺星各国开始重整世界，期间各国冲突不断，各种新兵器也大量产生，“鬼兵”就是在这个时间段诞生的新兴作战兵器——作为巨大的泛用式载人机甲，“鬼兵”为神光重科带来了无数收益。", hero_type=2, shadow="mon_archives_normal_6143.png", shadow_unlock="mon_archives_shadow_6143.png", dangerous=2, skill_list={421080,420086,4219,421901}, type=2, special="前排优先", speed="中", element={0}, weak_point={1,4}
},
	[155]={ model="6142", name="“捍卫者”", english="DAVIST", story="修格尔入侵战争时期发明的主战机甲，以皮实、易于生产和火力强大而广受好评，在战后百年的今天，依然在泰诺星的各种军队与民间武装中服役着，因为型号老旧，有时候被戏称为“大老爹”.", hero_type=2, shadow="mon_archives_normal_6142.png", shadow_unlock="mon_archives_shadow_6142.png", dangerous=2, skill_list={420080,420086,4225,422501}, type=2, special="后排优先", speed="中", element={0}, weak_point={1,4}
},
	[156]={ model="6144", name="“暴风旋涡”", english="DAVIST", story="大龙技研开发的小型安保机械武装，通常用于警戒和防卫工作。平时看似无害，但触发警报后攻击性十分强，在触发其防御模式后，只要靠近一定的范围就会被其攻击——据有幸品尝过其攻击的人说，被四五支电棒轮流电击的滋味绝对不好受。", hero_type=2, shadow="mon_archives_normal_6144.png", shadow_unlock="mon_archives_shadow_6144.png", dangerous=2, skill_list={421080,420086,4231,423101}, type=2, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[157]={ model="6139", name="“广目”", english="DAVIST", story="大龙技研开发出来的多用途空中无人机，机上搭载了三个万能导轨平台，可以根据需要安装不同的功能模组，最常见的模组是用于治安的泰瑟飞镖或麻醉弹。", hero_type=2, shadow="mon_archives_normal_6139.png", shadow_unlock="mon_archives_shadow_6139.png", dangerous=2, skill_list={420080,420086,4237,423701}, type=2, special="后排优先", speed="中", element={0}, weak_point={1,2}
},
	[201]={ model="6109", name="锤男", english="DAVIST", story="原是参与矿场开采的工人，在遭遇锚点降临之后，遭受虚蚀域污染导致改变了生体特征，已经丧失了自我意识。通过身上变异的皮肤以及生长的异变结构判断，该异变体遭受的感染程度：Ⅲ级。行为较为笨拙，但是抡起锤子砸人的能力值得肯定，如无一定的对抗能力遇见还是及时绕开比较好。", hero_type=2, shadow="mon_archives_normal_6109.png", shadow_unlock="mon_archives_shadow_6109.png", dangerous=2, skill_list={441080,440086,4401,440101}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[202]={ model="6110", name="切裂魔", english="DAVIST", story="调整者的成员。加入调整者的理由有很多，求温饱、求庇护，或只是单纯地想要宣泄心中的不满，“切裂魔”很明显属于后者。他们热衷鲜血，热衷虐杀，喜欢将猎杀的对象以残忍的方式肢解并展览——即便在调整者阵营内部，他们的行为也引起了众多成员的反感。", hero_type=2, shadow="mon_archives_normal_6110.png", shadow_unlock="mon_archives_shadow_6110.png", dangerous=2, skill_list={441080,440086,4407,440701}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[203]={ model="6121", name="镰爪", english="DAVIST", story="从身上遗留的制式服装穿戴来看，这类异变体可能原本是负责安保的人员，在被污染后已经丧失了自我意识，同时改变了生体特征，手臂处长出了巨大的刃状物。虽然外观看起来可能是行动很迅捷的类型，但移动速度其实和正常人差不多，比想象中的要缓慢。其手臂上的刃状物可以轻易造成巨大伤害，若是与其遭遇绝不能掉以轻心，建议直接逃走。", hero_type=2, shadow="mon_archives_normal_6121.png", shadow_unlock="mon_archives_shadow_6121.png", dangerous=3, skill_list={440080,440086,4413,441301}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[204]={ model="6117", name="第三只手", english="DAVIST", story="调整者的成员，在调整者内部级别应该不高，通常会在一些跑腿或者简单的作战里看到她们的身影。但切勿因为她们级别较低而轻视她们的战斗力，能以“第三只手”作为代号，足以说明她们受污染后增生出来的第三只手有多么刁钻、难搞。", hero_type=2, shadow="mon_archives_normal_6117.png", shadow_unlock="mon_archives_shadow_6117.png", dangerous=2, skill_list={441080,440086,4419,441901}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[205]={ model="6129", name="鬼面狮", english="DAVIST", story="被污染的四足野兽，已经看不见原本的样子，污染物黑泥覆盖全身让其拥有仿佛狮子的造型，原本头部的位置是一块像鬼脸的增殖体，拥有操控元素的能力，进食方式是通过仿佛鬓毛的触手吮吸。", hero_type=2, shadow="mon_archives_normal_6129.png", shadow_unlock="mon_archives_shadow_6129.png", dangerous=2, skill_list={441080,440086,4425,442501}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[206]={ model="6130_h", name="热浪", english="DAVIST", story="受到虚蚀域侵蚀后异变的人类，但已经失去了属于人类的基本生体特征。身体中间因高热引发的残缺，甚至会因高热引发视觉扭曲现象，但此处也是其所有能量的核心来源。——其身体为什么会发出高热仍有待研究，初步推测是由其异变时周围的环境影响所导致。", hero_type=2, shadow="mon_archives_normal_6130.png", shadow_unlock="mon_archives_shadow_6130.png", dangerous=2, skill_list={440080,440086,4431,443101}, type=3, special="后排优先", speed="中", element={0}, weak_point={3,4}
},
	[207]={ model="6125", name="炮手", english="DAVIST", story="由人类异变而来，双手异化成炮筒状的异变体，能从其中喷射出“能量”进行攻击，有多种射击模式。", hero_type=2, shadow="mon_archives_normal_6125.png", shadow_unlock="mon_archives_shadow_6125.png", dangerous=2, skill_list={440080,440086,4437,443701}, type=3, special="对位优先", speed="中", element={0}, weak_point={1,4}
},
	[208]={ model="6127", name="钻头车", english="DAVIST", story="上半身异化成钻头状的异变体，能够钻开坚硬的建筑与地表，破坏力极强。攻击方式是用钻头式的头部把目标“钻”死，因为攻击方式残忍且太过血腥，所以对于这种异变体的处理方式只有一种——直接歼灭。", hero_type=2, shadow="mon_archives_normal_6127.png", shadow_unlock="mon_archives_shadow_6127.png", dangerous=2, skill_list={441080,440086,4443,444301}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,4}
},
	[209]={ model="6150_b", name="鬣石蜥", english="DAVIST", story="泰诺星野外的某种蜥蜴类生物在被虚粒子污染后的变异形态，大量的异化结晶体遍布于躯体上，能以极快的速度在地下挖掘前进，虽然生为异变体，但性情却意外地相当胆小，在自知不敌的情况下会迅速溜之大吉。", hero_type=2, shadow="mon_archives_normal_6150.png", shadow_unlock="mon_archives_shadow_6150.png", dangerous=2, skill_list={441080,440086,4449,444901}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[210]={ model="6148", name="异变矿工", english="DAVIST", story="曾在源晶矿场中工作，但被突如其来的虚粒子风暴污染，变成了异变体的可怜人。挥舞着曾是自己最得心应手的工具，但现在已变成凶器的矿锄四处活动，无差别地对一切活物展开攻击。", hero_type=2, shadow="mon_archives_normal_6148.png", shadow_unlock="mon_archives_shadow_6148.png", dangerous=2, skill_list={441080,440086,4455,445501}, type=3, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[211]={ model="6147", name="异变机械师", english="DAVIST", story="曾在源晶矿场中工作，但被突如其来的虚粒子风暴污染，变成了异变体的可怜人。在变异前担任着机械维修师的工作，身上总是带着一大堆工具，在变成怪物后，这些工具也“长”在了它的身上。", hero_type=2, shadow="mon_archives_normal_6147.png", shadow_unlock="mon_archives_shadow_6147.png", dangerous=2, skill_list={446180,440086,4461,446101}, type=3, special="对位优先", speed="中", element={0}, weak_point={1,3}
},
	[212]={ model="6159", name="祭司", english="DAVIST", story="维拉提亚古代的祭司，掌握着古老的星辰术法，几乎没有弱点，无论过去还是现在，与他们扯上关系都不是一件好事。", hero_type=2, shadow="mon_archives_normal_6159.png", shadow_unlock="mon_archives_shadow_6159.png", dangerous=2, skill_list={446580,440086,4465,446501}, type=3, special="对位优先", speed="中", element={0}, weak_point={2,5}
},
	[213]={ model="6160", name="污化骑士", english="DAVIST", story="维拉提亚的骑士，掌握着强大的枪术，几乎没有弱点，无论过去还是现在被污化的形态，与他们扯上关系都不是一件好事。", hero_type=2, shadow="mon_archives_normal_6160.png", shadow_unlock="mon_archives_shadow_6160.png", dangerous=2, skill_list={446780,440086,4467,446701}, type=3, special="对位优先", speed="中", element={0}, weak_point={1,2}
},
	[251]={ model="6102", name="腊肠犬", english="DAVIST", story="名为“修格尔”的外星生物中的一种，外形长得神似犬类，身躯外表长满了金属和看上去像是石块的未知物质。这类外星生物通常以群聚的方式出现，它们拥有和犬类相同的行走方式，其爪子形如钢刃般，能以极其诡异的方式进行移动，且具有强大的杀伤力。", hero_type=2, shadow="mon_archives_normal_6102.png", shadow_unlock="mon_archives_shadow_6102.png", dangerous=2, skill_list={460080,460086,4601,460101}, type=4, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[252]={ model="6112", name="侍女", english="DAVIST", story="仅看背影的话绝对会被当做美丽知性的普通女性，但其实是凶残的外星生物“修格尔”中的一种。依靠不明能量与操控身边的“双剑”进行攻击，轻盈灵巧的身段让她们看上去相当……漂亮。即使在战斗中也会时刻保持优雅，或许是因为本能吧。", hero_type=2, shadow="mon_archives_normal_6112.png", shadow_unlock="mon_archives_shadow_6112.png", dangerous=2, skill_list={460080,460086,4607,460701}, type=4, special="对位优先", speed="中", element={0}, weak_point={1,3}
},
	[253]={ model="6118", name="蛇亚龙", english="DAVIST", story="名为“修格尔”的外星生物中的一种，外形与只出现在传说和故事中的“飞蛇”极为类似。似乎有相当高的智慧，并不会莽撞发起攻击，而是找准时机一击致命，十分符合刻板印象中对于“蛇”和“龙”的印象。", hero_type=2, shadow="mon_archives_normal_6118.png", shadow_unlock="mon_archives_shadow_6118.png", dangerous=2, skill_list={460080,460086,4613,461301}, type=4, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[254]={ model="6123", name="猎狼", english="DAVIST", story="名为“修格尔”的外星生物中的一种，形似泰诺星上的犬类，它们拥有相对短小的四肢与巨大的“头颅”，且头部周围被很多繁杂的结构层层包围着，根据和它们战斗过的情报说，这里似乎是它们的“死穴”。", hero_type=2, shadow="mon_archives_normal_6123.png", shadow_unlock="mon_archives_shadow_6123.png", dangerous=2, skill_list={460080,460086,4619,461901}, type=4, special="前排优先", speed="中", element={0}, weak_point={1,5}
},
	[255]={ model="6124", name="山岭兽", english="DAVIST", story="名为“修格尔”的外星生物中的一种，背甲以堆叠的晶石块分布为主，在周围有个别碎晶石以浮游的状态存在，能够操控重力，所过之处经常伴随着地面塌陷和建筑物坍塌。根据作战情报，没有坚甲覆盖的腹部是其弱点，作战时可优先攻击。", hero_type=2, shadow="mon_archives_normal_6124.png", shadow_unlock="mon_archives_shadow_6124.png", dangerous=2, skill_list={460080,462586,4625,462501}, type=4, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[256]={ model="6136", name="轮天使", english="DAVIST", story="外观类似于泰诺星古代传说生物“天使”的修格尔，身边缠绕着异形火焰，背后有三个类似于“车轮”形状的物体在一刻不停地旋转，似乎拥有一定的知能，能够发出一些类似“语言”的声音，但没有人能理解它在说什么.", hero_type=2, shadow="mon_archives_normal_6136.png", shadow_unlock="mon_archives_shadow_6136.png", dangerous=2, skill_list={460080,460086,4631,463101}, type=4, special="前排优先", speed="中", element={0}, weak_point={1,2}
},
	[257]={ model="6138", name="星之母子", english="DAVIST", story="由两个子个体组成的修格尔，其中一名子个体个头较大，外观呈现女性特征，另一名子个体个头较小，外观呈现小孩特征，两个子个体的攻击形式与其说是在发起攻击，不如说更像是在“母子嬉戏“更为合适.", hero_type=2, shadow="mon_archives_normal_6138.png", shadow_unlock="mon_archives_shadow_6138.png", dangerous=2, skill_list={460080,460086,4637,463701}, type=4, special="对位优先", speed="中", element={0}, weak_point={1,2}
},
	[257]={ model="6157", name="斧鹿头", english="DAVIST", story="被污染的部落战士，已经看不出原本人类的形态，或许过去他们也曾得到过“鹿神”的力量，但现在只是“异变体”而已，如果你在荒野中遇到游荡的他们，最好避开。", hero_type=2, shadow="mon_archives_normal_6157.png", shadow_unlock="mon_archives_shadow_6157.png", dangerous=2, skill_list={460080,460086,4643,464301}, type=4, special="前排优先", speed="中", element={0}, weak_point={1,4}
},
	[502]={ model="6107", name="犬猩", english="DAVIST", story="名为“修格尔”的外星生物中的一种，很难形容它们更接近犬类，还是灵长类。体格硕大且性情狂暴，一拳超过500公斤的攻击力让它们成为非常难应付的敌人之一，但所幸的是犬猩的移动速度不快，因此遭遇后如果能及时远离，或许可以逃过一劫。", hero_type=6, shadow="mon_archives_normal_6107.png", shadow_unlock="mon_archives_shadow_6107.png", dangerous=3, skill_list={501180,501190,501186,5011,501101,501102,501104}, type=4, special="前排优先", speed="慢", element={0}, weak_point={1,2}
},
	[501]={ model="6301", name="铁棘刺", english="DAVIST", story="调整者教团成员，但地位比较低下，经常被安排在一些先遣的破坏任务中。因遭到污染侵蚀导致身体各个部位出现了不同程度的异变，包括并不限于皮肤异变、体表结构异化——手臂长出类似棘刺状的部位。该异变个体能保有人类意识，但精神出现了严重的污染，长期陷入疯狂、病态化，并具有强烈的攻击性与破坏性。", hero_type=6, shadow="mon_archives_normal_6301.png", shadow_unlock="mon_archives_shadow_6301.png", dangerous=3, skill_list={500180,500190,500186,5001,500101,500102,500104}, type=3, special="前排优先", speed="慢", element={0}, weak_point={2,3}
},
	[503]={ model="6309", name="蕾娜", english="DAVIST", story="原启幕集团的高级研究员，也是黎苏根大学的生物学教授，因为被注射了某种药剂，成为了被称为“怨念之花”的怪物，枯败的身躯给人一种残缺的美，从残留的人类特征看，似乎还保持着一些人类的理性和理智，但千万不要轻易靠近她——如果你不想被她的爪子撕碎的话。", hero_type=6, shadow="mon_archives_normal_6309.png", shadow_unlock="mon_archives_shadow_6309.png", dangerous=3, skill_list={502180,502190,502186,5021,502101,502102,502104}, type=3, special="后排优先", speed="慢", element={0}, weak_point={1,2}
},
	[504]={ model="6310", name="芙兰朵", english="DAVIST", story="神秘组织“调整者教团”的干部，代号“诡翼”，在黎苏根内作为幕后黑手策划了不少恶性事件，千万不要被其甜美魅惑的外表所欺骗。", hero_type=6, shadow="mon_archives_normal_6310.png", shadow_unlock="mon_archives_shadow_6310.png", dangerous=3, skill_list={503180,503190,503186,5031,503101,503102,503104}, type=3, special="对位优先", speed="慢", element={0}, weak_point={1,2}
},
	[505]={ model="6305", name="迪恩", english="DAVIST", story="迪恩·兰斯洛特，曾是约瑟伯格知名世家兰斯洛特一族的本代当家人，但在某个事故后不幸身故。迪恩再次出现在世界上的时候，他已经成为了调整者教团的“铁骑士”，为了教团清除挡在前进路上的一切障碍——", hero_type=6, shadow="mon_archives_normal_6305.png", shadow_unlock="mon_archives_shadow_6305.png", dangerous=3, skill_list={504180,504190,504186,5041,504101,504102,504104}, type=3, special="前排优先", speed="慢", element={0}, weak_point={2,3}
},
	[509]={ model="6303", name="斯科皮欧", english="DAVIST", story="一切都成谜的修格尔个体，与常见的修格尔不同，该个体从观察上来说不仅拥有智慧，还可以对周边的空间进行一定程度的干涉。根据莱斯坦斯安全局的说法，这个个体很可能是修格尔中的高阶物种，甚至有可能是领袖级别，但具体的情报仍未完全解析。", hero_type=6, shadow="mon_archives_normal_6303.png", shadow_unlock="mon_archives_shadow_6303.png", dangerous=3, skill_list={506180,506190,506186,5061,506101,506102,506104}, type=4, special="前排优先", speed="慢", element={0}, weak_point={1,5}
},
	[510]={ model="6302", name="剑天使", english="DAVIST", story="外形与古代传说中的天使有些许相似的修格尔，挥动着与身体构成材质一样的“大剑”进行攻击。似乎具有智能，能从其“头部”发出不明所以的具有韵律感的声音，有好事者说这是修格尔的语言，但从来没有人能够证实这一点。", hero_type=6, shadow="mon_archives_normal_6302.png", shadow_unlock="mon_archives_shadow_6302.png", dangerous=3, skill_list={507180,507190,507186,5071,507101,507102,507104}, type=4, special="前排优先", speed="慢", element={0}, weak_point={1,2}
},
	[511]={ model="6304", name="危烈兽", english="DAVIST", story="名为“修格尔”的外星生物中的一种，外形与泰诺星上的老虎有些相似，没有明显的五官，但长了一张能吸收周围能量的“嘴巴”，背后的四根“尾巴”能发射能量与热线，破坏力极其强大。在受到正面攻击时会产生防护力场，如需正面突破，需要比它强大数倍的力量，是已知修格尔中比较棘手的存在。", hero_type=6, shadow="mon_archives_normal_6304.png", shadow_unlock="mon_archives_shadow_6304.png", dangerous=3, skill_list={508180,508190,508186,5081,508101,508102,508104}, type=4, special="前排优先", speed="慢", element={0}, weak_point={1,3}
},
	[508]={ model="6311", name="明", english="DAVIST", story="反空天星链组织“星解联”在黎苏根地区的负责人，性格风风火火，一头红发异常显眼，虽然年纪尚轻，但都被手下称为“大姐头”。", hero_type=6, shadow="mon_archives_normal_6311.png", shadow_unlock="mon_archives_shadow_6311.png", dangerous=3, skill_list={505180,505190,505186,5051,505101,505102,505104}, type=1, special="对位优先", speed="慢", element={0}, weak_point={1,3}
},
	[512]={ model="6312", name="卢卡斯", english="DAVIST", story="克罗瓦德外交大臣雷奥妮·黑斯廷斯曾经最信任的副官，但现在已经变成了一心复仇的恐怖怪物。", hero_type=6, shadow="mon_archives_normal_6312.png", shadow_unlock="mon_archives_shadow_6312.png", dangerous=3, skill_list={509180,509190,509186,5091,509101,509102,509104}, type=3, special="前排优先", speed="慢", element={0}, weak_point={2,3}
},
	[513]={ model="6313", name="鹿神", english="DAVIST", story="过去曾是斯利普尼尔部落的“神”，巨大的鹿头呈现庄严的气质和恐怖的威压，被部落的人们世代侍奉，但现在只是困匿在荒野之中的亡灵罢了。", hero_type=6, shadow="mon_archives_normal_6313.png", shadow_unlock="mon_archives_shadow_6313.png", dangerous=3, skill_list={510180,510190,510186,5101,510101,510102,510104}, type=4, special="对位优先", speed="慢", element={0}, weak_point={3,4}
},
	[514]={ model="6314", name="戴妮卡", english="DAVIST", story="过去曾有着“维拉提亚天使”之称的护星骑士团团长，现在被污染成异变体，辉煌的过往已经变成了深埋地底的秘密，唯有死亡能得到解脱。", hero_type=6, shadow="mon_archives_normal_6314.png", shadow_unlock="mon_archives_shadow_6314.png", dangerous=3, skill_list={511180,511190,511186,5111,511101,511102,511104}, type=3, special="前排优先", speed="慢", element={0}, weak_point={4,5}
},
	[515]={ model="6315", name="“容器”的碎片", english="DAVIST", story="过去曾有着“维拉提亚天使”之称的护星骑士团团长，现在被污染成异变体，辉煌的过往已经变成了深埋地底的秘密，唯有死亡能得到解脱。", hero_type=6, shadow="mon_archives_normal_6315.png", shadow_unlock="mon_archives_shadow_6315.png", dangerous=3, skill_list={511280,511290,511286,5112,511201,511202,511204}, type=3, special="对位优先", speed="慢", element={0}, weak_point={2,5}
},
	[516]={ model="6316_b", name="艾许", english="DAVIST", story="本是由福登城科学家艾尔莎·图兰灵雅研制的人工智能，虚拟世界“伊甸园”的管理者，后因错误地理解艾尔莎的愿望而选择和残破的第十二使徒封禁物结合，生出了自我意识成为人造使徒级修格尔。试图用和锚点空间结合的“伊甸园”来吸收福登城所有人类的意识，并自诩为乐土世界的新神明。", hero_type=6, shadow="mon_archives_normal_6316_b.png", shadow_unlock="mon_archives_shadow_6316_b.png", dangerous=3, skill_list={516180,516190,516186,5161,516101,516102,516104}, type=4, special="对位优先", speed="慢", element={0}, weak_point={1,3}
}
}

return manual_mon_data