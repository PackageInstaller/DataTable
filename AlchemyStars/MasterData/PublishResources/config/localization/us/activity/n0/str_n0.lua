local config = {
  str_n0_activity_end = "Event ended",
  str_n0_day = "{1}d",
  str_n0_hour = "{1}h",
  str_n0_minus = "{1} min",
  str_n0_less_one_minus = "<1 min",
  str_n0_activity_remain_time = "Event Ends In: {1}",
  str_n0_activity_normal_level_remain_time = "Event Remaining Time: {1}",
  str_n0_activity_hard_level_remain_time = "Event Remaining Time: {1}",
  str_n0_activity_hard_level_lock_mission_tips = "Clear The Homecoming first",
  str_n0_activity_hard_level_lock_time_tips = "Unlock time: {1}",
  str_n0_activity_minigame_remain_time = "Event Remaining Time: {1}",
  str_n0_activity_minigame_lock_time_tips = "Unlock time: {1}",
  str_n0_activity_movie_remain_time = "Event Remaining Time: {1}",
  str_n0_shop_close_time_tips = "Event Remaining Time: {1}",
  str_n0_shop_item_title = "Lin Guild Promissory Note",
  str_n0_shop_item_des = "A check from the Lin Guild. Can be cashed in for items at The Docks, according to the amount stated above.",
  str_n0_shop_pet_name = "Liqing",
  str_n0_shop_pet_des1 = "What's the hold-up? Don't tell me you haven't decided yet!",
  str_n0_shop_pet_des2 = "Why the hesitation? Everything here is worth buying!",
  str_n0_shop_pet_des3 = "Don't miss out or you'll be sorry!",
  str_n0_shop_pet_des4 = "There's really nothing you're interested in?",
  str_n0_shop_pet_des5 = "Be careful... This place will empty your pockets before you know it.",
  str_n0_item_unlimit_count = "Not limited",
  str_n0_item_empty_title = "Sold Out",
  str_n0_item_has_empty_tips = "The selected product is sold out. Try buying something else.",
  str_n0_item_remain_title = "Remaining",
  str_n0_main_entry_tips1 = "New: The Docks",
  str_n0_main_entry_tips2 = "New: Lost Ship At Sea",
  str_n0_hard_remain_time_title = "Challenge Time Remaining",
  str_n0_hard_level_btn01 = "Capsized",
  str_n0_hard_level_btn02 = "Shipwrecked",
  str_n0_activity_hadchall = "Cleared",
  str_n0_cook_title = "Collect delicious foods!",
  str_n0_cook_btn_receive = "Claim",
  str_n0_cook_has_mat = "Ingredients Owned: {1}",
  str_n0_cook_use_mat = "Required Ingredients: {1}/{2}",
  str_n0_cook_name_desc = "Cooking Memory",
  str_n0_cook_reward_tip = "Claim Rewards",
  str_n0_cook_btn_unreach = "Not Completed",
  str_n0_cook_mat_limit = "Ingredient limit reached!",
  str_n0_cook_mat_empty = "Insufficient Ingredient Packs! Cannot continue adding!",
  str_n0_login_btn = "Berth Sign-In",
  str_n0_h1_name = "H1 - Rhythm",
  str_n0_h2_name = "H2 - The Reef",
  str_n0_h3_name = "H3 - The Tide",
  str_n0_h4_name = "H4 - Glory's Shield",
  str_n0_h5_name = "H5 - The Wounded",
  str_n0_h6_name = "H6 - The Fear",
  str_n0_h7_name = "EX1 - Safer Inside",
  str_n0_h8_name = "EX2 - Flee",
  str_n0_h9_name = "EX3 - Mania",
  str_n0_h10_name = "EX4 - Hubris",
  str_n0_h11_name = "EX5 - Subjugation",
  str_n0_h12_name = "EX6 - Collapse",
  str_n0_h1_name_desc = "Sometimes, just the rhythm of the waves is enough to change the situation on the battlefield.",
  str_n0_h2_name_desc = "In naval battles, reefs are like traps that can be used by either side to claim victory. During land battles, mechanical contraptions serve the same purpose.",
  str_n0_h3_name_desc = "Hearing that voice, seeing that figure... You know that you are not alone.",
  str_n0_h4_name_desc = "To guard glory is to guard hope. No matter what the future holds, this is an undeniable truth.",
  str_n0_h5_name_desc = "Although the enemy will face repercussions for their actions, this also means the battle is about to become a lot more difficult.",
  str_n0_h6_name_desc = "Don't be intimidated by the number of enemies. The best way to eliminate fear is to face it head-on.",
  str_n0_h7_name_desc = "When more and more enemies appear, forming a sea of enemies, perhaps the path to victory lies in shrinking your defensive line and concentrating your power on a united resistance.",
  str_n0_h8_name_desc = "It is almost as though your enemy has the power to win at any time, but they would rather toy with you than end the battle too soon...",
  str_n0_h9_name_desc = "Whenever an enemy is seriously injured, you can be sure that their counterattack will be even more frenzied than before.",
  str_n0_h10_name_desc = "When the enemy is in danger, they will call on their allies for reinforcement. Eliminating them quickly is the only way to claim victory.",
  str_n0_h11_name_desc = "Be prepared to deal with various situations on the battlefield and suppress the enemy to the bitter end. Unfortunately, the enemy will do exactly the same.",
  str_n0_h12_name_desc = "When the earth is shattered and there is nowhere to run, how can we find a chance to emerge triumphant?",
  str_n0_1_name = "ST1 - Setting Sail",
  str_n0_2_name = "N1 - The Lin Family",
  str_n0_3_name = "N2 - Storm",
  str_n0_4_name = "N3 - Signs",
  str_n0_5_name = "N4 - Rattled",
  str_n0_6_name = "N5 - Mouse Tail",
  str_n0_7_name = "N6 - Monkey Head",
  str_n0_8_name = "ST2 - Rabbit Ears",
  str_n0_9_name = "N7 - Attrition",
  str_n0_10_name = "N8 - Hunger",
  str_n0_11_name = "N9 - Lost Ship",
  str_n0_12_name = "N10 - Aboard",
  str_n0_13_name = "N11 - The Compass",
  str_n0_14_name = "N12 - Last Stand",
  str_n0_15_name = "ST3 - Landfall",
  str_n0_1_name_desc = "/",
  str_n0_2_name_desc = "As Zhong Xu, an old friend of the Lin family, tells you more, you gradually piece together a more concrete impression of the Lin family in your mind.",
  str_n0_3_name_desc = "A storm sweeps over, and you decide to go to the deck to help Yuebai and Liqing. Amid the chaos, you sense unusual creatures in the sea...",
  str_n0_4_name_desc = "The Shadowind is badly damaged and can barely continue sailing. In this dire situation, it seems that you can only pray that the heavens are benevolent...",
  str_n0_5_name_desc = "Looking for the lost Compass in the depths and hunting for the required parts in the wreckage is like trying to fish a needle from the ocean... Can you really succeed?",
  str_n0_6_name_desc = "Animals sometimes have keener instincts than Aurorians and can find things that cannot easily be seen with the naked eye.",
  str_n0_7_name_desc = "Animals sometimes know more about cooperation than Aurorians, and can accurately convey information to their trusted friends.",
  str_n0_8_name_desc = "/",
  str_n0_9_name_desc = "You must persist, whether or not you can achieve results.",
  str_n0_10_name_desc = "Fear of hunger is a primal instinct. Everyone must do what they can do alleviate their unease.",
  str_n0_11_name_desc = "You must take a risk to see if there really is hope somewhere in the vast ocean.",
  str_n0_12_name_desc = "This is not the Shadowind you are familiar with. What is this place, exactly?",
  str_n0_13_name_desc = "The Compass is right there. You can almost touch it.",
  str_n0_14_name_desc = "Animals sometimes hold deeper grudges than Aurorians. All that they suffer will be returned tenfold.",
  str_n0_15_name_desc = "/",
  str_n0_1_name_desc_long = "Twin Pavilions Bay is alive with the atmosphere of the Spring Festival, a traditional festival from Longzhou. You and the other passengers from the Shadowind have been here for a while and are finally preparing for your departure. However, at the moment the Shadowind is about to set sail, Tweety finds you again and hands you a letter to be sent across the ocean. At Tweety's request, you decide to go to the continent of Longzhou on her behalf, embarking on the Shadowind.",
  str_n0_2_name_desc_long = "Zhong Xu and Liqing, your new acquaintances from Twin Pavilions Bay, seem to have some connection with the ship you are on. At the dinner table, Zhong Xu tells of his experience drifting to Astra half a year ago when he and Liqing met with misfortune aboard the Shadowind. As a result of that incident, not only was the Lin Guildmaster seriously injured, the Lin family's proud navigation device, The Compass, sank into the sea with the old ship.",
  str_n0_3_name_desc_long = "Sudden turbulence awakens each guest one by one as they rest in the cabin. A storm has struck. Wind, thunder, and rain clamor all around you. Instead of following the rescue team, you head to the deck. Yuebai is leading the crew to stabilize the ship as Liqing shrinks to one side in fear. When you use your psychic ability to find your companions, a school of serpentfish begins to frantically ram the Shadowind.",
  str_n0_4_name_desc_long = "After a night spent in a fierce fight between life and death, the Shadowind becomes riddled with holes, and all of its important hull sections are lost. Fortunately, you and your companions are still alive, but the situation is dire. Supplies will soon run out—you must find a way to sail once again. Li Tianxian, known to all as a charlatan, provides three divinations for the Shadowind, which gives Yuebai inspiration.",
  str_n0_5_name_desc_long = "With Zhong Xu's experience aboard a sinking ship, you decide to bet everything on relaunching the Shadowind and begin searching for the parts you need. The sails have been damaged, so it can only be rowed manually with oars. If it sets sail slowly in sunny weather, you may still have a chance to change your fate. The people on board are shaken, but Yuebai is very firm about what must be done. If she were to show any fear, no one would believe a single trace of hope existed.",
  str_n0_6_name_desc_long = "Everyone sets out one after another and decides to look for the missing wind vane—the mouse tail—aboard the huge Shadowind. Dantang also wishes to do something to help save the Shadowind, but she doesn't know anything about the mouse tail. Tianxian appears with his two talking birds. They circle in the sky above and find the mouse tail with ease.",
  str_n0_7_name_desc_long = "Liqing insists on taking the lifeboat out to sea alone to salvage a pulley nicknamed the \"monkey head,\" but he hesitates due to his innate fear of water. Out of concern, you take a lifeboat and float on the calm sea with him. Liqing clearly knows where the two of you are going, and you successfully fish the monkey head up from a shipwreck. He tells you it was all thanks to his \"friend in the sea.\"",
  str_n0_8_name_desc_long = "In order to repair the Shadowind, you begin attempting to salvage special parts from sunken ships—the rabbit ears. They're used to cover the leaks at the bottom of the ship, successfully relieving the pressure on the Shadowind. So far, the repair work has been largely completed. The sailors gather to celebrate, and everyone begins to believe that the rest of the voyage will be a success.",
  str_n0_9_name_desc_long = "As time goes by, the optimism of the sailors gradually fades. More and more practical problems begin to arise. With insufficient materials, crew members become sick, and now, another storm blocks the way.",
  str_n0_10_name_desc_long = "Food supplies run low, and the sailors have no choice but to spend more time fishing. Unexpectedly, a serpentfish is caught by accident, an incident which almost capsizes the ship. Liqing hurriedly tells the crew to release the serpentfish, avoiding a huge disaster. However, Zhong Xu sees something else. He finds the captain alone and announces that The Compass is just ahead.",
  str_n0_11_name_desc_long = "You see the wreckage of the old Shadowind from the deck. Yuebai immediately jumps into the water, and you and Liqing follow closely behind by boat. But then a sudden fog descends over the sea, and nothing can be seen amid the vast blanket of white. Yuebai joins you and tells you that she found a lost ship at the bottom of the ocean. As you drift, a huge ship appears in front of you.",
  str_n0_12_name_desc_long = "You board the huge ship in the fog, only to find no one aboard it. It doesn't appear to be the Shadowind... But Liqing alone recognizes it. It is the old Shadowind. Excitedly, he takes you to look for The Compass. Meanwhile, on the current Shadowind, Zhong Xu tells everyone about the old Shadowind's last moments. As he's telling his story, a sudden noise fills the air - they've got company.",
  str_n0_13_name_desc_long = "As you search for The Compass in the cabin of the old Shadowind, someone suddenly locks you inside the room. Liqing exclaims that the culprit is actually The Compass—he was originally a serpentfish, but has now turned into a fiendling with phenomenal power. If you don't catch him soon, all of your efforts will have been in vain.",
  str_n0_14_name_desc_long = "Zhong Xu leads the others to board the old ship and encounters The Compass—now a living fiendling. He is filled with resentment toward all Aurorians and the ship that imprisoned him. He tries to send you all to the bottom of the ocean. After a fierce battle, you defeat him, but his hatred makes everyone rethink their decisions. Yuebai releases him into the sea to right past wrongs. The Shadowind begins the last leg of its voyage, and you set off for Longzhou. Suddenly, the serpentfish emerge from the sea and carry the giant ship on their backs.",
  str_n0_15_name_desc_long = "The Shadowind finally docks successfully, and your misadventure finally ends. You spend the Spring Festival with the Lin family. The letter you brought is peculiar, but your mission is complete. A few days later, Yuebai invites you to see the Shadowind to witness its return to glory. You sign your name on the ship—the Shadowind will carry it back and forth between Longzhou and Astra, forever etching your name in the sea.",
  str_n0_food_name_1 = "Steamed Fish",
  str_n0_food_name_2 = "Sesame Balls",
  str_n0_food_name_3 = "Braised Pork",
  str_n0_food_name_4 = "Shrimplings",
  str_n0_food_name_5 = "Spring Rolls",
  str_n0_food_name_6 = "Sixi Meatballs",
  str_n0_food_name_7 = "Mixed Rice",
  str_n0_food_name_8 = "Tomato Pizza",
  str_n0_food_name_9 = "Steamed Egg",
  str_n0_food_name_10 = "Nuggets",
  str_n0_food_name_11 = "Sizzling Pot",
  str_n0_food_name_12 = "Seared Steak",
  str_n0_food_name_13 = "Udon",
  str_n0_food_name_14 = "Fried Rice",
  str_n0_food_desc_1 = "Fish marinated in ginger and cooking wine, then steamed in a pot. Soy sauce is added over it for just the right amount of umami flavoring.",
  str_n0_food_desc_2 = "A simple, delicious dessert made of glutinous rice and stuffed with black sesame. Suitable for the young and old alike.",
  str_n0_food_desc_3 = "Cubed pork cooked in soy sauce or sugar until perfectly browned. Fatty, yet not nauseating.",
  str_n0_food_desc_4 = "Dumplings stuffed with shrimp, boiled in water, then placed in a steamer. Springy and sumptuous, each bite is filled with flavor.",
  str_n0_food_desc_5 = "Spring rolls fried until golden and crisp, made with shredded meat, cabbage, bean curds, and more. A crunchy treat with complex flavors.",
  str_n0_food_desc_6 = "Pork and seafood meatballs fried first, then stewed. The sauce has a vivid color, aroma, and taste.",
  str_n0_food_desc_7 = "Rice and assorted ingredients cooked in a pot until a layer of crispy rice forms at the bottom. The smell is rich and irresistible.",
  str_n0_food_desc_8 = "A flour base topped with tomatoes, mushrooms, and more baked to perfection. Suitable for sharing.",
  str_n0_food_desc_9 = "Eggs beaten and steamed in a pot, then seasoned with soy sauce with scallion for garnish. Although simple, it is a very popular Longzhou dish.",
  str_n0_food_desc_10 = "Diced chicken coated in batter and fried until crispy golden on the outside, tender on the inside.",
  str_n0_food_desc_11 = "Beef grilled in an iron pot, seasoned with sweet soy sauce. Complemented by mushrooms, carrots, tofu, and other side dishes.",
  str_n0_food_desc_12 = "Center-cut steak, fried in an iron pan with butter until both sides are brown, served with black pepper sauce.",
  str_n0_food_desc_13 = "Thick noodles made from flour, salt, and water. Usually cooked in a broth.",
  str_n0_food_desc_14 = "Rice coated with eggs, stir fried until golden. Can include mushrooms, peas, carrots, shrimp, and more for a rich flavor.",
  str_n0_food_tishi_1 = [[
The <color=#b74b25>Flour</color> and <color=#b74b25>Seasoning</color> portion ratio should be 2:1.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_2 = [[
The number of <color=#b74b25>Vegetable</color> and <color=#b74b25>Seasoning</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_3 = [[
The number of<color=#b74b25>Vegetable</color> and <color=#b74b25>Seasoning</color> portions should be equal.
The number of <color=#b74b25>Seafood</color> portions should be less than the sum of the other two ingredients.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_4 = [[
The number of <color=#b74b25>Meat</color> portions should be twice the number of <color=#b74b25>Seasoning</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_5 = [[
The number of <color=#b74b25>Flour</color> portions should be greater than the sum of the other two ingredients.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_6 = [[
The number of <color=#b74b25>Flour</color> portions should be greater than the sum of the other two ingredients.
The number of <color=#b74b25>Seafood</color> and <color=#b74b25>Vegetable</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_7 = [[
The number of <color=#b74b25>Vegetable</color> and <color=#b74b25>Meat</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_8 = [[
The number of <color=#b74b25>Vegetable</color> and <color=#b74b25>Meat</color> portions should be equal.
The number of <color=#b74b25>Flour</color> portions should be twice the number of <color=#b74b25>Vegetable</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_9 = [[
The number of <color=#b74b25>Meat</color> portions should be greater than the sum of the other three ingredients.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_10 = [[
The number of <color=#b74b25>Meat</color> portions should be greater than the sum of the other three ingredients.
The number of <color=#b74b25>Egg</color> and <color=#b74b25>Seasoning</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_11 = [[
The number of <color=#b74b25>Rice</color> portions should be equal to the sum of the other three ingredients, and the smallest portion should be the <color=#b74b25>Eggs</color>.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_12 = [[
The number of <color=#b74b25>Rice</color> portions should be equal to the sum of the other three ingredients, and the smallest portion should be the <color=#b74b25>Eggs</color>.
The number of <color=#b74b25>Vegetable</color> and <color=#b74b25>Meat</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_13 = [[
There should be one more <color=#b74b25>Vegetable</color> portion than there are <color=#b74b25>Meat</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_14 = [[
There should be one more <color=#b74b25>Vegetable</color> portion than there are <color=#b74b25>Meat</color> portions.
The number of <color=#b74b25>Flour</color> portions should be less than the sum of the other two ingredients.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_15 = [[
The number of <color=#b74b25>Egg</color> and <color=#b74b25>Flour</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_16 = [[
The number of <color=#b74b25>Egg</color> and <color=#b74b25>Flour</color> portions should be equal.
The number of <color=#b74b25>Egg</color> portions should be greater than the number of <color=#b74b25>Seasoning</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_17 = [[
The number of <color=#b74b25>Flour</color> portion should be the sum of the <color=#b74b25>Egg</color> and <color=#b74b25>Seasoning</color> portions, and the largest portion should be the <color=#b74b25>Meat</color>.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_18 = [[
The number of <color=#b74b25>Flour</color> portion should be the sum of the <color=#b74b25>Egg</color> and <color=#b74b25>Seasoning</color> portions, and the largest portion should be the <color=#b74b25>Meat</color>.
The number of <color=#b74b25>Egg</color> and <color=#b74b25>Seasoning</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_19 = [[
There should be one more <color=#b74b25>Vegetable</color> portion than there are <color=#b74b25>Seasoning</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_20 = [[
The number of <color=#b74b25>Meat</color> portions should be greater than the sum of the other three ingredients.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_21 = [[
The number of <color=#b74b25>Meat</color> portions should be greater than the sum of the other three ingredients.
The number of <color=#b74b25>Vegetable</color>, <color=#b74b25>Egg</color>, and <color=#b74b25>Seasoning</color> portions should be equal.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_22 = [[
The number of <color=#b74b25>Flour</color> portions should be greater than the sum of the other two ingredients.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_23 = [[
The number of <color=#b74b25>Flour</color> portions should be greater than the sum of the other two ingredients.
The number of <color=#b74b25>Vegetable</color> portions should be twice the number of <color=#b74b25>Seasoning</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_24 = [[
The number of <color=#b74b25>Rice</color> portions should be twice the number of <color=#b74b25>Vegetable</color> portions.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_tishi_25 = [[
The number of <color=#b74b25>Rice</color> portions should be twice the number of <color=#b74b25>Vegetable</color> portions.
The number of <color=#b74b25>Vegetable</color> and <color=#b74b25>Egg</color> portions should be equal, and the largest portion should be the <color=#b74b25>Rice</color>.
<color=#b74b25>At least 1 portion of each ingredient must be added.</color>]],
  str_n0_food_taskdesc_1 = "Log in for 1 day during the event period",
  str_n0_food_taskdesc_2 = "Log in for 2 days during the event period",
  str_n0_food_taskdesc_3 = "Log in for 3 days during the event period",
  str_n0_food_taskdesc_4 = "Log in for 4 days during the event period",
  str_n0_food_taskdesc_5 = "Log in for 5 days during the event period",
  str_n0_food_taskdesc_6 = "Log in for 6 days during the event period",
  str_n0_food_taskdesc_7 = "Log in for 7 days during the event period",
  str_n0_food_taskdesc_8 = "Spend a total of 100 Prism during the event period",
  str_n0_food_taskdesc_9 = "Spend a total of 250 Prism during the event period",
  str_n0_food_taskdesc_10 = "Spend a total of 400 Prism during the event period",
  str_n0_food_taskdesc_11 = "Spend a total of 550 Prism during the event period",
  str_n0_food_taskdesc_12 = "Spend a total of 700 Prism during the event period",
  str_n0_food_taskdesc_13 = "Spend a total of 850 Prism during the event period",
  str_n0_food_taskdesc_14 = "Spend a total of 1,000 Prism during the event period",
  str_n0_food_taskdesc_15 = "Complete a total of 5 Colossus Dispatches during the event period",
  str_n0_food_taskdesc_16 = "Complete a total of 10 Colossus Dispatches during the event period",
  str_n0_food_taskdesc_17 = "Complete a total of 15 Colossus Dispatches during the event period",
  str_n0_food_taskdesc_18 = "Complete a total of 20 Colossus Dispatches during the event period",
  str_n0_food_taskdesc_19 = "Complete a total of 25 Colossus Dispatches during the event period",
  str_n0_food_taskdesc_20 = "Complete a total of 30 Colossus Dispatches during the event period",
  str_n0_food_taskdesc_21 = "Complete a total of 35 Colossus Dispatches during the event period",
  str_n0_foodbook_award = "Completion Reward",
  str_n0_foodbook_make = "Cook",
  str_n0_foodbook_unlock = "Unlocked: ",
  str_n0_foodbook_lockTxt = "Locked",
  str_n0_foodbook_isGet = "Completed",
  str_n0_foodbook_remainTime = "Time Remaining: {1}",
  str_n0_require_unFinished = "Not Completed",
  str_n0_require_unGot = "Claim",
  str_n0_cook_new = "NEW",
  str_n0_cook_make_mat_err = "You haven't added enough ingredients. Cooking cannot commence yet.",
  str_n0_require_received = "Claimed",
  str_n0_foodbook_remainTime_End = "Please reopen the menu.",
  str_n0_food_false_tishi = "You've added too much <color=#b74b25>{1}</color>. Adjust the recipe and try again!",
  str_n0_mat_name_01 = "Eggs",
  str_n0_mat_name_02 = "Flour",
  str_n0_mat_name_03 = "Rice",
  str_n0_mat_name_04 = "Seafood",
  str_n0_mat_name_05 = "Seasoning",
  str_n0_mat_name_06 = "Vegetables",
  str_n0_mat_name_07 = "Meat",
  str_n0_activity_intro_title = "Etched Upon the Ocean Event Details",
  str_n0_activity_intro_head_1 = "Obtaining Lin Guild Promissory Notes",
  str_n0_activity_intro_body_1 = [[
1. During the event period, Lin Guild Promissory Notes can be obtained when completing The Homecoming stages for the first time or Main Story and Resource Raid stages that require Prism. Lin Guild Promissory Notes will not be available after the event ends.
2. During the event, you can use Lin Guild Promissory Notes to purchase the items you want in The Docks event store.
3. The Docks will be available for 3 additional days after the event ends, so use up all your Lin Guild Promissory Notes before then. After The Docks ends, unused Lin Guild Promissory Notes will be converted to Nightium at the rate of 1:15.]],
  str_n0_activity_intro_head_2 = "Lost Ship At Sea Gameplay Details",
  str_n0_activity_intro_body_2 = [[
1. During the event period, complete The Homecoming stages first and wait for high-difficulty mode Lost Ship At Sea to unlock to access it.
2. Lost Ship At Sea mode has two difficulties. After clearing Capsized, you'll unlock Shipwrecked.]],
  str_n0_activity_intro_head_3 = "Cooking Frenzy and Lights, Camera, Action: Season 2 Gameplay Details",
  str_n0_activity_intro_body_3 = "1. During the event period, the new Cooking Frenzy mode and the exclusive Cloud Gardens gameplay—Lights, Camera, Action: Season 2—will be available. Navigate to each gameplay mode to explore the new content!\n2. View the corresponding gameplay information page for more details.",
  str_n0_movie_title_second = "Lights, Camera, Action! Season 2",
  str_n0_story_lookback = "Recap",
  str_n0_intro_title = "Cooking Frenzy Event Details",
  str_n0_intro_head_1 = "Obtaining Ingredient Packs",
  str_n0_intro_body_1 = [[
1. During the event period, you can complete Get Ingredients quests to obtain the corresponding quantity of Ingredient Packs.
2. After the event ends, any unused Ingredient Packs will be converted into Nightium at a ratio of 1:1,000.]],
  str_n0_intro_head_2 = "Gourmet Prep Gameplay Details",
  str_n0_intro_body_2 = [[
1. During the event period, 2 dish entries will unlock every day. You'll be able to use Ingredient Packs to prepare them. Obtain corresponding rewards when successfully preparing the dishes.
2. When cooking each kind of dish, you'll need to add different quantities of various ingredients according to the prompts. After successfully cooking the dish, the corresponding quantity of Ingredient Packs will be consumed and you'll receive rewards.
3. After successfully making each type of dish, you won't be able to make it again. If you fail to make the dish, your Ingredient Packs will not be consumed.
4. Earn rewards for successfully cooking a specified number of dishes.]]
}
return config
