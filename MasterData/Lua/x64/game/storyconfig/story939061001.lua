return {
	Play939061001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939061001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939061002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.STblack == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_4_0.name = "STblack"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.STblack = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.STblack

				arg_1_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "STblack" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 2

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= var_4_4 + 0.3 and arg_1_1.time_ < var_4_4 + 0.3 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_5 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_5 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_6 = 2

			if var_4_5 <= arg_1_1.time_ and arg_1_1.time_ < var_4_5 + var_4_6 then
				local var_4_7 = Color.New(0, 0, 0)

				var_4_7.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_5) / var_4_6)
				arg_1_1.mask_.color = var_4_7
			end

			if arg_1_1.time_ >= var_4_5 + var_4_6 and arg_1_1.time_ < var_4_5 + var_4_6 + arg_4_0 then
				local var_4_8 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_8.a = 0
				arg_1_1.mask_.color = var_4_8
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story.awb")

				local var_4_11 = manager.audio:GetAudioName("bgm_activity_5_0_ui_minigame_wuchang_story", "bgm_activity_5_0_ui_minigame_wuchang_story")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_11 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_11

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_11
						arg_1_1.bgmTxt2_.text = var_4_11
					end

					if arg_1_1.bgmTimer then
						arg_1_1.bgmTimer:Stop()

						arg_1_1.bgmTimer = nil
					end

					if arg_1_1.settingData.show_music_name == 1 then
						arg_1_1.musicController:SetSelectedState("show")
						arg_1_1.musicAnimator_:Play("open", 0, 0)

						if arg_1_1.settingData.music_time ~= 0 then
							arg_1_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_1_1.settingData.music_time), function()
								if arg_1_1 == nil or isNil(arg_1_1.bgmTxt_) then
									return
								end

								arg_1_1.musicController:SetSelectedState("hide")
								arg_1_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.marker = "21321112121"
				arg_1_1.actionList["1"] = arg_1_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_1_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_1_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 106,
					enterClipName = "",
					completeShowStoryUI = true,
					isNeedInteraction = true,
					uiBtnName = "bgBtn_",
					enterHideStoryUI = true,
					completeClipName = "",
					enterController = {},
					completeController = {}
				})
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939061002 = function(arg_6_0, arg_6_1)
		arg_6_1.time_ = 0
		arg_6_1.frameCnt_ = 0
		arg_6_1.state_ = "playing"
		arg_6_1.curTalkId_ = 939061002
		arg_6_1.duration_ = 9

		SetActive(arg_6_1.tipsGo_, false)

		function arg_6_1.onSingleLineFinish_()
			arg_6_1.onSingleLineUpdate_ = nil
			arg_6_1.onSingleLineFinish_ = nil
			arg_6_1.state_ = "waiting"
		end

		function arg_6_1.playNext_(arg_8_0)
			if arg_8_0 == 1 then
				arg_6_0:Play939061003(arg_6_1)
			end
		end

		function arg_6_1.onSingleLineUpdate_(arg_9_0)
			if arg_6_1.bgs_.ST12 == nil then
				local var_9_0 = Object.Instantiate(arg_6_1.paintGo_)

				var_9_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_9_0.name = "ST12"
				var_9_0.transform.parent = arg_6_1.stage_.transform
				var_9_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.bgs_.ST12 = var_9_0
			end

			if 2.00000000298023 < arg_6_1.time_ and arg_6_1.time_ <= 2.00000000298023 + arg_9_0 then
				local var_9_1 = arg_6_1.bgs_.ST12

				arg_6_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_9_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_9_2 = var_9_1:GetComponent("SpriteRenderer")

				if var_9_2 and var_9_2.sprite then
					local var_9_3 = 2 * (var_9_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_9_1.transform.localScale = Vector3.New(var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, var_9_3 / var_9_2.sprite.bounds.size.y < var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x and var_9_3 * manager.ui.mainCameraCom_.aspect / var_9_2.sprite.bounds.size.x or var_9_3 / var_9_2.sprite.bounds.size.y, 0)
				end

				for iter_9_0, iter_9_1 in pairs(arg_6_1.bgs_) do
					if iter_9_0 ~= "ST12" then
						iter_9_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_9_4 = 4.00000000298023

			if 4.00000000298023 < arg_6_1.time_ and arg_6_1.time_ <= var_9_4 + arg_9_0 then
				arg_6_1.allBtn_.enabled = false
			end

			if arg_6_1.time_ >= var_9_4 + 0.3 and arg_6_1.time_ < var_9_4 + 0.3 + arg_9_0 then
				arg_6_1.allBtn_.enabled = true
			end

			local var_9_5 = 0

			if 0 < arg_6_1.time_ and arg_6_1.time_ <= var_9_5 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_6 = 2

			if var_9_5 <= arg_6_1.time_ and arg_6_1.time_ < var_9_5 + var_9_6 then
				local var_9_7 = Color.New(0, 0, 0)

				var_9_7.a = Mathf.Lerp(0, 1, (arg_6_1.time_ - var_9_5) / var_9_6)
				arg_6_1.mask_.color = var_9_7
			end

			if arg_6_1.time_ >= var_9_5 + var_9_6 and arg_6_1.time_ < var_9_5 + var_9_6 + arg_9_0 then
				local var_9_8 = Color.New(0, 0, 0)

				var_9_8.a = 1
				arg_6_1.mask_.color = var_9_8
			end

			local var_9_9 = 2

			if 2 < arg_6_1.time_ and arg_6_1.time_ <= var_9_9 + arg_9_0 then
				arg_6_1.mask_.enabled = true
				arg_6_1.mask_.raycastTarget = true

				arg_6_1:SetGaussion(false)
			end

			local var_9_10 = 2

			if var_9_9 <= arg_6_1.time_ and arg_6_1.time_ < var_9_9 + var_9_10 then
				local var_9_11 = Color.New(0, 0, 0)

				var_9_11.a = Mathf.Lerp(1, 0, (arg_6_1.time_ - var_9_9) / var_9_10)
				arg_6_1.mask_.color = var_9_11
			end

			if arg_6_1.time_ >= var_9_9 + var_9_10 and arg_6_1.time_ < var_9_9 + var_9_10 + arg_9_0 then
				local var_9_12 = Color.New(0, 0, 0)

				arg_6_1.mask_.enabled = false
				var_9_12.a = 0
				arg_6_1.mask_.color = var_9_12
			end

			local var_9_13 = "1248ui_story"

			if arg_6_1.actors_["1248ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1248ui_story"))) then
				local var_9_14 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_6_1.stage_.transform)

				var_9_14.name = var_9_13
				var_9_14.transform.localPosition = Vector3.New(0, 100, 0)
				arg_6_1.actors_[var_9_13] = var_9_14

				local var_9_15 = var_9_14:GetComponentInChildren(typeof(CharacterEffect))

				var_9_15.enabled = true

				local var_9_16 = GameObjectTools.GetOrAddComponent(var_9_14, typeof(DynamicBoneHelper))

				if var_9_16 then
					var_9_16:EnableDynamicBone(false)
				end

				arg_6_1:ShowWeapon(var_9_15.transform, false)

				arg_6_1.var_[var_9_13 .. "Animator"] = var_9_15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_6_1.var_[var_9_13 .. "Animator"].applyRootMotion = true
				arg_6_1.var_[var_9_13 .. "LipSync"] = var_9_15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_9_17 = arg_6_1.actors_["1248ui_story"].transform

			if 3.8 < arg_6_1.time_ and arg_6_1.time_ <= 3.8 + arg_9_0 then
				arg_6_1.var_.moveOldPos1248ui_story = var_9_17.localPosition
			end

			local var_9_18 = 0.001

			if 3.8 <= arg_6_1.time_ and arg_6_1.time_ < 3.8 + var_9_18 then
				var_9_17.localPosition = Vector3.Lerp(arg_6_1.var_.moveOldPos1248ui_story, Vector3.New(0, -0.775, -6.18), (arg_6_1.time_ - 3.8) / var_9_18)
				var_9_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_17.position).x, (manager.ui.mainCamera.transform.position - var_9_17.position).y, (manager.ui.mainCamera.transform.position - var_9_17.position).z)
				var_9_17.localEulerAngles.z = 0
				var_9_17.localEulerAngles.x = 0
				var_9_17.localEulerAngles = var_9_17.localEulerAngles
			end

			if arg_6_1.time_ >= 3.8 + var_9_18 and arg_6_1.time_ < 3.8 + var_9_18 + arg_9_0 then
				var_9_17.localPosition = Vector3.New(0, -0.775, -6.18)
				var_9_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_9_17.position).x, (manager.ui.mainCamera.transform.position - var_9_17.position).y, (manager.ui.mainCamera.transform.position - var_9_17.position).z)
				var_9_17.localEulerAngles.z = 0
				var_9_17.localEulerAngles.x = 0
				var_9_17.localEulerAngles = var_9_17.localEulerAngles
			end

			local var_9_19 = arg_6_1.actors_["1248ui_story"]

			if 3.8 < arg_6_1.time_ and arg_6_1.time_ <= 3.8 + arg_9_0 and not isNil(var_9_19) and arg_6_1.var_.characterEffect1248ui_story == nil then
				arg_6_1.var_.characterEffect1248ui_story = var_9_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_9_20 = 0.200000002980232

			if 3.8 <= arg_6_1.time_ and arg_6_1.time_ < 3.8 + var_9_20 and not isNil(var_9_19) then
				if arg_6_1.var_.characterEffect1248ui_story and not isNil(var_9_19) then
					arg_6_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_6_1.time_ >= 3.8 + var_9_20 and arg_6_1.time_ < 3.8 + var_9_20 + arg_9_0 and not isNil(var_9_19) and arg_6_1.var_.characterEffect1248ui_story then
				arg_6_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			if 3.8 < arg_6_1.time_ and arg_6_1.time_ <= 3.8 + arg_9_0 then
				arg_6_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action1_1")
			end

			if 3.8 < arg_6_1.time_ and arg_6_1.time_ <= 3.8 + arg_9_0 then
				arg_6_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_haixiuA", "EmotionTimelineAnimator")
			end

			if arg_6_1.frameCnt_ <= 1 then
				arg_6_1.dialog_:SetActive(false)
			end

			local var_9_22 = 4.00000000298023
			local var_9_23 = 0.35

			if 4.00000000298023 < arg_6_1.time_ and arg_6_1.time_ <= var_9_22 + arg_9_0 then
				arg_6_1.talkMaxDuration = 0

				arg_6_1.dialog_:SetActive(true)

				arg_6_1.dialogCg_.alpha = 0

				local var_9_24 = LeanTween.value(arg_6_1.dialog_, 0, 1, 0.3)

				var_9_24:setOnUpdate(LuaHelper.FloatAction(function(arg_10_0)
					arg_6_1.dialogCg_.alpha = arg_10_0
				end))
				var_9_24:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_6_1.dialog_)
					var_9_24:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_6_1.duration_ = arg_6_1.duration_ + 0.3

				SetActive(arg_6_1.leftNameGo_, true)

				arg_6_1.leftNameTxt_.text = arg_6_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_6_1.leftNameTxt_.transform)

				arg_6_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_6_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_6_1:RecordName(arg_6_1.leftNameTxt_.text)
				SetActive(arg_6_1.iconTrs_.gameObject, false)
				arg_6_1.callingController_:SetSelectedState("normal")

				local var_9_25 = arg_6_1:FormatText(arg_6_1:GetWordFromCfg(939061002).content)

				arg_6_1.text_.text = var_9_25

				LuaForUtil.ClearLinePrefixSymbol(arg_6_1.text_)

				local var_9_27 = 14 <= 0 and var_9_23 or var_9_23 * (utf8.len(var_9_25) / 14)

				if (14 <= 0 and var_9_23 or var_9_23 * (utf8.len(var_9_25) / 14)) > 0 and var_9_23 < var_9_27 then
					arg_6_1.talkMaxDuration = var_9_27
					var_9_22 = var_9_22 + 0.3

					if var_9_27 + var_9_22 > arg_6_1.duration_ then
						arg_6_1.duration_ = var_9_27 + var_9_22
					end
				end

				arg_6_1.text_.text = var_9_25
				arg_6_1.typewritter.percent = 0

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(false)
				arg_6_1:RecordContent(arg_6_1.text_.text)
			end

			local var_9_28 = var_9_22 + 0.3
			local var_9_29 = math.max(var_9_23, arg_6_1.talkMaxDuration)

			if var_9_22 + 0.3 <= arg_6_1.time_ and arg_6_1.time_ < var_9_28 + var_9_29 then
				arg_6_1.typewritter.percent = (arg_6_1.time_ - var_9_28) / var_9_29

				arg_6_1.typewritter:SetDirty()
			end

			if arg_6_1.time_ >= var_9_28 + var_9_29 and arg_6_1.time_ < var_9_28 + var_9_29 + arg_9_0 then
				arg_6_1.typewritter.percent = 1

				arg_6_1.typewritter:SetDirty()
				arg_6_1:ShowNextGo(true)
			end
		end

		arg_6_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_6_1:InitPlayNodeList()
	end,
	Play939061003 = function(arg_12_0, arg_12_1)
		arg_12_1.time_ = 0
		arg_12_1.frameCnt_ = 0
		arg_12_1.state_ = "playing"
		arg_12_1.curTalkId_ = 939061003
		arg_12_1.duration_ = 5

		SetActive(arg_12_1.tipsGo_, false)

		function arg_12_1.onSingleLineFinish_()
			arg_12_1.onSingleLineUpdate_ = nil
			arg_12_1.onSingleLineFinish_ = nil
			arg_12_1.state_ = "waiting"
		end

		function arg_12_1.playNext_(arg_14_0)
			if arg_14_0 == 1 then
				arg_12_0:Play939061004(arg_12_1)
			end
		end

		function arg_12_1.onSingleLineUpdate_(arg_15_0)
			if 0 < arg_12_1.time_ and arg_12_1.time_ <= 0 + arg_15_0 and not isNil(arg_12_1.actors_["1248ui_story"]) and arg_12_1.var_.characterEffect1248ui_story == nil then
				arg_12_1.var_.characterEffect1248ui_story = arg_12_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_15_0 = 0.200000002980232

			if 0 <= arg_12_1.time_ and arg_12_1.time_ < 0 + var_15_0 and not isNil(arg_12_1.actors_["1248ui_story"]) then
				if arg_12_1.var_.characterEffect1248ui_story and not isNil(arg_12_1.actors_["1248ui_story"]) then
					arg_12_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_12_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_12_1.time_ - 0) / var_15_0)
				end
			end

			if arg_12_1.time_ >= 0 + var_15_0 and arg_12_1.time_ < 0 + var_15_0 + arg_15_0 and not isNil(arg_12_1.actors_["1248ui_story"]) and arg_12_1.var_.characterEffect1248ui_story then
				arg_12_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_12_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_15_1 = 0
			local var_15_2 = 0.475

			if 0 < arg_12_1.time_ and arg_12_1.time_ <= var_15_1 + arg_15_0 then
				arg_12_1.talkMaxDuration = 0
				arg_12_1.dialogCg_.alpha = 1

				arg_12_1.dialog_:SetActive(true)
				SetActive(arg_12_1.leftNameGo_, true)

				arg_12_1.leftNameTxt_.text = arg_12_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_12_1.leftNameTxt_.transform)

				arg_12_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_12_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_12_1:RecordName(arg_12_1.leftNameTxt_.text)
				SetActive(arg_12_1.iconTrs_.gameObject, true)
				arg_12_1.iconController_:SetSelectedState("hero")

				arg_12_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_12_1.callingController_:SetSelectedState("normal")

				arg_12_1.keyicon_.color = Color.New(1, 1, 1)
				arg_12_1.icon_.color = Color.New(1, 1, 1)

				local var_15_3 = arg_12_1:FormatText(arg_12_1:GetWordFromCfg(939061003).content)

				arg_12_1.text_.text = var_15_3

				LuaForUtil.ClearLinePrefixSymbol(arg_12_1.text_)

				local var_15_5 = 19 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 19)

				if (19 <= 0 and var_15_2 or var_15_2 * (utf8.len(var_15_3) / 19)) > 0 and var_15_2 < var_15_5 then
					arg_12_1.talkMaxDuration = var_15_5

					if var_15_5 + var_15_1 > arg_12_1.duration_ then
						arg_12_1.duration_ = var_15_5 + var_15_1
					end
				end

				arg_12_1.text_.text = var_15_3
				arg_12_1.typewritter.percent = 0

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(false)
				arg_12_1:RecordContent(arg_12_1.text_.text)
			end

			local var_15_6 = math.max(var_15_2, arg_12_1.talkMaxDuration)

			if var_15_1 <= arg_12_1.time_ and arg_12_1.time_ < var_15_1 + var_15_6 then
				arg_12_1.typewritter.percent = (arg_12_1.time_ - var_15_1) / var_15_6

				arg_12_1.typewritter:SetDirty()
			end

			if arg_12_1.time_ >= var_15_1 + var_15_6 and arg_12_1.time_ < var_15_1 + var_15_6 + arg_15_0 then
				arg_12_1.typewritter.percent = 1

				arg_12_1.typewritter:SetDirty()
				arg_12_1:ShowNextGo(true)
			end
		end

		arg_12_1.nodeConfigList_ = {}

		arg_12_1:InitPlayNodeList()
	end,
	Play939061004 = function(arg_16_0, arg_16_1)
		arg_16_1.time_ = 0
		arg_16_1.frameCnt_ = 0
		arg_16_1.state_ = "playing"
		arg_16_1.curTalkId_ = 939061004
		arg_16_1.duration_ = 5

		SetActive(arg_16_1.tipsGo_, false)

		function arg_16_1.onSingleLineFinish_()
			arg_16_1.onSingleLineUpdate_ = nil
			arg_16_1.onSingleLineFinish_ = nil
			arg_16_1.state_ = "waiting"
		end

		function arg_16_1.playNext_(arg_18_0)
			if arg_18_0 == 1 then
				arg_16_0:Play939061005(arg_16_1)
			end
		end

		function arg_16_1.onSingleLineUpdate_(arg_19_0)
			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 and not isNil(arg_16_1.actors_["1248ui_story"]) and arg_16_1.var_.characterEffect1248ui_story == nil then
				arg_16_1.var_.characterEffect1248ui_story = arg_16_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_19_0 = 0.200000002980232

			if 0 <= arg_16_1.time_ and arg_16_1.time_ < 0 + var_19_0 and not isNil(arg_16_1.actors_["1248ui_story"]) then
				if arg_16_1.var_.characterEffect1248ui_story and not isNil(arg_16_1.actors_["1248ui_story"]) then
					arg_16_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_16_1.time_ >= 0 + var_19_0 and arg_16_1.time_ < 0 + var_19_0 + arg_19_0 and not isNil(arg_16_1.actors_["1248ui_story"]) and arg_16_1.var_.characterEffect1248ui_story then
				arg_16_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action4_1")
			end

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= 0 + arg_19_0 then
				arg_16_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_19_2 = 0
			local var_19_3 = 0.575

			if 0 < arg_16_1.time_ and arg_16_1.time_ <= var_19_2 + arg_19_0 then
				arg_16_1.talkMaxDuration = 0
				arg_16_1.dialogCg_.alpha = 1

				arg_16_1.dialog_:SetActive(true)
				SetActive(arg_16_1.leftNameGo_, true)

				arg_16_1.leftNameTxt_.text = arg_16_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_16_1.leftNameTxt_.transform)

				arg_16_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_16_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_16_1:RecordName(arg_16_1.leftNameTxt_.text)
				SetActive(arg_16_1.iconTrs_.gameObject, false)
				arg_16_1.callingController_:SetSelectedState("normal")

				local var_19_4 = arg_16_1:FormatText(arg_16_1:GetWordFromCfg(939061004).content)

				arg_16_1.text_.text = var_19_4

				LuaForUtil.ClearLinePrefixSymbol(arg_16_1.text_)

				local var_19_6 = 23 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 23)

				if (23 <= 0 and var_19_3 or var_19_3 * (utf8.len(var_19_4) / 23)) > 0 and var_19_3 < var_19_6 then
					arg_16_1.talkMaxDuration = var_19_6

					if var_19_6 + var_19_2 > arg_16_1.duration_ then
						arg_16_1.duration_ = var_19_6 + var_19_2
					end
				end

				arg_16_1.text_.text = var_19_4
				arg_16_1.typewritter.percent = 0

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(false)
				arg_16_1:RecordContent(arg_16_1.text_.text)
			end

			local var_19_7 = math.max(var_19_3, arg_16_1.talkMaxDuration)

			if var_19_2 <= arg_16_1.time_ and arg_16_1.time_ < var_19_2 + var_19_7 then
				arg_16_1.typewritter.percent = (arg_16_1.time_ - var_19_2) / var_19_7

				arg_16_1.typewritter:SetDirty()
			end

			if arg_16_1.time_ >= var_19_2 + var_19_7 and arg_16_1.time_ < var_19_2 + var_19_7 + arg_19_0 then
				arg_16_1.typewritter.percent = 1

				arg_16_1.typewritter:SetDirty()
				arg_16_1:ShowNextGo(true)
			end
		end

		arg_16_1.nodeConfigList_ = {}

		arg_16_1:InitPlayNodeList()
	end,
	Play939061005 = function(arg_20_0, arg_20_1)
		arg_20_1.time_ = 0
		arg_20_1.frameCnt_ = 0
		arg_20_1.state_ = "playing"
		arg_20_1.curTalkId_ = 939061005
		arg_20_1.duration_ = 5

		SetActive(arg_20_1.tipsGo_, false)

		function arg_20_1.onSingleLineFinish_()
			arg_20_1.onSingleLineUpdate_ = nil
			arg_20_1.onSingleLineFinish_ = nil
			arg_20_1.state_ = "waiting"
		end

		function arg_20_1.playNext_(arg_22_0)
			if arg_22_0 == 1 then
				arg_20_0:Play939061006(arg_20_1)
			end
		end

		function arg_20_1.onSingleLineUpdate_(arg_23_0)
			if 0 < arg_20_1.time_ and arg_20_1.time_ <= 0 + arg_23_0 and not isNil(arg_20_1.actors_["1248ui_story"]) and arg_20_1.var_.characterEffect1248ui_story == nil then
				arg_20_1.var_.characterEffect1248ui_story = arg_20_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_23_0 = 0.200000002980232

			if 0 <= arg_20_1.time_ and arg_20_1.time_ < 0 + var_23_0 and not isNil(arg_20_1.actors_["1248ui_story"]) then
				if arg_20_1.var_.characterEffect1248ui_story and not isNil(arg_20_1.actors_["1248ui_story"]) then
					arg_20_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_20_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_20_1.time_ - 0) / var_23_0)
				end
			end

			if arg_20_1.time_ >= 0 + var_23_0 and arg_20_1.time_ < 0 + var_23_0 + arg_23_0 and not isNil(arg_20_1.actors_["1248ui_story"]) and arg_20_1.var_.characterEffect1248ui_story then
				arg_20_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_20_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_23_1 = 0
			local var_23_2 = 0.85

			if 0 < arg_20_1.time_ and arg_20_1.time_ <= var_23_1 + arg_23_0 then
				arg_20_1.talkMaxDuration = 0
				arg_20_1.dialogCg_.alpha = 1

				arg_20_1.dialog_:SetActive(true)
				SetActive(arg_20_1.leftNameGo_, false)

				arg_20_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_20_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_20_1:RecordName(arg_20_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_20_1.iconTrs_.gameObject, false)
				arg_20_1.callingController_:SetSelectedState("normal")

				local var_23_3 = arg_20_1:FormatText(arg_20_1:GetWordFromCfg(939061005).content)

				arg_20_1.text_.text = var_23_3

				LuaForUtil.ClearLinePrefixSymbol(arg_20_1.text_)

				local var_23_5 = 34 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 34)

				if (34 <= 0 and var_23_2 or var_23_2 * (utf8.len(var_23_3) / 34)) > 0 and var_23_2 < var_23_5 then
					arg_20_1.talkMaxDuration = var_23_5

					if var_23_5 + var_23_1 > arg_20_1.duration_ then
						arg_20_1.duration_ = var_23_5 + var_23_1
					end
				end

				arg_20_1.text_.text = var_23_3
				arg_20_1.typewritter.percent = 0

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(false)
				arg_20_1:RecordContent(arg_20_1.text_.text)
			end

			local var_23_6 = math.max(var_23_2, arg_20_1.talkMaxDuration)

			if var_23_1 <= arg_20_1.time_ and arg_20_1.time_ < var_23_1 + var_23_6 then
				arg_20_1.typewritter.percent = (arg_20_1.time_ - var_23_1) / var_23_6

				arg_20_1.typewritter:SetDirty()
			end

			if arg_20_1.time_ >= var_23_1 + var_23_6 and arg_20_1.time_ < var_23_1 + var_23_6 + arg_23_0 then
				arg_20_1.typewritter.percent = 1

				arg_20_1.typewritter:SetDirty()
				arg_20_1:ShowNextGo(true)
			end
		end

		arg_20_1.nodeConfigList_ = {}

		arg_20_1:InitPlayNodeList()
	end,
	Play939061006 = function(arg_24_0, arg_24_1)
		arg_24_1.time_ = 0
		arg_24_1.frameCnt_ = 0
		arg_24_1.state_ = "playing"
		arg_24_1.curTalkId_ = 939061006
		arg_24_1.duration_ = 5

		SetActive(arg_24_1.tipsGo_, false)

		function arg_24_1.onSingleLineFinish_()
			arg_24_1.onSingleLineUpdate_ = nil
			arg_24_1.onSingleLineFinish_ = nil
			arg_24_1.state_ = "waiting"
		end

		function arg_24_1.playNext_(arg_26_0)
			if arg_26_0 == 1 then
				arg_24_0:Play939061007(arg_24_1)
			end
		end

		function arg_24_1.onSingleLineUpdate_(arg_27_0)
			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1.var_.moveOldPos1248ui_story = arg_24_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_27_0 = 0.001

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_0 then
				arg_24_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_24_1.var_.moveOldPos1248ui_story, Vector3.New(0, -0.775, -6.18), (arg_24_1.time_ - 0) / var_27_0)
				arg_24_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1248ui_story"].transform.position).z)
				arg_24_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1248ui_story"].transform.localEulerAngles = arg_24_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_24_1.time_ >= 0 + var_27_0 and arg_24_1.time_ < 0 + var_27_0 + arg_27_0 then
				arg_24_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0, -0.775, -6.18)
				arg_24_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_24_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_24_1.actors_["1248ui_story"].transform.position).z)
				arg_24_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_24_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_24_1.actors_["1248ui_story"].transform.localEulerAngles = arg_24_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_27_1 = arg_24_1.actors_["1248ui_story"]

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1248ui_story == nil then
				arg_24_1.var_.characterEffect1248ui_story = var_27_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_27_2 = 0.200000002980232

			if 0 <= arg_24_1.time_ and arg_24_1.time_ < 0 + var_27_2 and not isNil(var_27_1) then
				if arg_24_1.var_.characterEffect1248ui_story and not isNil(var_27_1) then
					arg_24_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_24_1.time_ >= 0 + var_27_2 and arg_24_1.time_ < 0 + var_27_2 + arg_27_0 and not isNil(var_27_1) and arg_24_1.var_.characterEffect1248ui_story then
				arg_24_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action4_2")
			end

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= 0 + arg_27_0 then
				arg_24_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_27_4 = 0
			local var_27_5 = 1.1

			if 0 < arg_24_1.time_ and arg_24_1.time_ <= var_27_4 + arg_27_0 then
				arg_24_1.talkMaxDuration = 0
				arg_24_1.dialogCg_.alpha = 1

				arg_24_1.dialog_:SetActive(true)
				SetActive(arg_24_1.leftNameGo_, true)

				arg_24_1.leftNameTxt_.text = arg_24_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_24_1.leftNameTxt_.transform)

				arg_24_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_24_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_24_1:RecordName(arg_24_1.leftNameTxt_.text)
				SetActive(arg_24_1.iconTrs_.gameObject, false)
				arg_24_1.callingController_:SetSelectedState("normal")

				local var_27_6 = arg_24_1:FormatText(arg_24_1:GetWordFromCfg(939061006).content)

				arg_24_1.text_.text = var_27_6

				LuaForUtil.ClearLinePrefixSymbol(arg_24_1.text_)

				local var_27_8 = 44 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_6) / 44)

				if (44 <= 0 and var_27_5 or var_27_5 * (utf8.len(var_27_6) / 44)) > 0 and var_27_5 < var_27_8 then
					arg_24_1.talkMaxDuration = var_27_8

					if var_27_8 + var_27_4 > arg_24_1.duration_ then
						arg_24_1.duration_ = var_27_8 + var_27_4
					end
				end

				arg_24_1.text_.text = var_27_6
				arg_24_1.typewritter.percent = 0

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(false)
				arg_24_1:RecordContent(arg_24_1.text_.text)
			end

			local var_27_9 = math.max(var_27_5, arg_24_1.talkMaxDuration)

			if var_27_4 <= arg_24_1.time_ and arg_24_1.time_ < var_27_4 + var_27_9 then
				arg_24_1.typewritter.percent = (arg_24_1.time_ - var_27_4) / var_27_9

				arg_24_1.typewritter:SetDirty()
			end

			if arg_24_1.time_ >= var_27_4 + var_27_9 and arg_24_1.time_ < var_27_4 + var_27_9 + arg_27_0 then
				arg_24_1.typewritter.percent = 1

				arg_24_1.typewritter:SetDirty()
				arg_24_1:ShowNextGo(true)
			end
		end

		arg_24_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_24_1:InitPlayNodeList()
	end,
	Play939061007 = function(arg_28_0, arg_28_1)
		arg_28_1.time_ = 0
		arg_28_1.frameCnt_ = 0
		arg_28_1.state_ = "playing"
		arg_28_1.curTalkId_ = 939061007
		arg_28_1.duration_ = 5

		SetActive(arg_28_1.tipsGo_, false)

		function arg_28_1.onSingleLineFinish_()
			arg_28_1.onSingleLineUpdate_ = nil
			arg_28_1.onSingleLineFinish_ = nil
			arg_28_1.state_ = "waiting"
		end

		function arg_28_1.playNext_(arg_30_0)
			if arg_30_0 == 1 then
				arg_28_0:Play939061008(arg_28_1)
			end
		end

		function arg_28_1.onSingleLineUpdate_(arg_31_0)
			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1.var_.moveOldPos1248ui_story = arg_28_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_31_0 = 0.001

			if 0 <= arg_28_1.time_ and arg_28_1.time_ < 0 + var_31_0 then
				arg_28_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_28_1.var_.moveOldPos1248ui_story, Vector3.New(0, -0.775, -6.18), (arg_28_1.time_ - 0) / var_31_0)
				arg_28_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1248ui_story"].transform.position).z)
				arg_28_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1248ui_story"].transform.localEulerAngles = arg_28_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_28_1.time_ >= 0 + var_31_0 and arg_28_1.time_ < 0 + var_31_0 + arg_31_0 then
				arg_28_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0, -0.775, -6.18)
				arg_28_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_28_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_28_1.actors_["1248ui_story"].transform.position).z)
				arg_28_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_28_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_28_1.actors_["1248ui_story"].transform.localEulerAngles = arg_28_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_1")
			end

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= 0 + arg_31_0 then
				arg_28_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_31_1 = 0
			local var_31_2 = 1.2

			if 0 < arg_28_1.time_ and arg_28_1.time_ <= var_31_1 + arg_31_0 then
				arg_28_1.talkMaxDuration = 0
				arg_28_1.dialogCg_.alpha = 1

				arg_28_1.dialog_:SetActive(true)
				SetActive(arg_28_1.leftNameGo_, true)

				arg_28_1.leftNameTxt_.text = arg_28_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_28_1.leftNameTxt_.transform)

				arg_28_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_28_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_28_1:RecordName(arg_28_1.leftNameTxt_.text)
				SetActive(arg_28_1.iconTrs_.gameObject, false)
				arg_28_1.callingController_:SetSelectedState("normal")

				local var_31_3 = arg_28_1:FormatText(arg_28_1:GetWordFromCfg(939061007).content)

				arg_28_1.text_.text = var_31_3

				LuaForUtil.ClearLinePrefixSymbol(arg_28_1.text_)

				local var_31_5 = 48 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 48)

				if (48 <= 0 and var_31_2 or var_31_2 * (utf8.len(var_31_3) / 48)) > 0 and var_31_2 < var_31_5 then
					arg_28_1.talkMaxDuration = var_31_5

					if var_31_5 + var_31_1 > arg_28_1.duration_ then
						arg_28_1.duration_ = var_31_5 + var_31_1
					end
				end

				arg_28_1.text_.text = var_31_3
				arg_28_1.typewritter.percent = 0

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(false)
				arg_28_1:RecordContent(arg_28_1.text_.text)
			end

			local var_31_6 = math.max(var_31_2, arg_28_1.talkMaxDuration)

			if var_31_1 <= arg_28_1.time_ and arg_28_1.time_ < var_31_1 + var_31_6 then
				arg_28_1.typewritter.percent = (arg_28_1.time_ - var_31_1) / var_31_6

				arg_28_1.typewritter:SetDirty()
			end

			if arg_28_1.time_ >= var_31_1 + var_31_6 and arg_28_1.time_ < var_31_1 + var_31_6 + arg_31_0 then
				arg_28_1.typewritter.percent = 1

				arg_28_1.typewritter:SetDirty()
				arg_28_1:ShowNextGo(true)
			end
		end

		arg_28_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_28_1:InitPlayNodeList()
	end,
	Play939061008 = function(arg_32_0, arg_32_1)
		arg_32_1.time_ = 0
		arg_32_1.frameCnt_ = 0
		arg_32_1.state_ = "playing"
		arg_32_1.curTalkId_ = 939061008
		arg_32_1.duration_ = 5

		SetActive(arg_32_1.tipsGo_, false)

		function arg_32_1.onSingleLineFinish_()
			arg_32_1.onSingleLineUpdate_ = nil
			arg_32_1.onSingleLineFinish_ = nil
			arg_32_1.state_ = "waiting"
		end

		function arg_32_1.playNext_(arg_34_0)
			if arg_34_0 == 1 then
				arg_32_0:Play939061009(arg_32_1)
			end
		end

		function arg_32_1.onSingleLineUpdate_(arg_35_0)
			if arg_32_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_35_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_32_1.stage_.transform)

				var_35_0.name = "1284ui_story"
				var_35_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_32_1.actors_["1284ui_story"] = var_35_0

				local var_35_1 = var_35_0:GetComponentInChildren(typeof(CharacterEffect))

				var_35_1.enabled = true

				local var_35_2 = GameObjectTools.GetOrAddComponent(var_35_0, typeof(DynamicBoneHelper))

				if var_35_2 then
					var_35_2:EnableDynamicBone(false)
				end

				arg_32_1:ShowWeapon(var_35_1.transform, false)

				arg_32_1.var_["1284ui_story" .. "Animator"] = var_35_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_32_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_32_1.var_["1284ui_story" .. "LipSync"] = var_35_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_35_3 = arg_32_1.actors_["1284ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1284ui_story = var_35_3.localPosition
			end

			local var_35_4 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_4 then
				var_35_3.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_32_1.time_ - 0) / var_35_4)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_4 and arg_32_1.time_ < 0 + var_35_4 + arg_35_0 then
				var_35_3.localPosition = Vector3.New(0.7, -0.985, -6.22)
				var_35_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_3.position).x, (manager.ui.mainCamera.transform.position - var_35_3.position).y, (manager.ui.mainCamera.transform.position - var_35_3.position).z)
				var_35_3.localEulerAngles.z = 0
				var_35_3.localEulerAngles.x = 0
				var_35_3.localEulerAngles = var_35_3.localEulerAngles
			end

			local var_35_5 = arg_32_1.actors_["1248ui_story"].transform

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1.var_.moveOldPos1248ui_story = var_35_5.localPosition
			end

			local var_35_6 = 0.001

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_6 then
				var_35_5.localPosition = Vector3.Lerp(arg_32_1.var_.moveOldPos1248ui_story, Vector3.New(-0.7, -0.775, -6.18), (arg_32_1.time_ - 0) / var_35_6)
				var_35_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_5.position).x, (manager.ui.mainCamera.transform.position - var_35_5.position).y, (manager.ui.mainCamera.transform.position - var_35_5.position).z)
				var_35_5.localEulerAngles.z = 0
				var_35_5.localEulerAngles.x = 0
				var_35_5.localEulerAngles = var_35_5.localEulerAngles
			end

			if arg_32_1.time_ >= 0 + var_35_6 and arg_32_1.time_ < 0 + var_35_6 + arg_35_0 then
				var_35_5.localPosition = Vector3.New(-0.7, -0.775, -6.18)
				var_35_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_35_5.position).x, (manager.ui.mainCamera.transform.position - var_35_5.position).y, (manager.ui.mainCamera.transform.position - var_35_5.position).z)
				var_35_5.localEulerAngles.z = 0
				var_35_5.localEulerAngles.x = 0
				var_35_5.localEulerAngles = var_35_5.localEulerAngles
			end

			local var_35_7 = arg_32_1.actors_["1284ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect1284ui_story == nil then
				arg_32_1.var_.characterEffect1284ui_story = var_35_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_8 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_8 and not isNil(var_35_7) then
				if arg_32_1.var_.characterEffect1284ui_story and not isNil(var_35_7) then
					arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_32_1.time_ >= 0 + var_35_8 and arg_32_1.time_ < 0 + var_35_8 + arg_35_0 and not isNil(var_35_7) and arg_32_1.var_.characterEffect1284ui_story then
				arg_32_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			local var_35_10 = arg_32_1.actors_["1248ui_story"]

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1248ui_story == nil then
				arg_32_1.var_.characterEffect1248ui_story = var_35_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_35_11 = 0.200000002980232

			if 0 <= arg_32_1.time_ and arg_32_1.time_ < 0 + var_35_11 and not isNil(var_35_10) then
				if arg_32_1.var_.characterEffect1248ui_story and not isNil(var_35_10) then
					arg_32_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_32_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_32_1.time_ - 0) / var_35_11)
				end
			end

			if arg_32_1.time_ >= 0 + var_35_11 and arg_32_1.time_ < 0 + var_35_11 + arg_35_0 and not isNil(var_35_10) and arg_32_1.var_.characterEffect1248ui_story then
				arg_32_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_32_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= 0 + arg_35_0 then
				arg_32_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_35_12 = 0
			local var_35_13 = 0.575

			if 0 < arg_32_1.time_ and arg_32_1.time_ <= var_35_12 + arg_35_0 then
				arg_32_1.talkMaxDuration = 0
				arg_32_1.dialogCg_.alpha = 1

				arg_32_1.dialog_:SetActive(true)
				SetActive(arg_32_1.leftNameGo_, true)

				arg_32_1.leftNameTxt_.text = arg_32_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_32_1.leftNameTxt_.transform)

				arg_32_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_32_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_32_1:RecordName(arg_32_1.leftNameTxt_.text)
				SetActive(arg_32_1.iconTrs_.gameObject, false)
				arg_32_1.callingController_:SetSelectedState("normal")

				local var_35_14 = arg_32_1:FormatText(arg_32_1:GetWordFromCfg(939061008).content)

				arg_32_1.text_.text = var_35_14

				LuaForUtil.ClearLinePrefixSymbol(arg_32_1.text_)

				local var_35_16 = 23 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_14) / 23)

				if (23 <= 0 and var_35_13 or var_35_13 * (utf8.len(var_35_14) / 23)) > 0 and var_35_13 < var_35_16 then
					arg_32_1.talkMaxDuration = var_35_16

					if var_35_16 + var_35_12 > arg_32_1.duration_ then
						arg_32_1.duration_ = var_35_16 + var_35_12
					end
				end

				arg_32_1.text_.text = var_35_14
				arg_32_1.typewritter.percent = 0

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(false)
				arg_32_1:RecordContent(arg_32_1.text_.text)
			end

			local var_35_17 = math.max(var_35_13, arg_32_1.talkMaxDuration)

			if var_35_12 <= arg_32_1.time_ and arg_32_1.time_ < var_35_12 + var_35_17 then
				arg_32_1.typewritter.percent = (arg_32_1.time_ - var_35_12) / var_35_17

				arg_32_1.typewritter:SetDirty()
			end

			if arg_32_1.time_ >= var_35_12 + var_35_17 and arg_32_1.time_ < var_35_12 + var_35_17 + arg_35_0 then
				arg_32_1.typewritter.percent = 1

				arg_32_1.typewritter:SetDirty()
				arg_32_1:ShowNextGo(true)
			end
		end

		arg_32_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_32_1:InitPlayNodeList()
	end,
	Play939061009 = function(arg_36_0, arg_36_1)
		arg_36_1.time_ = 0
		arg_36_1.frameCnt_ = 0
		arg_36_1.state_ = "playing"
		arg_36_1.curTalkId_ = 939061009
		arg_36_1.duration_ = 5

		SetActive(arg_36_1.tipsGo_, false)

		function arg_36_1.onSingleLineFinish_()
			arg_36_1.onSingleLineUpdate_ = nil
			arg_36_1.onSingleLineFinish_ = nil
			arg_36_1.state_ = "waiting"
		end

		function arg_36_1.playNext_(arg_38_0)
			if arg_38_0 == 1 then
				arg_36_0:Play939061010(arg_36_1)
			end
		end

		function arg_36_1.onSingleLineUpdate_(arg_39_0)
			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 and not isNil(arg_36_1.actors_["1284ui_story"]) and arg_36_1.var_.characterEffect1284ui_story == nil then
				arg_36_1.var_.characterEffect1284ui_story = arg_36_1.actors_["1284ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_39_0 = 0.200000002980232

			if 0 <= arg_36_1.time_ and arg_36_1.time_ < 0 + var_39_0 and not isNil(arg_36_1.actors_["1284ui_story"]) then
				if arg_36_1.var_.characterEffect1284ui_story and not isNil(arg_36_1.actors_["1284ui_story"]) then
					arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_36_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_36_1.time_ - 0) / var_39_0)
				end
			end

			if arg_36_1.time_ >= 0 + var_39_0 and arg_36_1.time_ < 0 + var_39_0 + arg_39_0 and not isNil(arg_36_1.actors_["1284ui_story"]) and arg_36_1.var_.characterEffect1284ui_story then
				arg_36_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_36_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= 0 + arg_39_0 then
				arg_36_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_2")
			end

			local var_39_1 = 0
			local var_39_2 = 0.7

			if 0 < arg_36_1.time_ and arg_36_1.time_ <= var_39_1 + arg_39_0 then
				arg_36_1.talkMaxDuration = 0
				arg_36_1.dialogCg_.alpha = 1

				arg_36_1.dialog_:SetActive(true)
				SetActive(arg_36_1.leftNameGo_, true)

				arg_36_1.leftNameTxt_.text = arg_36_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_36_1.leftNameTxt_.transform)

				arg_36_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_36_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_36_1:RecordName(arg_36_1.leftNameTxt_.text)
				SetActive(arg_36_1.iconTrs_.gameObject, true)
				arg_36_1.iconController_:SetSelectedState("hero")

				arg_36_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_36_1.callingController_:SetSelectedState("normal")

				arg_36_1.keyicon_.color = Color.New(1, 1, 1)
				arg_36_1.icon_.color = Color.New(1, 1, 1)

				local var_39_3 = arg_36_1:FormatText(arg_36_1:GetWordFromCfg(939061009).content)

				arg_36_1.text_.text = var_39_3

				LuaForUtil.ClearLinePrefixSymbol(arg_36_1.text_)

				local var_39_5 = 28 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 28)

				if (28 <= 0 and var_39_2 or var_39_2 * (utf8.len(var_39_3) / 28)) > 0 and var_39_2 < var_39_5 then
					arg_36_1.talkMaxDuration = var_39_5

					if var_39_5 + var_39_1 > arg_36_1.duration_ then
						arg_36_1.duration_ = var_39_5 + var_39_1
					end
				end

				arg_36_1.text_.text = var_39_3
				arg_36_1.typewritter.percent = 0

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(false)
				arg_36_1:RecordContent(arg_36_1.text_.text)
			end

			local var_39_6 = math.max(var_39_2, arg_36_1.talkMaxDuration)

			if var_39_1 <= arg_36_1.time_ and arg_36_1.time_ < var_39_1 + var_39_6 then
				arg_36_1.typewritter.percent = (arg_36_1.time_ - var_39_1) / var_39_6

				arg_36_1.typewritter:SetDirty()
			end

			if arg_36_1.time_ >= var_39_1 + var_39_6 and arg_36_1.time_ < var_39_1 + var_39_6 + arg_39_0 then
				arg_36_1.typewritter.percent = 1

				arg_36_1.typewritter:SetDirty()
				arg_36_1:ShowNextGo(true)
			end
		end

		arg_36_1.nodeConfigList_ = {}

		arg_36_1:InitPlayNodeList()
	end,
	Play939061010 = function(arg_40_0, arg_40_1)
		arg_40_1.time_ = 0
		arg_40_1.frameCnt_ = 0
		arg_40_1.state_ = "playing"
		arg_40_1.curTalkId_ = 939061010
		arg_40_1.duration_ = 5

		SetActive(arg_40_1.tipsGo_, false)

		function arg_40_1.onSingleLineFinish_()
			arg_40_1.onSingleLineUpdate_ = nil
			arg_40_1.onSingleLineFinish_ = nil
			arg_40_1.state_ = "waiting"
		end

		function arg_40_1.playNext_(arg_42_0)
			if arg_42_0 == 1 then
				arg_40_0:Play939061011(arg_40_1)
			end
		end

		function arg_40_1.onSingleLineUpdate_(arg_43_0)
			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1.var_.moveOldPos1284ui_story = arg_40_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_43_0 = 0.001

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_0 then
				arg_40_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_40_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_40_1.time_ - 0) / var_43_0)
				arg_40_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1284ui_story"].transform.position).z)
				arg_40_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1284ui_story"].transform.localEulerAngles = arg_40_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_40_1.time_ >= 0 + var_43_0 and arg_40_1.time_ < 0 + var_43_0 + arg_43_0 then
				arg_40_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_40_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_40_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_40_1.actors_["1284ui_story"].transform.position).z)
				arg_40_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_40_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_40_1.actors_["1284ui_story"].transform.localEulerAngles = arg_40_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_43_1 = arg_40_1.actors_["1284ui_story"]

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1284ui_story == nil then
				arg_40_1.var_.characterEffect1284ui_story = var_43_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_43_2 = 0.200000002980232

			if 0 <= arg_40_1.time_ and arg_40_1.time_ < 0 + var_43_2 and not isNil(var_43_1) then
				if arg_40_1.var_.characterEffect1284ui_story and not isNil(var_43_1) then
					arg_40_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_40_1.time_ >= 0 + var_43_2 and arg_40_1.time_ < 0 + var_43_2 + arg_43_0 and not isNil(var_43_1) and arg_40_1.var_.characterEffect1284ui_story then
				arg_40_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action2_1")
			end

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= 0 + arg_43_0 then
				arg_40_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_43_4 = 0
			local var_43_5 = 1

			if 0 < arg_40_1.time_ and arg_40_1.time_ <= var_43_4 + arg_43_0 then
				arg_40_1.talkMaxDuration = 0
				arg_40_1.dialogCg_.alpha = 1

				arg_40_1.dialog_:SetActive(true)
				SetActive(arg_40_1.leftNameGo_, true)

				arg_40_1.leftNameTxt_.text = arg_40_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_40_1.leftNameTxt_.transform)

				arg_40_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_40_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_40_1:RecordName(arg_40_1.leftNameTxt_.text)
				SetActive(arg_40_1.iconTrs_.gameObject, false)
				arg_40_1.callingController_:SetSelectedState("normal")

				local var_43_6 = arg_40_1:FormatText(arg_40_1:GetWordFromCfg(939061010).content)

				arg_40_1.text_.text = var_43_6

				LuaForUtil.ClearLinePrefixSymbol(arg_40_1.text_)

				local var_43_8 = 40 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_6) / 40)

				if (40 <= 0 and var_43_5 or var_43_5 * (utf8.len(var_43_6) / 40)) > 0 and var_43_5 < var_43_8 then
					arg_40_1.talkMaxDuration = var_43_8

					if var_43_8 + var_43_4 > arg_40_1.duration_ then
						arg_40_1.duration_ = var_43_8 + var_43_4
					end
				end

				arg_40_1.text_.text = var_43_6
				arg_40_1.typewritter.percent = 0

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(false)
				arg_40_1:RecordContent(arg_40_1.text_.text)
			end

			local var_43_9 = math.max(var_43_5, arg_40_1.talkMaxDuration)

			if var_43_4 <= arg_40_1.time_ and arg_40_1.time_ < var_43_4 + var_43_9 then
				arg_40_1.typewritter.percent = (arg_40_1.time_ - var_43_4) / var_43_9

				arg_40_1.typewritter:SetDirty()
			end

			if arg_40_1.time_ >= var_43_4 + var_43_9 and arg_40_1.time_ < var_43_4 + var_43_9 + arg_43_0 then
				arg_40_1.typewritter.percent = 1

				arg_40_1.typewritter:SetDirty()
				arg_40_1:ShowNextGo(true)
			end
		end

		arg_40_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_40_1:InitPlayNodeList()
	end,
	Play939061011 = function(arg_44_0, arg_44_1)
		arg_44_1.time_ = 0
		arg_44_1.frameCnt_ = 0
		arg_44_1.state_ = "playing"
		arg_44_1.curTalkId_ = 939061011
		arg_44_1.duration_ = 5

		SetActive(arg_44_1.tipsGo_, false)

		function arg_44_1.onSingleLineFinish_()
			arg_44_1.onSingleLineUpdate_ = nil
			arg_44_1.onSingleLineFinish_ = nil
			arg_44_1.state_ = "waiting"
		end

		function arg_44_1.playNext_(arg_46_0)
			if arg_46_0 == 1 then
				arg_44_0:Play939061012(arg_44_1)
			end
		end

		function arg_44_1.onSingleLineUpdate_(arg_47_0)
			if arg_44_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_47_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_44_1.stage_.transform)

				var_47_0.name = "1054ui_story"
				var_47_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_44_1.actors_["1054ui_story"] = var_47_0

				local var_47_1 = var_47_0:GetComponentInChildren(typeof(CharacterEffect))

				var_47_1.enabled = true

				local var_47_2 = GameObjectTools.GetOrAddComponent(var_47_0, typeof(DynamicBoneHelper))

				if var_47_2 then
					var_47_2:EnableDynamicBone(false)
				end

				arg_44_1:ShowWeapon(var_47_1.transform, false)

				arg_44_1.var_["1054ui_story" .. "Animator"] = var_47_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_44_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_44_1.var_["1054ui_story" .. "LipSync"] = var_47_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_47_3 = arg_44_1.actors_["1054ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1054ui_story = var_47_3.localPosition

				local var_47_4 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_4 then
					var_47_4:EnableDynamicBone(false)
				end
			end

			local var_47_5 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_5 then
				var_47_3.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_44_1.time_ - 0) / var_47_5)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_5 and arg_44_1.time_ < 0 + var_47_5 + arg_47_0 then
				var_47_3.localPosition = Vector3.New(-0.7, -0.985, -6)
				var_47_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_3.position).x, (manager.ui.mainCamera.transform.position - var_47_3.position).y, (manager.ui.mainCamera.transform.position - var_47_3.position).z)
				var_47_3.localEulerAngles.z = 0
				var_47_3.localEulerAngles.x = 0
				var_47_3.localEulerAngles = var_47_3.localEulerAngles

				local var_47_6 = GameObjectTools.GetOrAddComponent(var_47_3.gameObject, typeof(DynamicBoneHelper))

				if var_47_6 then
					var_47_6:EnableDynamicBone(true)
				end
			end

			local var_47_7 = arg_44_1.actors_["1248ui_story"].transform

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1.var_.moveOldPos1248ui_story = var_47_7.localPosition
			end

			local var_47_8 = 0.001

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_8 then
				var_47_7.localPosition = Vector3.Lerp(arg_44_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_44_1.time_ - 0) / var_47_8)
				var_47_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_7.position).x, (manager.ui.mainCamera.transform.position - var_47_7.position).y, (manager.ui.mainCamera.transform.position - var_47_7.position).z)
				var_47_7.localEulerAngles.z = 0
				var_47_7.localEulerAngles.x = 0
				var_47_7.localEulerAngles = var_47_7.localEulerAngles
			end

			if arg_44_1.time_ >= 0 + var_47_8 and arg_44_1.time_ < 0 + var_47_8 + arg_47_0 then
				var_47_7.localPosition = Vector3.New(0, 100, 0)
				var_47_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_47_7.position).x, (manager.ui.mainCamera.transform.position - var_47_7.position).y, (manager.ui.mainCamera.transform.position - var_47_7.position).z)
				var_47_7.localEulerAngles.z = 0
				var_47_7.localEulerAngles.x = 0
				var_47_7.localEulerAngles = var_47_7.localEulerAngles
			end

			local var_47_9 = arg_44_1.actors_["1054ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1054ui_story == nil then
				arg_44_1.var_.characterEffect1054ui_story = var_47_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_10 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_10 and not isNil(var_47_9) then
				if arg_44_1.var_.characterEffect1054ui_story and not isNil(var_47_9) then
					arg_44_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_44_1.time_ >= 0 + var_47_10 and arg_44_1.time_ < 0 + var_47_10 + arg_47_0 and not isNil(var_47_9) and arg_44_1.var_.characterEffect1054ui_story then
				arg_44_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_47_12 = arg_44_1.actors_["1284ui_story"]

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 and not isNil(var_47_12) and arg_44_1.var_.characterEffect1284ui_story == nil then
				arg_44_1.var_.characterEffect1284ui_story = var_47_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_47_13 = 0.200000002980232

			if 0 <= arg_44_1.time_ and arg_44_1.time_ < 0 + var_47_13 and not isNil(var_47_12) then
				if arg_44_1.var_.characterEffect1284ui_story and not isNil(var_47_12) then
					arg_44_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_44_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_44_1.time_ - 0) / var_47_13)
				end
			end

			if arg_44_1.time_ >= 0 + var_47_13 and arg_44_1.time_ < 0 + var_47_13 + arg_47_0 and not isNil(var_47_12) and arg_44_1.var_.characterEffect1284ui_story then
				arg_44_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_44_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= 0 + arg_47_0 then
				arg_44_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_47_14 = 0
			local var_47_15 = 1

			if 0 < arg_44_1.time_ and arg_44_1.time_ <= var_47_14 + arg_47_0 then
				arg_44_1.talkMaxDuration = 0
				arg_44_1.dialogCg_.alpha = 1

				arg_44_1.dialog_:SetActive(true)
				SetActive(arg_44_1.leftNameGo_, true)

				arg_44_1.leftNameTxt_.text = arg_44_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_44_1.leftNameTxt_.transform)

				arg_44_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_44_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_44_1:RecordName(arg_44_1.leftNameTxt_.text)
				SetActive(arg_44_1.iconTrs_.gameObject, false)
				arg_44_1.callingController_:SetSelectedState("normal")

				local var_47_16 = arg_44_1:FormatText(arg_44_1:GetWordFromCfg(939061011).content)

				arg_44_1.text_.text = var_47_16

				LuaForUtil.ClearLinePrefixSymbol(arg_44_1.text_)

				local var_47_18 = 40 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_16) / 40)

				if (40 <= 0 and var_47_15 or var_47_15 * (utf8.len(var_47_16) / 40)) > 0 and var_47_15 < var_47_18 then
					arg_44_1.talkMaxDuration = var_47_18

					if var_47_18 + var_47_14 > arg_44_1.duration_ then
						arg_44_1.duration_ = var_47_18 + var_47_14
					end
				end

				arg_44_1.text_.text = var_47_16
				arg_44_1.typewritter.percent = 0

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(false)
				arg_44_1:RecordContent(arg_44_1.text_.text)
			end

			local var_47_19 = math.max(var_47_15, arg_44_1.talkMaxDuration)

			if var_47_14 <= arg_44_1.time_ and arg_44_1.time_ < var_47_14 + var_47_19 then
				arg_44_1.typewritter.percent = (arg_44_1.time_ - var_47_14) / var_47_19

				arg_44_1.typewritter:SetDirty()
			end

			if arg_44_1.time_ >= var_47_14 + var_47_19 and arg_44_1.time_ < var_47_14 + var_47_19 + arg_47_0 then
				arg_44_1.typewritter.percent = 1

				arg_44_1.typewritter:SetDirty()
				arg_44_1:ShowNextGo(true)
			end
		end

		arg_44_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_44_1:InitPlayNodeList()
	end,
	Play939061012 = function(arg_48_0, arg_48_1)
		arg_48_1.time_ = 0
		arg_48_1.frameCnt_ = 0
		arg_48_1.state_ = "playing"
		arg_48_1.curTalkId_ = 939061012
		arg_48_1.duration_ = 5

		SetActive(arg_48_1.tipsGo_, false)

		function arg_48_1.onSingleLineFinish_()
			arg_48_1.onSingleLineUpdate_ = nil
			arg_48_1.onSingleLineFinish_ = nil
			arg_48_1.state_ = "waiting"
		end

		function arg_48_1.playNext_(arg_50_0)
			if arg_50_0 == 1 then
				arg_48_0:Play939061013(arg_48_1)
			end
		end

		function arg_48_1.onSingleLineUpdate_(arg_51_0)
			if arg_48_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_51_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_48_1.stage_.transform)

				var_51_0.name = "6148ui_story"
				var_51_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_48_1.actors_["6148ui_story"] = var_51_0

				local var_51_1 = var_51_0:GetComponentInChildren(typeof(CharacterEffect))

				var_51_1.enabled = true

				local var_51_2 = GameObjectTools.GetOrAddComponent(var_51_0, typeof(DynamicBoneHelper))

				if var_51_2 then
					var_51_2:EnableDynamicBone(false)
				end

				arg_48_1:ShowWeapon(var_51_1.transform, false)

				arg_48_1.var_["6148ui_story" .. "Animator"] = var_51_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_48_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_48_1.var_["6148ui_story" .. "LipSync"] = var_51_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_51_3 = arg_48_1.actors_["6148ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos6148ui_story = var_51_3.localPosition

				local var_51_4 = GameObjectTools.GetOrAddComponent(var_51_3.gameObject, typeof(DynamicBoneHelper))

				if var_51_4 then
					var_51_4:EnableDynamicBone(false)
				end
			end

			local var_51_5 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_5 then
				var_51_3.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_48_1.time_ - 0) / var_51_5)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_5 and arg_48_1.time_ < 0 + var_51_5 + arg_51_0 then
				var_51_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_51_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_3.position).x, (manager.ui.mainCamera.transform.position - var_51_3.position).y, (manager.ui.mainCamera.transform.position - var_51_3.position).z)
				var_51_3.localEulerAngles.z = 0
				var_51_3.localEulerAngles.x = 0
				var_51_3.localEulerAngles = var_51_3.localEulerAngles

				local var_51_6 = GameObjectTools.GetOrAddComponent(var_51_3.gameObject, typeof(DynamicBoneHelper))

				if var_51_6 then
					var_51_6:EnableDynamicBone(true)
				end
			end

			local var_51_7 = arg_48_1.actors_["6148ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect6148ui_story == nil then
				arg_48_1.var_.characterEffect6148ui_story = var_51_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_8 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_8 and not isNil(var_51_7) then
				if arg_48_1.var_.characterEffect6148ui_story and not isNil(var_51_7) then
					arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_48_1.time_ >= 0 + var_51_8 and arg_48_1.time_ < 0 + var_51_8 + arg_51_0 and not isNil(var_51_7) and arg_48_1.var_.characterEffect6148ui_story then
				arg_48_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_51_10 = arg_48_1.actors_["1054ui_story"]

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect1054ui_story == nil then
				arg_48_1.var_.characterEffect1054ui_story = var_51_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_51_11 = 0.200000002980232

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_11 and not isNil(var_51_10) then
				if arg_48_1.var_.characterEffect1054ui_story and not isNil(var_51_10) then
					arg_48_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_48_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_48_1.time_ - 0) / var_51_11)
				end
			end

			if arg_48_1.time_ >= 0 + var_51_11 and arg_48_1.time_ < 0 + var_51_11 + arg_51_0 and not isNil(var_51_10) and arg_48_1.var_.characterEffect1054ui_story then
				arg_48_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_48_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_51_12 = arg_48_1.actors_["1284ui_story"].transform

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= 0 + arg_51_0 then
				arg_48_1.var_.moveOldPos1284ui_story = var_51_12.localPosition
			end

			local var_51_13 = 0.001

			if 0 <= arg_48_1.time_ and arg_48_1.time_ < 0 + var_51_13 then
				var_51_12.localPosition = Vector3.Lerp(arg_48_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_48_1.time_ - 0) / var_51_13)
				var_51_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_12.position).x, (manager.ui.mainCamera.transform.position - var_51_12.position).y, (manager.ui.mainCamera.transform.position - var_51_12.position).z)
				var_51_12.localEulerAngles.z = 0
				var_51_12.localEulerAngles.x = 0
				var_51_12.localEulerAngles = var_51_12.localEulerAngles
			end

			if arg_48_1.time_ >= 0 + var_51_13 and arg_48_1.time_ < 0 + var_51_13 + arg_51_0 then
				var_51_12.localPosition = Vector3.New(0, 100, 0)
				var_51_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_51_12.position).x, (manager.ui.mainCamera.transform.position - var_51_12.position).y, (manager.ui.mainCamera.transform.position - var_51_12.position).z)
				var_51_12.localEulerAngles.z = 0
				var_51_12.localEulerAngles.x = 0
				var_51_12.localEulerAngles = var_51_12.localEulerAngles
			end

			local var_51_14 = 0
			local var_51_15 = 1.175

			if 0 < arg_48_1.time_ and arg_48_1.time_ <= var_51_14 + arg_51_0 then
				arg_48_1.talkMaxDuration = 0
				arg_48_1.dialogCg_.alpha = 1

				arg_48_1.dialog_:SetActive(true)
				SetActive(arg_48_1.leftNameGo_, true)

				arg_48_1.leftNameTxt_.text = arg_48_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_48_1.leftNameTxt_.transform)

				arg_48_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_48_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_48_1:RecordName(arg_48_1.leftNameTxt_.text)
				SetActive(arg_48_1.iconTrs_.gameObject, false)
				arg_48_1.callingController_:SetSelectedState("normal")

				local var_51_16 = arg_48_1:FormatText(arg_48_1:GetWordFromCfg(939061012).content)

				arg_48_1.text_.text = var_51_16

				LuaForUtil.ClearLinePrefixSymbol(arg_48_1.text_)

				local var_51_18 = 47 <= 0 and var_51_15 or var_51_15 * (utf8.len(var_51_16) / 47)

				if (47 <= 0 and var_51_15 or var_51_15 * (utf8.len(var_51_16) / 47)) > 0 and var_51_15 < var_51_18 then
					arg_48_1.talkMaxDuration = var_51_18

					if var_51_18 + var_51_14 > arg_48_1.duration_ then
						arg_48_1.duration_ = var_51_18 + var_51_14
					end
				end

				arg_48_1.text_.text = var_51_16
				arg_48_1.typewritter.percent = 0

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(false)
				arg_48_1:RecordContent(arg_48_1.text_.text)
			end

			local var_51_19 = math.max(var_51_15, arg_48_1.talkMaxDuration)

			if var_51_14 <= arg_48_1.time_ and arg_48_1.time_ < var_51_14 + var_51_19 then
				arg_48_1.typewritter.percent = (arg_48_1.time_ - var_51_14) / var_51_19

				arg_48_1.typewritter:SetDirty()
			end

			if arg_48_1.time_ >= var_51_14 + var_51_19 and arg_48_1.time_ < var_51_14 + var_51_19 + arg_51_0 then
				arg_48_1.typewritter.percent = 1

				arg_48_1.typewritter:SetDirty()
				arg_48_1:ShowNextGo(true)
			end
		end

		arg_48_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_48_1:InitPlayNodeList()
	end,
	Play939061013 = function(arg_52_0, arg_52_1)
		arg_52_1.time_ = 0
		arg_52_1.frameCnt_ = 0
		arg_52_1.state_ = "playing"
		arg_52_1.curTalkId_ = 939061013
		arg_52_1.duration_ = 1

		SetActive(arg_52_1.tipsGo_, false)

		function arg_52_1.onSingleLineFinish_()
			arg_52_1.onSingleLineUpdate_ = nil
			arg_52_1.onSingleLineFinish_ = nil
			arg_52_1.state_ = "waiting"

			SetActive(arg_52_1.choicesGo_, true)

			for iter_53_0, iter_53_1 in ipairs(arg_52_1.choices_) do
				SetActive(iter_53_1.go, iter_53_0 <= 1)
			end

			arg_52_1.choices_[1].txt.text = arg_52_1:FormatText(StoryChoiceCfg[1680].name)
		end

		function arg_52_1.playNext_(arg_54_0)
			if arg_54_0 == 1 then
				arg_52_0:Play939061014(arg_52_1)
			end

			arg_52_1:RecordChoiceLog(939061013, 1680)
		end

		function arg_52_1.onSingleLineUpdate_(arg_55_0)
			if 0 < arg_52_1.time_ and arg_52_1.time_ <= 0 + arg_55_0 and not isNil(arg_52_1.actors_["6148ui_story"]) and arg_52_1.var_.characterEffect6148ui_story == nil then
				arg_52_1.var_.characterEffect6148ui_story = arg_52_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_55_0 = 0.200000002980232

			if 0 <= arg_52_1.time_ and arg_52_1.time_ < 0 + var_55_0 and not isNil(arg_52_1.actors_["6148ui_story"]) then
				if arg_52_1.var_.characterEffect6148ui_story and not isNil(arg_52_1.actors_["6148ui_story"]) then
					arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_52_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_52_1.time_ - 0) / var_55_0)
				end
			end

			if arg_52_1.time_ >= 0 + var_55_0 and arg_52_1.time_ < 0 + var_55_0 + arg_55_0 and not isNil(arg_52_1.actors_["6148ui_story"]) and arg_52_1.var_.characterEffect6148ui_story then
				arg_52_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_52_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_55_1 = 0

			if 0 < arg_52_1.time_ and arg_52_1.time_ <= var_55_1 + arg_55_0 then
				arg_52_1.allBtn_.enabled = false
			end

			if arg_52_1.time_ >= var_55_1 + 1 and arg_52_1.time_ < var_55_1 + 1 + arg_55_0 then
				arg_52_1.allBtn_.enabled = true
			end
		end

		arg_52_1.nodeConfigList_ = {}

		arg_52_1:InitPlayNodeList()
	end,
	Play939061014 = function(arg_56_0, arg_56_1)
		arg_56_1.time_ = 0
		arg_56_1.frameCnt_ = 0
		arg_56_1.state_ = "playing"
		arg_56_1.curTalkId_ = 939061014
		arg_56_1.duration_ = 5

		SetActive(arg_56_1.tipsGo_, false)

		function arg_56_1.onSingleLineFinish_()
			arg_56_1.onSingleLineUpdate_ = nil
			arg_56_1.onSingleLineFinish_ = nil
			arg_56_1.state_ = "waiting"
		end

		function arg_56_1.playNext_(arg_58_0)
			if arg_58_0 == 1 then
				arg_56_0:Play939061015(arg_56_1)
			end
		end

		function arg_56_1.onSingleLineUpdate_(arg_59_0)
			local var_59_0 = 0.55

			if 0 < arg_56_1.time_ and arg_56_1.time_ <= 0 + arg_59_0 then
				arg_56_1.talkMaxDuration = 0
				arg_56_1.dialogCg_.alpha = 1

				arg_56_1.dialog_:SetActive(true)
				SetActive(arg_56_1.leftNameGo_, true)

				arg_56_1.leftNameTxt_.text = arg_56_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_56_1.leftNameTxt_.transform)

				arg_56_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_56_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_56_1:RecordName(arg_56_1.leftNameTxt_.text)
				SetActive(arg_56_1.iconTrs_.gameObject, true)
				arg_56_1.iconController_:SetSelectedState("hero")

				arg_56_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_56_1.callingController_:SetSelectedState("normal")

				arg_56_1.keyicon_.color = Color.New(1, 1, 1)
				arg_56_1.icon_.color = Color.New(1, 1, 1)

				local var_59_1 = arg_56_1:FormatText(arg_56_1:GetWordFromCfg(939061014).content)

				arg_56_1.text_.text = var_59_1

				LuaForUtil.ClearLinePrefixSymbol(arg_56_1.text_)

				local var_59_3 = 22 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 22)

				if (22 <= 0 and var_59_0 or var_59_0 * (utf8.len(var_59_1) / 22)) > 0 and var_59_0 < var_59_3 then
					arg_56_1.talkMaxDuration = var_59_3

					if var_59_3 + 0 > arg_56_1.duration_ then
						arg_56_1.duration_ = var_59_3 + 0
					end
				end

				arg_56_1.text_.text = var_59_1
				arg_56_1.typewritter.percent = 0

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(false)
				arg_56_1:RecordContent(arg_56_1.text_.text)
			end

			local var_59_4 = math.max(var_59_0, arg_56_1.talkMaxDuration)

			if 0 <= arg_56_1.time_ and arg_56_1.time_ < 0 + var_59_4 then
				arg_56_1.typewritter.percent = (arg_56_1.time_ - 0) / var_59_4

				arg_56_1.typewritter:SetDirty()
			end

			if arg_56_1.time_ >= 0 + var_59_4 and arg_56_1.time_ < 0 + var_59_4 + arg_59_0 then
				arg_56_1.typewritter.percent = 1

				arg_56_1.typewritter:SetDirty()
				arg_56_1:ShowNextGo(true)
			end
		end

		arg_56_1.nodeConfigList_ = {}

		arg_56_1:InitPlayNodeList()
	end,
	Play939061015 = function(arg_60_0, arg_60_1)
		arg_60_1.time_ = 0
		arg_60_1.frameCnt_ = 0
		arg_60_1.state_ = "playing"
		arg_60_1.curTalkId_ = 939061015
		arg_60_1.duration_ = 5

		SetActive(arg_60_1.tipsGo_, false)

		function arg_60_1.onSingleLineFinish_()
			arg_60_1.onSingleLineUpdate_ = nil
			arg_60_1.onSingleLineFinish_ = nil
			arg_60_1.state_ = "waiting"
		end

		function arg_60_1.playNext_(arg_62_0)
			if arg_62_0 == 1 then
				arg_60_0:Play939061016(arg_60_1)
			end
		end

		function arg_60_1.onSingleLineUpdate_(arg_63_0)
			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1.var_.moveOldPos1054ui_story = arg_60_1.actors_["1054ui_story"].transform.localPosition

				local var_63_0 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_0 then
					var_63_0:EnableDynamicBone(false)
				end
			end

			local var_63_1 = 0.001

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_1 then
				arg_60_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_60_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_60_1.time_ - 0) / var_63_1)
				arg_60_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1054ui_story"].transform.position).z)
				arg_60_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1054ui_story"].transform.localEulerAngles = arg_60_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_60_1.time_ >= 0 + var_63_1 and arg_60_1.time_ < 0 + var_63_1 + arg_63_0 then
				arg_60_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_60_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_60_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_60_1.actors_["1054ui_story"].transform.position).z)
				arg_60_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_60_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_60_1.actors_["1054ui_story"].transform.localEulerAngles = arg_60_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_63_2 = GameObjectTools.GetOrAddComponent(arg_60_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_63_2 then
					var_63_2:EnableDynamicBone(true)
				end
			end

			local var_63_3 = arg_60_1.actors_["1054ui_story"]

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1054ui_story == nil then
				arg_60_1.var_.characterEffect1054ui_story = var_63_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_63_4 = 0.200000002980232

			if 0 <= arg_60_1.time_ and arg_60_1.time_ < 0 + var_63_4 and not isNil(var_63_3) then
				if arg_60_1.var_.characterEffect1054ui_story and not isNil(var_63_3) then
					arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_60_1.time_ >= 0 + var_63_4 and arg_60_1.time_ < 0 + var_63_4 + arg_63_0 and not isNil(var_63_3) and arg_60_1.var_.characterEffect1054ui_story then
				arg_60_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= 0 + arg_63_0 then
				arg_60_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_63_6 = 0
			local var_63_7 = 0.15

			if 0 < arg_60_1.time_ and arg_60_1.time_ <= var_63_6 + arg_63_0 then
				arg_60_1.talkMaxDuration = 0
				arg_60_1.dialogCg_.alpha = 1

				arg_60_1.dialog_:SetActive(true)
				SetActive(arg_60_1.leftNameGo_, true)

				arg_60_1.leftNameTxt_.text = arg_60_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_60_1.leftNameTxt_.transform)

				arg_60_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_60_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_60_1:RecordName(arg_60_1.leftNameTxt_.text)
				SetActive(arg_60_1.iconTrs_.gameObject, false)
				arg_60_1.callingController_:SetSelectedState("normal")

				local var_63_8 = arg_60_1:FormatText(arg_60_1:GetWordFromCfg(939061015).content)

				arg_60_1.text_.text = var_63_8

				LuaForUtil.ClearLinePrefixSymbol(arg_60_1.text_)

				local var_63_10 = 6 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_8) / 6)

				if (6 <= 0 and var_63_7 or var_63_7 * (utf8.len(var_63_8) / 6)) > 0 and var_63_7 < var_63_10 then
					arg_60_1.talkMaxDuration = var_63_10

					if var_63_10 + var_63_6 > arg_60_1.duration_ then
						arg_60_1.duration_ = var_63_10 + var_63_6
					end
				end

				arg_60_1.text_.text = var_63_8
				arg_60_1.typewritter.percent = 0

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(false)
				arg_60_1:RecordContent(arg_60_1.text_.text)
			end

			local var_63_11 = math.max(var_63_7, arg_60_1.talkMaxDuration)

			if var_63_6 <= arg_60_1.time_ and arg_60_1.time_ < var_63_6 + var_63_11 then
				arg_60_1.typewritter.percent = (arg_60_1.time_ - var_63_6) / var_63_11

				arg_60_1.typewritter:SetDirty()
			end

			if arg_60_1.time_ >= var_63_6 + var_63_11 and arg_60_1.time_ < var_63_6 + var_63_11 + arg_63_0 then
				arg_60_1.typewritter.percent = 1

				arg_60_1.typewritter:SetDirty()
				arg_60_1:ShowNextGo(true)
			end
		end

		arg_60_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_60_1:InitPlayNodeList()
	end,
	Play939061016 = function(arg_64_0, arg_64_1)
		arg_64_1.time_ = 0
		arg_64_1.frameCnt_ = 0
		arg_64_1.state_ = "playing"
		arg_64_1.curTalkId_ = 939061016
		arg_64_1.duration_ = 5

		SetActive(arg_64_1.tipsGo_, false)

		function arg_64_1.onSingleLineFinish_()
			arg_64_1.onSingleLineUpdate_ = nil
			arg_64_1.onSingleLineFinish_ = nil
			arg_64_1.state_ = "waiting"
		end

		function arg_64_1.playNext_(arg_66_0)
			if arg_66_0 == 1 then
				arg_64_0:Play939061017(arg_64_1)
			end
		end

		function arg_64_1.onSingleLineUpdate_(arg_67_0)
			if 0 < arg_64_1.time_ and arg_64_1.time_ <= 0 + arg_67_0 and not isNil(arg_64_1.actors_["1054ui_story"]) and arg_64_1.var_.characterEffect1054ui_story == nil then
				arg_64_1.var_.characterEffect1054ui_story = arg_64_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_67_0 = 0.200000002980232

			if 0 <= arg_64_1.time_ and arg_64_1.time_ < 0 + var_67_0 and not isNil(arg_64_1.actors_["1054ui_story"]) then
				if arg_64_1.var_.characterEffect1054ui_story and not isNil(arg_64_1.actors_["1054ui_story"]) then
					arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_64_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_64_1.time_ - 0) / var_67_0)
				end
			end

			if arg_64_1.time_ >= 0 + var_67_0 and arg_64_1.time_ < 0 + var_67_0 + arg_67_0 and not isNil(arg_64_1.actors_["1054ui_story"]) and arg_64_1.var_.characterEffect1054ui_story then
				arg_64_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_64_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_67_1 = 0
			local var_67_2 = 1.225

			if 0 < arg_64_1.time_ and arg_64_1.time_ <= var_67_1 + arg_67_0 then
				arg_64_1.talkMaxDuration = 0
				arg_64_1.dialogCg_.alpha = 1

				arg_64_1.dialog_:SetActive(true)
				SetActive(arg_64_1.leftNameGo_, true)

				arg_64_1.leftNameTxt_.text = arg_64_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_64_1.leftNameTxt_.transform)

				arg_64_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_64_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_64_1:RecordName(arg_64_1.leftNameTxt_.text)
				SetActive(arg_64_1.iconTrs_.gameObject, true)
				arg_64_1.iconController_:SetSelectedState("hero")

				arg_64_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_64_1.callingController_:SetSelectedState("normal")

				arg_64_1.keyicon_.color = Color.New(1, 1, 1)
				arg_64_1.icon_.color = Color.New(1, 1, 1)

				local var_67_3 = arg_64_1:FormatText(arg_64_1:GetWordFromCfg(939061016).content)

				arg_64_1.text_.text = var_67_3

				LuaForUtil.ClearLinePrefixSymbol(arg_64_1.text_)

				local var_67_5 = 49 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 49)

				if (49 <= 0 and var_67_2 or var_67_2 * (utf8.len(var_67_3) / 49)) > 0 and var_67_2 < var_67_5 then
					arg_64_1.talkMaxDuration = var_67_5

					if var_67_5 + var_67_1 > arg_64_1.duration_ then
						arg_64_1.duration_ = var_67_5 + var_67_1
					end
				end

				arg_64_1.text_.text = var_67_3
				arg_64_1.typewritter.percent = 0

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(false)
				arg_64_1:RecordContent(arg_64_1.text_.text)
			end

			local var_67_6 = math.max(var_67_2, arg_64_1.talkMaxDuration)

			if var_67_1 <= arg_64_1.time_ and arg_64_1.time_ < var_67_1 + var_67_6 then
				arg_64_1.typewritter.percent = (arg_64_1.time_ - var_67_1) / var_67_6

				arg_64_1.typewritter:SetDirty()
			end

			if arg_64_1.time_ >= var_67_1 + var_67_6 and arg_64_1.time_ < var_67_1 + var_67_6 + arg_67_0 then
				arg_64_1.typewritter.percent = 1

				arg_64_1.typewritter:SetDirty()
				arg_64_1:ShowNextGo(true)
			end
		end

		arg_64_1.nodeConfigList_ = {}

		arg_64_1:InitPlayNodeList()
	end,
	Play939061017 = function(arg_68_0, arg_68_1)
		arg_68_1.time_ = 0
		arg_68_1.frameCnt_ = 0
		arg_68_1.state_ = "playing"
		arg_68_1.curTalkId_ = 939061017
		arg_68_1.duration_ = 5

		SetActive(arg_68_1.tipsGo_, false)

		function arg_68_1.onSingleLineFinish_()
			arg_68_1.onSingleLineUpdate_ = nil
			arg_68_1.onSingleLineFinish_ = nil
			arg_68_1.state_ = "waiting"
		end

		function arg_68_1.playNext_(arg_70_0)
			if arg_70_0 == 1 then
				arg_68_0:Play939061018(arg_68_1)
			end
		end

		function arg_68_1.onSingleLineUpdate_(arg_71_0)
			local var_71_0 = 1.325

			if 0 < arg_68_1.time_ and arg_68_1.time_ <= 0 + arg_71_0 then
				arg_68_1.talkMaxDuration = 0
				arg_68_1.dialogCg_.alpha = 1

				arg_68_1.dialog_:SetActive(true)
				SetActive(arg_68_1.leftNameGo_, true)

				arg_68_1.leftNameTxt_.text = arg_68_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_68_1.leftNameTxt_.transform)

				arg_68_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_68_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_68_1:RecordName(arg_68_1.leftNameTxt_.text)
				SetActive(arg_68_1.iconTrs_.gameObject, true)
				arg_68_1.iconController_:SetSelectedState("hero")

				arg_68_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_68_1.callingController_:SetSelectedState("normal")

				arg_68_1.keyicon_.color = Color.New(1, 1, 1)
				arg_68_1.icon_.color = Color.New(1, 1, 1)

				local var_71_1 = arg_68_1:FormatText(arg_68_1:GetWordFromCfg(939061017).content)

				arg_68_1.text_.text = var_71_1

				LuaForUtil.ClearLinePrefixSymbol(arg_68_1.text_)

				local var_71_3 = 53 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 53)

				if (53 <= 0 and var_71_0 or var_71_0 * (utf8.len(var_71_1) / 53)) > 0 and var_71_0 < var_71_3 then
					arg_68_1.talkMaxDuration = var_71_3

					if var_71_3 + 0 > arg_68_1.duration_ then
						arg_68_1.duration_ = var_71_3 + 0
					end
				end

				arg_68_1.text_.text = var_71_1
				arg_68_1.typewritter.percent = 0

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(false)
				arg_68_1:RecordContent(arg_68_1.text_.text)
			end

			local var_71_4 = math.max(var_71_0, arg_68_1.talkMaxDuration)

			if 0 <= arg_68_1.time_ and arg_68_1.time_ < 0 + var_71_4 then
				arg_68_1.typewritter.percent = (arg_68_1.time_ - 0) / var_71_4

				arg_68_1.typewritter:SetDirty()
			end

			if arg_68_1.time_ >= 0 + var_71_4 and arg_68_1.time_ < 0 + var_71_4 + arg_71_0 then
				arg_68_1.typewritter.percent = 1

				arg_68_1.typewritter:SetDirty()
				arg_68_1:ShowNextGo(true)
			end
		end

		arg_68_1.nodeConfigList_ = {}

		arg_68_1:InitPlayNodeList()
	end,
	Play939061018 = function(arg_72_0, arg_72_1)
		arg_72_1.time_ = 0
		arg_72_1.frameCnt_ = 0
		arg_72_1.state_ = "playing"
		arg_72_1.curTalkId_ = 939061018
		arg_72_1.duration_ = 5

		SetActive(arg_72_1.tipsGo_, false)

		function arg_72_1.onSingleLineFinish_()
			arg_72_1.onSingleLineUpdate_ = nil
			arg_72_1.onSingleLineFinish_ = nil
			arg_72_1.state_ = "waiting"
		end

		function arg_72_1.playNext_(arg_74_0)
			if arg_74_0 == 1 then
				arg_72_0:Play939061019(arg_72_1)
			end
		end

		function arg_72_1.onSingleLineUpdate_(arg_75_0)
			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos1284ui_story = arg_72_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_75_0 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_0 then
				arg_72_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_72_1.time_ - 0) / var_75_0)
				arg_72_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).z)
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles = arg_72_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_0 and arg_72_1.time_ < 0 + var_75_0 + arg_75_0 then
				arg_72_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_72_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_72_1.actors_["1284ui_story"].transform.position).z)
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_72_1.actors_["1284ui_story"].transform.localEulerAngles = arg_72_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_75_1 = arg_72_1.actors_["6148ui_story"].transform

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1.var_.moveOldPos6148ui_story = var_75_1.localPosition

				local var_75_2 = GameObjectTools.GetOrAddComponent(var_75_1.gameObject, typeof(DynamicBoneHelper))

				if var_75_2 then
					var_75_2:EnableDynamicBone(false)
				end
			end

			local var_75_3 = 0.001

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_3 then
				var_75_1.localPosition = Vector3.Lerp(arg_72_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_72_1.time_ - 0) / var_75_3)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles
			end

			if arg_72_1.time_ >= 0 + var_75_3 and arg_72_1.time_ < 0 + var_75_3 + arg_75_0 then
				var_75_1.localPosition = Vector3.New(0, 100, 0)
				var_75_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_75_1.position).x, (manager.ui.mainCamera.transform.position - var_75_1.position).y, (manager.ui.mainCamera.transform.position - var_75_1.position).z)
				var_75_1.localEulerAngles.z = 0
				var_75_1.localEulerAngles.x = 0
				var_75_1.localEulerAngles = var_75_1.localEulerAngles

				local var_75_4 = GameObjectTools.GetOrAddComponent(var_75_1.gameObject, typeof(DynamicBoneHelper))

				if var_75_4 then
					var_75_4:EnableDynamicBone(true)
				end
			end

			local var_75_5 = arg_72_1.actors_["1284ui_story"]

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1284ui_story == nil then
				arg_72_1.var_.characterEffect1284ui_story = var_75_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_75_6 = 0.200000002980232

			if 0 <= arg_72_1.time_ and arg_72_1.time_ < 0 + var_75_6 and not isNil(var_75_5) then
				if arg_72_1.var_.characterEffect1284ui_story and not isNil(var_75_5) then
					arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_72_1.time_ >= 0 + var_75_6 and arg_72_1.time_ < 0 + var_75_6 + arg_75_0 and not isNil(var_75_5) and arg_72_1.var_.characterEffect1284ui_story then
				arg_72_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= 0 + arg_75_0 then
				arg_72_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_75_8 = 0
			local var_75_9 = 0.8

			if 0 < arg_72_1.time_ and arg_72_1.time_ <= var_75_8 + arg_75_0 then
				arg_72_1.talkMaxDuration = 0
				arg_72_1.dialogCg_.alpha = 1

				arg_72_1.dialog_:SetActive(true)
				SetActive(arg_72_1.leftNameGo_, true)

				arg_72_1.leftNameTxt_.text = arg_72_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_72_1.leftNameTxt_.transform)

				arg_72_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_72_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_72_1:RecordName(arg_72_1.leftNameTxt_.text)
				SetActive(arg_72_1.iconTrs_.gameObject, false)
				arg_72_1.callingController_:SetSelectedState("normal")

				local var_75_10 = arg_72_1:FormatText(arg_72_1:GetWordFromCfg(939061018).content)

				arg_72_1.text_.text = var_75_10

				LuaForUtil.ClearLinePrefixSymbol(arg_72_1.text_)

				local var_75_12 = 32 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_10) / 32)

				if (32 <= 0 and var_75_9 or var_75_9 * (utf8.len(var_75_10) / 32)) > 0 and var_75_9 < var_75_12 then
					arg_72_1.talkMaxDuration = var_75_12

					if var_75_12 + var_75_8 > arg_72_1.duration_ then
						arg_72_1.duration_ = var_75_12 + var_75_8
					end
				end

				arg_72_1.text_.text = var_75_10
				arg_72_1.typewritter.percent = 0

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(false)
				arg_72_1:RecordContent(arg_72_1.text_.text)
			end

			local var_75_13 = math.max(var_75_9, arg_72_1.talkMaxDuration)

			if var_75_8 <= arg_72_1.time_ and arg_72_1.time_ < var_75_8 + var_75_13 then
				arg_72_1.typewritter.percent = (arg_72_1.time_ - var_75_8) / var_75_13

				arg_72_1.typewritter:SetDirty()
			end

			if arg_72_1.time_ >= var_75_8 + var_75_13 and arg_72_1.time_ < var_75_8 + var_75_13 + arg_75_0 then
				arg_72_1.typewritter.percent = 1

				arg_72_1.typewritter:SetDirty()
				arg_72_1:ShowNextGo(true)
			end
		end

		arg_72_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_72_1:InitPlayNodeList()
	end,
	Play939061019 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939061019
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939061020(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			if arg_76_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_79_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_76_1.stage_.transform)

				var_79_0.name = "1211ui_story"
				var_79_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_76_1.actors_["1211ui_story"] = var_79_0

				local var_79_1 = var_79_0:GetComponentInChildren(typeof(CharacterEffect))

				var_79_1.enabled = true

				local var_79_2 = GameObjectTools.GetOrAddComponent(var_79_0, typeof(DynamicBoneHelper))

				if var_79_2 then
					var_79_2:EnableDynamicBone(false)
				end

				arg_76_1:ShowWeapon(var_79_1.transform, false)

				arg_76_1.var_["1211ui_story" .. "Animator"] = var_79_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_76_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_76_1.var_["1211ui_story" .. "LipSync"] = var_79_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_79_3 = arg_76_1.actors_["1211ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1211ui_story = var_79_3.localPosition
			end

			local var_79_4 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				var_79_3.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_76_1.time_ - 0) / var_79_4)
				var_79_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_3.position).x, (manager.ui.mainCamera.transform.position - var_79_3.position).y, (manager.ui.mainCamera.transform.position - var_79_3.position).z)
				var_79_3.localEulerAngles.z = 0
				var_79_3.localEulerAngles.x = 0
				var_79_3.localEulerAngles = var_79_3.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				var_79_3.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_79_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_3.position).x, (manager.ui.mainCamera.transform.position - var_79_3.position).y, (manager.ui.mainCamera.transform.position - var_79_3.position).z)
				var_79_3.localEulerAngles.z = 0
				var_79_3.localEulerAngles.x = 0
				var_79_3.localEulerAngles = var_79_3.localEulerAngles
			end

			local var_79_5 = arg_76_1.actors_["1054ui_story"].transform

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.var_.moveOldPos1054ui_story = var_79_5.localPosition

				local var_79_6 = GameObjectTools.GetOrAddComponent(var_79_5.gameObject, typeof(DynamicBoneHelper))

				if var_79_6 then
					var_79_6:EnableDynamicBone(false)
				end
			end

			local var_79_7 = 0.001

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_7 then
				var_79_5.localPosition = Vector3.Lerp(arg_76_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_76_1.time_ - 0) / var_79_7)
				var_79_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_5.position).x, (manager.ui.mainCamera.transform.position - var_79_5.position).y, (manager.ui.mainCamera.transform.position - var_79_5.position).z)
				var_79_5.localEulerAngles.z = 0
				var_79_5.localEulerAngles.x = 0
				var_79_5.localEulerAngles = var_79_5.localEulerAngles
			end

			if arg_76_1.time_ >= 0 + var_79_7 and arg_76_1.time_ < 0 + var_79_7 + arg_79_0 then
				var_79_5.localPosition = Vector3.New(0, 100, 0)
				var_79_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_79_5.position).x, (manager.ui.mainCamera.transform.position - var_79_5.position).y, (manager.ui.mainCamera.transform.position - var_79_5.position).z)
				var_79_5.localEulerAngles.z = 0
				var_79_5.localEulerAngles.x = 0
				var_79_5.localEulerAngles = var_79_5.localEulerAngles

				local var_79_8 = GameObjectTools.GetOrAddComponent(var_79_5.gameObject, typeof(DynamicBoneHelper))

				if var_79_8 then
					var_79_8:EnableDynamicBone(true)
				end
			end

			local var_79_9 = arg_76_1.actors_["1211ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1211ui_story == nil then
				arg_76_1.var_.characterEffect1211ui_story = var_79_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_10 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_10 and not isNil(var_79_9) then
				if arg_76_1.var_.characterEffect1211ui_story and not isNil(var_79_9) then
					arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_76_1.time_ >= 0 + var_79_10 and arg_76_1.time_ < 0 + var_79_10 + arg_79_0 and not isNil(var_79_9) and arg_76_1.var_.characterEffect1211ui_story then
				arg_76_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_79_12 = arg_76_1.actors_["1284ui_story"]

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 and not isNil(var_79_12) and arg_76_1.var_.characterEffect1284ui_story == nil then
				arg_76_1.var_.characterEffect1284ui_story = var_79_12:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_79_13 = 0.200000002980232

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_13 and not isNil(var_79_12) then
				if arg_76_1.var_.characterEffect1284ui_story and not isNil(var_79_12) then
					arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_76_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_76_1.time_ - 0) / var_79_13)
				end
			end

			if arg_76_1.time_ >= 0 + var_79_13 and arg_76_1.time_ < 0 + var_79_13 + arg_79_0 and not isNil(var_79_12) and arg_76_1.var_.characterEffect1284ui_story then
				arg_76_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_76_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_79_14 = 0
			local var_79_15 = 0.975

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= var_79_14 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, false)
				arg_76_1.callingController_:SetSelectedState("normal")

				local var_79_16 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(939061019).content)

				arg_76_1.text_.text = var_79_16

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_18 = 39 <= 0 and var_79_15 or var_79_15 * (utf8.len(var_79_16) / 39)

				if (39 <= 0 and var_79_15 or var_79_15 * (utf8.len(var_79_16) / 39)) > 0 and var_79_15 < var_79_18 then
					arg_76_1.talkMaxDuration = var_79_18

					if var_79_18 + var_79_14 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_18 + var_79_14
					end
				end

				arg_76_1.text_.text = var_79_16
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_19 = math.max(var_79_15, arg_76_1.talkMaxDuration)

			if var_79_14 <= arg_76_1.time_ and arg_76_1.time_ < var_79_14 + var_79_19 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - var_79_14) / var_79_19

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= var_79_14 + var_79_19 and arg_76_1.time_ < var_79_14 + var_79_19 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_76_1:InitPlayNodeList()
	end,
	Play939061020 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939061020
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939061021(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1248ui_story = arg_80_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_83_0 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_0 then
				arg_80_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1248ui_story, Vector3.New(0.7, -0.775, -6.18), (arg_80_1.time_ - 0) / var_83_0)
				arg_80_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1248ui_story"].transform.position).z)
				arg_80_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1248ui_story"].transform.localEulerAngles = arg_80_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_0 and arg_80_1.time_ < 0 + var_83_0 + arg_83_0 then
				arg_80_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0.7, -0.775, -6.18)
				arg_80_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_80_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_80_1.actors_["1248ui_story"].transform.position).z)
				arg_80_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_80_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_80_1.actors_["1248ui_story"].transform.localEulerAngles = arg_80_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_83_1 = arg_80_1.actors_["1284ui_story"].transform

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.var_.moveOldPos1284ui_story = var_83_1.localPosition
			end

			local var_83_2 = 0.001

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_2 then
				var_83_1.localPosition = Vector3.Lerp(arg_80_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_80_1.time_ - 0) / var_83_2)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			if arg_80_1.time_ >= 0 + var_83_2 and arg_80_1.time_ < 0 + var_83_2 + arg_83_0 then
				var_83_1.localPosition = Vector3.New(0, 100, 0)
				var_83_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_83_1.position).x, (manager.ui.mainCamera.transform.position - var_83_1.position).y, (manager.ui.mainCamera.transform.position - var_83_1.position).z)
				var_83_1.localEulerAngles.z = 0
				var_83_1.localEulerAngles.x = 0
				var_83_1.localEulerAngles = var_83_1.localEulerAngles
			end

			local var_83_3 = arg_80_1.actors_["1248ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect1248ui_story == nil then
				arg_80_1.var_.characterEffect1248ui_story = var_83_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_4 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 and not isNil(var_83_3) then
				if arg_80_1.var_.characterEffect1248ui_story and not isNil(var_83_3) then
					arg_80_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 and not isNil(var_83_3) and arg_80_1.var_.characterEffect1248ui_story then
				arg_80_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_83_6 = arg_80_1.actors_["1211ui_story"]

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect1211ui_story == nil then
				arg_80_1.var_.characterEffect1211ui_story = var_83_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_83_7 = 0.200000002980232

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_7 and not isNil(var_83_6) then
				if arg_80_1.var_.characterEffect1211ui_story and not isNil(var_83_6) then
					arg_80_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_80_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_80_1.time_ - 0) / var_83_7)
				end
			end

			if arg_80_1.time_ >= 0 + var_83_7 and arg_80_1.time_ < 0 + var_83_7 + arg_83_0 and not isNil(var_83_6) and arg_80_1.var_.characterEffect1211ui_story then
				arg_80_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_80_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action3_1")
			end

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_zhayanL", "EmotionTimelineAnimator")
			end

			local var_83_8 = 0
			local var_83_9 = 0.675

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= var_83_8 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, false)
				arg_80_1.callingController_:SetSelectedState("normal")

				local var_83_10 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(939061020).content)

				arg_80_1.text_.text = var_83_10

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_12 = 27 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_10) / 27)

				if (27 <= 0 and var_83_9 or var_83_9 * (utf8.len(var_83_10) / 27)) > 0 and var_83_9 < var_83_12 then
					arg_80_1.talkMaxDuration = var_83_12

					if var_83_12 + var_83_8 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_12 + var_83_8
					end
				end

				arg_80_1.text_.text = var_83_10
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_13 = math.max(var_83_9, arg_80_1.talkMaxDuration)

			if var_83_8 <= arg_80_1.time_ and arg_80_1.time_ < var_83_8 + var_83_13 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - var_83_8) / var_83_13

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= var_83_8 + var_83_13 and arg_80_1.time_ < var_83_8 + var_83_13 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_80_1:InitPlayNodeList()
	end,
	Play939061021 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939061021
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939061022(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos6148ui_story = arg_84_1.actors_["6148ui_story"].transform.localPosition

				local var_87_0 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_0 then
					var_87_0:EnableDynamicBone(false)
				end
			end

			local var_87_1 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_1 then
				arg_84_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_84_1.time_ - 0) / var_87_1)
				arg_84_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["6148ui_story"].transform.position).z)
				arg_84_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["6148ui_story"].transform.localEulerAngles = arg_84_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_1 and arg_84_1.time_ < 0 + var_87_1 + arg_87_0 then
				arg_84_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_84_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_84_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_84_1.actors_["6148ui_story"].transform.position).z)
				arg_84_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_84_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_84_1.actors_["6148ui_story"].transform.localEulerAngles = arg_84_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_87_2 = GameObjectTools.GetOrAddComponent(arg_84_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_87_2 then
					var_87_2:EnableDynamicBone(true)
				end
			end

			local var_87_3 = arg_84_1.actors_["1211ui_story"].transform

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.var_.moveOldPos1211ui_story = var_87_3.localPosition
			end

			local var_87_4 = 0.001

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				var_87_3.localPosition = Vector3.Lerp(arg_84_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_84_1.time_ - 0) / var_87_4)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				var_87_3.localPosition = Vector3.New(0, 100, 0)
				var_87_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_87_3.position).x, (manager.ui.mainCamera.transform.position - var_87_3.position).y, (manager.ui.mainCamera.transform.position - var_87_3.position).z)
				var_87_3.localEulerAngles.z = 0
				var_87_3.localEulerAngles.x = 0
				var_87_3.localEulerAngles = var_87_3.localEulerAngles
			end

			local var_87_5 = arg_84_1.actors_["6148ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect6148ui_story == nil then
				arg_84_1.var_.characterEffect6148ui_story = var_87_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_6 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_6 and not isNil(var_87_5) then
				if arg_84_1.var_.characterEffect6148ui_story and not isNil(var_87_5) then
					arg_84_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_84_1.time_ >= 0 + var_87_6 and arg_84_1.time_ < 0 + var_87_6 + arg_87_0 and not isNil(var_87_5) and arg_84_1.var_.characterEffect6148ui_story then
				arg_84_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_87_8 = arg_84_1.actors_["1248ui_story"]

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect1248ui_story == nil then
				arg_84_1.var_.characterEffect1248ui_story = var_87_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_87_9 = 0.200000002980232

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_9 and not isNil(var_87_8) then
				if arg_84_1.var_.characterEffect1248ui_story and not isNil(var_87_8) then
					arg_84_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_84_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_84_1.time_ - 0) / var_87_9)
				end
			end

			if arg_84_1.time_ >= 0 + var_87_9 and arg_84_1.time_ < 0 + var_87_9 + arg_87_0 and not isNil(var_87_8) and arg_84_1.var_.characterEffect1248ui_story then
				arg_84_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_84_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_87_10 = 0
			local var_87_11 = 0.15

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= var_87_10 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, false)
				arg_84_1.callingController_:SetSelectedState("normal")

				local var_87_12 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(939061021).content)

				arg_84_1.text_.text = var_87_12

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_14 = 6 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_12) / 6)

				if (6 <= 0 and var_87_11 or var_87_11 * (utf8.len(var_87_12) / 6)) > 0 and var_87_11 < var_87_14 then
					arg_84_1.talkMaxDuration = var_87_14

					if var_87_14 + var_87_10 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_14 + var_87_10
					end
				end

				arg_84_1.text_.text = var_87_12
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_15 = math.max(var_87_11, arg_84_1.talkMaxDuration)

			if var_87_10 <= arg_84_1.time_ and arg_84_1.time_ < var_87_10 + var_87_15 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - var_87_10) / var_87_15

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= var_87_10 + var_87_15 and arg_84_1.time_ < var_87_10 + var_87_15 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1211ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_84_1:InitPlayNodeList()
	end,
	Play939061022 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939061022
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939061023(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1054ui_story = arg_88_1.actors_["1054ui_story"].transform.localPosition

				local var_91_0 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_0 then
					var_91_0:EnableDynamicBone(false)
				end
			end

			local var_91_1 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_1 then
				arg_88_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_88_1.time_ - 0) / var_91_1)
				arg_88_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1054ui_story"].transform.position).z)
				arg_88_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1054ui_story"].transform.localEulerAngles = arg_88_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_1 and arg_88_1.time_ < 0 + var_91_1 + arg_91_0 then
				arg_88_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_88_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_88_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_88_1.actors_["1054ui_story"].transform.position).z)
				arg_88_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_88_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_88_1.actors_["1054ui_story"].transform.localEulerAngles = arg_88_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_91_2 = GameObjectTools.GetOrAddComponent(arg_88_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_91_2 then
					var_91_2:EnableDynamicBone(true)
				end
			end

			local var_91_3 = arg_88_1.actors_["1248ui_story"].transform

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.var_.moveOldPos1248ui_story = var_91_3.localPosition
			end

			local var_91_4 = 0.001

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_4 then
				var_91_3.localPosition = Vector3.Lerp(arg_88_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_88_1.time_ - 0) / var_91_4)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			if arg_88_1.time_ >= 0 + var_91_4 and arg_88_1.time_ < 0 + var_91_4 + arg_91_0 then
				var_91_3.localPosition = Vector3.New(0, 100, 0)
				var_91_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_91_3.position).x, (manager.ui.mainCamera.transform.position - var_91_3.position).y, (manager.ui.mainCamera.transform.position - var_91_3.position).z)
				var_91_3.localEulerAngles.z = 0
				var_91_3.localEulerAngles.x = 0
				var_91_3.localEulerAngles = var_91_3.localEulerAngles
			end

			local var_91_5 = arg_88_1.actors_["1054ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1054ui_story == nil then
				arg_88_1.var_.characterEffect1054ui_story = var_91_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_6 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_6 and not isNil(var_91_5) then
				if arg_88_1.var_.characterEffect1054ui_story and not isNil(var_91_5) then
					arg_88_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_88_1.time_ >= 0 + var_91_6 and arg_88_1.time_ < 0 + var_91_6 + arg_91_0 and not isNil(var_91_5) and arg_88_1.var_.characterEffect1054ui_story then
				arg_88_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_91_8 = arg_88_1.actors_["6148ui_story"]

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.characterEffect6148ui_story == nil then
				arg_88_1.var_.characterEffect6148ui_story = var_91_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_91_9 = 0.200000002980232

			if 0 <= arg_88_1.time_ and arg_88_1.time_ < 0 + var_91_9 and not isNil(var_91_8) then
				if arg_88_1.var_.characterEffect6148ui_story and not isNil(var_91_8) then
					arg_88_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_88_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_88_1.time_ - 0) / var_91_9)
				end
			end

			if arg_88_1.time_ >= 0 + var_91_9 and arg_88_1.time_ < 0 + var_91_9 + arg_91_0 and not isNil(var_91_8) and arg_88_1.var_.characterEffect6148ui_story then
				arg_88_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_88_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_91_10 = 0
			local var_91_11 = 0.15

			if 0 < arg_88_1.time_ and arg_88_1.time_ <= var_91_10 + arg_91_0 then
				arg_88_1.talkMaxDuration = 0
				arg_88_1.dialogCg_.alpha = 1

				arg_88_1.dialog_:SetActive(true)
				SetActive(arg_88_1.leftNameGo_, true)

				arg_88_1.leftNameTxt_.text = arg_88_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_88_1.leftNameTxt_.transform)

				arg_88_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_88_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_88_1:RecordName(arg_88_1.leftNameTxt_.text)
				SetActive(arg_88_1.iconTrs_.gameObject, false)
				arg_88_1.callingController_:SetSelectedState("normal")

				local var_91_12 = arg_88_1:FormatText(arg_88_1:GetWordFromCfg(939061022).content)

				arg_88_1.text_.text = var_91_12

				LuaForUtil.ClearLinePrefixSymbol(arg_88_1.text_)

				local var_91_14 = 6 <= 0 and var_91_11 or var_91_11 * (utf8.len(var_91_12) / 6)

				if (6 <= 0 and var_91_11 or var_91_11 * (utf8.len(var_91_12) / 6)) > 0 and var_91_11 < var_91_14 then
					arg_88_1.talkMaxDuration = var_91_14

					if var_91_14 + var_91_10 > arg_88_1.duration_ then
						arg_88_1.duration_ = var_91_14 + var_91_10
					end
				end

				arg_88_1.text_.text = var_91_12
				arg_88_1.typewritter.percent = 0

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(false)
				arg_88_1:RecordContent(arg_88_1.text_.text)
			end

			local var_91_15 = math.max(var_91_11, arg_88_1.talkMaxDuration)

			if var_91_10 <= arg_88_1.time_ and arg_88_1.time_ < var_91_10 + var_91_15 then
				arg_88_1.typewritter.percent = (arg_88_1.time_ - var_91_10) / var_91_15

				arg_88_1.typewritter:SetDirty()
			end

			if arg_88_1.time_ >= var_91_10 + var_91_15 and arg_88_1.time_ < var_91_10 + var_91_15 + arg_91_0 then
				arg_88_1.typewritter.percent = 1

				arg_88_1.typewritter:SetDirty()
				arg_88_1:ShowNextGo(true)
			end
		end

		arg_88_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1054ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1248ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_88_1:InitPlayNodeList()
	end,
	Play939061023 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939061023
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
			arg_92_1.auto_ = false
		end

		function arg_92_1.playNext_(arg_94_0)
			arg_92_1.onStoryFinished_()
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(arg_92_1.actors_["1054ui_story"]) and arg_92_1.var_.characterEffect1054ui_story == nil then
				arg_92_1.var_.characterEffect1054ui_story = arg_92_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_0 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_0 and not isNil(arg_92_1.actors_["1054ui_story"]) then
				if arg_92_1.var_.characterEffect1054ui_story and not isNil(arg_92_1.actors_["1054ui_story"]) then
					arg_92_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_92_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_92_1.time_ - 0) / var_95_0)
				end
			end

			if arg_92_1.time_ >= 0 + var_95_0 and arg_92_1.time_ < 0 + var_95_0 + arg_95_0 and not isNil(arg_92_1.actors_["1054ui_story"]) and arg_92_1.var_.characterEffect1054ui_story then
				arg_92_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_92_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_95_1 = 0
			local var_95_2 = 0.425

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_1 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, true)
				arg_92_1.iconController_:SetSelectedState("hero")

				arg_92_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_92_1.callingController_:SetSelectedState("normal")

				arg_92_1.keyicon_.color = Color.New(1, 1, 1)
				arg_92_1.icon_.color = Color.New(1, 1, 1)

				local var_95_3 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(939061023).content)

				arg_92_1.text_.text = var_95_3

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_5 = 17 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 17)

				if (17 <= 0 and var_95_2 or var_95_2 * (utf8.len(var_95_3) / 17)) > 0 and var_95_2 < var_95_5 then
					arg_92_1.talkMaxDuration = var_95_5

					if var_95_5 + var_95_1 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_5 + var_95_1
					end
				end

				arg_92_1.text_.text = var_95_3
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_6 = math.max(var_95_2, arg_92_1.talkMaxDuration)

			if var_95_1 <= arg_92_1.time_ and arg_92_1.time_ < var_95_1 + var_95_6 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_1) / var_95_6

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_1 + var_95_6 and arg_92_1.time_ < var_95_1 + var_95_6 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {}

		arg_92_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12"
	},
	voices = {},
	skipMarkers = {
		939061001
	}
}
