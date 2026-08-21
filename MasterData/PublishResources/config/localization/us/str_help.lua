local config = {
  str_help_maze_explain = "Secret Territory Exploration Info",
  str_help_maze_title1 = "Secret Territory",
  str_help_maze_title2 = "Exploration Cost",
  str_help_maze_title3 = "Aurorian Attributes",
  str_help_maze_title4 = "Secret Territory Characteristics",
  str_help_maze_title5 = "Failed to Inherit",
  str_help_maze_title6 = "Secret Territory Exploration Reset",
  str_help_maze_title7 = "Secret Store",
  str_help_maze_title8 = "Auto Secret Territory Exploration",
  str_help_maze_details1 = "There are several paths on each level of Secret Territory. Choose any of the paths to reach the Origin Room and defeat the boss to proceed to the next level.",
  str_help_maze_details2 = "Secret Territory battles need to consume MS, a fixed resource. You will fail the challenge if you have insufficient MS. MS can be recovered through time and the Lumina Spring. Research within the Colossus can increase MS recovery speed.",
  str_help_maze_details3 = "All Aurorians in the Secret Territory are granted fixed attributes. Only skills and enhanced effects gained from Ascension and Breakthrough will take effect. Some Relics will also be able to improve Aurorian attributes.",
  str_help_maze_details4 = "In Secret Territory, Aurorians will share the damage they take equally, and those with 0 HP will not be able to fight again. Damage taken by an Aurorian is recorded after the battle, and Aurorians can recover through the Lumina Spring and some Relics.",
  str_help_maze_details5 = "The HP of the Eclipsites in a stage where the battle is lost will be recorded, and you can change your line-up and continue your battle. However, if you voluntarily exit the stage, everything will be reset back to the original state.",
  str_help_maze_details6 = "The Secret Territory goes through 1 cycle every 14 days. Once the Secret Territory Exploration time is over, the exploration progress is reset, and the challenge has to be attempted from the start again. After reset, Relics obtained will be cleared.",
  str_help_maze_details7 = "Text Fragments can be obtained from Challenge Stages. These Text Fragments can then be used to purchase various items and resources in the Secret Store.",
  str_help_maze_details8 = "After you clear the Secret Territory Level 5 boss room, you'll unlock the automatic exploration function. All battle rooms can be explored automatically, apart from boss stages.",
  str_help_uispiritdetailgroupcontroller_explain = "Aurorian Info",
  str_help_uispiritdetailgroupcontroller_title1 = "Basic Attribute Info",
  str_help_uispiritdetailgroupcontroller_title2 = "Attribute Info",
  str_help_uispiritdetailgroupcontroller_title3 = "Skill Info",
  str_help_uispiritdetailgroupcontroller_title4 = "Basic Level Info",
  str_help_uispiritdetailgroupcontroller_title5 = "Aurorian Breakthrough Info",
  str_help_uispiritdetailgroupcontroller_title6 = "Special Button",
  str_help_uispiritdetailgroupcontroller_title7 = "Aurorian Class",
  str_help_uispiritdetailgroupcontroller_details1 = [[
1. You can view an Aurorian's Attack, Defense, HP, and other attributes.
2. In battles, your team's HP is the sum of all your Aurorians' HP, and Defense is the sum of all your Aurorians' Defense. Each Aurorian deals damage according to their ATK.]],
  str_help_uispiritdetailgroupcontroller_details2 = [[
1. During battles, Aurorians will appear and attack by moving on tiles corresponding to their elements.
2. There is a Counter Circle among the elements: Water -> Fire -> Forest-> Thunder -> Water.
3. High-rating Aurorians can ascend to gain secondary elements that deal 35% of their attack damage.]],
  str_help_uispiritdetailgroupcontroller_details3 = [[
1. Tap to bring up the Skill Screen, which displays the skills of the selected Aurorian.
2. Each Aurorian has Active Skills and Chain Combos. Certain highly-rated Aurorians can unlock Equipment Skills after Ascension or Breakthrough.]],
  str_help_uispiritdetailgroupcontroller_details4 = [[
1. Upgrading Aurorians can increase their levels.
2. Once an Aurorian reaches max level, they can Ascend.
3. Once an Aurorian is Ascended, their max level will increase, and the Aurorian will reach Ascension I, with no reduction to their attributes.]],
  str_help_uispiritdetailgroupcontroller_details5 = [[
1. Aurorian Breakthrough stages are related to the Aurorian's Magnitude.
2. The higher an Aurorian's Magnitude, the more Breakthrough stages available for an Aurorian.
3. After Breakthrough, the Magnitude color will change according to the corresponding stage.]],
  str_help_uispiritdetailgroupcontroller_details6 = [[
1. Affinity is the degree of affinity between Aurorians and the main character.
2. You can view Aurorian profiles and dialogs from their Files.]],
  str_help_uispiritdetailgroupcontroller_details7 = [[
1. Converters are experts who control the Alchemy Board. They can change the elements of the tiles on the Alchemy Board or change their own positions. They are indispensable characters for executing battle strategies.
2. Detonators are powerful attackers who can attack multiple targets on the board with their wide-area attacks and deal massive damage to large enemies.
3. Snipers are characters who can kill individual enemies with precision. They have high damage output, and are suitable for attacking small enemies.
4. Supporters are characters that provide continuous healing as well as various buffs; with their special abilities, they can enhance the team's fighting abilities.]],
  str_help_uigradeInterfacecontroller_explain = "Aurorian Ascension Info",
  str_help_uigradeInterfacecontroller_title1 = "Ascension Condition Info",
  str_help_uigradeInterfacecontroller_title2 = "Ascension Attribute Info",
  str_help_uigradeInterfacecontroller_title3 = "Level-up Info",
  str_help_uigradeInterfacecontroller_details1 = [[
1. Aurorians must reach the max level in current phase to ascend.
2. Ascension costs Nightium and materials.
3. Clear Main Quests for materials to ascend.]],
  str_help_uigradeInterfacecontroller_details2 = "Some Aurorians with 5 stars and above can awaken their secondary elements after reaching Ascension III.",
  str_help_uigradeInterfacecontroller_details3 = "Tap on the Level-up Info button to open the Level-up Info screen, and view the level-up info of Aurorians.",
  str_help_uibreakcontroller_explain = "Aurorian Breakthrough Info",
  str_help_uibreakcontroller_title1 = "Breakthrough Condition Info",
  str_help_uibreakcontroller_title2 = "Magnitude Change Info",
  str_help_uibreakcontroller_title3 = "Star Path Info",
  str_help_uibreakcontroller_title4 = "Level-up Info",
  str_help_uibreakcontroller_title5 = "Solamber Redeem Description",
  str_help_uibreakcontroller_details1 = [[
1. Duplicate Aurorians automatically convert into Aurorian-specific Solamber and Heartstones.
2. Aurorian Solamber enables breakthroughs.]],
  str_help_uibreakcontroller_details2 = [[
1. An Aurorian's Magnitude is the total number of Breakthrough stages available.
2. Every breakthrough of a stage will see a change in corresponding ratings.]],
  str_help_uibreakcontroller_details3 = [[
1. Both sides of the cross-shaped star will display whether the stage is improving a skill or an attribute.
2. Tap on the cross-shaped stars to view detailed info on the improved content in that stage.]],
  str_help_uibreakcontroller_details4 = [[
1. When leveling up attributes, attributes gained after leveling up will be displayed.
2. When leveling up skills, level-up info will be displayed.]],
  str_help_uibreakcontroller_details5 = [[
1. Use a specific amount of Solamber Crystals to redeem 5-Star Solamber; Solamber Druse to redeem 6-Star Solamber (excluding exclusive Aurorian Solamber); Solamber Seals to redeem exclusive Aurorian Solamber.
2. This does not apply to the following Aurorians: Tohru, Kanna, Elma, Lucoa, Joker, Queen, Fox, Violet, Mona.]],
  str_help_uiaircraftcontorller_explain = "Colossus Info",
  str_help_uiaircraftcontorller_title1 = "Colossus Lumina Cost Info:",
  str_help_uiaircraftcontorller_title2 = "Colossus Lumina Upgrade Info:",
  str_help_uiaircraftcontorller_title3 = "Colossus Resource Info:",
  str_help_uiaircraftcontorller_title4 = "Colossus Deployment Info:",
  str_help_uiaircraftcontorller_title5 = "Colossus Interaction Info:",
  str_help_uiaircraftcontorller_details1 = [[
1. All rooms within the Colossus require Lumina to function.
2. Room unlock access and upgrade access require more Lumina.]],
  str_help_uiaircraftcontorller_details2 = "Unlocking and upgrading more Lumina Grids will increase the Lumina cap.",
  str_help_uiaircraftcontorller_details3 = "Some rooms in the Colossus can yield in-game resources, which need to be claimed manually.",
  str_help_uiaircraftcontorller_details4 = [[
1. All Aurorians have Work Skills, and when deployed to a corresponding room, they will be able to enhance the room's feature to a certain extent.
2. Once an Aurorian meets certain conditions, new Work Skills or an enhancement of the current Work Skill will be unlocked.]],
  str_help_uiaircraftcontorller_details5 = [[
1. There are four recreation rooms on the Colossus for the leisure and relaxation. Aurorians can use any one of these four rooms doing whatever they like.
2. Tap an Aurorian to interact with them.]],
  str_help_uiaircraftcentralroom_explain = "Colossus Bridge Info",
  str_help_uiaircraftcentralroom_title1 = "Bridge Info:",
  str_help_uiaircraftcentralroom_details1 = [[
1. Increasing the Bridge Level will increase the Max. Colossus Mood.
2. Deploying Aurorians can increase the Mood points generated by the furniture.]],
  str_help_uiaircraftpowerroom_explain = "Colossus Lumina Grid Info",
  str_help_uiaircraftpowerroom_title1 = "Lumina Grid Info:",
  str_help_uiaircraftpowerroom_details1 = [[
1. Lumina Grid provides Lumina for rooms, and upgrading the room increases the Lumina.
2. Lumina Grid can increase the hourly recovery speed of Fireflies.
3. Upgrading the room and deploying Aurorians can additionally increase the recovery speed of Fireflies.]],
  str_help_uiaircraftmazeroom_explain = "Colossus Exploration Office Info",
  str_help_uiaircraftmazeroom_title1 = "Exploration Office Info:",
  str_help_uiaircraftmazeroom_title2 = "Increasing Secret Territory Output:",
  str_help_uiaircraftmazeroom_details1 = [[
1. Can recover and store MS.
2. The stored MS reset timer will be synchronized with the Secret Territory's reset time.
3. Deploy Aurorians to speed up MS recovery.]],
  str_help_uiaircraftmazeroom_details2 = [[
1. Exploration can increase the number of Text Fragments yielded from the Secret Territory.
2. Upgrading this room unlocks more Secret Territory stages, which can be cleared for better rewards.]],
  str_help_uiaircraftresourceroom_explain = "Colossus Resource Station Info",
  str_help_uiaircraftresourceroom_title1 = "Resource Station Info:",
  str_help_uiaircraftresourceroom_title2 = "Carrier Recovery Info:",
  str_help_uiaircraftresourceroom_details1 = [[
1. Unlocks more Resource Raids.
2. Recover Carriers.
3. Store Carriers.
4. Upgrading the room or deploying Aurorians can increase the recovery speed of Carriers.]],
  str_help_uiaircraftresourceroom_details2 = "When Carrier reaches the max storage limit, it will not recover any more",
  str_help_uiaircraftprismroom_explain = "Colossus Prism Pillar Info",
  str_help_uiaircraftprismroom_title1 = "Prism Pillar Info:",
  str_help_uiaircraftprismroom_details1 = [[
1. The Prism Pillar automatically generates Prism.
2. The Prism Pillar can also store Prism.
3. High-level Prism Pillars can increase your maximum Prism capacity.
4. Upgrading this room and deploying Aurorians can increase Prism generation speed.]],
  str_help_uiaircrafttowerroom_explain = "Colossus Starlight Chamber Info:",
  str_help_uiaircrafttowerroom_title1 = "Starlight Chamber Info:",
  str_help_uiaircrafttowerroom_details1 = [[
1. Can produce and store Heartstones.
2. High-level Starlight Chambers have a chance to produce additional Star Gems.
3. Upgrade this room or deploy Aurorians to speed up Heartstone production.]],
  str_help_uiaircraftsmeltroom_explain = "Colossus Workshop Info",
  str_help_uiaircraftsmeltroom_title1 = "Smelting Info:",
  str_help_uiaircraftsmeltroom_title2 = "Workshop Info:",
  str_help_uiaircraftsmeltroom_details1 = [[
1. Atomic Reagents can be used to convert same level materials or to fuse advanced items via smelting.
2. Colossus Patches can be dismantled to craft Fireflies.
3. The surplus Solamber of an Aurorian at max Breakthrough can be dismantled here.]],
  str_help_uiaircraftsmeltroom_details2 = [[
1. You can craft and store atomic reagents here.
2. Upgrading the Workshop will increase its atomic reagent storage and unlock more advanced materials.
3. Deploying Aurorians can reduce the atomic reagents cost.]],
  str_help_dispatch_title1 = "Dispatch Quests",
  str_help_dispatch_details1 = "1. The Dispatch Office receives a number of quests every day. Navigator can obtain rewards by dispatching a squad of Aurorians to complete these quests.",
  str_help_dispatch_title2 = "Dispatch Info",
  str_help_dispatch_details2 = [[
1. Dispatching a squad of Aurorians will consume dispatch attempts, which you regain over time.
2. Deploying Aurorians can speed up the rate at which you regain dispatch attempts.
3. Upgrade the room to deploy even more Aurorians, or to increase the rating of Dispatch Quests.]],
  str_help_uidiscovery_explain = "Exploration Map Info",
  str_help_uidiscovery_title1 = "Main Story Battle",
  str_help_uidiscovery_title2 = "Exploration Rewards",
  str_help_uidiscovery_title3 = "Battle Rating",
  str_help_uidiscovery_title4 = "Enemy Intel",
  str_help_uidiscovery_details1 = "Direct Aurorians to explore the world by completing Main Story Battles and get to know more Aurorians while exploring the world.",
  str_help_uidiscovery_details2 = "When you complete an Exploration, you can obtain a variety of supplies and rewards. The special department will give the commander many types of rewards based on the battle ratings, including 3-Star Rewards, 1st Clear Rewards, and Normal Rewards.",
  str_help_uidiscovery_details3 = "Every stage has a corresponding battle objective, and achieving three battle objectives at the same time will earn you the highest battle rating—a 3-Star.",
  str_help_uidiscovery_details4 = "From the stage screen, you can view enemy intel. You can preview the enemy intel in this stage and find out the elements and appearance of the monsters you will face.",
  str_help_uidrawcardcontroller_explain = "Recruitment Info",
  str_help_uidrawcardcontroller_title1 = "Exclusive Beginner's Recruitment Info:",
  str_help_uidrawcardcontroller_title2 = "Limited-Time Recruitment Info:",
  str_help_uidrawcardcontroller_title3 = "Mainstay Recruitment Info:",
  str_help_uidrawcardcontroller_title4 = "Aurorian Preview Info:",
  str_help_uidrawcardcontroller_title5 = "Rotating Recruitment Info:",
  str_help_uidrawcardcontroller_details1 = "Only Lumamber can be used to recruit from the Exclusive Beginner's Recruitment event.",
  str_help_uidrawcardcontroller_details2 = [[
1. Limited-time recruitments will cost Special Star Flares.
2. If you don't have enough Special Star Flares, you can spend Lumamber to get more.]],
  str_help_uidrawcardcontroller_details3 = [[
1. Mainstay recruitment require Star Flares.
2. If you don't have enough Star Flares, you can spend Lumamber to get more.]],
  str_help_uidrawcardcontroller_details4 = "You can preview the attributes and skills of Aurorians that have reached their final Ascension stage by tapping on the Aurorian's avatar or the information bar displaying their name.",
  str_help_uidrawcardcontroller_details5 = [[
1.Rotating Recruitment requires Star Flares.
2.If you don't have enough Star Flares, you can spend Lumamber to get more.]],
  str_help_helppet_title1 = "Support Guide Info",
  str_help_helppet_details1 = [[
1. You can configure 1 Support Aurorian for each element, up to 4 Aurorians.
2. Support Aurorians can be temporarily recruited by your friends. This won't stop you from deploying them in battles of your own.]],
  str_help_helppet_title2 = "Support Aurorians",
  str_help_helppet_details2 = [[
1. You can temporarily recruit a friend's Support Aurorian or a Support Aurorian randomly assigned by the game to help you in battles.
2. After Support Aurorians are deployed to your formation, they can fight for you like your own Aurorians.]],
  str_help_helppet_title3 = "Support Aurorian Restrictions",
  str_help_helppet_details3 = [[
1. Support Aurorians may be deployed only once per day, but there is no limit on how many different Aurorians you can deploy.
2. Attempts are used up only when a stage is cleared. Losses or exits do not count as attempts.]],
  str_help_petequip_title1 = "Aurorian Equipment Info",
  str_help_petequip_details1 = [[
1. When an Aurorian reaches Ascension I, Aurorian equipment is unlocked.
2. Aurorian equipment can increase an Aurorian's ATK, DEF, HP, and element counter damage.
3. After unlocking equipment, Aurorians will gain equipment skills. Upgrading equipment will improve the effect of equipment skills.]],
  str_help_petequip_title2 = "Element Counter Damage",
  str_help_petequip_details2 = [[
1. An Aurorian's base element counter damage is 120%, meaning it will deal 120% damage to enemies with counter elements. Upgrading equipment will increase an Aurorian's main element counter damage.
2. When an Aurorian's elements are countered, damage dealt will remain at 80%.]],
  str_help_petequip_title3 = "Equipment Refinement Info",
  str_help_petequip_details3 = [[
1.Some Aurorians' equipment can be further upgraded. This is known as Equipment Refinement.
2.Equipment Refinement is unlocked for these Aurorians when they reach Ascension III, Lv.80, and Equipment Lv.10.
3.Upgrading the Equipment Refinement level increases the Aurorian's ATK, DEF, HP, and various battle skill effects.]],
  str_help_talepettask_title1 = "Obtaining Legendary Aurorians",
  str_help_talepettask_details1 = [[
1. Choose one of the Legendary Aurorians to recruit. A series of recruiting quests for the selected Aurorian will be shown. After completing all of the quests, you can obtain the Aurorian.
2. When you obtain your Legendary Aurorian, it will automatically be upgraded to Ascension III.]],
  str_help_talepettask_title2 = "Recruiting Legendary Aurorians",
  str_help_talepettask_details2 = [[
1. Only one Legendary Aurorian can be summoned at the same time, and progress will only be counted toward recruiting the selected Legendary Aurorian. The other Aurorians' recruiting quest progress will be locked when recruiting a specific Legendary Aurorian.
2. Switching the Legendary Aurorian being recruited will clear the quest progress of their currently-highest quest stage, but completed quest stages will not be cleared. Pay attention when switching!]],
  str_help_talepetlevel_title1 = "Elysium",
  str_help_talepetlevel_details1 = "1. In Elysium battles, Aurorians will be enhanced with Star Power, granting them more power than usual.",
  str_help_talepetlevel_title2 = "Apex",
  str_help_talepetlevel_details2 = "1. Obtain Regal, Frostfire, Mythos, and Requiem to unlock the Memoria, Apex.",
  str_help_eve_title1 = "The Event Has Started!",
  str_help_eve_title2 = "Event Rewards",
  str_help_eve_details1 = "Event stages are divided into two stages, which will unlock at the corresponding times.",
  str_help_eve_details2 = [[
You can earn Wrench Nut Emblems from event stages, which can be exchanged for items in the Highway Store.
After the event ends, surplus Wrench Nut Emblems will be converted into Nightium according to the store's exchange ratio.
You'll receive rewards according to your accumulated event quest completion progress.]],
  str_help_sakura_title1 = "Daruma Smash Info",
  str_help_sakura_details1 = [[
1. Five prize pools are available for the event with up to 100 draws from each.
2. Spend Cloud Blossom Petals to draw prizes.
3. You may unlock the next pool by drawing the current pool's grand prize but are still eligible to draw from the previous prize pools.
4. After Daruma Smash is over, all surplus Cloud Blossom Petals are converted into Nightium at the ratio of 1 to 30.]],
  str_help_talepettask_title3 = "Legendary Aurorian Breakthrough",
  str_help_talepettask_details3 = [[
1. Legendary Aurorian breakthroughs require Heartstones and Star Crests. Breakthroughs can be divided into six stages. Number of Star Crests consumed per Stage are 1, 1, 2, 1, 2, and 3.
2. You can get Star Crests from the Star Store and future events.]],
  str_help_battlepass_tittle1 = "Special Event Book",
  str_help_battlepass_tittle2 = "Level and Time",
  str_help_battlepass_tittle3 = "Elite Edition",
  str_help_battlepass_details1 = "A special event book containing a variety of quests and rewards. You can earn Contribution points by completing the quests in this event book, increasing the book's level, and obtaining rewards by accumulating Contribution points.",
  str_help_battlepass_details2 = [[
1. The Special Event Book has a level limit. Once the maximum level is reached, the book's level cannot be raised any further.
2. The Special Event Book also has a time limit. When the time ends, this Special Event Book will be closed.]],
  str_help_battlepass_details3 = [[
1. The basic Special Event Book is unlocked by default, and you can claim its rewards based on its level.
2. Purchase the Elite Edition or Deluxe Edition of the Special Event Book, you can claim the elite reward for the corresponding levels.]],
  str_help_summerminigame_tittle = "Event Info",
  str_help_summerminigame_tittle1 = "Make Iced Drink",
  str_help_summerminigame_tittle2 = "Customer Mood",
  str_help_summerminigame_tittle3 = "Rating Bonus",
  str_help_summerminigame_tittle4 = "Chill Thrill",
  str_help_summerminigame_details1 = [[
1. The iced drink stand is now in business! The more orders you complete within the time limit, the more rating points you'll earn.
2. You'll need to complete 4 steps to make a cup of iced drink: select the size, ingredients, drinks, and serve to the customer. The order in which you select the ingredients and drinks doesn't matter.]],
  str_help_summerminigame_details2 = [[
Each customer has a certain waiting time. As the waiting time becomes longer, their mood will drop from Happy, to Impatient, and then to Angry.
The better the customer's mood, the more rating points you'll receive for completing their order.]],
  str_help_summerminigame_details3 = "In a single challenge, the more orders you complete in a row, the higher your rating bonus will be when complete.",
  str_help_summerminigame_details4 = "Completing a certain number of orders in a row will activate Chill Thrill. While Chill Thrill is active, you can tap anywhere on the screen to automatically complete each order step and quickly rack up rating points!",
  str_help_summer_activity_two_title1 = "Endgame Unlocking Info",
  str_help_summer_activity_two_title2 = "Endgame Stage Info",
  str_help_summer_activity_two_details1 = [[
1. Once the event begins, a set of Endgame challenges will unlock each day.
2. The first four stages are normal levels, while the fifth stage will be an Endgame stage.
3. The final Endgame stage, The Desolate Monarch, unlocks on the sixth day.]],
  str_help_summer_activity_two_details2 = [[
1. Endgame challenges can be repeated.
2. You can choose the difficulty and Endgame Modes of Endgame stages.
3. You can earn Endgame Points, and will earn bonus points for setting a new high score.]],
  str_help_summer_activity_two_title3 = "Difficulty Info",
  str_help_summer_activity_two_details3 = [[
1. You can choose the difficulty and Endgame Modes of each Endgame stage.
2. Each difficulty grants a corresponding base amount of points. The higher the difficulty, the more points you'll get.
3. Each Endgame Strategy has a corresponding point multiplier. The more Endgame Modes you select, the higher your overall point multiplier will be. The base point multiplier is 100%.
4. Total Endgame Point Earned = Base Points x Point Multiplier.]],
  str_help_world_boss_title1 = "Desolation Codex Mode",
  str_help_world_boss_details1 = [[
1.In Desolation Codex mode, you can challenge a different boss enemy each event cycle. Bosses have infinite HP, and you'll earn a corresponding rank and rewards according to the damage you deal.
2.You'll be promoted from rank Bronze to Paragon based on your highest total damage dealt. When your current damage reaches a certain amount, you'll gain access to Paragon rank. After reaching Paragon, if you are among the top 999 players with the highest challenge results, you will be promoted to Legendary rank.
3.Forgotten Whispers and Forgotten Utterances obtained from the Desolation Codex can be exchanged for rare items at the Exiled Harborage.]],
  str_help_world_boss_title2 = "Crusade Formation",
  str_help_world_boss_details2 = [[
1.You can use multiple teams to challenge bosses. The total damage dealt by all of your teams will be calculated as your final damage dealt.
2.Each Aurorian can be deployed to one team only. If you want to assign them to another team, you can choose to reset their current team's battle record.]],
  str_help_world_boss_title3 = "Rank Results",
  str_help_world_boss_details3 = [[
1. Each Desolation Codex cycle last for a specified period of time. At the end of the current cycle, results will be calculated according to your rank at that time, and rank emblems and rewards will be issued correspondingly.
2. Your rank emblem will be displayed on your personal avatar, and your emblem for this cycle will be determined according to your rank at the end of the previous cycle. If you fail to participate in the Desolation Codex challenge this cycle, you won't receive a rank in the next cycle, and your emblem won't be displayed on your avatar.
3. Rank rewards will be sent to your mailbox. Please note that the delivery process may be delayed.]],
  str_help_world_boss_title4 = "Enemy Info",
  str_help_world_boss_details4 = [[
1. After dealing a certain amount of damage to a boss, the attributes of the boss will be enhanced. Bosses have multiple enhancement stages.
2. Battle results will record damage dealt to the boss alone, and damage dealt to enemies summoned by the boss will not be included in the calculations.
3. Aurorians deal 100% more element counter damage.
4. Boss enemies are immune to HP percentage-based damage.]],
  str_help_shuoming_aircrafttactic_help_title1 = "Simulation Room Info",
  str_help_shuoming_aircrafttactic_help_desc1 = [[
1. The Simulation Room is where Data Disks are complied and stored. Data Disks will be generated here free of charge every week.
2. You can upgrade the room to increase its Data Disk storage capacity and reduce their generation time.
3. You can also deploy Aurorians here to further reduce Data Disk generation time.]],
  str_help_shuoming_aircrafttactic_help_title2 = "Data Disk Info:",
  str_help_shuoming_aircrafttactic_help_desc2 = [[
1. When a Data Disk is successfully generated, you'll receive an unopened Data Disk. Tap to open it, and it will randomly become a specific type of Data Disk.
2. You can accelerate Data Disk generation. When you have free chances available, Data Disks can be manufactured for free. Otherwise, you can use Fireflies to reduce the generation time. Use enough Fireflies, and you can directly generate a new Data Disk.
3. There is a limit to the number of Data Disks you can store. If you reach the limit, you will no longer receive Data Disks. After using Data Disks, you can continue to obtain Data Disks once the total number you own falls below the limit.
4. Data Disks can be deleted manually but cannot be recovered once you do so.]],
  str_help_shuoming_aircrafttactic_help_title3 = "Command Archives Gameplay Info:",
  str_help_shuoming_aircrafttactic_help_desc3 = [[
1. In the command simulator, you can select different types of Data Disks to challenge, and each type of Data Disk corresponds to a combat scenario.
2. These scenarios feature various combat situations, and battles that have already been encountered also have a chance of appearing again.
3. In each type of Data Disk, you can choose from three different difficulties. The higher the difficulty, the more Commander EXP you'll obtain from clearing stages.
4. Data Disks will be consumed after clearing stages, but will not be consumed if a stage is not completed or if you are defeated.]],
  str_help_shuoming_aircrafttactic_help_title4 = "Commander Level Info:",
  str_help_shuoming_aircrafttactic_help_desc4 = [[
1. Commander EXP can be earned by clearing any Data Disk.
2. Your Commander Level will automatically increase once you accumulate a certain amount of Commander EXP.
3. After your Commander Level increases, you'll receive the corresponding rewards.
4. You can check your Commander Level in your Personal Info and Friend Info.]],
  str_help_shuoming_aircrafttactic_help_title5 = "Data Fragment Info:",
  str_help_shuoming_aircrafttactic_help_desc5 = [[
1. When a Data Disk is generated, there's a chance you'll obtain a disk containing Data Fragments. You can obtain Data Fragments after clearing any difficulty.
2. Data Fragments will be displayed as special drops.
3. Once all of the data in the database has been unlocked, Data Fragments will no longer be obtained when generating Data Disks.]],
  str_help_shuoming_aircrafttactic_help_title6 = "Database Info:",
  str_help_shuoming_aircrafttactic_help_desc6 = [[
1. There are 4 clues for each type of intel in the database.
2. By consuming Data Fragments, you can unlock the database's intel clues and obtain intel.
3. After unlocking all 4 pieces of intel in the database, you'll obtain intel rewards.
4. Database intel can only be unlocked in the specified order. After the previous one has been completely unlocked, the subsequent intel can be unlocked.]],
  str_help_shuoming_n8_help_title1 = "Command Archives (Test Version) Gameplay Info:",
  str_help_shuoming_n8_help_desc1 = [[
1. The Command Archives (Test Version) is a strategic command simulator temporarily repaired by Gronru.
2. In the command simulator, you can select different types of Data Disks to challenge, and each type of Data Disk corresponds to a combat scenario.
3. These scenarios feature various combat situations, and battles that have already been encountered also have a chance of appearing again.
4. In each type of Data Disk, you can choose from three different difficulties. The higher the difficulty, the more Renown you'll receive after clearing it.
5. Data Disks will be consumed after clearing stages but will not be consumed if a stage is not completed or if you are defeated.]],
  str_help_shuoming_n8_help_title2 = "Obtaining Data Disks:",
  str_help_shuoming_n8_help_desc2 = [[
Data Disk Acquisition Info
1. You'll be given some Data Disks at the beginning of the event.
2. After the event begins, you'll receive a Data Disk at regular intervals.
3. There is a limit to the number of Data Disks you can store. If you reach the limit, you will no longer receive Data Disks. After consuming Data Disks, reducing your total amount to below the limit, you will continue to obtain them.
4. Data Disks can be deleted manually, but cannot be recovered once you do so.]],
  str_help_data_title = "Database Info:",
  str_help_data_desc = [[
1. There are 4 clues for each type of intel in the database.
2. By consuming Data Fragments, you can unlock the database's intel clues and obtain intel.
3. After unlocking all 4 pieces of intel in the database, you'll obtain intel rewards.
4. Database intel can only be unlocked in the specified order. After the previous one has been completely unlocked, the subsequent intel can be unlocked.]],
  str_help_shuoming_blackunderbellydungeon_help_title1 = "White Night, Black Underbelly Info",
  str_help_shuoming_blackunderbellydungeon_help_desc1 = [[
1.When White Night, Black Underbelly stages are cleared a certain number of times, a Bonus Time will be activated, where there will be Corrupted Eclipsites on the battlefield. Defeat them to earn extra Nightium.
2.Stages cleared at different difficulty levels in White Night, Black Underbelly are recorded separately.
3.Stages will be counted separately when Carriers are used for sweeping.]],
  str_help_shuoming_fengxinta_title = "Hyacinth Tower Info",
  str_help_shuoming_fengxinta_desc = [[
1. Once you obtain furniture or building blueprints, the production of corresponding items can be unlocked in Hyacinth Tower.
2. Production consumes certain materials. Once the production is completed, you can claim the item.
3. Level up Cloud Gardens to unlock more production queues and increase productivity.]],
  str_help_shuoming_baifang_title1 = "Friend Visit",
  str_help_shuoming_baifang_desc1 = [[
1. When a friend has Cloud Gardens, you can pay a visit to them.
2. When visiting a friend's Cloud Gardens, you can perform actions such as speeding up a friend's productions, watering Unique Trees, and taking items from your friend's Item Box.]],
  str_help_shuoming_baifang_title2 = "Production Speedup and Watering",
  str_help_shuoming_baifang_desc2 = [[
1. When there's an item or a Unique Tree that can be sped up in a friend's Cloud Gardens, remember to speed up or water them!
2. Each item under production can only be sped up once per day.
3. Each plot of Land of Fertility can only be watered once per day.]],
  str_help_shuoming_baifang_title3 = "Cloud Gardens Item Box",
  str_help_shuoming_baifang_desc3 = [[
1. Navigators can place items in their Cloud Gardens' Item Box.
2. When visiting a friend's Cloud Gardens, Navigators can take items from one grid in their friend's Item Box.
3. Navigators can only take items once from each friend daily.
4. Navigators can take items up to 10 times per day.]],
  str_help_shuoming_homelevel_title1 = "Cloud Gardens Decoration",
  str_help_shuoming_homelevel_desc1 = [[
1. Navigators can decorate Cloud Gardens with buildings and Unique Trees.
2. While an invited Aurorian settles at Cloud Gardens, their Affinity will increase over time.]],
  str_help_shuoming_homelevel_title2 = "Constructing Buildings",
  str_help_shuoming_homelevel_desc2 = [[
Various buildings can be constructed via the Hyacinth Tower located in the center of the square to decorate Cloud Gardens.
Wood and ores are required to construct buildings. They're scattered throughout the area and can be obtained with the appropriate tools.]],
  str_help_shuoming_homelevel_title3 = "Unique Trees Breeding",
  str_help_shuoming_homelevel_desc3 = [[
Unique Trees are decorative trees that can be placed in Cloud Gardens.
Unique Trees can be planted by sowing their seeds on the Land of Fertility, which can be obtained from Hyacinth Tower.]],
  str_help_shuoming_homelevel_title4 = "Fishing",
  str_help_shuoming_homelevel_desc4 = [[
A variety of fish can be caught by fishing along the river.
Some fish are worth more and can be sold to fulfill store orders.
Some rare fish are great for displaying and can be raised in the square's Fountain of Hope.]],
  str_help_shuoming_homelevel_title5 = "Treasure Hunting",
  str_help_shuoming_homelevel_desc5 = [[
Hunting for treasures in Cloud Gardens grants a chance to obtain Chests and Hope Coins.
Navigators can toss Hope Coins into the Fountain of Hope to learn the story behind them.]],
  str_help_shuoming_homelevel_title6 = "Aurorians settled",
  str_help_shuoming_homelevel_desc6 = [[
After constructing and decorating the Gardens Dorm, Navigators can invite Aurorians to move in.
Whenever an Aurorian moves in to Cloud Gardens, Navigators can interact with them and trigger random events.]],
  str_help_shuoming_homelevel_title7 = "Visiting Friends",
  str_help_shuoming_homelevel_desc7 = [[
Navigators can visit their friends' Cloud Gardens to help speed up their building construction and Unique Tree growth.
Navigators can also place items in their Cloud Gardens' Item Box for visiting friends to take from.]],
  str_help_shuoming_breed_desc1 = [[
Mutation Breeding, Targeted Breeding, and Alteration Breeding can be carried out on the Land of Fertility.
Add Unique Tree seeds here to start the breeding. After breeding for a period of time, you will get a Unique Tree and the seed of this Unique Tree. The number of seeds dropped is random, within a certain range.
Unique Trees can be placed in Cloud Gardens, where they can undergo dyeing processes.]],
  str_help_shuoming_breed_desc2 = [[
Mutation Breeding can only be carried out with different seeds of the same rarity. Mutation Breeding cannot be carried out on Unique Trees of IV rarity.
If the two seeds are from the same category, the Unique Tree that is produced will be of the same category.
If the two seeds are from different categories, any corresponding tree under the two categories may be produced, and there is a high chance of producing a Unique Tree belonging to the genus of Main Seed.]],
  str_help_shuoming_breed_desc3 = [[
Mutation Breeding has a chance to produce random Unique Trees of a higher rarity. Advanced Unique Trees will be randomly produced from all trees in the categories represented by the Main Seed and the Mutation Factor.
If the upgrade is unsuccessful, the Main Seed or Unique Tree corresponding to the Mutation Factor will be produced instead.]],
  str_help_shuoming_breed_desc4 = "Mutation Breeding results can be previewed after adding the Main Seed and Mutation Factor.",
  str_help_shuoming_breed_desc5 = "Targeted Breeding can only be carried out with two identical seeds. Targeted Breeding will always produce a Unique Tree corresponding to the added seed.",
  str_help_shuoming_breed_desc6 = "Approaching a Unique Tree that has been placed in Cloud Gardens will make the tree undergo a dyeing process. This process will use up Rose Crystalloids and change the color of the Unique Tree.",
  str_help_shuoming_breed_desc7 = [[
Mutation Breeding and Targeted Breeding will generate a bonus item: Petrowood.
Petrowood obtained is related to the quality of the Unique Trees, and the weekly limit is 100.]],
  str_help_shuoming_breed_desc8 = "Consuming 1 Unique Tree IV and 1 Alteration Potion during Alteration Breeding can generate other basic Unique Trees IV of the same species.",
  str_help_shuoming_breed_title1 = "The Land of Fertility and Unique Trees",
  str_help_shuoming_breed_title2 = "Mutation Breeding Rules",
  str_help_shuoming_breed_title3 = "Upgrade Rules",
  str_help_shuoming_breed_title4 = "Breeding Result Preview",
  str_help_shuoming_breed_title5 = "Targeted Breeding Rules",
  str_help_shuoming_breed_title6 = "Dye Breeding",
  str_help_shuoming_breed_title7 = "Petrowood",
  str_help_shuoming_breed_title8 = "Alteration Breeding Rules",
  str_help_homeland_wishing_title1 = "Fountain of Hope Info",
  str_help_homeland_wishing_title2 = "Collecting Hope Coins",
  str_help_homeland_wishing_title3 = "Raising Ornamental Fish",
  str_help_homeland_wishing_desc1 = [[
1. It is said that the Caelestites have an unofficial tradition. When a Caelestite is about to become an adult, they need to throw a Hope Coin they made personally into the Fountain of Hope and make a wish. This tradition was forgotten with the disappearance of the Caelestites, and even their Hope Coins have disappeared without a trace...
2. There is a chance to get Hope Coins when fishing.]],
  str_help_homeland_wishing_desc2 = [[
1. Hope Coins that are obtained in Cloud Gardens can be thrown into the Fountain of Hope for collection.
2. You will receive rewards according to the number of Hope Coins thrown into the Fountain of Hope.]],
  str_help_homeland_wishing_desc3 = [[
1. High-quality fish that you catch can be raised in the Fountain of Hope.
2. The raised fish can be collected back at any time without affecting their sales.]],
  str_help_shuoming_visitfriends_title1 = "Home List Information",
  str_help_shuoming_visitfriends_title2 = "Home List Information 1",
  str_help_shuoming_visitfriends_title3 = "Home List Information 2",
  str_help_homeland_visitfriends_desc1 = "Home List Description 1",
  str_help_homeland_visitfriends_desc2 = "Home List Description 2",
  str_help_homeland_visitfriends_desc3 = "Home List Description 3",
  str_help_shuoming_storehouse_title1 = "Item Box Information",
  str_help_shuoming_storehouse_title2 = "Item Box Information 1",
  str_help_shuoming_storehouse_title3 = "Item Box Information 2",
  str_help_homeland_storehouse_desc1 = "Item Box Description 1",
  str_help_homeland_storehouse_desc2 = "Item Box Description 2",
  str_help_homeland_storehouse_desc3 = "Item Box Description 3",
  str_help_diff_mission_title1 = "Pandora's Box",
  str_help_diff_mission_title2 = "Challenge Trophy",
  str_help_diff_mission_title3 = "Challenge Formation",
  str_help_diff_mission_title4 = "Battlefield Characteristics",
  str_help_diff_mission_title5 = "Enemy Intel",
  str_help_diff_mission_desc1 = "1. Pandora's Box consists of a series of highly difficult stages, providing a variety of mechanisms and bosses for Navigators to challenge.\n2. Each Pandora's Box chapter contains multiple waypoints, and each waypoint contains multiple stages. As there's no order between the stages, Navigators are free to challenge any stage within the waypoint.\n3. There are 3–5 Challenge Trophies in each waypoint, and only by using the required lineup according to the Trophy conditions to clear all waypoint stages can Navigators obtain the corresponding Trophies and rewards.\n4. When challenging stages in the same waypoint, Navigators are required to use different Aurorians.",
  str_help_diff_mission_desc2 = [[
1. Each waypoint has 3-5 Challenge Trophies, and different Challenge Trophies have different challenge conditions.
2. Navigators need to clear all waypoint stages with the required lineups according to the Trophy conditions to obtain the corresponding Trophies and rewards.
3. As there's no order between the Trophies, Navigators are free to challenge each Trophy multiple times.
4. Once a Challenge Trophy is obtained, it'll remain even when the stage formation is reset.]],
  str_help_diff_mission_desc3 = [[
1. Each stage can be challenged with one formation.
2. Used Aurorians cannot be used again in different stages in the same waypoint. However, Aurorians can be used again in another waypoints.
3. Stage formation can be reset, and resetting the formation will not affect obtained Challenge Trophies.]],
  str_help_diff_mission_desc4 = "Each stage has its own battlefield characteristics which provide different mechanisms to stages and monsters. Navigators can learn about battlefield characteristics from stage screen to make necessary preparation in advance.",
  str_help_diff_mission_desc5 = "Navigators can view enemy intel from the stage screen and learn about battlefield characteristics in the stage such as the elements and appearance of the monsters you will face.",
  str_help_shuoming_tanbao_title1 = "Signal Retrieval",
  str_help_shuoming_tanbao_title2 = "Explorer Chubb",
  str_help_shuoming_tanbao_title3 = "Portable Detector",
  str_help_shuoming_tanbao_title4 = "Locating Treasure",
  str_help_shuoming_tanbao_desc1 = "1. Detailed Investigation consumes Special Signals or Normal Signals.\n2. After Detailed Investigation begins, Navigators will receive Special Signal ×1 and Normal Signal ×2 to start off.\n3. From the second day of the event, Navigators will receive Special Signal ×1 and Normal Signal ×2 every day. Each Navigator can receive up to Special Signal ×6 and Normal Signal ×12 in total during the event period.",
  str_help_shuoming_tanbao_desc2 = [[
1. After Detailed Investigation begins, Explorer Chubb will appear around Hyacinth Square in Cloud Gardens.
2. Locate Explorer Chubb on Hyacinth Square and interact with it in order to begin consuming Signals to start investigating.
3. Locate treasure using the Signal's guidance within the given time to complete the investigation. Otherwise, it'll be considered a failure.]],
  str_help_shuoming_tanbao_desc3 = [[
1.Treasures are scattered all over Cloud Gardens. During the investigation, Navigators can scan and locate the treasures with the Portable Detector.
2.The Portable Detector will emit different colors based on how close Navigators are to the treasure (from far to near): red, yellow, and green.
3.The Portable Detector can also scan the rough location of treasures. It will give feedback via scanning angles based on its distance to the treasure. The closer you get, the narrower the scanning angle will be, until it is able to pinpoint the location of the treasure.]],
  str_help_shuoming_tanbao_desc4 = [[
1. Treasures detected by the Portable Detector will emit a faint glow.
2. The color of the glow will be different depending on the type of Signal consumed for the detection.
3. Once the treasure is found, tapping on it will conclude a successful hunt, upon which you will receive a corresponding reward!]],
  str_help_n20minigame_tittle1 = "Make Udon",
  str_help_n20minigame_tittle2 = "Customer Mood",
  str_help_n20minigame_tittle3 = "Rating Bonus",
  str_help_n20minigame_tittle4 = "Topping Frenzy",
  str_help_n20minigame_details1 = [[
1. The food cart is now in business! The more orders you complete within the time limit, the more rating points you'll earn.
2. You'll need to complete 4 steps to make a serve of udon: select a size, ingredients, soup, and serve to the customer. The order in which you select the ingredients and soup doesn't matter.]],
  str_help_n20minigame_details2 = [[
Each customer has a certain waiting time. As the waiting time becomes longer, their mood will drop from Happy, to Impatient, and then to Angry.
The better the customer's mood, the more rating points you'll receive for completing their order.]],
  str_help_n20minigame_details3 = "In a single challenge, the more orders you complete in a row, the higher your rating bonus will be when complete.",
  str_help_n20minigame_details4 = "Completing a certain number of orders in a row will activate Topping Frenzy. While Topping Frenzy is active, you can tap anywhere on the screen to automatically complete each order step and quickly rack up rating points!",
  str_help_activity_review_tittle1 = "Travel Memories Info",
  str_help_activity_review_desc1 = [[
1. You can consume Cloud Disks to unlock Travel Memories.
2. You will receive 1 Cloud Disk when you reach 60 Activity every day.
3. Cloud Disks no longer accumulate once the limit has been reached.]],
  str_help_sailing_explain = "Into the Abyss",
  str_help_sailing_title1 = "Undercity π",
  str_help_sailing_title2 = "Ventilator",
  str_help_sailing_title3 = "Exploration Teams",
  str_help_sailing_title4 = "Ventilator Counts",
  str_help_sailing_details1 = "A set of ruins discovered by the Illumina Federation roughly three decades ago. After spending a vast amount of labor and resources to reconstruct it, the Federation began delving into the seemingly-bottomless depths of the Undercity, hoping to uncover further knowledge of Astra's ancient civilization. Ten years ago, however, the ruins were attacked by a legion of Eclipsites commanded by the Eclipse. After inundating the Undercity's ventilation systems with toxic gases, wave after wave of murderous Eclipsites began pouring into the ruins, effectively halting the Illumina Federation's ambitious exploration. Faced with an endless stream of bloodthirsty monsters, the Federation had no choice but to fight as they retreated to the surface, sealing off every single floor of the Undercity along the way. As a result, Undercity 101 was declared completely off-limits and highly dangerous, as the countless Eclipsites that invaded it a decade ago still roam its floors today. Fearing that the secrets of the ancient civilization would fall into the wrong hands, it was later renamed Undercity π, a bottomless Undercity hiding the untold knowledge of ages past...",
  str_help_sailing_details2 = "1. Each floor in Undercity π has an unspecified number of ventilators. Starting on Floor 1, the Navigator must locate every ventilator while exploring the Undercity.\n2. The Navigator must activate every ventilator on each floor of the Undercity to clear out the toxic fumes and progress to the next floor.\n3. Each ventilator requires the Lumina of 5 Aurorians to activate. The ventilators can be activated in any order.\n4. By increasing the number of \"Total Ventilators Activated\" the Navigator can claim even greater rewards via the Exploration Rewards interface!",
  str_help_sailing_details3 = [[
1. Every floor contains several ventilators, each of which is guarded by a powerful Eclipsite boss. As such, a full team of 5 Aurorians is required to challenge each stage.
2. Each Aurorian can only be assigned to a single team on the same floor, and cannot be assigned to teams for other stages of the floor.
3. Stage formation can be reset; Aurorians whose formations are reset can be assigned to any stage formation on the current floor.
4. Stages that have been cleared must be garrisoned by a team; resetting a stage's garrison team will reset that stage's status from cleared to uncleared.
5. A floor is counted as cleared once all its stages have been cleared.
6. Resetting a stage's team formation on a cleared floor will not change the cleared status of that floor.]],
  str_help_sailing_details4 = [[
1. Throughout your explorations, ventilators will be divided into two sets: "Ventilators Activated" and "Total Ventilators Activated."
2. "Total Ventilators Activated" indicates the highest number of ventilators activated by the Navigator for this exploration; resetting any stages/floors will not affect this number.
3. "Ventilators Activated" indicates the number of currently-activated ventilators for a given exploration attempt. Resetting a stage for the current floor will decrease this number; resetting stages for a cleared floor will not affect this number.]],
  str_help_shuoming_property_cultivate_title1 = "Enlightenment System Info",
  str_help_shuoming_property_cultivate_desc1 = [[
1. The Enlightenment system is an upgrade system that enhances the combat capabilities of all Aurorians.
2. The Enlightenment system consists of a Water, Fire, Forest, and Thunder Module, and each module enhances the attributes of Aurorians with the corresponding primary element.
3. The Enlightenment system increases the ATK, DEF, HP, Element Counter Damage, Active Skill Final Damage, and Element Tile Refresh Probability of Aurorians of the same element.
4. The enhancements of the Enlightenment system will not be displayed in the interface, but will take effect directly in battles.
5. The enhancements of the Enlightenment system will not take effect in some gameplay. Please refer to the relevant gameplay info for details.]],
  str_help_shuoming_property_cultivate_title2 = "Enlightenment System Upgrade Info",
  str_help_shuoming_property_cultivate_desc2 = [[
1. Materials can be used to level up Element Modules.
2. Element Modules can be upgraded after they have reached their max level and the prerequisite conditions have been met.
3. Element Modules can be leveled up further after they are upgraded.]],
  str_help_elimate_explain = "Enlightened Training Info",
  str_help_elimate_tittle1 = "Gameplay Info",
  str_help_elimate_tittle2 = "Aurorian Bonds",
  str_help_elimate_tittle3 = "Support Faction",
  str_help_elimate_tittle4 = "Points Rewards",
  str_help_elimate_tittle5 = "Clearance Rewards",
  str_help_elimate_details1 = [[
1. During Enlightened Training, it is possible to challenge various difficulty levels.
2. Regardless of the difficulty level, all challenges must be completed in a certain number of rounds, and the HP percentage of Aurorians is inherited between stages. The challenge ends if you are defeated at any stage.
3. Enlightenment Gears, which are only effective in the current challenge, can be obtained after clearing stages. All Enlightenment Gears will be removed after the challenge ends.
4. In Enlightened Training stages, it is not necessary to make connections. Instead, tiles can be removed by tapping them. Tapping on a tile will also select all adjacent tiles of the same color. Tapping the tile again will remove the selected tiles, and Aurorians will cast a Chain Combo based on the number of removed tiles.]],
  str_help_elimate_details2 = [[
1. During Enlightened Training, bonds exist between certain Aurorians.
2. When Aurorians with a bond are deployed at the same time, they will gain each other's primary element. When tiles of one of these primary elements are removed, both Aurorians will engage in combat.]],
  str_help_elimate_details3 = [[
1. In Enlightened Training, each faction has a unique faction support skill.
2. When at least 3 Aurorians of the same faction are deployed, removing 15/30 tiles at once will trigger a Lv.1/Lv.2 faction skill.]],
  str_help_elimate_details4 = [[
1. During Enlightened Training, points are gained by clearing stages. The higher the difficulty, the more points obtained when clearing a stage.
2. Points rewards can be claimed when a certain number of points are accumulated in each period. Points rewards are reset in each period.
3. The higher the unlocked difficulty, the better the point rewards in each period, and the higher the upper limit of points rewards.]],
  str_help_elimate_details5 = [[
1. During Enlightened Training, rewards can be claimed after clearing stages.
2. During each period, the amount and quantity of clearance rewards that can be claimed is capped, and this limit is reset in every period.]],
  str_help_world_boss_title1_new = "Desolation Codex: Enlightenment Mode",
  str_help_world_boss_details1_new = [[
1.In Desolation Codex mode, you can challenge a different boss enemy each event cycle. Bosses have infinite HP, and you'll earn a corresponding rank and rewards according to the damage you deal.
2.You'll be promoted from rank Bronze to Paragon based on your highest total damage dealt. When your current damage reaches a certain amount, you'll gain access to Paragon rank. After reaching Paragon, if you are among the top 999 players with the highest challenge results, you will be promoted to Legendary rank.
3.Forgotten Whispers and Forgotten Utterances obtained from the Desolation Codex can be exchanged for rare items at the Exiled Harborage.
4. In the Enlightenment Mode, it is not necessary to make connections. Instead, tiles can be removed by tapping them. Tapping on a tile will also select all adjacent tiles of the same color. Tapping the tile again will remove the selected tiles, and Aurorians will cast a Chain Combo based on the number of removed tiles.]],
  str_help_season1_tab_1 = "Awakening in the Storm",
  str_help_season1_tab_2 = "Dream",
  str_help_season1_tab_3 = "Memory Workshop",
  str_help_season1_tab_4 = "Memory Fragments",
  str_help_season1_tab_5 = "Eve's Collection Box",
  str_help_season1_title_101 = "Awakening in the Storm",
  str_help_season1_title_102 = "Dream",
  str_help_season1_title_103 = "Memory Fragments",
  str_help_season1_title_104 = "Stand By Me Set",
  str_help_season1_title_105 = "Eve's Collection Box",
  str_help_season1_title_201 = "Omen",
  str_help_season1_title_202 = "Reverie and Nightmare",
  str_help_season1_title_203 = "Stage Details",
  str_help_season1_title_204 = "Wit",
  str_help_season1_title_205 = "Smiles Lead to Happiness",
  str_help_season1_title_206 = "Cognova/Nostalix",
  str_help_season1_title_207 = "Sandstorm",
  str_help_season1_title_208 = "Obstacle",
  str_help_season1_title_209 = "Dream Devourer",
  str_help_season1_title_301 = "Memory Workshop",
  str_help_season1_title_302 = "Metamorpha and Sediment Shard",
  str_help_season1_title_303 = "Exchange Item",
  str_help_season1_title_304 = "Expiry Conversion",
  str_help_season1_title_305 = "Authentic Dreamscapes",
  str_help_season1_title_401 = "Memory Fragments",
  str_help_season1_title_402 = "Unlock Fragments",
  str_help_season1_title_403 = "Fragment Details",
  str_help_season1_title_501 = "Eve's Collection Box",
  str_help_season1_title_502 = "Unnamed Treasure",
  str_help_season1_title_503 = "Item Synthesis",
  str_help_season1_title_504 = "Memories' Imprint",
  str_help_season1_title_505 = "Sonic Memory",
  str_help_season1_disc_101 = "Awakening in the Storm has arrived. In a profound slumber, the dream recurs, replaying itself.",
  str_help_season1_disc_102 = "Guide Eve in utilizing her Wit points to conquer the Omen within the dream. Upon settling it, you will gain access to Metamorpha and Sediment Shards. These can be traded for a range of rewards at the Memory Workshop, including the outfit Once Upon a Springtime.",
  str_help_season1_disc_103 = "Finish the quests detailed in the Memory Fragments to earn Lumamber, and uncover hidden storylines about Eve.",
  str_help_season1_disc_104 = "Complete quests within the dream world to acquire the Stand By Me Set.",
  str_help_season1_disc_105 = "The little trinkets collected in the Dream are all carefully stored here by Eve.",
  str_help_season1_disc_201 = "Awakening in the Storm is upon us, yet the Omen is hindering Eve's awakening. Assist Eve in vanquishing the Omen, and be rewarded generously for success. Note that each challenge against the Omen will consume 1 Wit point.",
  str_help_season1_disc_202 = [[
There are two difficulty levels for the Omen challenge: Reverie and Nightmare.
While Nightmare offers a more challenging experience, it also provides superior rewards. If you find Nightmare too overwhelming, consider trying Reverie first.
Within the same Omen challenge, the star level achieved in Nightmare will be synchronized with Reverie. Achieving a three-star clearance reward and the 1st Clear Reward in Nightmare will also grant you corresponding rewards from Reverie.]],
  str_help_season1_disc_203 = "Visit the Stage Details to see all the Omen information related to Awakening in the Storm, where you can also switch between Reverie and Nightmare.",
  str_help_season1_disc_204 = "Eve maintains a sense of rationality and clarity, allowing her to challenge the Omen in Awakening in the Storm. Wit point will replenish by 3 points each day at 05:00 (UTC+0), 00:00 (UTC-5).",
  str_help_season1_disc_205 = [[
Smiles Lead to Happiness can grant potent buffs to Eve.
Triumph over the Omen under Nightmare difficulty to obtain Ripples of Joy. The item can enhance the level of Smiles Lead to Happiness.]],
  str_help_season1_disc_206 = "Mysterious treasures are hidden in Cognova and Nostalix. You can put them in Eve's Collection Box. Don't miss the chance to open them.",
  str_help_season1_disc_207 = "Sandstorm blocked Eve's path and clouded her heart. Defeat the Omen around you to dispel the Sandstorm!",
  str_help_season1_disc_208 = "Eve, always obedient, never had the desire to break through the illusion. Yet, the thing she holds dear ultimately shatters it. \"Let me inherit my brother's weapon!\"",
  str_help_season1_disc_209 = [[
Uh-oh, a swarm of Dream Devourers is nibbling away at Eve's dream! If her dream crumbles, poor Eve might never wake again... We can't let it happen!
From 05:00, 6 September, to 04:00, 27 September, a new swarm of Dream Devourers emerges at 05:00 daily. You'll have 5 chances to drive them away every day, with the first 2 successful expulsions offering bountiful rewards. The difficulty of expelling these Dream Devourers increases with each attempt until reset at 05:00 the following day.]],
  str_help_season1_disc_301 = "The Memory Workshop provides a selection of rewards, among which is the outfit Once Upon a Springtime.",
  str_help_season1_disc_302 = "Resolve the Omen in the dream to acquire Metamorpha and Sediment Shards.",
  str_help_season1_disc_303 = "Metamorpha can be exchanged for the outfit Once Upon a Springtime, and Sediment Shards can be exchanged for various other rewards.",
  str_help_season1_disc_304 = "After the Memory Workshop closes, Metamorpha will be converted into Dream Shards at a 1:1 ratio, while Sediment Shards will be exchanged for Nightium at a 1:30 ratio. The corresponding items will be sent directly to your Warehouse upon successful conversion.",
  str_help_season1_disc_305 = "After the Memory Workshop closes, the Once Upon a Springtime outfit will still be available in Authentic Dreamscapes. At that time, you can exchange Dream Shards, which are converted from Metamorpha, for the outfit.",
  str_help_season1_disc_401 = "Finish the quests detailed in the Memory Fragments to earn Lumamber, and uncover hidden storylines about Eve.",
  str_help_season1_disc_402 = "Complete the specific quests to unlock the fragments and acquire Lumamber.",
  str_help_season1_disc_403 = "Upon unlocking the fragments, you can also uncover hidden storylines about Eve.",
  str_help_season1_disc_501 = "The little trinkets collected in the Dream are all carefully stored here by Eve.",
  str_help_season1_disc_502 = "Unnamed Treasures hold collectibles found in the dream, along with clues to acquire content that has not yet been collected.",
  str_help_season1_disc_503 = "Some collectibles will interact magically with each other, creating new mysterious objects.",
  str_help_season1_disc_504 = "Memories' Imprint documents the remarkable moments experienced in the dream and clues to acquire content that hasn't been collected.",
  str_help_season1_disc_505 = "Sonic Memory captures the snippets of melodies heard in the dream, along with clues to acquire uncollected content.",
  str_help_season2_tab_1 = "Trials Amongst Golden Ripples",
  str_help_season2_tab_2 = "Dream",
  str_help_season2_tab_3 = "Trial Auction",
  str_help_season2_tab_4 = "Checklist",
  str_help_season2_tab_5 = "Case Exhibit",
  str_help_season2_title_101 = "Trials Amongst Golden Ripples",
  str_help_season2_title_102 = "Dream",
  str_help_season2_title_103 = "Checklist",
  str_help_season2_title_104 = "Stand By Me Set",
  str_help_season2_title_105 = "Case Exhibit",
  str_help_season2_title_201 = "Edge",
  str_help_season2_title_202 = "Reverie and Nightmare",
  str_help_season2_title_203 = "Stage Details",
  str_help_season2_title_204 = "Wit",
  str_help_season2_title_205 = "Truth Focus",
  str_help_season2_title_206 = "Cognova/Case File",
  str_help_season2_title_207 = "Mystic Fog",
  str_help_season2_title_208 = "Scale of Justice",
  str_help_season2_title_209 = "Dream Devourer",
  str_help_season2_title_301 = "Trial Auction",
  str_help_season2_title_302 = "Counterweights of Soul & Candle of Justice",
  str_help_season2_title_303 = "Exchange Item",
  str_help_season2_title_304 = "Expiry Conversion",
  str_help_season2_title_305 = "Authentic Dreamscapes",
  str_help_season2_title_401 = "Checklist",
  str_help_season2_title_402 = "Mission",
  str_help_season2_title_501 = "Case Exhibit",
  str_help_season2_title_502 = "Unnamed Treasure",
  str_help_season2_title_503 = "Memories' Imprint",
  str_help_season2_title_504 = "Sonic Memory",
  str_help_season2_disc_101 = "Silence, silence! Trials Amongst Golden Ripples is now in session!",
  str_help_season2_disc_102 = "Guide Irridon in utilizing her Wit points to conquer the Edge within the dream. Upon settling it, you will gain access to Counterweights of Soul and Candle of Justice, which can be traded for a range of rewards at the Trial Auction, including the outfit Fiat Iustitia.",
  str_help_season2_disc_103 = "Complete the Missions in the Checklist to get Lumamber as a reward.",
  str_help_season2_disc_104 = "Complete quests within the dream world to acquire the Stand By Me Set.",
  str_help_season2_disc_105 = "All the evidence gathered within the dream is methodically categorized and stored by Irridon here.",
  str_help_season2_disc_201 = "Trials Amongst Golden Ripples is already underway, yet the Edge is hindering Irridon's awakening. Assist Irridon in handling the Edge, and you'll be rewarded generously for success. Note that each challenge against the Edge will consume 1 Wit point.",
  str_help_season2_disc_202 = [[
There are two difficulty levels for the Edge challenge: Reverie and Nightmare.
While Nightmare offers a more challenging experience, it also provides superior rewards. If you find Nightmare too overwhelming, consider trying Reverie first.
Within the same Edge challenge, the star level achieved in Nightmare will be synchronized with Reverie. Achieving a three-star clearance reward and the 1st Clear Reward in Nightmare will also grant you corresponding rewards from Reverie.]],
  str_help_season2_disc_203 = "Visit the Stage Details to see all the Edge information related to Trials Amongst Golden Ripples, where you can also switch between Reverie and Nightmare.",
  str_help_season2_disc_204 = "The key to maintaining a sense of rationality and clarity, allowing her to challenge the Edge in Trials Amongst Golden Ripples. Wit point will replenish by 3 points each day at 05:00 (UTC+0), 00:00 (UTC-5).",
  str_help_season2_disc_205 = [[
Truth Focus can provide strong assistance along the way.
Triumph over the Edge under Nightmare difficulty to obtain Light of Justice. The item can enhance the level of Truth Focus.]],
  str_help_season2_disc_206 = "There are mysterious clues and physical evidence in Cognova and Case Files, which will be organized into the Case Exhibit after acquisition.",
  str_help_season2_disc_207 = "The Mystic Fog blocks Irridon's path and clouds her heart. Defeat the Edges around you to dispel the Mystic Fog!",
  str_help_season2_disc_208 = "Collect clues and use the Scale of Justice for deduction to solve the cases encountered!",
  str_help_season2_disc_209 = [[
Oh, no, a swarm of Dream Devourers is nibbling away Irridon's dream! If her dream crumbles, poor Irridon might never wake again... We can't let it happen!
A new swarm of Dream Devourers emerges at 05:00 daily. You'll have 5 chances to drive them away every day, with the first 2 successful expulsions offering bountiful rewards. The difficulty of expelling these Dream Devourers increases with each attempt until reset at 05:00 the following day.]],
  str_help_season2_disc_301 = "The Trial Auction provides a selection of rewards, among which is the outfit Fiat Iustitia.",
  str_help_season2_disc_302 = "Resolve the Edge in the dream to acquire Counterweights of Soul and Candle of Justice.",
  str_help_season2_disc_303 = "Counterweights of Soul can be exchanged for the outfit Fiat Iustitia, and Candle of Justice can be exchanged for various other rewards.",
  str_help_season2_disc_304 = "After the Trial Auction closes, Counterweights of Soul will be converted into Dream Shards at a 1:1 ratio, while Candle of Justice will be exchanged for Nightium at a 1:30 ratio. The corresponding items will be sent directly to you via mail.",
  str_help_season2_disc_305 = "After the Trial Auction concludes, the Fiat Iustitia outfit will still be available in Authentic Dreamscapes. At that time, you can exchange Dream Shards, which are converted from Counterweights of Soul, for the outfit.",
  str_help_season2_disc_401 = "Complete the Missions in the Checklist to get Lumamber as a reward.",
  str_help_season2_disc_402 = "Complete the corresponding Mission to get Lumamber as a reward.",
  str_help_season2_disc_501 = "All the evidence gathered within the dream is methodically categorized and stored by Irridon here.",
  str_help_season2_disc_502 = "Unnamed Treasures hold collectibles found in the dream, along with clues to acquire content that has not yet been collected.",
  str_help_season2_disc_503 = "Memories' Imprint documents the remarkable moments experienced in the dream and clues to acquire content that hasn't been collected.",
  str_help_season2_disc_504 = "Sonic Memory captures the snippets of melodies heard in the dream, along with clues to acquire uncollected content.",
  str_help_season3_tab_1 = "Underwater Fantasia",
  str_help_season3_tab_2 = "Dream",
  str_help_season3_tab_3 = "Sea Bubbles Cafe",
  str_help_season3_tab_4 = "Dreamy Prelude",
  str_help_season3_tab_5 = "Connolly's Wardrobe",
  str_help_season3_title_101 = "Underwater Fantasia",
  str_help_season3_title_102 = "Dream",
  str_help_season3_title_103 = "Dreamy Prelude",
  str_help_season3_title_104 = "Stand By Me Set",
  str_help_season3_title_105 = "Connolly's Wardrobe",
  str_help_season3_title_201 = "Vortex",
  str_help_season3_title_202 = "Reverie and Nightmare",
  str_help_season3_title_203 = "Stage Details",
  str_help_season3_title_204 = "Wit",
  str_help_season3_title_205 = "Aqua Connection",
  str_help_season3_title_206 = "Treasure Clam Shell",
  str_help_season3_title_207 = "Eeriness",
  str_help_season3_title_301 = "Sea Bubbles Cafe",
  str_help_season3_title_302 = "Echoing Seashells and Delicious Fluorophora",
  str_help_season3_title_303 = "Exchange Item",
  str_help_season3_title_304 = "Expiry Conversion",
  str_help_season3_title_305 = "Authentic Dreamscapes",
  str_help_season3_title_401 = "Dreamy Prelude",
  str_help_season3_title_402 = "Quest",
  str_help_season3_title_501 = "Connolly's Wardrobe",
  str_help_season3_title_502 = "Unnamed Treasure",
  str_help_season3_title_503 = "Memories' Imprint",
  str_help_season3_title_504 = "Sonic Memory",
  str_help_season3_disc_101 = "After traveling through the rabbit hole beneath the water, will the place where Connolly sings be an underwater fantasia or a vortex of the past...",
  str_help_season3_disc_102 = "Guide Connolly to help her conquer the Vortex within the dream. Upon settling it, you will gain access to Echoing Seashells and Delicious Fluorophora. These can be traded for a range of rewards at the Sea Bubbles Cafe, including the outfit Aquatic Reverie.",
  str_help_season3_disc_103 = "Complete quests in Dreamy Prelude to get Lumamber.",
  str_help_season3_disc_104 = "Complete quests within the dream world to acquire the Stand By Me Set.",
  str_help_season3_disc_105 = "All the items gathered in the dream are methodically categorized and stored here by Connolly.",
  str_help_season3_disc_201 = "The doors to Wonderland have been opened, yet the Vortex is hindering Connolly's advance. Assist Connolly in vanquishing the Vortex, and receive generous rewards upon your success. Note that each challenge against the Vortex will consume 1 Wit point.",
  str_help_season3_disc_202 = [[
There are two difficulty levels for the Vortex challenge: Reverie and Nightmare.
While Nightmare offers a more challenging experience, it also provides superior rewards. If you find Nightmare too overwhelming, consider trying Reverie first.
Within the same Vortex challenge, the star level achieved in Nightmare will be synchronized with Reverie. Achieving a three-star clearance reward and the 1st Clear Reward in Nightmare will also grant you corresponding rewards from Reverie.]],
  str_help_season3_disc_203 = "Visit the Stage Details to see all the Vortex information related to Underwater Fantasia, where you can also switch between Reverie and Nightmare.",
  str_help_season3_disc_204 = "The key to maintaining a sense of rationality and clarity, allowing her to challenge the Vortex in Underwater Fantasia. Wit point will replenish by 3 points each day at 05:00 (UTC+0), 00:00 (UTC-5).",
  str_help_season3_disc_205 = [[
Aqua Connection can provide strong assistance along the way.
Triumph over the Vortex under Nightmare difficulty to obtain Study of the Pact. The item can enhance the level of Aqua Connection.]],
  str_help_season3_disc_206 = "There are mysterious clues in Treasure Clam Shell, which will be organized into Connolly's Wardrobe after acquisition.",
  str_help_season3_disc_207 = "The Eeriness blocked Connolly's path. Defeat the Vortex around you to dispel the Eeriness!",
  str_help_season3_disc_301 = "The Sea Bubbles Cafe provides a selection of rewards, among which is the outfit Aquatic Reverie.",
  str_help_season3_disc_302 = "Resolve the Vortex in the dream to acquire Echoing Seashells and Delicious Fluorophora.",
  str_help_season3_disc_303 = "Echoing Seashells can be exchanged for the outfit Aquatic Reverie, and Delicious Fluorophora can be exchanged for various other rewards.",
  str_help_season3_disc_304 = "After the Sea Bubbles Cafe closes, Echoing Seashells will be converted into Dream Shards at a 1:1 ratio, while Delicious Fluorophora will be exchanged for Nightium at a 1:30 ratio. The corresponding items will be sent directly to you via mail.",
  str_help_season3_disc_305 = "After the Sea Bubbles Cafe closes, the Aquatic Reverie outfit will still be available in Authentic Dreamscapes. At that time, you can exchange Dream Shards, which are converted from Echoing Seashells, for the outfit.",
  str_help_season3_disc_401 = "Complete quests in Dreamy Prelude to get Lumamber and other rewards.",
  str_help_season3_disc_402 = "Complete the corresponding quests to get Lumamber and other rewards.",
  str_help_season3_disc_501 = "All the items gathered in the dream are methodically categorized and stored here by Connolly.",
  str_help_season3_disc_502 = "Unnamed Treasures hold collectibles found in the dream, along with clues to acquire content that has not yet been collected.",
  str_help_season3_disc_503 = "Memories' Imprint documents the remarkable moments experienced in the dream and clues to acquire content that hasn't been collected.",
  str_help_season3_disc_504 = "Sonic Memory captures the snippets of melodies heard in the dream, along with clues to acquire uncollected content.",
  str_help_season4_tab_1 = "Sword Song Under a Canopy of Dreams",
  str_help_season4_tab_2 = "Dream",
  str_help_season4_tab_3 = "Verdant Exchange",
  str_help_season4_tab_4 = "Missions",
  str_help_season4_tab_5 = "Swordswoman's Memories",
  str_help_season4_tab_6 = "Daytime Merchant",
  str_help_season4_tab_7 = "Purging Evil in the Still Night",
  str_help_season4_title_101 = "Sword Song Under a Canopy of Dreams",
  str_help_season4_title_102 = "Dream",
  str_help_season4_title_103 = "Missions",
  str_help_season4_title_104 = "Stand By Me Set",
  str_help_season4_title_105 = "Swordswoman's Memories",
  str_help_season4_title_201 = "Miasma",
  str_help_season4_title_202 = "Reverie and Nightmare",
  str_help_season4_title_203 = "Stage Details",
  str_help_season4_title_204 = "Wit",
  str_help_season4_title_205 = "Sword Heart",
  str_help_season4_title_206 = "Casket",
  str_help_season4_title_207 = "Stratus",
  str_help_season4_title_208 = "Dream Devourer",
  str_help_season4_title_301 = "Verdant Exchange",
  str_help_season4_title_302 = "The Wisteria Hairpin and the Ancient Copper Coin",
  str_help_season4_title_303 = "Exchange Item",
  str_help_season4_title_304 = "Expiry Conversion",
  str_help_season4_title_305 = "Authentic Dreamscapes",
  str_help_season4_title_401 = "Missions",
  str_help_season4_title_402 = "Quest",
  str_help_season4_title_501 = "Swordswoman's Memories",
  str_help_season4_title_502 = "Memories' Imprint",
  str_help_season4_title_503 = "Sonic Memory",
  str_help_season4_title_601 = "Indigo Guild",
  str_help_season4_title_602 = "Harbor and Ship Upgrade",
  str_help_season4_title_603 = "Hire Crew",
  str_help_season4_title_604 = "Crew Management",
  str_help_season4_title_605 = "Ship Status",
  str_help_season4_title_606 = "Weather Incidents and Sailing Incidents",
  str_help_season4_title_607 = "Ship Sailing and Incident Decisions",
  str_help_season4_title_608 = "Working Capital and Prosperity Level",
  str_help_season4_title_609 = "Guild Prosperity and Auspicious Energy",
  str_help_season4_title_701 = "Swordfighter of the Night",
  str_help_season4_title_702 = "Feng Shui and Force Points",
  str_help_season4_title_703 = "Formation Nodes and Knacks",
  str_help_season4_title_704 = "Equip",
  str_help_season4_title_705 = "Guild Prosperity and Auspicious Energy",
  str_help_season4_disc_101 = "The attention-catching block has been struck. Now that the spectators have all arrived, the evil-slaying legend of Areia the swordswoman is about to begin...",
  str_help_season4_disc_102 = "Guide Areia to help her conquer the Miasma within the dream. Upon settling it, you will gain access to Wisteria Hairpins and Ancient Copper Coins. These can be traded for a range of rewards at the Verdant Exchange, including the outfit Lavender Splendor.",
  str_help_season4_disc_103 = "Complete quests in Missions to get Lumamber.",
  str_help_season4_disc_104 = "Complete quests within the dream world to acquire the Stand By Me Set.",
  str_help_season4_disc_105 = "All the items gathered in the dream are methodically categorized and stored here by Areia.",
  str_help_season4_disc_201 = "The legend of the swordfighter has started, yet the Miasma is hindering Areia's advance. Assist Areia in removing the Miasma, and receive generous rewards upon your success. Note that each challenge against the Miasma will consume 1 Wit point.",
  str_help_season4_disc_202 = [[
There are two difficulty levels for the Miasma challenge: Reverie and Nightmare.
While Nightmare offers a more challenging experience, it also provides superior rewards. If you find Nightmare too overwhelming, consider trying Reverie first.
Within the same Miasma challenge, the star level achieved in Nightmare will be synchronized with Reverie. Achieving a three-star clearance reward and the 1st Clear Reward in Nightmare will also grant you corresponding rewards from Reverie.]],
  str_help_season4_disc_203 = "Visit the Stage Details to see all the Miasma information related to Sword Song Under a Canopy of Dreams, where you can also switch between Reverie and Nightmare.",
  str_help_season4_disc_204 = "The key to maintaining a sense of rationality and clarity, allowing her to challenge the Miasma in Sword Song Under a Canopy of Dreams. Wit point will replenish by 3 points each day at 05:00 (UTC+0), 00:00 (UTC-5).",
  str_help_season4_disc_205 = [[
Sword Heart can provide strong assistance along the way.
Triumph over the Miasma under Nightmare difficulty to obtain Sword-Forging Will. The item can enhance the level of Sword Heart.]],
  str_help_season4_disc_206 = "Antiques are stored in the Casket.",
  str_help_season4_disc_207 = "The Stratus blocked Areia's path. Defeat the Miasma around you to dispel the Stratus!",
  str_help_season4_disc_208 = [[
Oh, no, a swarm of Dream Devourers is nibbling away Areia's dream! If her dream crumbles, poor Irridon might never wake again... We can't let it happen!
A new swarm of Dream Devourers emerges at 05:00 daily. You'll have 5 chances to drive them away every day, with the first 2 successful expulsions offering bountiful rewards. The difficulty of expelling these Dream Devourers increases with each attempt until reset at 05:00 the following day.]],
  str_help_season4_disc_301 = "The Verdant Exchange provides a selection of rewards, among which is the outfit Lavender Splendor.",
  str_help_season4_disc_302 = "Resolve the Miasma in the dream to acquire Wisteria Hairpins and Ancient Copper Coins.",
  str_help_season4_disc_303 = "Wisteria Hairpins can be exchanged for the outfit Lavender Splendor, and Ancient Copper Coins can be exchanged for various other rewards.",
  str_help_season4_disc_304 = "After the Verdant Exchange closes, Wisteria Hairpins will be converted into Dream Shards at a 1:1 ratio, while Ancient Copper Coins will be exchanged for Nightium at a 1:30 ratio. The corresponding items will be sent directly to you via mail.",
  str_help_season4_disc_305 = "After the Verdant Exchange closes, the Lavender Splendor outfit will still be available in Authentic Dreamscapes. At that time, you can exchange Dream Shards, which are converted from Wisteria Hairpins, for the outfit.",
  str_help_season4_disc_401 = "Complete quests in Missions to get Lumamber and other rewards.",
  str_help_season4_disc_402 = "Complete the corresponding quests to get Lumamber and other rewards.",
  str_help_season4_disc_501 = "All the items gathered in the dream are methodically categorized and stored here by Areia.",
  str_help_season4_disc_502 = "Memories' Imprint documents the remarkable moments experienced in the dream and clues to acquire content that hasn't been collected.",
  str_help_season4_disc_503 = "Sonic Memory captures the snippets of melodies heard in the dream.",
  str_help_season4_disc_601 = "Twin Pavilions Bay's newest guild, Indigo Guild, has rented several harbors in the port area in anticipation of engaging in maritime trade, and it seems that the leader of this guild is an enigmatic lady and an artisan from the east. Engage in shipping activities to earn lots of Working Capital! The Auspicious Energy gained while you amass your fortune will also improve your luck and provide you with lots of help in your battles at night.",
  str_help_season4_disc_602 = "Working Capital can be used to upgrade the harbors and ships rented by guilds. After being upgraded, harbors will have more capable crew members and faster unloading speed. Larger ships can also carry a larger load of goods and earn greater profits, but a more capable crew will be required to manage everything smoothly!",
  str_help_season4_disc_603 = "The Working Capital you earn can be used to hire crew members for your ships, and each crew member has different Ability Points. Upgrade harbors to hire more crew members of higher Ability Points.",
  str_help_season4_disc_604 = "Crew members that you have hired can be assigned to any ship, but each crew member can only be working on one ship at a time.",
  str_help_season4_disc_605 = "Ship Status affects how much profit is made on each shipping voyage. If Ship Status is at 100%, you will earn working capital equivalent to the Remaining Load. The Ship Status is determined by Dispatch, Shipping Capacity, and Readiness. If any of these fail to meet the requirements, Ship Status will significantly decline. Appoint appropriate crew members and respond to Sailing Incidents wisely to increase your profit from voyages!",
  str_help_season4_disc_606 = "Weather Incidents will take place randomly at harbors and will refresh after a certain number of sailing voyages. Ships will encounter random Sailing Incidents corresponding to the Weather Incident during the voyage, so please take note of the weather before setting sail at the harbor!",
  str_help_season4_disc_607 = "Ships will encounter three Sailing Incidents during each voyage, and Navigators will need to make decisions upon three Sailing Incidents. The course of action selected will directly affect the profit earned from the voyage, so choose carefully! After a voyage is completed, the ship will need some time to unload its goods. Each ship has its own unloading time, so make reasonable sailing arrangements.",
  str_help_season4_disc_608 = "During voyages, Navigators can earn Working Capital, which can be used to hire crew members, upgrade harbors, and upgrade ships. The guild's Prosperity Level increases with the amount of Working Capital earned. Don't forget to try hard to get a higher rating to get rating rewards!",
  str_help_season4_disc_609 = "Meet the Working Capital targets to upgrade the guild's Prosperity level and get Auspicious Energy rewards with each upgrade. Auspicious Energy rewards can be used to activate and upgrade Feng Shui Knacks in the Purging Evil in the Still Night gameplay to make battles easier!",
  str_help_season4_disc_701 = "Play the role of a merchant during the day and a swordfighter during the night. To investigate smuggled stolen goods and smuggling mechanisms, the artisan and swordfighter need to overcome many obstacles and face their enemies head-on! Purging Evil in the Still Night consists of five groups of linear challenge stages, and each group of stages will be released gradually over time!",
  str_help_season4_disc_702 = "Under the cover of darkness, the Navigator's team no longer needs to move along tiles of the same color. Instead, the team will consume force points to move. The team recovers a certain number of force points at the start of each round, and the player can choose a suitable combat strategy based on how many force points they have to choose the best path and defeat enemies more efficiently!",
  str_help_season4_disc_703 = "Navigators can use the Auspicious Energy earned in the Daytime Merchant gameplay to upgrade a Five Element Feng Shui Array, which unlocks various powerful Feng Shui Formation Nodes and Knacks. Formation Nodes are the core elements of the Feng Shui array and must be activated to use the Knack inside them. The more Auspicious Energy that is used, the more Formation Nodes and Knacks that can be activated.",
  str_help_season4_disc_704 = "In addition to activating Formation Nodes, all Feng Shui Knacks can be equipped to take effect in stages and help the Navigator in battles. The number of Knacks that can be equipped will increase gradually as more Formation Nodes are activated and upgraded, up to 4 Knacks in a stage. Choose the best combination of Knacks for your team!",
  str_help_season4_disc_705 = "Meet the Working Capital targets in the Daytime Merchant gameplay to upgrade the guild's Prosperity level and get Auspicious Energy rewards. Auspicious Energy can be used to activate and upgrade Feng Shui Knacks in the Purging Evil in the Still Night gameplay to make battles easier!",
  str_help_season5_tab_1 = "A Thousand-Year Vigil",
  str_help_season5_tab_2 = "Dream",
  str_help_season5_tab_3 = "Northwind Market",
  str_help_season5_tab_4 = "Legion Council Records",
  str_help_season5_tab_5 = "Dreamland Afterimage",
  str_help_season5_tab_6 = "Dreamscape Ruins",
  str_help_season5_title_101 = "A Thousand-Year Vigil",
  str_help_season5_title_102 = "Dream",
  str_help_season5_title_103 = "Legion Council Records",
  str_help_season5_title_104 = "Stand By Me Set",
  str_help_season5_title_105 = "Dreamland Afterimage",
  str_help_season5_title_201 = "Unveil and Roam",
  str_help_season5_title_202 = "Omen",
  str_help_season5_title_203 = "Stage Details",
  str_help_season5_title_204 = "Wit",
  str_help_season5_title_205 = "Sword Soul",
  str_help_season5_title_206 = "Wooden Box",
  str_help_season5_title_301 = "Northwind Market",
  str_help_season5_title_302 = "Silver Wreath and Watcher's Coin",
  str_help_season5_title_303 = "Exchange Item",
  str_help_season5_title_304 = "Expiry Conversion",
  str_help_season5_title_305 = "Authentic Dreamscapes",
  str_help_season5_title_401 = "Legion Council Records",
  str_help_season5_title_402 = "Quest",
  str_help_season5_title_501 = "Dreamland Afterimage",
  str_help_season5_title_502 = "Memories' Imprint",
  str_help_season5_title_503 = "Sonic Memory",
  str_help_season5_title_601 = "Dreamscape Ruins",
  str_help_season5_title_602 = "Passage",
  str_help_season5_disc_101 = "Broken memories don't just vanish for no reason. Across a thousand years, those memories become even clearer under the watchful eyes...",
  str_help_season5_disc_102 = "Guide Regal to help him conquer the Omen within the dream. Upon settling it, you will gain access to Silver Wreaths and Watcher's Coins. These can be traded for a range of rewards at the Northwind Market, including the outfit Day of Triumph.",
  str_help_season5_disc_103 = "Complete quests in Legion Council Records to get Lumamber.",
  str_help_season5_disc_104 = "Complete quests within the dream world to acquire the Stand By Me Set.",
  str_help_season5_disc_105 = "All the items gathered in the dream are methodically categorized and stored here.",
  str_help_season5_disc_201 = "Unveil and Roam will be available simultaneously. Experience Regal's life in Unveil mode. Challenging Omen doesn't cost Wit, and there are no rewards for repeated challenges. In Roam mode, Omen is available for challenging at the cost of Wit, and repeated challenges grant rewards.",
  str_help_season5_disc_202 = "Across millennia, Regal still stands watch, yet the Omen is hindering his advance. Assist Regal in vanquishing the Omen, and be rewarded generously for success. Note that each challenge against the Omen in Roam mode will consume 1 Wit point.",
  str_help_season5_disc_203 = "Visit the Stage Details to see all the Omen information related to A Thousand-Year Vigil.",
  str_help_season5_disc_204 = "The key to maintaining a sense of rationality and clarity, allowing him to challenge the Omen in A Thousand-Year Vigil. Wit point will replenish each day at 05:00 (UTC+0), 00:00 (UTC-5).",
  str_help_season5_disc_205 = [[
Sword Soul can provide strong assistance along the way.
Triumph over the Omen in Roam mode to obtain Fragrant Wheat Ear, which can be used to enhance Sword Soul level.]],
  str_help_season5_disc_206 = "A worn-out wooden box that can be found everywhere, possibly containing precious treasures.",
  str_help_season5_disc_301 = "The Northwind Market provides a selection of rewards, among which is the outfit Day of Triumph.",
  str_help_season5_disc_302 = "Resolve the Omen in the dream to acquire Silver Wreaths and Watcher's Coins.",
  str_help_season5_disc_303 = "Silver Wreaths can be exchanged for the outfit Day of Triumph, and Watcher's Coins can be exchanged for various other rewards.",
  str_help_season5_disc_304 = "After the Northwind Market closes, Silver Wreaths will be converted into Dream Shards at a 1:1 ratio, while Watcher's Coins will be exchanged for Nightium at a 1:30 ratio. The corresponding items will be sent directly to you via mail.",
  str_help_season5_disc_305 = "After the Northwind Market closes, the Day of Triumph outfit will still be available in Authentic Dreamscapes. At that time, you can exchange Dream Shards, which are converted from Silver Wreaths, for the outfit.",
  str_help_season5_disc_401 = "Complete quests in Legion Council Records to get Lumamber and other rewards.",
  str_help_season5_disc_402 = "Complete the corresponding quests to get Lumamber and other rewards.",
  str_help_season5_disc_501 = "All the items gathered in the dream are methodically categorized and stored here.",
  str_help_season5_disc_502 = "Memories' Imprint documents the remarkable moments experienced in the dream and clues to acquire content that hasn't been collected.",
  str_help_season5_disc_503 = "Sonic Memory captures the snippets of melodies heard in the dream.",
  str_help_season5_disc_601 = "So this is where the Dream Devourer infiltrates dreams to wreak havoc? When the time is right, the Dreamscape Ruins will open its gates. Tap on the Dreamscape Ruins then, and venture forth to eliminate it!",
  str_help_season5_disc_602 = "Each passage offers unique scenery and challenges. Choose a passage to progress! New passages will open every once in a while!"
}
return config
