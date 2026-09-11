return {
	Play939062001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 939062001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play939062002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.I06 == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I06")
				var_4_0.name = "I06"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.I06 = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.I06

				arg_1_1.bgs_.I06.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I06" then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_4_11 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

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

			if 0.5 < arg_1_1.time_ and arg_1_1.time_ <= 0.5 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_3_0_story_intense_argue", "bgm_activity_3_0_story_intense_argue")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_14 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_14

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_14
						arg_1_1.bgmTxt2_.text = var_4_14
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

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_15 = 2
			local var_4_16 = 1

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_15 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_17 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_17:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(939062001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 40 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 40)

				if (40 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 40)) > 0 and var_4_16 < var_4_20 then
					arg_1_1.talkMaxDuration = var_4_20
					var_4_15 = var_4_15 + 0.3

					if var_4_20 + var_4_15 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_20 + var_4_15
					end
				end

				arg_1_1.text_.text = var_4_18
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_21 = var_4_15 + 0.3
			local var_4_22 = math.max(var_4_16, arg_1_1.talkMaxDuration)

			if var_4_15 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_21 + var_4_22 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_21) / var_4_22

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_21 + var_4_22 and arg_1_1.time_ < var_4_21 + var_4_22 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {}

		arg_1_1:InitPlayNodeList()
	end,
	Play939062002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 939062002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play939062003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if arg_9_1.actors_["1284ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1284ui_story"))) then
				local var_12_0 = Object.Instantiate(Asset.Load("Char/" .. "1284ui_story"), arg_9_1.stage_.transform)

				var_12_0.name = "1284ui_story"
				var_12_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_9_1.actors_["1284ui_story"] = var_12_0

				local var_12_1 = var_12_0:GetComponentInChildren(typeof(CharacterEffect))

				var_12_1.enabled = true

				local var_12_2 = GameObjectTools.GetOrAddComponent(var_12_0, typeof(DynamicBoneHelper))

				if var_12_2 then
					var_12_2:EnableDynamicBone(false)
				end

				arg_9_1:ShowWeapon(var_12_1.transform, false)

				arg_9_1.var_["1284ui_story" .. "Animator"] = var_12_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_9_1.var_["1284ui_story" .. "Animator"].applyRootMotion = true
				arg_9_1.var_["1284ui_story" .. "LipSync"] = var_12_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_12_3 = arg_9_1.actors_["1284ui_story"].transform

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.var_.moveOldPos1284ui_story = var_12_3.localPosition
			end

			local var_12_4 = 0.001

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				var_12_3.localPosition = Vector3.Lerp(arg_9_1.var_.moveOldPos1284ui_story, Vector3.New(-0.7, -0.985, -6.22), (arg_9_1.time_ - 0) / var_12_4)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				var_12_3.localPosition = Vector3.New(-0.7, -0.985, -6.22)
				var_12_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_12_3.position).x, (manager.ui.mainCamera.transform.position - var_12_3.position).y, (manager.ui.mainCamera.transform.position - var_12_3.position).z)
				var_12_3.localEulerAngles.z = 0
				var_12_3.localEulerAngles.x = 0
				var_12_3.localEulerAngles = var_12_3.localEulerAngles
			end

			local var_12_5 = arg_9_1.actors_["1284ui_story"]

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1284ui_story == nil then
				arg_9_1.var_.characterEffect1284ui_story = var_12_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_12_6 = 0.200000002980232

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_6 and not isNil(var_12_5) then
				if arg_9_1.var_.characterEffect1284ui_story and not isNil(var_12_5) then
					arg_9_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_9_1.time_ >= 0 + var_12_6 and arg_9_1.time_ < 0 + var_12_6 + arg_12_0 and not isNil(var_12_5) and arg_9_1.var_.characterEffect1284ui_story then
				arg_9_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action3_1")
			end

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_12_8 = 0
			local var_12_9 = 0.275

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_8 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, true)

				arg_9_1.leftNameTxt_.text = arg_9_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_9_1.leftNameTxt_.transform)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1.leftNameTxt_.text)
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_10 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(939062002).content)

				arg_9_1.text_.text = var_12_10

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_12 = 11 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_10) / 11)

				if (11 <= 0 and var_12_9 or var_12_9 * (utf8.len(var_12_10) / 11)) > 0 and var_12_9 < var_12_12 then
					arg_9_1.talkMaxDuration = var_12_12

					if var_12_12 + var_12_8 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_12 + var_12_8
					end
				end

				arg_9_1.text_.text = var_12_10
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_13 = math.max(var_12_9, arg_9_1.talkMaxDuration)

			if var_12_8 <= arg_9_1.time_ and arg_9_1.time_ < var_12_8 + var_12_13 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_8) / var_12_13

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_8 + var_12_13 and arg_9_1.time_ < var_12_8 + var_12_13 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {
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

		arg_9_1:InitPlayNodeList()
	end,
	Play939062003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 939062003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play939062004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1054ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1054ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1054ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1054ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1054ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1054ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1054ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1054ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1054ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1054ui_story = var_16_3.localPosition

				local var_16_4 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_4 then
					var_16_4:EnableDynamicBone(false)
				end
			end

			local var_16_5 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_5 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1054ui_story, Vector3.New(0.7, -0.985, -6), (arg_13_1.time_ - 0) / var_16_5)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_5 and arg_13_1.time_ < 0 + var_16_5 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0.7, -0.985, -6)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles

				local var_16_6 = GameObjectTools.GetOrAddComponent(var_16_3.gameObject, typeof(DynamicBoneHelper))

				if var_16_6 then
					var_16_6:EnableDynamicBone(true)
				end
			end

			local var_16_7 = arg_13_1.actors_["1054ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1054ui_story == nil then
				arg_13_1.var_.characterEffect1054ui_story = var_16_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_8 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_8 and not isNil(var_16_7) then
				if arg_13_1.var_.characterEffect1054ui_story and not isNil(var_16_7) then
					arg_13_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_8 and arg_13_1.time_ < 0 + var_16_8 + arg_16_0 and not isNil(var_16_7) and arg_13_1.var_.characterEffect1054ui_story then
				arg_13_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_16_10 = arg_13_1.actors_["1284ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1284ui_story == nil then
				arg_13_1.var_.characterEffect1284ui_story = var_16_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_11 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_11 and not isNil(var_16_10) then
				if arg_13_1.var_.characterEffect1284ui_story and not isNil(var_16_10) then
					arg_13_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_13_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_13_1.time_ - 0) / var_16_11)
				end
			end

			if arg_13_1.time_ >= 0 + var_16_11 and arg_13_1.time_ < 0 + var_16_11 + arg_16_0 and not isNil(var_16_10) and arg_13_1.var_.characterEffect1284ui_story then
				arg_13_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_13_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_16_12 = 0
			local var_16_13 = 0.425

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_12 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_14 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(939062003).content)

				arg_13_1.text_.text = var_16_14

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_16 = 17 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_14) / 17)

				if (17 <= 0 and var_16_13 or var_16_13 * (utf8.len(var_16_14) / 17)) > 0 and var_16_13 < var_16_16 then
					arg_13_1.talkMaxDuration = var_16_16

					if var_16_16 + var_16_12 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_16 + var_16_12
					end
				end

				arg_13_1.text_.text = var_16_14
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_17 = math.max(var_16_13, arg_13_1.talkMaxDuration)

			if var_16_12 <= arg_13_1.time_ and arg_13_1.time_ < var_16_12 + var_16_17 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_12) / var_16_17

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_12 + var_16_17 and arg_13_1.time_ < var_16_12 + var_16_17 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
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

		arg_13_1:InitPlayNodeList()
	end,
	Play939062004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 939062004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play939062005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1054ui_story = arg_17_1.actors_["1054ui_story"].transform.localPosition

				local var_20_0 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_0 then
					var_20_0:EnableDynamicBone(false)
				end
			end

			local var_20_1 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_1 then
				arg_17_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_1)
				arg_17_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).z)
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles = arg_17_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_1 and arg_17_1.time_ < 0 + var_20_1 + arg_20_0 then
				arg_17_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1054ui_story"].transform.position).z)
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1054ui_story"].transform.localEulerAngles = arg_17_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_20_2 = GameObjectTools.GetOrAddComponent(arg_17_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_20_2 then
					var_20_2:EnableDynamicBone(true)
				end
			end

			local var_20_3 = arg_17_1.actors_["1284ui_story"].transform

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1284ui_story = var_20_3.localPosition
			end

			local var_20_4 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_4 then
				var_20_3.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_4)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_4 and arg_17_1.time_ < 0 + var_20_4 + arg_20_0 then
				var_20_3.localPosition = Vector3.New(0, 100, 0)
				var_20_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_20_3.position).x, (manager.ui.mainCamera.transform.position - var_20_3.position).y, (manager.ui.mainCamera.transform.position - var_20_3.position).z)
				var_20_3.localEulerAngles.z = 0
				var_20_3.localEulerAngles.x = 0
				var_20_3.localEulerAngles = var_20_3.localEulerAngles
			end

			local var_20_5 = 0
			local var_20_6 = 1.375

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_5 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, true)

				arg_17_1.leftNameTxt_.text = arg_17_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_17_1.leftNameTxt_.transform)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1.leftNameTxt_.text)
				SetActive(arg_17_1.iconTrs_.gameObject, true)
				arg_17_1.iconController_:SetSelectedState("hero")

				arg_17_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_17_1.callingController_:SetSelectedState("calling")

				arg_17_1.keyicon_.color = Color.New(1, 1, 1)
				arg_17_1.icon_.color = Color.New(1, 1, 1)

				local var_20_7 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(939062004).content)

				arg_17_1.text_.text = var_20_7

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_9 = 55 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 55)

				if (55 <= 0 and var_20_6 or var_20_6 * (utf8.len(var_20_7) / 55)) > 0 and var_20_6 < var_20_9 then
					arg_17_1.talkMaxDuration = var_20_9

					if var_20_9 + var_20_5 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_9 + var_20_5
					end
				end

				arg_17_1.text_.text = var_20_7
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_10 = math.max(var_20_6, arg_17_1.talkMaxDuration)

			if var_20_5 <= arg_17_1.time_ and arg_17_1.time_ < var_20_5 + var_20_10 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_5) / var_20_10

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_5 + var_20_10 and arg_17_1.time_ < var_20_5 + var_20_10 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
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
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play939062005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 939062005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play939062006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1248ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1248ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1248ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1248ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1248ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1248ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1248ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1248ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1248ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1248ui_story == nil then
				arg_21_1.var_.characterEffect1248ui_story = var_24_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_4 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 and not isNil(var_24_3) then
				if arg_21_1.var_.characterEffect1248ui_story and not isNil(var_24_3) then
					arg_21_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_21_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_21_1.time_ - 0) / var_24_4)
				end
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 and not isNil(var_24_3) and arg_21_1.var_.characterEffect1248ui_story then
				arg_21_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_21_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_24_5 = 0
			local var_24_6 = 0.95

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_5 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, true)
				arg_21_1.iconController_:SetSelectedState("hero")

				arg_21_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_21_1.callingController_:SetSelectedState("normal")

				arg_21_1.keyicon_.color = Color.New(1, 1, 1)
				arg_21_1.icon_.color = Color.New(1, 1, 1)

				local var_24_7 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(939062005).content)

				arg_21_1.text_.text = var_24_7

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_9 = 38 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 38)

				if (38 <= 0 and var_24_6 or var_24_6 * (utf8.len(var_24_7) / 38)) > 0 and var_24_6 < var_24_9 then
					arg_21_1.talkMaxDuration = var_24_9

					if var_24_9 + var_24_5 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_9 + var_24_5
					end
				end

				arg_21_1.text_.text = var_24_7
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_10 = math.max(var_24_6, arg_21_1.talkMaxDuration)

			if var_24_5 <= arg_21_1.time_ and arg_21_1.time_ < var_24_5 + var_24_10 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_5) / var_24_10

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_5 + var_24_10 and arg_21_1.time_ < var_24_5 + var_24_10 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {}

		arg_21_1:InitPlayNodeList()
	end,
	Play939062006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 939062006
		arg_25_1.duration_ = 6.17

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play939062007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				local var_28_0 = arg_25_1.var_.effecthainengdaoguang1

				if not arg_25_1.var_.effecthainengdaoguang1 then
					var_28_0 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang01"), manager.ui.mainCamera.transform)
					var_28_0.name = "hainengdaoguang1"
					arg_25_1.var_.effecthainengdaoguang1 = var_28_0
				else
					var_28_0.transform:SetParent(manager.ui.mainCamera.transform)
				end

				var_28_0.transform.localPosition = Vector3.New(0, 0, 0)
				var_28_0.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.23333333333333 < arg_25_1.time_ and arg_25_1.time_ <= 2.23333333333333 + arg_28_0 then
				if arg_25_1.var_.effecthainengdaoguang1 then
					Object.Destroy(arg_25_1.var_.effecthainengdaoguang1)

					arg_25_1.var_.effecthainengdaoguang1 = nil
				end
			end

			local var_28_3 = manager.ui.mainCamera.transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.shakeOldPos = var_28_3.localPosition
			end

			local var_28_4 = 0.333333333333333

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				local var_28_5, var_28_6 = math.modf((arg_25_1.time_ - 0) / 0.066)

				var_28_3.localPosition = Vector3.New(var_28_6 * 0.13, var_28_6 * 0.13, var_28_6 * 0.13) + arg_25_1.var_.shakeOldPos
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = arg_25_1.var_.shakeOldPos
			end

			local var_28_7 = 0

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_7 + arg_28_0 then
				arg_25_1.allBtn_.enabled = false
			end

			if arg_25_1.time_ >= var_28_7 + 0.766666666666667 and arg_25_1.time_ < var_28_7 + 0.766666666666667 + arg_28_0 then
				arg_25_1.allBtn_.enabled = true
			end

			if arg_25_1.frameCnt_ <= 1 then
				arg_25_1.dialog_:SetActive(false)
			end

			local var_28_8 = 1.16666666666667
			local var_28_9 = 0.775

			if 1.16666666666667 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0

				arg_25_1.dialog_:SetActive(true)

				arg_25_1.dialogCg_.alpha = 0

				local var_28_10 = LeanTween.value(arg_25_1.dialog_, 0, 1, 0.3)

				var_28_10:setOnUpdate(LuaHelper.FloatAction(function(arg_29_0)
					arg_25_1.dialogCg_.alpha = arg_29_0
				end))
				var_28_10:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_25_1.dialog_)
					var_28_10:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_25_1.duration_ = arg_25_1.duration_ + 0.3

				SetActive(arg_25_1.leftNameGo_, false)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_11 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(939062006).content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 31 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 31)

				if (31 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 31)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13
					var_28_8 = var_28_8 + 0.3

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_14 = var_28_8 + 0.3
			local var_28_15 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 + 0.3 <= arg_25_1.time_ and arg_25_1.time_ < var_28_14 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_14) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_14 + var_28_15 and arg_25_1.time_ < var_28_14 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {}

		arg_25_1:InitPlayNodeList()
	end,
	Play939062007 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 939062007
		arg_31_1.duration_ = 5

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play939062008(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1.var_.moveOldPos1284ui_story = arg_31_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_34_0 = 0.001

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_0 then
				arg_31_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_31_1.var_.moveOldPos1284ui_story, Vector3.New(0, -0.985, -6.22), (arg_31_1.time_ - 0) / var_34_0)
				arg_31_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).z)
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles = arg_31_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_31_1.time_ >= 0 + var_34_0 and arg_31_1.time_ < 0 + var_34_0 + arg_34_0 then
				arg_31_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6.22)
				arg_31_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_31_1.actors_["1284ui_story"].transform.position).z)
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_31_1.actors_["1284ui_story"].transform.localEulerAngles = arg_31_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_34_1 = arg_31_1.actors_["1284ui_story"]

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1284ui_story == nil then
				arg_31_1.var_.characterEffect1284ui_story = var_34_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_34_2 = 0.200000002980232

			if 0 <= arg_31_1.time_ and arg_31_1.time_ < 0 + var_34_2 and not isNil(var_34_1) then
				if arg_31_1.var_.characterEffect1284ui_story and not isNil(var_34_1) then
					arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_31_1.time_ >= 0 + var_34_2 and arg_31_1.time_ < 0 + var_34_2 + arg_34_0 and not isNil(var_34_1) and arg_31_1.var_.characterEffect1284ui_story then
				arg_31_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= 0 + arg_34_0 then
				arg_31_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_34_4 = 0
			local var_34_5 = 0.35

			if 0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_4 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0
				arg_31_1.dialogCg_.alpha = 1

				arg_31_1.dialog_:SetActive(true)
				SetActive(arg_31_1.leftNameGo_, true)

				arg_31_1.leftNameTxt_.text = arg_31_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_31_1.leftNameTxt_.transform)

				arg_31_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_31_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_31_1:RecordName(arg_31_1.leftNameTxt_.text)
				SetActive(arg_31_1.iconTrs_.gameObject, false)
				arg_31_1.callingController_:SetSelectedState("normal")

				local var_34_6 = arg_31_1:FormatText(arg_31_1:GetWordFromCfg(939062007).content)

				arg_31_1.text_.text = var_34_6

				LuaForUtil.ClearLinePrefixSymbol(arg_31_1.text_)

				local var_34_8 = 14 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 14)

				if (14 <= 0 and var_34_5 or var_34_5 * (utf8.len(var_34_6) / 14)) > 0 and var_34_5 < var_34_8 then
					arg_31_1.talkMaxDuration = var_34_8

					if var_34_8 + var_34_4 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_8 + var_34_4
					end
				end

				arg_31_1.text_.text = var_34_6
				arg_31_1.typewritter.percent = 0

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(false)
				arg_31_1:RecordContent(arg_31_1.text_.text)
			end

			local var_34_9 = math.max(var_34_5, arg_31_1.talkMaxDuration)

			if var_34_4 <= arg_31_1.time_ and arg_31_1.time_ < var_34_4 + var_34_9 then
				arg_31_1.typewritter.percent = (arg_31_1.time_ - var_34_4) / var_34_9

				arg_31_1.typewritter:SetDirty()
			end

			if arg_31_1.time_ >= var_34_4 + var_34_9 and arg_31_1.time_ < var_34_4 + var_34_9 + arg_34_0 then
				arg_31_1.typewritter.percent = 1

				arg_31_1.typewritter:SetDirty()
				arg_31_1:ShowNextGo(true)
			end
		end

		arg_31_1.nodeConfigList_ = {
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

		arg_31_1:InitPlayNodeList()
	end,
	Play939062008 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 939062008
		arg_35_1.duration_ = 5

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play939062009(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 then
				arg_35_1.var_.moveOldPos1284ui_story = arg_35_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_38_0 = 0.001

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_0 then
				arg_35_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_35_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_35_1.time_ - 0) / var_38_0)
				arg_35_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1284ui_story"].transform.position).z)
				arg_35_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1284ui_story"].transform.localEulerAngles = arg_35_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_35_1.time_ >= 0 + var_38_0 and arg_35_1.time_ < 0 + var_38_0 + arg_38_0 then
				arg_35_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_35_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_35_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_35_1.actors_["1284ui_story"].transform.position).z)
				arg_35_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_35_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_35_1.actors_["1284ui_story"].transform.localEulerAngles = arg_35_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_38_1 = arg_35_1.actors_["1284ui_story"]

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= 0 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1284ui_story == nil then
				arg_35_1.var_.characterEffect1284ui_story = var_38_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_38_2 = 0.200000002980232

			if 0 <= arg_35_1.time_ and arg_35_1.time_ < 0 + var_38_2 and not isNil(var_38_1) then
				if arg_35_1.var_.characterEffect1284ui_story and not isNil(var_38_1) then
					arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_35_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_35_1.time_ - 0) / var_38_2)
				end
			end

			if arg_35_1.time_ >= 0 + var_38_2 and arg_35_1.time_ < 0 + var_38_2 + arg_38_0 and not isNil(var_38_1) and arg_35_1.var_.characterEffect1284ui_story then
				arg_35_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_35_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			local var_38_3 = 0
			local var_38_4 = 0.4

			if 0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0
				arg_35_1.dialogCg_.alpha = 1

				arg_35_1.dialog_:SetActive(true)
				SetActive(arg_35_1.leftNameGo_, true)

				arg_35_1.leftNameTxt_.text = arg_35_1:FormatText(StoryNameCfg[1544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_35_1.leftNameTxt_.transform)

				arg_35_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_35_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_35_1:RecordName(arg_35_1.leftNameTxt_.text)
				SetActive(arg_35_1.iconTrs_.gameObject, true)
				arg_35_1.iconController_:SetSelectedState("hero")

				arg_35_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_35_1.callingController_:SetSelectedState("normal")

				arg_35_1.keyicon_.color = Color.New(1, 1, 1)
				arg_35_1.icon_.color = Color.New(1, 1, 1)

				local var_38_5 = arg_35_1:FormatText(arg_35_1:GetWordFromCfg(939062008).content)

				arg_35_1.text_.text = var_38_5

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.text_)

				local var_38_7 = 16 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 16)

				if (16 <= 0 and var_38_4 or var_38_4 * (utf8.len(var_38_5) / 16)) > 0 and var_38_4 < var_38_7 then
					arg_35_1.talkMaxDuration = var_38_7

					if var_38_7 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_7 + var_38_3
					end
				end

				arg_35_1.text_.text = var_38_5
				arg_35_1.typewritter.percent = 0

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(false)
				arg_35_1:RecordContent(arg_35_1.text_.text)
			end

			local var_38_8 = math.max(var_38_4, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_8 then
				arg_35_1.typewritter.percent = (arg_35_1.time_ - var_38_3) / var_38_8

				arg_35_1.typewritter:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_8 and arg_35_1.time_ < var_38_3 + var_38_8 + arg_38_0 then
				arg_35_1.typewritter.percent = 1

				arg_35_1.typewritter:SetDirty()
				arg_35_1:ShowNextGo(true)
			end
		end

		arg_35_1.nodeConfigList_ = {
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

		arg_35_1:InitPlayNodeList()
	end,
	Play939062009 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 939062009
		arg_39_1.duration_ = 5

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play939062010(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0.55

			if 0 < arg_39_1.time_ and arg_39_1.time_ <= 0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0
				arg_39_1.dialogCg_.alpha = 1

				arg_39_1.dialog_:SetActive(true)
				SetActive(arg_39_1.leftNameGo_, true)

				arg_39_1.leftNameTxt_.text = arg_39_1:FormatText(StoryNameCfg[1544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_39_1.leftNameTxt_.transform)

				arg_39_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_39_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_39_1:RecordName(arg_39_1.leftNameTxt_.text)
				SetActive(arg_39_1.iconTrs_.gameObject, true)
				arg_39_1.iconController_:SetSelectedState("hero")

				arg_39_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_39_1.callingController_:SetSelectedState("normal")

				arg_39_1.keyicon_.color = Color.New(1, 1, 1)
				arg_39_1.icon_.color = Color.New(1, 1, 1)

				local var_42_1 = arg_39_1:FormatText(arg_39_1:GetWordFromCfg(939062009).content)

				arg_39_1.text_.text = var_42_1

				LuaForUtil.ClearLinePrefixSymbol(arg_39_1.text_)

				local var_42_3 = 22 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 22)

				if (22 <= 0 and var_42_0 or var_42_0 * (utf8.len(var_42_1) / 22)) > 0 and var_42_0 < var_42_3 then
					arg_39_1.talkMaxDuration = var_42_3

					if var_42_3 + 0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_3 + 0
					end
				end

				arg_39_1.text_.text = var_42_1
				arg_39_1.typewritter.percent = 0

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(false)
				arg_39_1:RecordContent(arg_39_1.text_.text)
			end

			local var_42_4 = math.max(var_42_0, arg_39_1.talkMaxDuration)

			if 0 <= arg_39_1.time_ and arg_39_1.time_ < 0 + var_42_4 then
				arg_39_1.typewritter.percent = (arg_39_1.time_ - 0) / var_42_4

				arg_39_1.typewritter:SetDirty()
			end

			if arg_39_1.time_ >= 0 + var_42_4 and arg_39_1.time_ < 0 + var_42_4 + arg_42_0 then
				arg_39_1.typewritter.percent = 1

				arg_39_1.typewritter:SetDirty()
				arg_39_1:ShowNextGo(true)
			end
		end

		arg_39_1.nodeConfigList_ = {}

		arg_39_1:InitPlayNodeList()
	end,
	Play939062010 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 939062010
		arg_43_1.duration_ = 5

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play939062011(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			if arg_43_1.actors_["6148ui_story"] == nil and not isNil((Asset.Load("Char/" .. "6148ui_story"))) then
				local var_46_0 = Object.Instantiate(Asset.Load("Char/" .. "6148ui_story"), arg_43_1.stage_.transform)

				var_46_0.name = "6148ui_story"
				var_46_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_43_1.actors_["6148ui_story"] = var_46_0

				local var_46_1 = var_46_0:GetComponentInChildren(typeof(CharacterEffect))

				var_46_1.enabled = true

				local var_46_2 = GameObjectTools.GetOrAddComponent(var_46_0, typeof(DynamicBoneHelper))

				if var_46_2 then
					var_46_2:EnableDynamicBone(false)
				end

				arg_43_1:ShowWeapon(var_46_1.transform, false)

				arg_43_1.var_["6148ui_story" .. "Animator"] = var_46_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_43_1.var_["6148ui_story" .. "Animator"].applyRootMotion = true
				arg_43_1.var_["6148ui_story" .. "LipSync"] = var_46_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_46_3 = arg_43_1.actors_["6148ui_story"].transform

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1.var_.moveOldPos6148ui_story = var_46_3.localPosition

				local var_46_4 = GameObjectTools.GetOrAddComponent(var_46_3.gameObject, typeof(DynamicBoneHelper))

				if var_46_4 then
					var_46_4:EnableDynamicBone(false)
				end
			end

			local var_46_5 = 0.001

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_5 then
				var_46_3.localPosition = Vector3.Lerp(arg_43_1.var_.moveOldPos6148ui_story, Vector3.New(0, -0.985, -6), (arg_43_1.time_ - 0) / var_46_5)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles
			end

			if arg_43_1.time_ >= 0 + var_46_5 and arg_43_1.time_ < 0 + var_46_5 + arg_46_0 then
				var_46_3.localPosition = Vector3.New(0, -0.985, -6)
				var_46_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_46_3.position).x, (manager.ui.mainCamera.transform.position - var_46_3.position).y, (manager.ui.mainCamera.transform.position - var_46_3.position).z)
				var_46_3.localEulerAngles.z = 0
				var_46_3.localEulerAngles.x = 0
				var_46_3.localEulerAngles = var_46_3.localEulerAngles

				local var_46_6 = GameObjectTools.GetOrAddComponent(var_46_3.gameObject, typeof(DynamicBoneHelper))

				if var_46_6 then
					var_46_6:EnableDynamicBone(true)
				end
			end

			local var_46_7 = arg_43_1.actors_["6148ui_story"]

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.characterEffect6148ui_story == nil then
				arg_43_1.var_.characterEffect6148ui_story = var_46_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_46_8 = 0.200000002980232

			if 0 <= arg_43_1.time_ and arg_43_1.time_ < 0 + var_46_8 and not isNil(var_46_7) then
				if arg_43_1.var_.characterEffect6148ui_story and not isNil(var_46_7) then
					arg_43_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_43_1.time_ >= 0 + var_46_8 and arg_43_1.time_ < 0 + var_46_8 + arg_46_0 and not isNil(var_46_7) and arg_43_1.var_.characterEffect6148ui_story then
				arg_43_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= 0 + arg_46_0 then
				arg_43_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_46_10 = 0
			local var_46_11 = 0.675

			if 0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_10 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0
				arg_43_1.dialogCg_.alpha = 1

				arg_43_1.dialog_:SetActive(true)
				SetActive(arg_43_1.leftNameGo_, true)

				arg_43_1.leftNameTxt_.text = arg_43_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_43_1.leftNameTxt_.transform)

				arg_43_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_43_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_43_1:RecordName(arg_43_1.leftNameTxt_.text)
				SetActive(arg_43_1.iconTrs_.gameObject, false)
				arg_43_1.callingController_:SetSelectedState("normal")

				local var_46_12 = arg_43_1:FormatText(arg_43_1:GetWordFromCfg(939062010).content)

				arg_43_1.text_.text = var_46_12

				LuaForUtil.ClearLinePrefixSymbol(arg_43_1.text_)

				local var_46_14 = 27 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_12) / 27)

				if (27 <= 0 and var_46_11 or var_46_11 * (utf8.len(var_46_12) / 27)) > 0 and var_46_11 < var_46_14 then
					arg_43_1.talkMaxDuration = var_46_14

					if var_46_14 + var_46_10 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_14 + var_46_10
					end
				end

				arg_43_1.text_.text = var_46_12
				arg_43_1.typewritter.percent = 0

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(false)
				arg_43_1:RecordContent(arg_43_1.text_.text)
			end

			local var_46_15 = math.max(var_46_11, arg_43_1.talkMaxDuration)

			if var_46_10 <= arg_43_1.time_ and arg_43_1.time_ < var_46_10 + var_46_15 then
				arg_43_1.typewritter.percent = (arg_43_1.time_ - var_46_10) / var_46_15

				arg_43_1.typewritter:SetDirty()
			end

			if arg_43_1.time_ >= var_46_10 + var_46_15 and arg_43_1.time_ < var_46_10 + var_46_15 + arg_46_0 then
				arg_43_1.typewritter.percent = 1

				arg_43_1.typewritter:SetDirty()
				arg_43_1:ShowNextGo(true)
			end
		end

		arg_43_1.nodeConfigList_ = {
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

		arg_43_1:InitPlayNodeList()
	end,
	Play939062011 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 939062011
		arg_47_1.duration_ = 5

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play939062012(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			if 0 < arg_47_1.time_ and arg_47_1.time_ <= 0 + arg_50_0 and not isNil(arg_47_1.actors_["6148ui_story"]) and arg_47_1.var_.characterEffect6148ui_story == nil then
				arg_47_1.var_.characterEffect6148ui_story = arg_47_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_50_0 = 0.200000002980232

			if 0 <= arg_47_1.time_ and arg_47_1.time_ < 0 + var_50_0 and not isNil(arg_47_1.actors_["6148ui_story"]) then
				if arg_47_1.var_.characterEffect6148ui_story and not isNil(arg_47_1.actors_["6148ui_story"]) then
					arg_47_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_47_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_47_1.time_ - 0) / var_50_0)
				end
			end

			if arg_47_1.time_ >= 0 + var_50_0 and arg_47_1.time_ < 0 + var_50_0 + arg_50_0 and not isNil(arg_47_1.actors_["6148ui_story"]) and arg_47_1.var_.characterEffect6148ui_story then
				arg_47_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_47_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_50_1 = 0
			local var_50_2 = 1.175

			if 0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_1 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0
				arg_47_1.dialogCg_.alpha = 1

				arg_47_1.dialog_:SetActive(true)
				SetActive(arg_47_1.leftNameGo_, true)

				arg_47_1.leftNameTxt_.text = arg_47_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_47_1.leftNameTxt_.transform)

				arg_47_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_47_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_47_1:RecordName(arg_47_1.leftNameTxt_.text)
				SetActive(arg_47_1.iconTrs_.gameObject, true)
				arg_47_1.iconController_:SetSelectedState("hero")

				arg_47_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_47_1.callingController_:SetSelectedState("normal")

				arg_47_1.keyicon_.color = Color.New(1, 1, 1)
				arg_47_1.icon_.color = Color.New(1, 1, 1)

				local var_50_3 = arg_47_1:FormatText(arg_47_1:GetWordFromCfg(939062011).content)

				arg_47_1.text_.text = var_50_3

				LuaForUtil.ClearLinePrefixSymbol(arg_47_1.text_)

				local var_50_5 = 47 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 47)

				if (47 <= 0 and var_50_2 or var_50_2 * (utf8.len(var_50_3) / 47)) > 0 and var_50_2 < var_50_5 then
					arg_47_1.talkMaxDuration = var_50_5

					if var_50_5 + var_50_1 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_5 + var_50_1
					end
				end

				arg_47_1.text_.text = var_50_3
				arg_47_1.typewritter.percent = 0

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(false)
				arg_47_1:RecordContent(arg_47_1.text_.text)
			end

			local var_50_6 = math.max(var_50_2, arg_47_1.talkMaxDuration)

			if var_50_1 <= arg_47_1.time_ and arg_47_1.time_ < var_50_1 + var_50_6 then
				arg_47_1.typewritter.percent = (arg_47_1.time_ - var_50_1) / var_50_6

				arg_47_1.typewritter:SetDirty()
			end

			if arg_47_1.time_ >= var_50_1 + var_50_6 and arg_47_1.time_ < var_50_1 + var_50_6 + arg_50_0 then
				arg_47_1.typewritter.percent = 1

				arg_47_1.typewritter:SetDirty()
				arg_47_1:ShowNextGo(true)
			end
		end

		arg_47_1.nodeConfigList_ = {}

		arg_47_1:InitPlayNodeList()
	end,
	Play939062012 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 939062012
		arg_51_1.duration_ = 5

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play939062013(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = 0.1

			if 0 < arg_51_1.time_ and arg_51_1.time_ <= 0 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				arg_51_1.leftNameTxt_.text = arg_51_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, true)
				arg_51_1.iconController_:SetSelectedState("hero")

				arg_51_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_51_1.callingController_:SetSelectedState("normal")

				arg_51_1.keyicon_.color = Color.New(1, 1, 1)
				arg_51_1.icon_.color = Color.New(1, 1, 1)

				local var_54_1 = arg_51_1:FormatText(arg_51_1:GetWordFromCfg(939062012).content)

				arg_51_1.text_.text = var_54_1

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_3 = 4 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 4)

				if (4 <= 0 and var_54_0 or var_54_0 * (utf8.len(var_54_1) / 4)) > 0 and var_54_0 < var_54_3 then
					arg_51_1.talkMaxDuration = var_54_3

					if var_54_3 + 0 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_3 + 0
					end
				end

				arg_51_1.text_.text = var_54_1
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)
				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_4 = math.max(var_54_0, arg_51_1.talkMaxDuration)

			if 0 <= arg_51_1.time_ and arg_51_1.time_ < 0 + var_54_4 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - 0) / var_54_4

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= 0 + var_54_4 and arg_51_1.time_ < 0 + var_54_4 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end

		arg_51_1.nodeConfigList_ = {}

		arg_51_1:InitPlayNodeList()
	end,
	Play939062013 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 939062013
		arg_55_1.duration_ = 1

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"

			SetActive(arg_55_1.choicesGo_, true)

			for iter_56_0, iter_56_1 in ipairs(arg_55_1.choices_) do
				SetActive(iter_56_1.go, iter_56_0 <= 2)
			end

			arg_55_1.choices_[1].txt.text = arg_55_1:FormatText(StoryChoiceCfg[1681].name)
			arg_55_1.choices_[2].txt.text = arg_55_1:FormatText(StoryChoiceCfg[1682].name)
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play939062014(arg_55_1)
			end

			if arg_57_0 == 2 then
				arg_55_0:Play939062014(arg_55_1)
			end

			arg_55_1:RecordChoiceLog(939062013, 1681, 1682)
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			if 0 < arg_55_1.time_ and arg_55_1.time_ <= 0 + arg_58_0 then
				arg_55_1.var_.moveOldPos6148ui_story = arg_55_1.actors_["6148ui_story"].transform.localPosition

				local var_58_0 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_0 then
					var_58_0:EnableDynamicBone(false)
				end
			end

			local var_58_1 = 0.001

			if 0 <= arg_55_1.time_ and arg_55_1.time_ < 0 + var_58_1 then
				arg_55_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_55_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_55_1.time_ - 0) / var_58_1)
				arg_55_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6148ui_story"].transform.position).z)
				arg_55_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["6148ui_story"].transform.localEulerAngles = arg_55_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_55_1.time_ >= 0 + var_58_1 and arg_55_1.time_ < 0 + var_58_1 + arg_58_0 then
				arg_55_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_55_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_55_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_55_1.actors_["6148ui_story"].transform.position).z)
				arg_55_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_55_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_55_1.actors_["6148ui_story"].transform.localEulerAngles = arg_55_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_58_2 = GameObjectTools.GetOrAddComponent(arg_55_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_58_2 then
					var_58_2:EnableDynamicBone(true)
				end
			end

			local var_58_3 = 0

			if 0 < arg_55_1.time_ and arg_55_1.time_ <= var_58_3 + arg_58_0 then
				arg_55_1.allBtn_.enabled = false
			end

			if arg_55_1.time_ >= var_58_3 + 0.7 and arg_55_1.time_ < var_58_3 + 0.7 + arg_58_0 then
				arg_55_1.allBtn_.enabled = true
			end
		end

		arg_55_1.nodeConfigList_ = {
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

		arg_55_1:InitPlayNodeList()
	end,
	Play939062014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 939062014
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play939062015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0.725

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, true)
				arg_59_1.iconController_:SetSelectedState("hero")

				arg_59_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_59_1.callingController_:SetSelectedState("calling")

				arg_59_1.keyicon_.color = Color.New(1, 1, 1)
				arg_59_1.icon_.color = Color.New(1, 1, 1)

				local var_62_1 = arg_59_1:FormatText(arg_59_1:GetWordFromCfg(939062014).content)

				arg_59_1.text_.text = var_62_1

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_3 = 29 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 29)

				if (29 <= 0 and var_62_0 or var_62_0 * (utf8.len(var_62_1) / 29)) > 0 and var_62_0 < var_62_3 then
					arg_59_1.talkMaxDuration = var_62_3

					if var_62_3 + 0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_3 + 0
					end
				end

				arg_59_1.text_.text = var_62_1
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_4 = math.max(var_62_0, arg_59_1.talkMaxDuration)

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_4 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - 0) / var_62_4

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= 0 + var_62_4 and arg_59_1.time_ < 0 + var_62_4 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {}

		arg_59_1:InitPlayNodeList()
	end,
	Play939062015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 939062015
		arg_63_1.duration_ = 5

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play939062016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0.1

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1248")

				arg_63_1.callingController_:SetSelectedState("calling")

				arg_63_1.keyicon_.color = Color.New(1, 1, 1)
				arg_63_1.icon_.color = Color.New(1, 1, 1)

				local var_66_1 = arg_63_1:FormatText(arg_63_1:GetWordFromCfg(939062015).content)

				arg_63_1.text_.text = var_66_1

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_3 = 4 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 4)

				if (4 <= 0 and var_66_0 or var_66_0 * (utf8.len(var_66_1) / 4)) > 0 and var_66_0 < var_66_3 then
					arg_63_1.talkMaxDuration = var_66_3

					if var_66_3 + 0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_3 + 0
					end
				end

				arg_63_1.text_.text = var_66_1
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)
				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_4 = math.max(var_66_0, arg_63_1.talkMaxDuration)

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_4 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - 0) / var_66_4

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= 0 + var_66_4 and arg_63_1.time_ < 0 + var_66_4 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {}

		arg_63_1:InitPlayNodeList()
	end,
	Play939062016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 939062016
		arg_67_1.duration_ = 5

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play939062017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1248ui_story = arg_67_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1248ui_story"].transform.position).z)
				arg_67_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1248ui_story"].transform.localEulerAngles = arg_67_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_67_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1248ui_story"].transform.position).z)
				arg_67_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1248ui_story"].transform.localEulerAngles = arg_67_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1248ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1248ui_story == nil then
				arg_67_1.var_.characterEffect1248ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1248ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_67_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_2)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1248ui_story then
				arg_67_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_67_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.marker = "luntantiezi3"
				arg_67_1.actionList["1"] = arg_67_1.actionList["1"] or StoryInteractionRogueCardForumGame.New(arg_67_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_67_1.actionList["1"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 206,
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

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play939062017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 939062017
		arg_71_1.duration_ = 5

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play939062018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:AudioAction("play", "music", "ui_skip", "ui_bgm_33", "ui_skip.awb")

				local var_74_2 = manager.audio:GetAudioName("ui_skip", "ui_bgm_33")

				if "" ~= "" then
					if arg_71_1.bgmTxt_.text ~= var_74_2 and arg_71_1.bgmTxt_.text ~= "" then
						if arg_71_1.bgmTxt2_.text ~= "" then
							arg_71_1.bgmTxt_.text = arg_71_1.bgmTxt2_.text
						end

						arg_71_1.bgmTxt2_.text = var_74_2

						arg_71_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_71_1.bgmTxt_.text = var_74_2
						arg_71_1.bgmTxt2_.text = var_74_2
					end

					if arg_71_1.bgmTimer then
						arg_71_1.bgmTimer:Stop()

						arg_71_1.bgmTimer = nil
					end

					if arg_71_1.settingData.show_music_name == 1 then
						arg_71_1.musicController:SetSelectedState("show")
						arg_71_1.musicAnimator_:Play("open", 0, 0)

						if arg_71_1.settingData.music_time ~= 0 then
							arg_71_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_71_1.settingData.music_time), function()
								if arg_71_1 == nil or isNil(arg_71_1.bgmTxt_) then
									return
								end

								arg_71_1.musicController:SetSelectedState("hide")
								arg_71_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_74_3 = 0
			local var_74_4 = 1.25

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_3 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, false)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_5 = arg_71_1:FormatText(arg_71_1:GetWordFromCfg(939062017).content)

				arg_71_1.text_.text = var_74_5

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_7 = 50 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 50)

				if (50 <= 0 and var_74_4 or var_74_4 * (utf8.len(var_74_5) / 50)) > 0 and var_74_4 < var_74_7 then
					arg_71_1.talkMaxDuration = var_74_7

					if var_74_7 + var_74_3 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_7 + var_74_3
					end
				end

				arg_71_1.text_.text = var_74_5
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)
				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_8 = math.max(var_74_4, arg_71_1.talkMaxDuration)

			if var_74_3 <= arg_71_1.time_ and arg_71_1.time_ < var_74_3 + var_74_8 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_3) / var_74_8

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_3 + var_74_8 and arg_71_1.time_ < var_74_3 + var_74_8 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {}

		arg_71_1:InitPlayNodeList()
	end,
	Play939062018 = function(arg_76_0, arg_76_1)
		arg_76_1.time_ = 0
		arg_76_1.frameCnt_ = 0
		arg_76_1.state_ = "playing"
		arg_76_1.curTalkId_ = 939062018
		arg_76_1.duration_ = 5

		SetActive(arg_76_1.tipsGo_, false)

		function arg_76_1.onSingleLineFinish_()
			arg_76_1.onSingleLineUpdate_ = nil
			arg_76_1.onSingleLineFinish_ = nil
			arg_76_1.state_ = "waiting"
		end

		function arg_76_1.playNext_(arg_78_0)
			if arg_78_0 == 1 then
				arg_76_0:Play939062019(arg_76_1)
			end
		end

		function arg_76_1.onSingleLineUpdate_(arg_79_0)
			local var_79_0 = 0.25

			if 0 < arg_76_1.time_ and arg_76_1.time_ <= 0 + arg_79_0 then
				arg_76_1.talkMaxDuration = 0
				arg_76_1.dialogCg_.alpha = 1

				arg_76_1.dialog_:SetActive(true)
				SetActive(arg_76_1.leftNameGo_, true)

				arg_76_1.leftNameTxt_.text = arg_76_1:FormatText(StoryNameCfg[1544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_76_1.leftNameTxt_.transform)

				arg_76_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_76_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_76_1:RecordName(arg_76_1.leftNameTxt_.text)
				SetActive(arg_76_1.iconTrs_.gameObject, true)
				arg_76_1.iconController_:SetSelectedState("hero")

				arg_76_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_76_1.callingController_:SetSelectedState("normal")

				arg_76_1.keyicon_.color = Color.New(1, 1, 1)
				arg_76_1.icon_.color = Color.New(1, 1, 1)

				local var_79_1 = arg_76_1:FormatText(arg_76_1:GetWordFromCfg(939062018).content)

				arg_76_1.text_.text = var_79_1

				LuaForUtil.ClearLinePrefixSymbol(arg_76_1.text_)

				local var_79_3 = 10 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 10)

				if (10 <= 0 and var_79_0 or var_79_0 * (utf8.len(var_79_1) / 10)) > 0 and var_79_0 < var_79_3 then
					arg_76_1.talkMaxDuration = var_79_3

					if var_79_3 + 0 > arg_76_1.duration_ then
						arg_76_1.duration_ = var_79_3 + 0
					end
				end

				arg_76_1.text_.text = var_79_1
				arg_76_1.typewritter.percent = 0

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(false)
				arg_76_1:RecordContent(arg_76_1.text_.text)
			end

			local var_79_4 = math.max(var_79_0, arg_76_1.talkMaxDuration)

			if 0 <= arg_76_1.time_ and arg_76_1.time_ < 0 + var_79_4 then
				arg_76_1.typewritter.percent = (arg_76_1.time_ - 0) / var_79_4

				arg_76_1.typewritter:SetDirty()
			end

			if arg_76_1.time_ >= 0 + var_79_4 and arg_76_1.time_ < 0 + var_79_4 + arg_79_0 then
				arg_76_1.typewritter.percent = 1

				arg_76_1.typewritter:SetDirty()
				arg_76_1:ShowNextGo(true)
			end
		end

		arg_76_1.nodeConfigList_ = {}

		arg_76_1:InitPlayNodeList()
	end,
	Play939062019 = function(arg_80_0, arg_80_1)
		arg_80_1.time_ = 0
		arg_80_1.frameCnt_ = 0
		arg_80_1.state_ = "playing"
		arg_80_1.curTalkId_ = 939062019
		arg_80_1.duration_ = 5

		SetActive(arg_80_1.tipsGo_, false)

		function arg_80_1.onSingleLineFinish_()
			arg_80_1.onSingleLineUpdate_ = nil
			arg_80_1.onSingleLineFinish_ = nil
			arg_80_1.state_ = "waiting"
		end

		function arg_80_1.playNext_(arg_82_0)
			if arg_82_0 == 1 then
				arg_80_0:Play939062020(arg_80_1)
			end
		end

		function arg_80_1.onSingleLineUpdate_(arg_83_0)
			local var_83_0 = 0.45

			if 0 < arg_80_1.time_ and arg_80_1.time_ <= 0 + arg_83_0 then
				arg_80_1.talkMaxDuration = 0
				arg_80_1.dialogCg_.alpha = 1

				arg_80_1.dialog_:SetActive(true)
				SetActive(arg_80_1.leftNameGo_, true)

				arg_80_1.leftNameTxt_.text = arg_80_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_80_1.leftNameTxt_.transform)

				arg_80_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_80_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_80_1:RecordName(arg_80_1.leftNameTxt_.text)
				SetActive(arg_80_1.iconTrs_.gameObject, true)
				arg_80_1.iconController_:SetSelectedState("hero")

				arg_80_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_80_1.callingController_:SetSelectedState("normal")

				arg_80_1.keyicon_.color = Color.New(1, 1, 1)
				arg_80_1.icon_.color = Color.New(1, 1, 1)

				local var_83_1 = arg_80_1:FormatText(arg_80_1:GetWordFromCfg(939062019).content)

				arg_80_1.text_.text = var_83_1

				LuaForUtil.ClearLinePrefixSymbol(arg_80_1.text_)

				local var_83_3 = 18 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 18)

				if (18 <= 0 and var_83_0 or var_83_0 * (utf8.len(var_83_1) / 18)) > 0 and var_83_0 < var_83_3 then
					arg_80_1.talkMaxDuration = var_83_3

					if var_83_3 + 0 > arg_80_1.duration_ then
						arg_80_1.duration_ = var_83_3 + 0
					end
				end

				arg_80_1.text_.text = var_83_1
				arg_80_1.typewritter.percent = 0

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(false)
				arg_80_1:RecordContent(arg_80_1.text_.text)
			end

			local var_83_4 = math.max(var_83_0, arg_80_1.talkMaxDuration)

			if 0 <= arg_80_1.time_ and arg_80_1.time_ < 0 + var_83_4 then
				arg_80_1.typewritter.percent = (arg_80_1.time_ - 0) / var_83_4

				arg_80_1.typewritter:SetDirty()
			end

			if arg_80_1.time_ >= 0 + var_83_4 and arg_80_1.time_ < 0 + var_83_4 + arg_83_0 then
				arg_80_1.typewritter.percent = 1

				arg_80_1.typewritter:SetDirty()
				arg_80_1:ShowNextGo(true)
			end
		end

		arg_80_1.nodeConfigList_ = {}

		arg_80_1:InitPlayNodeList()
	end,
	Play939062020 = function(arg_84_0, arg_84_1)
		arg_84_1.time_ = 0
		arg_84_1.frameCnt_ = 0
		arg_84_1.state_ = "playing"
		arg_84_1.curTalkId_ = 939062020
		arg_84_1.duration_ = 5

		SetActive(arg_84_1.tipsGo_, false)

		function arg_84_1.onSingleLineFinish_()
			arg_84_1.onSingleLineUpdate_ = nil
			arg_84_1.onSingleLineFinish_ = nil
			arg_84_1.state_ = "waiting"
		end

		function arg_84_1.playNext_(arg_86_0)
			if arg_86_0 == 1 then
				arg_84_0:Play939062021(arg_84_1)
			end
		end

		function arg_84_1.onSingleLineUpdate_(arg_87_0)
			local var_87_0 = 0.325

			if 0 < arg_84_1.time_ and arg_84_1.time_ <= 0 + arg_87_0 then
				arg_84_1.talkMaxDuration = 0
				arg_84_1.dialogCg_.alpha = 1

				arg_84_1.dialog_:SetActive(true)
				SetActive(arg_84_1.leftNameGo_, true)

				arg_84_1.leftNameTxt_.text = arg_84_1:FormatText(StoryNameCfg[1544].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_84_1.leftNameTxt_.transform)

				arg_84_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_84_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_84_1:RecordName(arg_84_1.leftNameTxt_.text)
				SetActive(arg_84_1.iconTrs_.gameObject, true)
				arg_84_1.iconController_:SetSelectedState("hero")

				arg_84_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2096")

				arg_84_1.callingController_:SetSelectedState("normal")

				arg_84_1.keyicon_.color = Color.New(1, 1, 1)
				arg_84_1.icon_.color = Color.New(1, 1, 1)

				local var_87_1 = arg_84_1:FormatText(arg_84_1:GetWordFromCfg(939062020).content)

				arg_84_1.text_.text = var_87_1

				LuaForUtil.ClearLinePrefixSymbol(arg_84_1.text_)

				local var_87_3 = 13 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 13)

				if (13 <= 0 and var_87_0 or var_87_0 * (utf8.len(var_87_1) / 13)) > 0 and var_87_0 < var_87_3 then
					arg_84_1.talkMaxDuration = var_87_3

					if var_87_3 + 0 > arg_84_1.duration_ then
						arg_84_1.duration_ = var_87_3 + 0
					end
				end

				arg_84_1.text_.text = var_87_1
				arg_84_1.typewritter.percent = 0

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(false)
				arg_84_1:RecordContent(arg_84_1.text_.text)
			end

			local var_87_4 = math.max(var_87_0, arg_84_1.talkMaxDuration)

			if 0 <= arg_84_1.time_ and arg_84_1.time_ < 0 + var_87_4 then
				arg_84_1.typewritter.percent = (arg_84_1.time_ - 0) / var_87_4

				arg_84_1.typewritter:SetDirty()
			end

			if arg_84_1.time_ >= 0 + var_87_4 and arg_84_1.time_ < 0 + var_87_4 + arg_87_0 then
				arg_84_1.typewritter.percent = 1

				arg_84_1.typewritter:SetDirty()
				arg_84_1:ShowNextGo(true)
			end
		end

		arg_84_1.nodeConfigList_ = {}

		arg_84_1:InitPlayNodeList()
	end,
	Play939062021 = function(arg_88_0, arg_88_1)
		arg_88_1.time_ = 0
		arg_88_1.frameCnt_ = 0
		arg_88_1.state_ = "playing"
		arg_88_1.curTalkId_ = 939062021
		arg_88_1.duration_ = 5

		SetActive(arg_88_1.tipsGo_, false)

		function arg_88_1.onSingleLineFinish_()
			arg_88_1.onSingleLineUpdate_ = nil
			arg_88_1.onSingleLineFinish_ = nil
			arg_88_1.state_ = "waiting"
		end

		function arg_88_1.playNext_(arg_90_0)
			if arg_90_0 == 1 then
				arg_88_0:Play939062022(arg_88_1)
			end
		end

		function arg_88_1.onSingleLineUpdate_(arg_91_0)
			if 0 < arg_88_1.time_ and arg_88_1.time_ <= 0 + arg_91_0 then
				arg_88_1.marker = "tingyixiajiuhao"
				arg_88_1.actionList["2"] = arg_88_1.actionList["2"] or StoryInteractionRogueCardForumGame.New(arg_88_1, "Widget/System/Activity_JokerCard/Activity_JokerCard_ForunPopUI")

				arg_88_1.actionList["2"]:SetData({
					hideOnEndGame = true,
					type = 1,
					postId = 313,
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

		arg_88_1.nodeConfigList_ = {}

		arg_88_1:InitPlayNodeList()
	end,
	Play939062022 = function(arg_92_0, arg_92_1)
		arg_92_1.time_ = 0
		arg_92_1.frameCnt_ = 0
		arg_92_1.state_ = "playing"
		arg_92_1.curTalkId_ = 939062022
		arg_92_1.duration_ = 5

		SetActive(arg_92_1.tipsGo_, false)

		function arg_92_1.onSingleLineFinish_()
			arg_92_1.onSingleLineUpdate_ = nil
			arg_92_1.onSingleLineFinish_ = nil
			arg_92_1.state_ = "waiting"
		end

		function arg_92_1.playNext_(arg_94_0)
			if arg_94_0 == 1 then
				arg_92_0:Play939062023(arg_92_1)
			end
		end

		function arg_92_1.onSingleLineUpdate_(arg_95_0)
			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1.var_.moveOldPos1054ui_story = arg_92_1.actors_["1054ui_story"].transform.localPosition

				local var_95_0 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_0 then
					var_95_0:EnableDynamicBone(false)
				end
			end

			local var_95_1 = 0.001

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_1 then
				arg_92_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_92_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_92_1.time_ - 0) / var_95_1)
				arg_92_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).z)
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles = arg_92_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_92_1.time_ >= 0 + var_95_1 and arg_92_1.time_ < 0 + var_95_1 + arg_95_0 then
				arg_92_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_92_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_92_1.actors_["1054ui_story"].transform.position).z)
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_92_1.actors_["1054ui_story"].transform.localEulerAngles = arg_92_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_95_2 = GameObjectTools.GetOrAddComponent(arg_92_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_95_2 then
					var_95_2:EnableDynamicBone(true)
				end
			end

			local var_95_3 = arg_92_1.actors_["1054ui_story"]

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1054ui_story == nil then
				arg_92_1.var_.characterEffect1054ui_story = var_95_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_95_4 = 0.200000002980232

			if 0 <= arg_92_1.time_ and arg_92_1.time_ < 0 + var_95_4 and not isNil(var_95_3) then
				if arg_92_1.var_.characterEffect1054ui_story and not isNil(var_95_3) then
					arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_92_1.time_ >= 0 + var_95_4 and arg_92_1.time_ < 0 + var_95_4 + arg_95_0 and not isNil(var_95_3) and arg_92_1.var_.characterEffect1054ui_story then
				arg_92_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= 0 + arg_95_0 then
				arg_92_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_95_6 = 0
			local var_95_7 = 0.6

			if 0 < arg_92_1.time_ and arg_92_1.time_ <= var_95_6 + arg_95_0 then
				arg_92_1.talkMaxDuration = 0
				arg_92_1.dialogCg_.alpha = 1

				arg_92_1.dialog_:SetActive(true)
				SetActive(arg_92_1.leftNameGo_, true)

				arg_92_1.leftNameTxt_.text = arg_92_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_92_1.leftNameTxt_.transform)

				arg_92_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_92_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_92_1:RecordName(arg_92_1.leftNameTxt_.text)
				SetActive(arg_92_1.iconTrs_.gameObject, false)
				arg_92_1.callingController_:SetSelectedState("normal")

				local var_95_8 = arg_92_1:FormatText(arg_92_1:GetWordFromCfg(939062022).content)

				arg_92_1.text_.text = var_95_8

				LuaForUtil.ClearLinePrefixSymbol(arg_92_1.text_)

				local var_95_10 = 24 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_8) / 24)

				if (24 <= 0 and var_95_7 or var_95_7 * (utf8.len(var_95_8) / 24)) > 0 and var_95_7 < var_95_10 then
					arg_92_1.talkMaxDuration = var_95_10

					if var_95_10 + var_95_6 > arg_92_1.duration_ then
						arg_92_1.duration_ = var_95_10 + var_95_6
					end
				end

				arg_92_1.text_.text = var_95_8
				arg_92_1.typewritter.percent = 0

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(false)
				arg_92_1:RecordContent(arg_92_1.text_.text)
			end

			local var_95_11 = math.max(var_95_7, arg_92_1.talkMaxDuration)

			if var_95_6 <= arg_92_1.time_ and arg_92_1.time_ < var_95_6 + var_95_11 then
				arg_92_1.typewritter.percent = (arg_92_1.time_ - var_95_6) / var_95_11

				arg_92_1.typewritter:SetDirty()
			end

			if arg_92_1.time_ >= var_95_6 + var_95_11 and arg_92_1.time_ < var_95_6 + var_95_11 + arg_95_0 then
				arg_92_1.typewritter.percent = 1

				arg_92_1.typewritter:SetDirty()
				arg_92_1:ShowNextGo(true)
			end
		end

		arg_92_1.nodeConfigList_ = {
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

		arg_92_1:InitPlayNodeList()
	end,
	Play939062023 = function(arg_96_0, arg_96_1)
		arg_96_1.time_ = 0
		arg_96_1.frameCnt_ = 0
		arg_96_1.state_ = "playing"
		arg_96_1.curTalkId_ = 939062023
		arg_96_1.duration_ = 5

		SetActive(arg_96_1.tipsGo_, false)

		function arg_96_1.onSingleLineFinish_()
			arg_96_1.onSingleLineUpdate_ = nil
			arg_96_1.onSingleLineFinish_ = nil
			arg_96_1.state_ = "waiting"
		end

		function arg_96_1.playNext_(arg_98_0)
			if arg_98_0 == 1 then
				arg_96_0:Play939062024(arg_96_1)
			end
		end

		function arg_96_1.onSingleLineUpdate_(arg_99_0)
			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1.var_.moveOldPos6148ui_story = arg_96_1.actors_["6148ui_story"].transform.localPosition

				local var_99_0 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_0 then
					var_99_0:EnableDynamicBone(false)
				end
			end

			local var_99_1 = 0.001

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_1 then
				arg_96_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_96_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_96_1.time_ - 0) / var_99_1)
				arg_96_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).z)
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles = arg_96_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_96_1.time_ >= 0 + var_99_1 and arg_96_1.time_ < 0 + var_99_1 + arg_99_0 then
				arg_96_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_96_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_96_1.actors_["6148ui_story"].transform.position).z)
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_96_1.actors_["6148ui_story"].transform.localEulerAngles = arg_96_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_99_2 = GameObjectTools.GetOrAddComponent(arg_96_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_99_2 then
					var_99_2:EnableDynamicBone(true)
				end
			end

			local var_99_3 = arg_96_1.actors_["6148ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect6148ui_story == nil then
				arg_96_1.var_.characterEffect6148ui_story = var_99_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_4 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_4 and not isNil(var_99_3) then
				if arg_96_1.var_.characterEffect6148ui_story and not isNil(var_99_3) then
					arg_96_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_96_1.time_ >= 0 + var_99_4 and arg_96_1.time_ < 0 + var_99_4 + arg_99_0 and not isNil(var_99_3) and arg_96_1.var_.characterEffect6148ui_story then
				arg_96_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_99_6 = arg_96_1.actors_["1054ui_story"]

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1054ui_story == nil then
				arg_96_1.var_.characterEffect1054ui_story = var_99_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_99_7 = 0.200000002980232

			if 0 <= arg_96_1.time_ and arg_96_1.time_ < 0 + var_99_7 and not isNil(var_99_6) then
				if arg_96_1.var_.characterEffect1054ui_story and not isNil(var_99_6) then
					arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_96_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_96_1.time_ - 0) / var_99_7)
				end
			end

			if arg_96_1.time_ >= 0 + var_99_7 and arg_96_1.time_ < 0 + var_99_7 + arg_99_0 and not isNil(var_99_6) and arg_96_1.var_.characterEffect1054ui_story then
				arg_96_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_96_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= 0 + arg_99_0 then
				arg_96_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_99_8 = 0
			local var_99_9 = 0.775

			if 0 < arg_96_1.time_ and arg_96_1.time_ <= var_99_8 + arg_99_0 then
				arg_96_1.talkMaxDuration = 0
				arg_96_1.dialogCg_.alpha = 1

				arg_96_1.dialog_:SetActive(true)
				SetActive(arg_96_1.leftNameGo_, true)

				arg_96_1.leftNameTxt_.text = arg_96_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_96_1.leftNameTxt_.transform)

				arg_96_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_96_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_96_1:RecordName(arg_96_1.leftNameTxt_.text)
				SetActive(arg_96_1.iconTrs_.gameObject, false)
				arg_96_1.callingController_:SetSelectedState("normal")

				local var_99_10 = arg_96_1:FormatText(arg_96_1:GetWordFromCfg(939062023).content)

				arg_96_1.text_.text = var_99_10

				LuaForUtil.ClearLinePrefixSymbol(arg_96_1.text_)

				local var_99_12 = 31 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_10) / 31)

				if (31 <= 0 and var_99_9 or var_99_9 * (utf8.len(var_99_10) / 31)) > 0 and var_99_9 < var_99_12 then
					arg_96_1.talkMaxDuration = var_99_12

					if var_99_12 + var_99_8 > arg_96_1.duration_ then
						arg_96_1.duration_ = var_99_12 + var_99_8
					end
				end

				arg_96_1.text_.text = var_99_10
				arg_96_1.typewritter.percent = 0

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(false)
				arg_96_1:RecordContent(arg_96_1.text_.text)
			end

			local var_99_13 = math.max(var_99_9, arg_96_1.talkMaxDuration)

			if var_99_8 <= arg_96_1.time_ and arg_96_1.time_ < var_99_8 + var_99_13 then
				arg_96_1.typewritter.percent = (arg_96_1.time_ - var_99_8) / var_99_13

				arg_96_1.typewritter:SetDirty()
			end

			if arg_96_1.time_ >= var_99_8 + var_99_13 and arg_96_1.time_ < var_99_8 + var_99_13 + arg_99_0 then
				arg_96_1.typewritter.percent = 1

				arg_96_1.typewritter:SetDirty()
				arg_96_1:ShowNextGo(true)
			end
		end

		arg_96_1.nodeConfigList_ = {
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

		arg_96_1:InitPlayNodeList()
	end,
	Play939062024 = function(arg_100_0, arg_100_1)
		arg_100_1.time_ = 0
		arg_100_1.frameCnt_ = 0
		arg_100_1.state_ = "playing"
		arg_100_1.curTalkId_ = 939062024
		arg_100_1.duration_ = 5

		SetActive(arg_100_1.tipsGo_, false)

		function arg_100_1.onSingleLineFinish_()
			arg_100_1.onSingleLineUpdate_ = nil
			arg_100_1.onSingleLineFinish_ = nil
			arg_100_1.state_ = "waiting"
		end

		function arg_100_1.playNext_(arg_102_0)
			if arg_102_0 == 1 then
				arg_100_0:Play939062025(arg_100_1)
			end
		end

		function arg_100_1.onSingleLineUpdate_(arg_103_0)
			if 0 < arg_100_1.time_ and arg_100_1.time_ <= 0 + arg_103_0 and not isNil(arg_100_1.actors_["6148ui_story"]) and arg_100_1.var_.characterEffect6148ui_story == nil then
				arg_100_1.var_.characterEffect6148ui_story = arg_100_1.actors_["6148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_103_0 = 0.200000002980232

			if 0 <= arg_100_1.time_ and arg_100_1.time_ < 0 + var_103_0 and not isNil(arg_100_1.actors_["6148ui_story"]) then
				if arg_100_1.var_.characterEffect6148ui_story and not isNil(arg_100_1.actors_["6148ui_story"]) then
					arg_100_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_100_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_100_1.time_ - 0) / var_103_0)
				end
			end

			if arg_100_1.time_ >= 0 + var_103_0 and arg_100_1.time_ < 0 + var_103_0 + arg_103_0 and not isNil(arg_100_1.actors_["6148ui_story"]) and arg_100_1.var_.characterEffect6148ui_story then
				arg_100_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_100_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_103_1 = 0
			local var_103_2 = 0.225

			if 0 < arg_100_1.time_ and arg_100_1.time_ <= var_103_1 + arg_103_0 then
				arg_100_1.talkMaxDuration = 0
				arg_100_1.dialogCg_.alpha = 1

				arg_100_1.dialog_:SetActive(true)
				SetActive(arg_100_1.leftNameGo_, true)

				arg_100_1.leftNameTxt_.text = arg_100_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_100_1.leftNameTxt_.transform)

				arg_100_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_100_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_100_1:RecordName(arg_100_1.leftNameTxt_.text)
				SetActive(arg_100_1.iconTrs_.gameObject, true)
				arg_100_1.iconController_:SetSelectedState("hero")

				arg_100_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_100_1.callingController_:SetSelectedState("normal")

				arg_100_1.keyicon_.color = Color.New(1, 1, 1)
				arg_100_1.icon_.color = Color.New(1, 1, 1)

				local var_103_3 = arg_100_1:FormatText(arg_100_1:GetWordFromCfg(939062024).content)

				arg_100_1.text_.text = var_103_3

				LuaForUtil.ClearLinePrefixSymbol(arg_100_1.text_)

				local var_103_5 = 9 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 9)

				if (9 <= 0 and var_103_2 or var_103_2 * (utf8.len(var_103_3) / 9)) > 0 and var_103_2 < var_103_5 then
					arg_100_1.talkMaxDuration = var_103_5

					if var_103_5 + var_103_1 > arg_100_1.duration_ then
						arg_100_1.duration_ = var_103_5 + var_103_1
					end
				end

				arg_100_1.text_.text = var_103_3
				arg_100_1.typewritter.percent = 0

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(false)
				arg_100_1:RecordContent(arg_100_1.text_.text)
			end

			local var_103_6 = math.max(var_103_2, arg_100_1.talkMaxDuration)

			if var_103_1 <= arg_100_1.time_ and arg_100_1.time_ < var_103_1 + var_103_6 then
				arg_100_1.typewritter.percent = (arg_100_1.time_ - var_103_1) / var_103_6

				arg_100_1.typewritter:SetDirty()
			end

			if arg_100_1.time_ >= var_103_1 + var_103_6 and arg_100_1.time_ < var_103_1 + var_103_6 + arg_103_0 then
				arg_100_1.typewritter.percent = 1

				arg_100_1.typewritter:SetDirty()
				arg_100_1:ShowNextGo(true)
			end
		end

		arg_100_1.nodeConfigList_ = {}

		arg_100_1:InitPlayNodeList()
	end,
	Play939062025 = function(arg_104_0, arg_104_1)
		arg_104_1.time_ = 0
		arg_104_1.frameCnt_ = 0
		arg_104_1.state_ = "playing"
		arg_104_1.curTalkId_ = 939062025
		arg_104_1.duration_ = 5

		SetActive(arg_104_1.tipsGo_, false)

		function arg_104_1.onSingleLineFinish_()
			arg_104_1.onSingleLineUpdate_ = nil
			arg_104_1.onSingleLineFinish_ = nil
			arg_104_1.state_ = "waiting"
		end

		function arg_104_1.playNext_(arg_106_0)
			if arg_106_0 == 1 then
				arg_104_0:Play939062026(arg_104_1)
			end
		end

		function arg_104_1.onSingleLineUpdate_(arg_107_0)
			local var_107_0 = 0.775

			if 0 < arg_104_1.time_ and arg_104_1.time_ <= 0 + arg_107_0 then
				arg_104_1.talkMaxDuration = 0
				arg_104_1.dialogCg_.alpha = 1

				arg_104_1.dialog_:SetActive(true)
				SetActive(arg_104_1.leftNameGo_, true)

				arg_104_1.leftNameTxt_.text = arg_104_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_104_1.leftNameTxt_.transform)

				arg_104_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_104_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_104_1:RecordName(arg_104_1.leftNameTxt_.text)
				SetActive(arg_104_1.iconTrs_.gameObject, true)
				arg_104_1.iconController_:SetSelectedState("hero")

				arg_104_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_104_1.callingController_:SetSelectedState("normal")

				arg_104_1.keyicon_.color = Color.New(1, 1, 1)
				arg_104_1.icon_.color = Color.New(1, 1, 1)

				local var_107_1 = arg_104_1:FormatText(arg_104_1:GetWordFromCfg(939062025).content)

				arg_104_1.text_.text = var_107_1

				LuaForUtil.ClearLinePrefixSymbol(arg_104_1.text_)

				local var_107_3 = 31 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 31)

				if (31 <= 0 and var_107_0 or var_107_0 * (utf8.len(var_107_1) / 31)) > 0 and var_107_0 < var_107_3 then
					arg_104_1.talkMaxDuration = var_107_3

					if var_107_3 + 0 > arg_104_1.duration_ then
						arg_104_1.duration_ = var_107_3 + 0
					end
				end

				arg_104_1.text_.text = var_107_1
				arg_104_1.typewritter.percent = 0

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(false)
				arg_104_1:RecordContent(arg_104_1.text_.text)
			end

			local var_107_4 = math.max(var_107_0, arg_104_1.talkMaxDuration)

			if 0 <= arg_104_1.time_ and arg_104_1.time_ < 0 + var_107_4 then
				arg_104_1.typewritter.percent = (arg_104_1.time_ - 0) / var_107_4

				arg_104_1.typewritter:SetDirty()
			end

			if arg_104_1.time_ >= 0 + var_107_4 and arg_104_1.time_ < 0 + var_107_4 + arg_107_0 then
				arg_104_1.typewritter.percent = 1

				arg_104_1.typewritter:SetDirty()
				arg_104_1:ShowNextGo(true)
			end
		end

		arg_104_1.nodeConfigList_ = {}

		arg_104_1:InitPlayNodeList()
	end,
	Play939062026 = function(arg_108_0, arg_108_1)
		arg_108_1.time_ = 0
		arg_108_1.frameCnt_ = 0
		arg_108_1.state_ = "playing"
		arg_108_1.curTalkId_ = 939062026
		arg_108_1.duration_ = 5

		SetActive(arg_108_1.tipsGo_, false)

		function arg_108_1.onSingleLineFinish_()
			arg_108_1.onSingleLineUpdate_ = nil
			arg_108_1.onSingleLineFinish_ = nil
			arg_108_1.state_ = "waiting"
		end

		function arg_108_1.playNext_(arg_110_0)
			if arg_110_0 == 1 then
				arg_108_0:Play939062027(arg_108_1)
			end
		end

		function arg_108_1.onSingleLineUpdate_(arg_111_0)
			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1.var_.moveOldPos1054ui_story = arg_108_1.actors_["1054ui_story"].transform.localPosition

				local var_111_0 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_0 then
					var_111_0:EnableDynamicBone(false)
				end
			end

			local var_111_1 = 0.001

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_1 then
				arg_108_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_108_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_108_1.time_ - 0) / var_111_1)
				arg_108_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1054ui_story"].transform.position).z)
				arg_108_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1054ui_story"].transform.localEulerAngles = arg_108_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_108_1.time_ >= 0 + var_111_1 and arg_108_1.time_ < 0 + var_111_1 + arg_111_0 then
				arg_108_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_108_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_108_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_108_1.actors_["1054ui_story"].transform.position).z)
				arg_108_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_108_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_108_1.actors_["1054ui_story"].transform.localEulerAngles = arg_108_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_111_2 = GameObjectTools.GetOrAddComponent(arg_108_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_111_2 then
					var_111_2:EnableDynamicBone(true)
				end
			end

			local var_111_3 = arg_108_1.actors_["1054ui_story"]

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 and not isNil(var_111_3) and arg_108_1.var_.characterEffect1054ui_story == nil then
				arg_108_1.var_.characterEffect1054ui_story = var_111_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_111_4 = 0.200000002980232

			if 0 <= arg_108_1.time_ and arg_108_1.time_ < 0 + var_111_4 and not isNil(var_111_3) then
				if arg_108_1.var_.characterEffect1054ui_story and not isNil(var_111_3) then
					arg_108_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_108_1.time_ >= 0 + var_111_4 and arg_108_1.time_ < 0 + var_111_4 + arg_111_0 and not isNil(var_111_3) and arg_108_1.var_.characterEffect1054ui_story then
				arg_108_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= 0 + arg_111_0 then
				arg_108_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_111_6 = 0
			local var_111_7 = 0.625

			if 0 < arg_108_1.time_ and arg_108_1.time_ <= var_111_6 + arg_111_0 then
				arg_108_1.talkMaxDuration = 0
				arg_108_1.dialogCg_.alpha = 1

				arg_108_1.dialog_:SetActive(true)
				SetActive(arg_108_1.leftNameGo_, true)

				arg_108_1.leftNameTxt_.text = arg_108_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_108_1.leftNameTxt_.transform)

				arg_108_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_108_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_108_1:RecordName(arg_108_1.leftNameTxt_.text)
				SetActive(arg_108_1.iconTrs_.gameObject, false)
				arg_108_1.callingController_:SetSelectedState("normal")

				local var_111_8 = arg_108_1:FormatText(arg_108_1:GetWordFromCfg(939062026).content)

				arg_108_1.text_.text = var_111_8

				LuaForUtil.ClearLinePrefixSymbol(arg_108_1.text_)

				local var_111_10 = 25 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_8) / 25)

				if (25 <= 0 and var_111_7 or var_111_7 * (utf8.len(var_111_8) / 25)) > 0 and var_111_7 < var_111_10 then
					arg_108_1.talkMaxDuration = var_111_10

					if var_111_10 + var_111_6 > arg_108_1.duration_ then
						arg_108_1.duration_ = var_111_10 + var_111_6
					end
				end

				arg_108_1.text_.text = var_111_8
				arg_108_1.typewritter.percent = 0

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(false)
				arg_108_1:RecordContent(arg_108_1.text_.text)
			end

			local var_111_11 = math.max(var_111_7, arg_108_1.talkMaxDuration)

			if var_111_6 <= arg_108_1.time_ and arg_108_1.time_ < var_111_6 + var_111_11 then
				arg_108_1.typewritter.percent = (arg_108_1.time_ - var_111_6) / var_111_11

				arg_108_1.typewritter:SetDirty()
			end

			if arg_108_1.time_ >= var_111_6 + var_111_11 and arg_108_1.time_ < var_111_6 + var_111_11 + arg_111_0 then
				arg_108_1.typewritter.percent = 1

				arg_108_1.typewritter:SetDirty()
				arg_108_1:ShowNextGo(true)
			end
		end

		arg_108_1.nodeConfigList_ = {
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

		arg_108_1:InitPlayNodeList()
	end,
	Play939062027 = function(arg_112_0, arg_112_1)
		arg_112_1.time_ = 0
		arg_112_1.frameCnt_ = 0
		arg_112_1.state_ = "playing"
		arg_112_1.curTalkId_ = 939062027
		arg_112_1.duration_ = 5

		SetActive(arg_112_1.tipsGo_, false)

		function arg_112_1.onSingleLineFinish_()
			arg_112_1.onSingleLineUpdate_ = nil
			arg_112_1.onSingleLineFinish_ = nil
			arg_112_1.state_ = "waiting"
		end

		function arg_112_1.playNext_(arg_114_0)
			if arg_114_0 == 1 then
				arg_112_0:Play939062028(arg_112_1)
			end
		end

		function arg_112_1.onSingleLineUpdate_(arg_115_0)
			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1.var_.moveOldPos6148ui_story = arg_112_1.actors_["6148ui_story"].transform.localPosition

				local var_115_0 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_0 then
					var_115_0:EnableDynamicBone(false)
				end
			end

			local var_115_1 = 0.001

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_1 then
				arg_112_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_112_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_112_1.time_ - 0) / var_115_1)
				arg_112_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["6148ui_story"].transform.position).z)
				arg_112_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["6148ui_story"].transform.localEulerAngles = arg_112_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_112_1.time_ >= 0 + var_115_1 and arg_112_1.time_ < 0 + var_115_1 + arg_115_0 then
				arg_112_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_112_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_112_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_112_1.actors_["6148ui_story"].transform.position).z)
				arg_112_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_112_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_112_1.actors_["6148ui_story"].transform.localEulerAngles = arg_112_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_115_2 = GameObjectTools.GetOrAddComponent(arg_112_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_115_2 then
					var_115_2:EnableDynamicBone(true)
				end
			end

			local var_115_3 = arg_112_1.actors_["6148ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect6148ui_story == nil then
				arg_112_1.var_.characterEffect6148ui_story = var_115_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_4 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_4 and not isNil(var_115_3) then
				if arg_112_1.var_.characterEffect6148ui_story and not isNil(var_115_3) then
					arg_112_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_112_1.time_ >= 0 + var_115_4 and arg_112_1.time_ < 0 + var_115_4 + arg_115_0 and not isNil(var_115_3) and arg_112_1.var_.characterEffect6148ui_story then
				arg_112_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_115_6 = arg_112_1.actors_["1054ui_story"]

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1054ui_story == nil then
				arg_112_1.var_.characterEffect1054ui_story = var_115_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_115_7 = 0.200000002980232

			if 0 <= arg_112_1.time_ and arg_112_1.time_ < 0 + var_115_7 and not isNil(var_115_6) then
				if arg_112_1.var_.characterEffect1054ui_story and not isNil(var_115_6) then
					arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_112_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_112_1.time_ - 0) / var_115_7)
				end
			end

			if arg_112_1.time_ >= 0 + var_115_7 and arg_112_1.time_ < 0 + var_115_7 + arg_115_0 and not isNil(var_115_6) and arg_112_1.var_.characterEffect1054ui_story then
				arg_112_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_112_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= 0 + arg_115_0 then
				arg_112_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_biyanbiaozhun", "EmotionTimelineAnimator")
			end

			local var_115_8 = 0
			local var_115_9 = 0.625

			if 0 < arg_112_1.time_ and arg_112_1.time_ <= var_115_8 + arg_115_0 then
				arg_112_1.talkMaxDuration = 0
				arg_112_1.dialogCg_.alpha = 1

				arg_112_1.dialog_:SetActive(true)
				SetActive(arg_112_1.leftNameGo_, true)

				arg_112_1.leftNameTxt_.text = arg_112_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_112_1.leftNameTxt_.transform)

				arg_112_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_112_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_112_1:RecordName(arg_112_1.leftNameTxt_.text)
				SetActive(arg_112_1.iconTrs_.gameObject, false)
				arg_112_1.callingController_:SetSelectedState("normal")

				local var_115_10 = arg_112_1:FormatText(arg_112_1:GetWordFromCfg(939062027).content)

				arg_112_1.text_.text = var_115_10

				LuaForUtil.ClearLinePrefixSymbol(arg_112_1.text_)

				local var_115_12 = 25 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_10) / 25)

				if (25 <= 0 and var_115_9 or var_115_9 * (utf8.len(var_115_10) / 25)) > 0 and var_115_9 < var_115_12 then
					arg_112_1.talkMaxDuration = var_115_12

					if var_115_12 + var_115_8 > arg_112_1.duration_ then
						arg_112_1.duration_ = var_115_12 + var_115_8
					end
				end

				arg_112_1.text_.text = var_115_10
				arg_112_1.typewritter.percent = 0

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(false)
				arg_112_1:RecordContent(arg_112_1.text_.text)
			end

			local var_115_13 = math.max(var_115_9, arg_112_1.talkMaxDuration)

			if var_115_8 <= arg_112_1.time_ and arg_112_1.time_ < var_115_8 + var_115_13 then
				arg_112_1.typewritter.percent = (arg_112_1.time_ - var_115_8) / var_115_13

				arg_112_1.typewritter:SetDirty()
			end

			if arg_112_1.time_ >= var_115_8 + var_115_13 and arg_112_1.time_ < var_115_8 + var_115_13 + arg_115_0 then
				arg_112_1.typewritter.percent = 1

				arg_112_1.typewritter:SetDirty()
				arg_112_1:ShowNextGo(true)
			end
		end

		arg_112_1.nodeConfigList_ = {
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

		arg_112_1:InitPlayNodeList()
	end,
	Play939062028 = function(arg_116_0, arg_116_1)
		arg_116_1.time_ = 0
		arg_116_1.frameCnt_ = 0
		arg_116_1.state_ = "playing"
		arg_116_1.curTalkId_ = 939062028
		arg_116_1.duration_ = 5.35

		SetActive(arg_116_1.tipsGo_, false)

		function arg_116_1.onSingleLineFinish_()
			arg_116_1.onSingleLineUpdate_ = nil
			arg_116_1.onSingleLineFinish_ = nil
			arg_116_1.state_ = "waiting"
		end

		function arg_116_1.playNext_(arg_118_0)
			if arg_118_0 == 1 then
				arg_116_0:Play939062029(arg_116_1)
			end
		end

		function arg_116_1.onSingleLineUpdate_(arg_119_0)
			local var_119_9000

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos1054ui_story = arg_116_1.actors_["1054ui_story"].transform.localPosition

				local var_119_0 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_0 then
					var_119_0:EnableDynamicBone(false)
				end
			end

			local var_119_1 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_1 then
				arg_116_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_1)
				arg_116_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).z)
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles = arg_116_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_1 and arg_116_1.time_ < 0 + var_119_1 + arg_119_0 then
				arg_116_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_116_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_116_1.actors_["1054ui_story"].transform.position).z)
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_116_1.actors_["1054ui_story"].transform.localEulerAngles = arg_116_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_119_2 = GameObjectTools.GetOrAddComponent(arg_116_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_119_2 then
					var_119_2:EnableDynamicBone(true)
				end
			end

			local var_119_3 = arg_116_1.actors_["6148ui_story"].transform

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				arg_116_1.var_.moveOldPos6148ui_story = var_119_3.localPosition

				local var_119_4 = GameObjectTools.GetOrAddComponent(var_119_3.gameObject, typeof(DynamicBoneHelper))

				if var_119_4 then
					var_119_4:EnableDynamicBone(false)
				end
			end

			local var_119_5 = 0.001

			if 0 <= arg_116_1.time_ and arg_116_1.time_ < 0 + var_119_5 then
				var_119_3.localPosition = Vector3.Lerp(arg_116_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_116_1.time_ - 0) / var_119_5)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles
			end

			if arg_116_1.time_ >= 0 + var_119_5 and arg_116_1.time_ < 0 + var_119_5 + arg_119_0 then
				var_119_3.localPosition = Vector3.New(0, 100, 0)
				var_119_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_119_3.position).x, (manager.ui.mainCamera.transform.position - var_119_3.position).y, (manager.ui.mainCamera.transform.position - var_119_3.position).z)
				var_119_3.localEulerAngles.z = 0
				var_119_3.localEulerAngles.x = 0
				var_119_3.localEulerAngles = var_119_3.localEulerAngles

				local var_119_6 = GameObjectTools.GetOrAddComponent(var_119_3.gameObject, typeof(DynamicBoneHelper))

				if var_119_6 then
					var_119_6:EnableDynamicBone(true)
				end
			end

			local var_119_7 = 0

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= var_119_7 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_3.localPosition
			end

			local var_119_8 = 0.6

			if var_119_7 <= arg_116_1.time_ and arg_116_1.time_ < var_119_7 + var_119_8 then
				local var_119_9, var_119_10 = math.modf((arg_116_1.time_ - var_119_7) / 0.066)

				var_119_3.localPosition = Vector3.New(var_119_10 * 0.13, var_119_10 * 0.13, var_119_10 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= var_119_7 + var_119_8 and arg_116_1.time_ < var_119_7 + var_119_8 + arg_119_0 then
				var_119_3.localPosition = arg_116_1.var_.shakeOldPos
			end

			if 0 < arg_116_1.time_ and arg_116_1.time_ <= 0 + arg_119_0 then
				local var_119_11 = arg_116_1.var_.effecthetidaoguang1

				if not arg_116_1.var_.effecthetidaoguang1 then
					var_119_11 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_daoguang1043_2"), manager.ui.mainCamera.transform)
					var_119_11.name = "hetidaoguang1"
					arg_116_1.var_.effecthetidaoguang1 = var_119_11
				else
					var_119_11.transform:SetParent(var_119_9000)
				end

				var_119_11.transform.localPosition = Vector3.New(-0.26, 0, -1.26)
				var_119_11.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_119_13 = manager.ui.mainCamera.transform

			if 0.034000001847744 < arg_116_1.time_ and arg_116_1.time_ <= 0.034000001847744 + arg_119_0 then
				arg_116_1.var_.shakeOldPos = var_119_13.localPosition
			end

			local var_119_14 = 0.315999998152256

			if 0.034000001847744 <= arg_116_1.time_ and arg_116_1.time_ < 0.034000001847744 + var_119_14 then
				local var_119_15, var_119_16 = math.modf((arg_116_1.time_ - 0.034000001847744) / 0.066)

				var_119_13.localPosition = Vector3.New(var_119_16 * 0.13, var_119_16 * 0.13, var_119_16 * 0.13) + arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.time_ >= 0.034000001847744 + var_119_14 and arg_116_1.time_ < 0.034000001847744 + var_119_14 + arg_119_0 then
				var_119_13.localPosition = arg_116_1.var_.shakeOldPos
			end

			if arg_116_1.frameCnt_ <= 1 then
				arg_116_1.dialog_:SetActive(false)
			end

			local var_119_17 = 0.35
			local var_119_18 = 0.25

			if 0.35 < arg_116_1.time_ and arg_116_1.time_ <= var_119_17 + arg_119_0 then
				arg_116_1.talkMaxDuration = 0

				arg_116_1.dialog_:SetActive(true)

				arg_116_1.dialogCg_.alpha = 0

				local var_119_19 = LeanTween.value(arg_116_1.dialog_, 0, 1, 0.3)

				var_119_19:setOnUpdate(LuaHelper.FloatAction(function(arg_120_0)
					arg_116_1.dialogCg_.alpha = arg_120_0
				end))
				var_119_19:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_116_1.dialog_)
					var_119_19:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_116_1.duration_ = arg_116_1.duration_ + 0.3

				SetActive(arg_116_1.leftNameGo_, true)

				arg_116_1.leftNameTxt_.text = arg_116_1:FormatText(StoryNameCfg[1489].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_116_1.leftNameTxt_.transform)

				arg_116_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_116_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_116_1:RecordName(arg_116_1.leftNameTxt_.text)
				SetActive(arg_116_1.iconTrs_.gameObject, false)
				arg_116_1.callingController_:SetSelectedState("normal")

				local var_119_20 = arg_116_1:FormatText(arg_116_1:GetWordFromCfg(939062028).content)

				arg_116_1.text_.text = var_119_20

				LuaForUtil.ClearLinePrefixSymbol(arg_116_1.text_)

				local var_119_22 = 10 <= 0 and var_119_18 or var_119_18 * (utf8.len(var_119_20) / 10)

				if (10 <= 0 and var_119_18 or var_119_18 * (utf8.len(var_119_20) / 10)) > 0 and var_119_18 < var_119_22 then
					arg_116_1.talkMaxDuration = var_119_22
					var_119_17 = var_119_17 + 0.3

					if var_119_22 + var_119_17 > arg_116_1.duration_ then
						arg_116_1.duration_ = var_119_22 + var_119_17
					end
				end

				arg_116_1.text_.text = var_119_20
				arg_116_1.typewritter.percent = 0

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(false)
				arg_116_1:RecordContent(arg_116_1.text_.text)
			end

			local var_119_23 = var_119_17 + 0.3
			local var_119_24 = math.max(var_119_18, arg_116_1.talkMaxDuration)

			if var_119_17 + 0.3 <= arg_116_1.time_ and arg_116_1.time_ < var_119_23 + var_119_24 then
				arg_116_1.typewritter.percent = (arg_116_1.time_ - var_119_23) / var_119_24

				arg_116_1.typewritter:SetDirty()
			end

			if arg_116_1.time_ >= var_119_23 + var_119_24 and arg_116_1.time_ < var_119_23 + var_119_24 + arg_119_0 then
				arg_116_1.typewritter.percent = 1

				arg_116_1.typewritter:SetDirty()
				arg_116_1:ShowNextGo(true)
			end
		end

		arg_116_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_116_1:InitPlayNodeList()
	end,
	Play939062029 = function(arg_122_0, arg_122_1)
		arg_122_1.time_ = 0
		arg_122_1.frameCnt_ = 0
		arg_122_1.state_ = "playing"
		arg_122_1.curTalkId_ = 939062029
		arg_122_1.duration_ = 5

		SetActive(arg_122_1.tipsGo_, false)

		function arg_122_1.onSingleLineFinish_()
			arg_122_1.onSingleLineUpdate_ = nil
			arg_122_1.onSingleLineFinish_ = nil
			arg_122_1.state_ = "waiting"
		end

		function arg_122_1.playNext_(arg_124_0)
			if arg_124_0 == 1 then
				arg_122_0:Play939062030(arg_122_1)
			end
		end

		function arg_122_1.onSingleLineUpdate_(arg_125_0)
			if 0 < arg_122_1.time_ and arg_122_1.time_ <= 0 + arg_125_0 then
				arg_122_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "ui_battle.awb")

				local var_125_2 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_122_1.bgmTxt_.text ~= var_125_2 and arg_122_1.bgmTxt_.text ~= "" then
						if arg_122_1.bgmTxt2_.text ~= "" then
							arg_122_1.bgmTxt_.text = arg_122_1.bgmTxt2_.text
						end

						arg_122_1.bgmTxt2_.text = var_125_2

						arg_122_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_122_1.bgmTxt_.text = var_125_2
						arg_122_1.bgmTxt2_.text = var_125_2
					end

					if arg_122_1.bgmTimer then
						arg_122_1.bgmTimer:Stop()

						arg_122_1.bgmTimer = nil
					end

					if arg_122_1.settingData.show_music_name == 1 then
						arg_122_1.musicController:SetSelectedState("show")
						arg_122_1.musicAnimator_:Play("open", 0, 0)

						if arg_122_1.settingData.music_time ~= 0 then
							arg_122_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_122_1.settingData.music_time), function()
								if arg_122_1 == nil or isNil(arg_122_1.bgmTxt_) then
									return
								end

								arg_122_1.musicController:SetSelectedState("hide")
								arg_122_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			local var_125_3 = 0
			local var_125_4 = 1.2

			if 0 < arg_122_1.time_ and arg_122_1.time_ <= var_125_3 + arg_125_0 then
				arg_122_1.talkMaxDuration = 0
				arg_122_1.dialogCg_.alpha = 1

				arg_122_1.dialog_:SetActive(true)
				SetActive(arg_122_1.leftNameGo_, false)

				arg_122_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_122_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_122_1:RecordName(arg_122_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_122_1.iconTrs_.gameObject, false)
				arg_122_1.callingController_:SetSelectedState("normal")

				local var_125_5 = arg_122_1:FormatText(arg_122_1:GetWordFromCfg(939062029).content)

				arg_122_1.text_.text = var_125_5

				LuaForUtil.ClearLinePrefixSymbol(arg_122_1.text_)

				local var_125_7 = 48 <= 0 and var_125_4 or var_125_4 * (utf8.len(var_125_5) / 48)

				if (48 <= 0 and var_125_4 or var_125_4 * (utf8.len(var_125_5) / 48)) > 0 and var_125_4 < var_125_7 then
					arg_122_1.talkMaxDuration = var_125_7

					if var_125_7 + var_125_3 > arg_122_1.duration_ then
						arg_122_1.duration_ = var_125_7 + var_125_3
					end
				end

				arg_122_1.text_.text = var_125_5
				arg_122_1.typewritter.percent = 0

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(false)
				arg_122_1:RecordContent(arg_122_1.text_.text)
			end

			local var_125_8 = math.max(var_125_4, arg_122_1.talkMaxDuration)

			if var_125_3 <= arg_122_1.time_ and arg_122_1.time_ < var_125_3 + var_125_8 then
				arg_122_1.typewritter.percent = (arg_122_1.time_ - var_125_3) / var_125_8

				arg_122_1.typewritter:SetDirty()
			end

			if arg_122_1.time_ >= var_125_3 + var_125_8 and arg_122_1.time_ < var_125_3 + var_125_8 + arg_125_0 then
				arg_122_1.typewritter.percent = 1

				arg_122_1.typewritter:SetDirty()
				arg_122_1:ShowNextGo(true)
			end
		end

		arg_122_1.nodeConfigList_ = {}

		arg_122_1:InitPlayNodeList()
	end,
	Play939062030 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 939062030
		arg_127_1.duration_ = 9

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play939062031(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			if arg_127_1.bgs_.STblack == nil then
				local var_130_0 = Object.Instantiate(arg_127_1.paintGo_)

				var_130_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "STblack")
				var_130_0.name = "STblack"
				var_130_0.transform.parent = arg_127_1.stage_.transform
				var_130_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_127_1.bgs_.STblack = var_130_0
			end

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= 2 + arg_130_0 then
				local var_130_1 = arg_127_1.bgs_.STblack

				arg_127_1.bgs_.STblack.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_130_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_130_2 = var_130_1:GetComponent("SpriteRenderer")

				if var_130_2 and var_130_2.sprite then
					local var_130_3 = 2 * (var_130_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_130_1.transform.localScale = Vector3.New(var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, var_130_3 / var_130_2.sprite.bounds.size.y < var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x and var_130_3 * manager.ui.mainCameraCom_.aspect / var_130_2.sprite.bounds.size.x or var_130_3 / var_130_2.sprite.bounds.size.y, 0)
				end

				for iter_130_0, iter_130_1 in pairs(arg_127_1.bgs_) do
					if iter_130_0 ~= "STblack" then
						iter_130_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_130_4 = 4

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_4 + arg_130_0 then
				arg_127_1.allBtn_.enabled = false
			end

			if arg_127_1.time_ >= var_130_4 + 0.3 and arg_127_1.time_ < var_130_4 + 0.3 + arg_130_0 then
				arg_127_1.allBtn_.enabled = true
			end

			local var_130_5 = 0

			if 0 < arg_127_1.time_ and arg_127_1.time_ <= var_130_5 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_6 = 2

			if var_130_5 <= arg_127_1.time_ and arg_127_1.time_ < var_130_5 + var_130_6 then
				local var_130_7 = Color.New(0, 0, 0)

				var_130_7.a = Mathf.Lerp(0, 1, (arg_127_1.time_ - var_130_5) / var_130_6)
				arg_127_1.mask_.color = var_130_7
			end

			if arg_127_1.time_ >= var_130_5 + var_130_6 and arg_127_1.time_ < var_130_5 + var_130_6 + arg_130_0 then
				local var_130_8 = Color.New(0, 0, 0)

				var_130_8.a = 1
				arg_127_1.mask_.color = var_130_8
			end

			local var_130_9 = 2

			if 2 < arg_127_1.time_ and arg_127_1.time_ <= var_130_9 + arg_130_0 then
				arg_127_1.mask_.enabled = true
				arg_127_1.mask_.raycastTarget = true

				arg_127_1:SetGaussion(false)
			end

			local var_130_10 = 2

			if var_130_9 <= arg_127_1.time_ and arg_127_1.time_ < var_130_9 + var_130_10 then
				local var_130_11 = Color.New(0, 0, 0)

				var_130_11.a = Mathf.Lerp(1, 0, (arg_127_1.time_ - var_130_9) / var_130_10)
				arg_127_1.mask_.color = var_130_11
			end

			if arg_127_1.time_ >= var_130_9 + var_130_10 and arg_127_1.time_ < var_130_9 + var_130_10 + arg_130_0 then
				local var_130_12 = Color.New(0, 0, 0)

				arg_127_1.mask_.enabled = false
				var_130_12.a = 0
				arg_127_1.mask_.color = var_130_12
			end

			if arg_127_1.frameCnt_ <= 1 then
				arg_127_1.dialog_:SetActive(false)
			end

			local var_130_13 = 4
			local var_130_14 = 0.4

			if 4 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0

				arg_127_1.dialog_:SetActive(true)

				arg_127_1.dialogCg_.alpha = 0

				local var_130_15 = LeanTween.value(arg_127_1.dialog_, 0, 1, 0.3)

				var_130_15:setOnUpdate(LuaHelper.FloatAction(function(arg_131_0)
					arg_127_1.dialogCg_.alpha = arg_131_0
				end))
				var_130_15:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_127_1.dialog_)
					var_130_15:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_127_1.duration_ = arg_127_1.duration_ + 0.3

				SetActive(arg_127_1.leftNameGo_, false)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_16 = arg_127_1:FormatText(arg_127_1:GetWordFromCfg(939062030).content)

				arg_127_1.text_.text = var_130_16

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_18 = 16 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 16)

				if (16 <= 0 and var_130_14 or var_130_14 * (utf8.len(var_130_16) / 16)) > 0 and var_130_14 < var_130_18 then
					arg_127_1.talkMaxDuration = var_130_18
					var_130_13 = var_130_13 + 0.3

					if var_130_18 + var_130_13 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_18 + var_130_13
					end
				end

				arg_127_1.text_.text = var_130_16
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)
				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_19 = var_130_13 + 0.3
			local var_130_20 = math.max(var_130_14, arg_127_1.talkMaxDuration)

			if var_130_13 + 0.3 <= arg_127_1.time_ and arg_127_1.time_ < var_130_19 + var_130_20 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_19) / var_130_20

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_19 + var_130_20 and arg_127_1.time_ < var_130_19 + var_130_20 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end

		arg_127_1.nodeConfigList_ = {}

		arg_127_1:InitPlayNodeList()
	end,
	Play939062031 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 939062031
		arg_133_1.duration_ = 7

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play939062032(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if arg_133_1.bgs_.ST12 == nil then
				local var_136_0 = Object.Instantiate(arg_133_1.paintGo_)

				var_136_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST12")
				var_136_0.name = "ST12"
				var_136_0.transform.parent = arg_133_1.stage_.transform
				var_136_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.bgs_.ST12 = var_136_0
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				local var_136_1 = arg_133_1.bgs_.ST12

				arg_133_1.bgs_.ST12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_136_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_136_2 = var_136_1:GetComponent("SpriteRenderer")

				if var_136_2 and var_136_2.sprite then
					local var_136_3 = 2 * (var_136_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_136_1.transform.localScale = Vector3.New(var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, var_136_3 / var_136_2.sprite.bounds.size.y < var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x and var_136_3 * manager.ui.mainCameraCom_.aspect / var_136_2.sprite.bounds.size.x or var_136_3 / var_136_2.sprite.bounds.size.y, 0)
				end

				for iter_136_0, iter_136_1 in pairs(arg_133_1.bgs_) do
					if iter_136_0 ~= "ST12" then
						iter_136_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_136_4 = 2

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_4 + arg_136_0 then
				arg_133_1.allBtn_.enabled = false
			end

			if arg_133_1.time_ >= var_136_4 + 0.3 and arg_133_1.time_ < var_136_4 + 0.3 + arg_136_0 then
				arg_133_1.allBtn_.enabled = true
			end

			local var_136_5 = 0

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_5 + arg_136_0 then
				arg_133_1.mask_.enabled = true
				arg_133_1.mask_.raycastTarget = true

				arg_133_1:SetGaussion(false)
			end

			local var_136_6 = 2

			if var_136_5 <= arg_133_1.time_ and arg_133_1.time_ < var_136_5 + var_136_6 then
				local var_136_7 = Color.New(0, 0, 0)

				var_136_7.a = Mathf.Lerp(1, 0, (arg_133_1.time_ - var_136_5) / var_136_6)
				arg_133_1.mask_.color = var_136_7
			end

			if arg_133_1.time_ >= var_136_5 + var_136_6 and arg_133_1.time_ < var_136_5 + var_136_6 + arg_136_0 then
				local var_136_8 = Color.New(0, 0, 0)

				arg_133_1.mask_.enabled = false
				var_136_8.a = 0
				arg_133_1.mask_.color = var_136_8
			end

			local var_136_9 = "1019ui_story"

			if arg_133_1.actors_["1019ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1019ui_story"))) then
				local var_136_10 = Object.Instantiate(Asset.Load("Char/" .. "1019ui_story"), arg_133_1.stage_.transform)

				var_136_10.name = var_136_9
				var_136_10.transform.localPosition = Vector3.New(0, 100, 0)
				arg_133_1.actors_[var_136_9] = var_136_10

				local var_136_11 = var_136_10:GetComponentInChildren(typeof(CharacterEffect))

				var_136_11.enabled = true

				local var_136_12 = GameObjectTools.GetOrAddComponent(var_136_10, typeof(DynamicBoneHelper))

				if var_136_12 then
					var_136_12:EnableDynamicBone(false)
				end

				arg_133_1:ShowWeapon(var_136_11.transform, false)

				arg_133_1.var_[var_136_9 .. "Animator"] = var_136_11.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_133_1.var_[var_136_9 .. "Animator"].applyRootMotion = true
				arg_133_1.var_[var_136_9 .. "LipSync"] = var_136_11.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_136_13 = arg_133_1.actors_["1019ui_story"].transform

			if 1.8 < arg_133_1.time_ and arg_133_1.time_ <= 1.8 + arg_136_0 then
				arg_133_1.var_.moveOldPos1019ui_story = var_136_13.localPosition
			end

			local var_136_14 = 0.001

			if 1.8 <= arg_133_1.time_ and arg_133_1.time_ < 1.8 + var_136_14 then
				var_136_13.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_133_1.time_ - 1.8) / var_136_14)
				var_136_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_13.position).x, (manager.ui.mainCamera.transform.position - var_136_13.position).y, (manager.ui.mainCamera.transform.position - var_136_13.position).z)
				var_136_13.localEulerAngles.z = 0
				var_136_13.localEulerAngles.x = 0
				var_136_13.localEulerAngles = var_136_13.localEulerAngles
			end

			if arg_133_1.time_ >= 1.8 + var_136_14 and arg_133_1.time_ < 1.8 + var_136_14 + arg_136_0 then
				var_136_13.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				var_136_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_136_13.position).x, (manager.ui.mainCamera.transform.position - var_136_13.position).y, (manager.ui.mainCamera.transform.position - var_136_13.position).z)
				var_136_13.localEulerAngles.z = 0
				var_136_13.localEulerAngles.x = 0
				var_136_13.localEulerAngles = var_136_13.localEulerAngles
			end

			local var_136_15 = arg_133_1.actors_["1019ui_story"]

			if 1.8 < arg_133_1.time_ and arg_133_1.time_ <= 1.8 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.characterEffect1019ui_story == nil then
				arg_133_1.var_.characterEffect1019ui_story = var_136_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_16 = 0.200000002980232

			if 1.8 <= arg_133_1.time_ and arg_133_1.time_ < 1.8 + var_136_16 and not isNil(var_136_15) then
				if arg_133_1.var_.characterEffect1019ui_story and not isNil(var_136_15) then
					arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 1.8 + var_136_16 and arg_133_1.time_ < 1.8 + var_136_16 + arg_136_0 and not isNil(var_136_15) and arg_133_1.var_.characterEffect1019ui_story then
				arg_133_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 1.8 < arg_133_1.time_ and arg_133_1.time_ <= 1.8 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 1.8 < arg_133_1.time_ and arg_133_1.time_ <= 1.8 + arg_136_0 then
				arg_133_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:AudioAction("play", "music", "bgm_story_office_new", "bgm_story_office_new", "bgm_story_office_new.awb")

				local var_136_20 = manager.audio:GetAudioName("bgm_story_office_new", "bgm_story_office_new")

				if "" ~= "" then
					if arg_133_1.bgmTxt_.text ~= var_136_20 and arg_133_1.bgmTxt_.text ~= "" then
						if arg_133_1.bgmTxt2_.text ~= "" then
							arg_133_1.bgmTxt_.text = arg_133_1.bgmTxt2_.text
						end

						arg_133_1.bgmTxt2_.text = var_136_20

						arg_133_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_133_1.bgmTxt_.text = var_136_20
						arg_133_1.bgmTxt2_.text = var_136_20
					end

					if arg_133_1.bgmTimer then
						arg_133_1.bgmTimer:Stop()

						arg_133_1.bgmTimer = nil
					end

					if arg_133_1.settingData.show_music_name == 1 then
						arg_133_1.musicController:SetSelectedState("show")
						arg_133_1.musicAnimator_:Play("open", 0, 0)

						if arg_133_1.settingData.music_time ~= 0 then
							arg_133_1.bgmTimer = TimeTools.StartAfterSeconds(tonumber(arg_133_1.settingData.music_time), function()
								if arg_133_1 == nil or isNil(arg_133_1.bgmTxt_) then
									return
								end

								arg_133_1.musicController:SetSelectedState("hide")
								arg_133_1.musicAnimator_:Play("back", 0, 0)
							end, {})
						end
					end
				end
			end

			if arg_133_1.frameCnt_ <= 1 then
				arg_133_1.dialog_:SetActive(false)
			end

			local var_136_21 = 2
			local var_136_22 = 1

			if 2 < arg_133_1.time_ and arg_133_1.time_ <= var_136_21 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0

				arg_133_1.dialog_:SetActive(true)

				arg_133_1.dialogCg_.alpha = 0

				local var_136_23 = LeanTween.value(arg_133_1.dialog_, 0, 1, 0.3)

				var_136_23:setOnUpdate(LuaHelper.FloatAction(function(arg_138_0)
					arg_133_1.dialogCg_.alpha = arg_138_0
				end))
				var_136_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_133_1.dialog_)
					var_136_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_133_1.duration_ = arg_133_1.duration_ + 0.3

				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_24 = arg_133_1:FormatText(arg_133_1:GetWordFromCfg(939062031).content)

				arg_133_1.text_.text = var_136_24

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_26 = 40 <= 0 and var_136_22 or var_136_22 * (utf8.len(var_136_24) / 40)

				if (40 <= 0 and var_136_22 or var_136_22 * (utf8.len(var_136_24) / 40)) > 0 and var_136_22 < var_136_26 then
					arg_133_1.talkMaxDuration = var_136_26
					var_136_21 = var_136_21 + 0.3

					if var_136_26 + var_136_21 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_26 + var_136_21
					end
				end

				arg_133_1.text_.text = var_136_24
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)
				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_27 = var_136_21 + 0.3
			local var_136_28 = math.max(var_136_22, arg_133_1.talkMaxDuration)

			if var_136_21 + 0.3 <= arg_133_1.time_ and arg_133_1.time_ < var_136_27 + var_136_28 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_27) / var_136_28

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_27 + var_136_28 and arg_133_1.time_ < var_136_27 + var_136_28 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play939062032 = function(arg_140_0, arg_140_1)
		arg_140_1.time_ = 0
		arg_140_1.frameCnt_ = 0
		arg_140_1.state_ = "playing"
		arg_140_1.curTalkId_ = 939062032
		arg_140_1.duration_ = 5

		SetActive(arg_140_1.tipsGo_, false)

		function arg_140_1.onSingleLineFinish_()
			arg_140_1.onSingleLineUpdate_ = nil
			arg_140_1.onSingleLineFinish_ = nil
			arg_140_1.state_ = "waiting"
		end

		function arg_140_1.playNext_(arg_142_0)
			if arg_142_0 == 1 then
				arg_140_0:Play939062033(arg_140_1)
			end
		end

		function arg_140_1.onSingleLineUpdate_(arg_143_0)
			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1.var_.moveOldPos1019ui_story = arg_140_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_143_0 = 0.001

			if 0 <= arg_140_1.time_ and arg_140_1.time_ < 0 + var_143_0 then
				arg_140_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_140_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_140_1.time_ - 0) / var_143_0)
				arg_140_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).z)
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles = arg_140_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_140_1.time_ >= 0 + var_143_0 and arg_140_1.time_ < 0 + var_143_0 + arg_143_0 then
				arg_140_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_140_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_140_1.actors_["1019ui_story"].transform.position).z)
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_140_1.actors_["1019ui_story"].transform.localEulerAngles = arg_140_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action1_1")
			end

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= 0 + arg_143_0 then
				arg_140_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_143_1 = 0
			local var_143_2 = 0.45

			if 0 < arg_140_1.time_ and arg_140_1.time_ <= var_143_1 + arg_143_0 then
				arg_140_1.talkMaxDuration = 0
				arg_140_1.dialogCg_.alpha = 1

				arg_140_1.dialog_:SetActive(true)
				SetActive(arg_140_1.leftNameGo_, true)

				arg_140_1.leftNameTxt_.text = arg_140_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_140_1.leftNameTxt_.transform)

				arg_140_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_140_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_140_1:RecordName(arg_140_1.leftNameTxt_.text)
				SetActive(arg_140_1.iconTrs_.gameObject, false)
				arg_140_1.callingController_:SetSelectedState("normal")

				local var_143_3 = arg_140_1:FormatText(arg_140_1:GetWordFromCfg(939062032).content)

				arg_140_1.text_.text = var_143_3

				LuaForUtil.ClearLinePrefixSymbol(arg_140_1.text_)

				local var_143_5 = 18 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 18)

				if (18 <= 0 and var_143_2 or var_143_2 * (utf8.len(var_143_3) / 18)) > 0 and var_143_2 < var_143_5 then
					arg_140_1.talkMaxDuration = var_143_5

					if var_143_5 + var_143_1 > arg_140_1.duration_ then
						arg_140_1.duration_ = var_143_5 + var_143_1
					end
				end

				arg_140_1.text_.text = var_143_3
				arg_140_1.typewritter.percent = 0

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(false)
				arg_140_1:RecordContent(arg_140_1.text_.text)
			end

			local var_143_6 = math.max(var_143_2, arg_140_1.talkMaxDuration)

			if var_143_1 <= arg_140_1.time_ and arg_140_1.time_ < var_143_1 + var_143_6 then
				arg_140_1.typewritter.percent = (arg_140_1.time_ - var_143_1) / var_143_6

				arg_140_1.typewritter:SetDirty()
			end

			if arg_140_1.time_ >= var_143_1 + var_143_6 and arg_140_1.time_ < var_143_1 + var_143_6 + arg_143_0 then
				arg_140_1.typewritter.percent = 1

				arg_140_1.typewritter:SetDirty()
				arg_140_1:ShowNextGo(true)
			end
		end

		arg_140_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_140_1:InitPlayNodeList()
	end,
	Play939062033 = function(arg_144_0, arg_144_1)
		arg_144_1.time_ = 0
		arg_144_1.frameCnt_ = 0
		arg_144_1.state_ = "playing"
		arg_144_1.curTalkId_ = 939062033
		arg_144_1.duration_ = 5

		SetActive(arg_144_1.tipsGo_, false)

		function arg_144_1.onSingleLineFinish_()
			arg_144_1.onSingleLineUpdate_ = nil
			arg_144_1.onSingleLineFinish_ = nil
			arg_144_1.state_ = "waiting"
		end

		function arg_144_1.playNext_(arg_146_0)
			if arg_146_0 == 1 then
				arg_144_0:Play939062034(arg_144_1)
			end
		end

		function arg_144_1.onSingleLineUpdate_(arg_147_0)
			if 0 < arg_144_1.time_ and arg_144_1.time_ <= 0 + arg_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) and arg_144_1.var_.characterEffect1019ui_story == nil then
				arg_144_1.var_.characterEffect1019ui_story = arg_144_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_147_0 = 0.200000002980232

			if 0 <= arg_144_1.time_ and arg_144_1.time_ < 0 + var_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) then
				if arg_144_1.var_.characterEffect1019ui_story and not isNil(arg_144_1.actors_["1019ui_story"]) then
					arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_144_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_144_1.time_ - 0) / var_147_0)
				end
			end

			if arg_144_1.time_ >= 0 + var_147_0 and arg_144_1.time_ < 0 + var_147_0 + arg_147_0 and not isNil(arg_144_1.actors_["1019ui_story"]) and arg_144_1.var_.characterEffect1019ui_story then
				arg_144_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_144_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_147_1 = 0
			local var_147_2 = 0.7

			if 0 < arg_144_1.time_ and arg_144_1.time_ <= var_147_1 + arg_147_0 then
				arg_144_1.talkMaxDuration = 0
				arg_144_1.dialogCg_.alpha = 1

				arg_144_1.dialog_:SetActive(true)
				SetActive(arg_144_1.leftNameGo_, true)

				arg_144_1.leftNameTxt_.text = arg_144_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_144_1.leftNameTxt_.transform)

				arg_144_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_144_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_144_1:RecordName(arg_144_1.leftNameTxt_.text)
				SetActive(arg_144_1.iconTrs_.gameObject, true)
				arg_144_1.iconController_:SetSelectedState("hero")

				arg_144_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_144_1.callingController_:SetSelectedState("normal")

				arg_144_1.keyicon_.color = Color.New(1, 1, 1)
				arg_144_1.icon_.color = Color.New(1, 1, 1)

				local var_147_3 = arg_144_1:FormatText(arg_144_1:GetWordFromCfg(939062033).content)

				arg_144_1.text_.text = var_147_3

				LuaForUtil.ClearLinePrefixSymbol(arg_144_1.text_)

				local var_147_5 = 28 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 28)

				if (28 <= 0 and var_147_2 or var_147_2 * (utf8.len(var_147_3) / 28)) > 0 and var_147_2 < var_147_5 then
					arg_144_1.talkMaxDuration = var_147_5

					if var_147_5 + var_147_1 > arg_144_1.duration_ then
						arg_144_1.duration_ = var_147_5 + var_147_1
					end
				end

				arg_144_1.text_.text = var_147_3
				arg_144_1.typewritter.percent = 0

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(false)
				arg_144_1:RecordContent(arg_144_1.text_.text)
			end

			local var_147_6 = math.max(var_147_2, arg_144_1.talkMaxDuration)

			if var_147_1 <= arg_144_1.time_ and arg_144_1.time_ < var_147_1 + var_147_6 then
				arg_144_1.typewritter.percent = (arg_144_1.time_ - var_147_1) / var_147_6

				arg_144_1.typewritter:SetDirty()
			end

			if arg_144_1.time_ >= var_147_1 + var_147_6 and arg_144_1.time_ < var_147_1 + var_147_6 + arg_147_0 then
				arg_144_1.typewritter.percent = 1

				arg_144_1.typewritter:SetDirty()
				arg_144_1:ShowNextGo(true)
			end
		end

		arg_144_1.nodeConfigList_ = {}

		arg_144_1:InitPlayNodeList()
	end,
	Play939062034 = function(arg_148_0, arg_148_1)
		arg_148_1.time_ = 0
		arg_148_1.frameCnt_ = 0
		arg_148_1.state_ = "playing"
		arg_148_1.curTalkId_ = 939062034
		arg_148_1.duration_ = 5

		SetActive(arg_148_1.tipsGo_, false)

		function arg_148_1.onSingleLineFinish_()
			arg_148_1.onSingleLineUpdate_ = nil
			arg_148_1.onSingleLineFinish_ = nil
			arg_148_1.state_ = "waiting"
		end

		function arg_148_1.playNext_(arg_150_0)
			if arg_150_0 == 1 then
				arg_148_0:Play939062035(arg_148_1)
			end
		end

		function arg_148_1.onSingleLineUpdate_(arg_151_0)
			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1.var_.moveOldPos1019ui_story = arg_148_1.actors_["1019ui_story"].transform.localPosition
			end

			local var_151_0 = 0.001

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_0 then
				arg_148_1.actors_["1019ui_story"].transform.localPosition = Vector3.Lerp(arg_148_1.var_.moveOldPos1019ui_story, Vector3.New(-0.2, -1.08, -5.9), (arg_148_1.time_ - 0) / var_151_0)
				arg_148_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1019ui_story"].transform.position).z)
				arg_148_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1019ui_story"].transform.localEulerAngles = arg_148_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			if arg_148_1.time_ >= 0 + var_151_0 and arg_148_1.time_ < 0 + var_151_0 + arg_151_0 then
				arg_148_1.actors_["1019ui_story"].transform.localPosition = Vector3.New(-0.2, -1.08, -5.9)
				arg_148_1.actors_["1019ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_148_1.actors_["1019ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1019ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_148_1.actors_["1019ui_story"].transform.position).z)
				arg_148_1.actors_["1019ui_story"].transform.localEulerAngles.z = 0
				arg_148_1.actors_["1019ui_story"].transform.localEulerAngles.x = 0
				arg_148_1.actors_["1019ui_story"].transform.localEulerAngles = arg_148_1.actors_["1019ui_story"].transform.localEulerAngles
			end

			local var_151_1 = arg_148_1.actors_["1019ui_story"]

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1019ui_story == nil then
				arg_148_1.var_.characterEffect1019ui_story = var_151_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_151_2 = 0.200000002980232

			if 0 <= arg_148_1.time_ and arg_148_1.time_ < 0 + var_151_2 and not isNil(var_151_1) then
				if arg_148_1.var_.characterEffect1019ui_story and not isNil(var_151_1) then
					arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if arg_148_1.time_ >= 0 + var_151_2 and arg_148_1.time_ < 0 + var_151_2 + arg_151_0 and not isNil(var_151_1) and arg_148_1.var_.characterEffect1019ui_story then
				arg_148_1.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/story1019/story1019action/1019action2_1")
			end

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= 0 + arg_151_0 then
				arg_148_1:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_151_4 = 0
			local var_151_5 = 1.15

			if 0 < arg_148_1.time_ and arg_148_1.time_ <= var_151_4 + arg_151_0 then
				arg_148_1.talkMaxDuration = 0
				arg_148_1.dialogCg_.alpha = 1

				arg_148_1.dialog_:SetActive(true)
				SetActive(arg_148_1.leftNameGo_, true)

				arg_148_1.leftNameTxt_.text = arg_148_1:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_148_1.leftNameTxt_.transform)

				arg_148_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_148_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_148_1:RecordName(arg_148_1.leftNameTxt_.text)
				SetActive(arg_148_1.iconTrs_.gameObject, false)
				arg_148_1.callingController_:SetSelectedState("normal")

				local var_151_6 = arg_148_1:FormatText(arg_148_1:GetWordFromCfg(939062034).content)

				arg_148_1.text_.text = var_151_6

				LuaForUtil.ClearLinePrefixSymbol(arg_148_1.text_)

				local var_151_8 = 46 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_6) / 46)

				if (46 <= 0 and var_151_5 or var_151_5 * (utf8.len(var_151_6) / 46)) > 0 and var_151_5 < var_151_8 then
					arg_148_1.talkMaxDuration = var_151_8

					if var_151_8 + var_151_4 > arg_148_1.duration_ then
						arg_148_1.duration_ = var_151_8 + var_151_4
					end
				end

				arg_148_1.text_.text = var_151_6
				arg_148_1.typewritter.percent = 0

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(false)
				arg_148_1:RecordContent(arg_148_1.text_.text)
			end

			local var_151_9 = math.max(var_151_5, arg_148_1.talkMaxDuration)

			if var_151_4 <= arg_148_1.time_ and arg_148_1.time_ < var_151_4 + var_151_9 then
				arg_148_1.typewritter.percent = (arg_148_1.time_ - var_151_4) / var_151_9

				arg_148_1.typewritter:SetDirty()
			end

			if arg_148_1.time_ >= var_151_4 + var_151_9 and arg_148_1.time_ < var_151_4 + var_151_9 + arg_151_0 then
				arg_148_1.typewritter.percent = 1

				arg_148_1.typewritter:SetDirty()
				arg_148_1:ShowNextGo(true)
			end
		end

		arg_148_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_148_1:InitPlayNodeList()
	end,
	Play939062035 = function(arg_152_0, arg_152_1)
		arg_152_1.time_ = 0
		arg_152_1.frameCnt_ = 0
		arg_152_1.state_ = "playing"
		arg_152_1.curTalkId_ = 939062035
		arg_152_1.duration_ = 5

		SetActive(arg_152_1.tipsGo_, false)

		function arg_152_1.onSingleLineFinish_()
			arg_152_1.onSingleLineUpdate_ = nil
			arg_152_1.onSingleLineFinish_ = nil
			arg_152_1.state_ = "waiting"
		end

		function arg_152_1.playNext_(arg_154_0)
			if arg_154_0 == 1 then
				arg_152_0:Play939062036(arg_152_1)
			end
		end

		function arg_152_1.onSingleLineUpdate_(arg_155_0)
			if 0 < arg_152_1.time_ and arg_152_1.time_ <= 0 + arg_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) and arg_152_1.var_.characterEffect1019ui_story == nil then
				arg_152_1.var_.characterEffect1019ui_story = arg_152_1.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_155_0 = 0.200000002980232

			if 0 <= arg_152_1.time_ and arg_152_1.time_ < 0 + var_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) then
				if arg_152_1.var_.characterEffect1019ui_story and not isNil(arg_152_1.actors_["1019ui_story"]) then
					arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
					arg_152_1.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_152_1.time_ - 0) / var_155_0)
				end
			end

			if arg_152_1.time_ >= 0 + var_155_0 and arg_152_1.time_ < 0 + var_155_0 + arg_155_0 and not isNil(arg_152_1.actors_["1019ui_story"]) and arg_152_1.var_.characterEffect1019ui_story then
				arg_152_1.var_.characterEffect1019ui_story.fillFlat = true
				arg_152_1.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			local var_155_1 = 0
			local var_155_2 = 0.1

			if 0 < arg_152_1.time_ and arg_152_1.time_ <= var_155_1 + arg_155_0 then
				arg_152_1.talkMaxDuration = 0
				arg_152_1.dialogCg_.alpha = 1

				arg_152_1.dialog_:SetActive(true)
				SetActive(arg_152_1.leftNameGo_, true)

				arg_152_1.leftNameTxt_.text = arg_152_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_152_1.leftNameTxt_.transform)

				arg_152_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_152_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_152_1:RecordName(arg_152_1.leftNameTxt_.text)
				SetActive(arg_152_1.iconTrs_.gameObject, true)
				arg_152_1.iconController_:SetSelectedState("hero")

				arg_152_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_152_1.callingController_:SetSelectedState("normal")

				arg_152_1.keyicon_.color = Color.New(1, 1, 1)
				arg_152_1.icon_.color = Color.New(1, 1, 1)

				local var_155_3 = arg_152_1:FormatText(arg_152_1:GetWordFromCfg(939062035).content)

				arg_152_1.text_.text = var_155_3

				LuaForUtil.ClearLinePrefixSymbol(arg_152_1.text_)

				local var_155_5 = 4 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 4)

				if (4 <= 0 and var_155_2 or var_155_2 * (utf8.len(var_155_3) / 4)) > 0 and var_155_2 < var_155_5 then
					arg_152_1.talkMaxDuration = var_155_5

					if var_155_5 + var_155_1 > arg_152_1.duration_ then
						arg_152_1.duration_ = var_155_5 + var_155_1
					end
				end

				arg_152_1.text_.text = var_155_3
				arg_152_1.typewritter.percent = 0

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(false)
				arg_152_1:RecordContent(arg_152_1.text_.text)
			end

			local var_155_6 = math.max(var_155_2, arg_152_1.talkMaxDuration)

			if var_155_1 <= arg_152_1.time_ and arg_152_1.time_ < var_155_1 + var_155_6 then
				arg_152_1.typewritter.percent = (arg_152_1.time_ - var_155_1) / var_155_6

				arg_152_1.typewritter:SetDirty()
			end

			if arg_152_1.time_ >= var_155_1 + var_155_6 and arg_152_1.time_ < var_155_1 + var_155_6 + arg_155_0 then
				arg_152_1.typewritter.percent = 1

				arg_152_1.typewritter:SetDirty()
				arg_152_1:ShowNextGo(true)
			end
		end

		arg_152_1.nodeConfigList_ = {}

		arg_152_1:InitPlayNodeList()
	end,
	Play939062036 = function(arg_156_0, arg_156_1)
		arg_156_1.time_ = 0
		arg_156_1.frameCnt_ = 0
		arg_156_1.state_ = "playing"
		arg_156_1.curTalkId_ = 939062036
		arg_156_1.duration_ = 5

		SetActive(arg_156_1.tipsGo_, false)

		function arg_156_1.onSingleLineFinish_()
			arg_156_1.onSingleLineUpdate_ = nil
			arg_156_1.onSingleLineFinish_ = nil
			arg_156_1.state_ = "waiting"
		end

		function arg_156_1.playNext_(arg_158_0)
			if arg_158_0 == 1 then
				arg_156_0:Play939062037(arg_156_1)
			end
		end

		function arg_156_1.onSingleLineUpdate_(arg_159_0)
			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1284ui_story = arg_156_1.actors_["1284ui_story"].transform.localPosition
			end

			local var_159_0 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_0 then
				arg_156_1.actors_["1284ui_story"].transform.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1284ui_story, Vector3.New(0.7, -0.985, -6.22), (arg_156_1.time_ - 0) / var_159_0)
				arg_156_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1284ui_story"].transform.position).z)
				arg_156_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1284ui_story"].transform.localEulerAngles = arg_156_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_0 and arg_156_1.time_ < 0 + var_159_0 + arg_159_0 then
				arg_156_1.actors_["1284ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6.22)
				arg_156_1.actors_["1284ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_156_1.actors_["1284ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1284ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_156_1.actors_["1284ui_story"].transform.position).z)
				arg_156_1.actors_["1284ui_story"].transform.localEulerAngles.z = 0
				arg_156_1.actors_["1284ui_story"].transform.localEulerAngles.x = 0
				arg_156_1.actors_["1284ui_story"].transform.localEulerAngles = arg_156_1.actors_["1284ui_story"].transform.localEulerAngles
			end

			local var_159_1 = arg_156_1.actors_["1019ui_story"].transform

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1.var_.moveOldPos1019ui_story = var_159_1.localPosition
			end

			local var_159_2 = 0.001

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_2 then
				var_159_1.localPosition = Vector3.Lerp(arg_156_1.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (arg_156_1.time_ - 0) / var_159_2)
				var_159_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_1.position).x, (manager.ui.mainCamera.transform.position - var_159_1.position).y, (manager.ui.mainCamera.transform.position - var_159_1.position).z)
				var_159_1.localEulerAngles.z = 0
				var_159_1.localEulerAngles.x = 0
				var_159_1.localEulerAngles = var_159_1.localEulerAngles
			end

			if arg_156_1.time_ >= 0 + var_159_2 and arg_156_1.time_ < 0 + var_159_2 + arg_159_0 then
				var_159_1.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				var_159_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_159_1.position).x, (manager.ui.mainCamera.transform.position - var_159_1.position).y, (manager.ui.mainCamera.transform.position - var_159_1.position).z)
				var_159_1.localEulerAngles.z = 0
				var_159_1.localEulerAngles.x = 0
				var_159_1.localEulerAngles = var_159_1.localEulerAngles
			end

			local var_159_3 = arg_156_1.actors_["1284ui_story"]

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect1284ui_story == nil then
				arg_156_1.var_.characterEffect1284ui_story = var_159_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_159_4 = 0.200000002980232

			if 0 <= arg_156_1.time_ and arg_156_1.time_ < 0 + var_159_4 and not isNil(var_159_3) then
				if arg_156_1.var_.characterEffect1284ui_story and not isNil(var_159_3) then
					arg_156_1.var_.characterEffect1284ui_story.fillFlat = false
				end
			end

			if arg_156_1.time_ >= 0 + var_159_4 and arg_156_1.time_ < 0 + var_159_4 + arg_159_0 and not isNil(var_159_3) and arg_156_1.var_.characterEffect1284ui_story then
				arg_156_1.var_.characterEffect1284ui_story.fillFlat = false
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/story1284/story1284action/1284action1_1")
			end

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= 0 + arg_159_0 then
				arg_156_1:PlayTimeline("1284ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_159_6 = 0
			local var_159_7 = 1

			if 0 < arg_156_1.time_ and arg_156_1.time_ <= var_159_6 + arg_159_0 then
				arg_156_1.talkMaxDuration = 0
				arg_156_1.dialogCg_.alpha = 1

				arg_156_1.dialog_:SetActive(true)
				SetActive(arg_156_1.leftNameGo_, true)

				arg_156_1.leftNameTxt_.text = arg_156_1:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_156_1.leftNameTxt_.transform)

				arg_156_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_156_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_156_1:RecordName(arg_156_1.leftNameTxt_.text)
				SetActive(arg_156_1.iconTrs_.gameObject, false)
				arg_156_1.callingController_:SetSelectedState("normal")

				local var_159_8 = arg_156_1:FormatText(arg_156_1:GetWordFromCfg(939062036).content)

				arg_156_1.text_.text = var_159_8

				LuaForUtil.ClearLinePrefixSymbol(arg_156_1.text_)

				local var_159_10 = 40 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_8) / 40)

				if (40 <= 0 and var_159_7 or var_159_7 * (utf8.len(var_159_8) / 40)) > 0 and var_159_7 < var_159_10 then
					arg_156_1.talkMaxDuration = var_159_10

					if var_159_10 + var_159_6 > arg_156_1.duration_ then
						arg_156_1.duration_ = var_159_10 + var_159_6
					end
				end

				arg_156_1.text_.text = var_159_8
				arg_156_1.typewritter.percent = 0

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(false)
				arg_156_1:RecordContent(arg_156_1.text_.text)
			end

			local var_159_11 = math.max(var_159_7, arg_156_1.talkMaxDuration)

			if var_159_6 <= arg_156_1.time_ and arg_156_1.time_ < var_159_6 + var_159_11 then
				arg_156_1.typewritter.percent = (arg_156_1.time_ - var_159_6) / var_159_11

				arg_156_1.typewritter:SetDirty()
			end

			if arg_156_1.time_ >= var_159_6 + var_159_11 and arg_156_1.time_ < var_159_6 + var_159_11 + arg_159_0 then
				arg_156_1.typewritter.percent = 1

				arg_156_1.typewritter:SetDirty()
				arg_156_1:ShowNextGo(true)
			end
		end

		arg_156_1.nodeConfigList_ = {
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
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_156_1:InitPlayNodeList()
	end,
	Play939062037 = function(arg_160_0, arg_160_1)
		arg_160_1.time_ = 0
		arg_160_1.frameCnt_ = 0
		arg_160_1.state_ = "playing"
		arg_160_1.curTalkId_ = 939062037
		arg_160_1.duration_ = 9

		SetActive(arg_160_1.tipsGo_, false)

		function arg_160_1.onSingleLineFinish_()
			arg_160_1.onSingleLineUpdate_ = nil
			arg_160_1.onSingleLineFinish_ = nil
			arg_160_1.state_ = "waiting"
		end

		function arg_160_1.playNext_(arg_162_0)
			if arg_162_0 == 1 then
				arg_160_0:Play939062038(arg_160_1)
			end
		end

		function arg_160_1.onSingleLineUpdate_(arg_163_0)
			if arg_160_1.bgs_.I03 == nil then
				local var_163_0 = Object.Instantiate(arg_160_1.paintGo_)

				var_163_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "I03")
				var_163_0.name = "I03"
				var_163_0.transform.parent = arg_160_1.stage_.transform
				var_163_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_160_1.bgs_.I03 = var_163_0
			end

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= 2 + arg_163_0 then
				local var_163_1 = arg_160_1.bgs_.I03

				arg_160_1.bgs_.I03.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_163_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_163_2 = var_163_1:GetComponent("SpriteRenderer")

				if var_163_2 and var_163_2.sprite then
					local var_163_3 = 2 * (var_163_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_163_1.transform.localScale = Vector3.New(var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, var_163_3 / var_163_2.sprite.bounds.size.y < var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x and var_163_3 * manager.ui.mainCameraCom_.aspect / var_163_2.sprite.bounds.size.x or var_163_3 / var_163_2.sprite.bounds.size.y, 0)
				end

				for iter_163_0, iter_163_1 in pairs(arg_160_1.bgs_) do
					if iter_163_0 ~= "I03" then
						iter_163_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_163_4 = 4

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_4 + arg_163_0 then
				arg_160_1.allBtn_.enabled = false
			end

			if arg_160_1.time_ >= var_163_4 + 0.3 and arg_160_1.time_ < var_163_4 + 0.3 + arg_163_0 then
				arg_160_1.allBtn_.enabled = true
			end

			local var_163_5 = 0

			if 0 < arg_160_1.time_ and arg_160_1.time_ <= var_163_5 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_6 = 2

			if var_163_5 <= arg_160_1.time_ and arg_160_1.time_ < var_163_5 + var_163_6 then
				local var_163_7 = Color.New(0, 0, 0)

				var_163_7.a = Mathf.Lerp(0, 1, (arg_160_1.time_ - var_163_5) / var_163_6)
				arg_160_1.mask_.color = var_163_7
			end

			if arg_160_1.time_ >= var_163_5 + var_163_6 and arg_160_1.time_ < var_163_5 + var_163_6 + arg_163_0 then
				local var_163_8 = Color.New(0, 0, 0)

				var_163_8.a = 1
				arg_160_1.mask_.color = var_163_8
			end

			local var_163_9 = 2

			if 2 < arg_160_1.time_ and arg_160_1.time_ <= var_163_9 + arg_163_0 then
				arg_160_1.mask_.enabled = true
				arg_160_1.mask_.raycastTarget = true

				arg_160_1:SetGaussion(false)
			end

			local var_163_10 = 2

			if var_163_9 <= arg_160_1.time_ and arg_160_1.time_ < var_163_9 + var_163_10 then
				local var_163_11 = Color.New(0, 0, 0)

				var_163_11.a = Mathf.Lerp(1, 0, (arg_160_1.time_ - var_163_9) / var_163_10)
				arg_160_1.mask_.color = var_163_11
			end

			if arg_160_1.time_ >= var_163_9 + var_163_10 and arg_160_1.time_ < var_163_9 + var_163_10 + arg_163_0 then
				local var_163_12 = Color.New(0, 0, 0)

				arg_160_1.mask_.enabled = false
				var_163_12.a = 0
				arg_160_1.mask_.color = var_163_12
			end

			local var_163_13 = arg_160_1.actors_["1284ui_story"].transform

			if 1.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= 1.96599999815226 + arg_163_0 then
				arg_160_1.var_.moveOldPos1284ui_story = var_163_13.localPosition
			end

			local var_163_14 = 0.001

			if 1.96599999815226 <= arg_160_1.time_ and arg_160_1.time_ < 1.96599999815226 + var_163_14 then
				var_163_13.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1284ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 1.96599999815226) / var_163_14)
				var_163_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_13.position).x, (manager.ui.mainCamera.transform.position - var_163_13.position).y, (manager.ui.mainCamera.transform.position - var_163_13.position).z)
				var_163_13.localEulerAngles.z = 0
				var_163_13.localEulerAngles.x = 0
				var_163_13.localEulerAngles = var_163_13.localEulerAngles
			end

			if arg_160_1.time_ >= 1.96599999815226 + var_163_14 and arg_160_1.time_ < 1.96599999815226 + var_163_14 + arg_163_0 then
				var_163_13.localPosition = Vector3.New(0, 100, 0)
				var_163_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_13.position).x, (manager.ui.mainCamera.transform.position - var_163_13.position).y, (manager.ui.mainCamera.transform.position - var_163_13.position).z)
				var_163_13.localEulerAngles.z = 0
				var_163_13.localEulerAngles.x = 0
				var_163_13.localEulerAngles = var_163_13.localEulerAngles
			end

			local var_163_15 = arg_160_1.actors_["1019ui_story"].transform

			if 1.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= 1.96599999815226 + arg_163_0 then
				arg_160_1.var_.moveOldPos1019ui_story = var_163_15.localPosition
			end

			local var_163_16 = 0.001

			if 1.96599999815226 <= arg_160_1.time_ and arg_160_1.time_ < 1.96599999815226 + var_163_16 then
				var_163_15.localPosition = Vector3.Lerp(arg_160_1.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (arg_160_1.time_ - 1.96599999815226) / var_163_16)
				var_163_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_15.position).x, (manager.ui.mainCamera.transform.position - var_163_15.position).y, (manager.ui.mainCamera.transform.position - var_163_15.position).z)
				var_163_15.localEulerAngles.z = 0
				var_163_15.localEulerAngles.x = 0
				var_163_15.localEulerAngles = var_163_15.localEulerAngles
			end

			if arg_160_1.time_ >= 1.96599999815226 + var_163_16 and arg_160_1.time_ < 1.96599999815226 + var_163_16 + arg_163_0 then
				var_163_15.localPosition = Vector3.New(0, 100, 0)
				var_163_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_163_15.position).x, (manager.ui.mainCamera.transform.position - var_163_15.position).y, (manager.ui.mainCamera.transform.position - var_163_15.position).z)
				var_163_15.localEulerAngles.z = 0
				var_163_15.localEulerAngles.x = 0
				var_163_15.localEulerAngles = var_163_15.localEulerAngles
			end

			local var_163_17 = arg_160_1.actors_["1284ui_story"]

			if 1.96599999815226 < arg_160_1.time_ and arg_160_1.time_ <= 1.96599999815226 + arg_163_0 and not isNil(var_163_17) and arg_160_1.var_.characterEffect1284ui_story == nil then
				arg_160_1.var_.characterEffect1284ui_story = var_163_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_163_18 = 0.034000001847744

			if 1.96599999815226 <= arg_160_1.time_ and arg_160_1.time_ < 1.96599999815226 + var_163_18 and not isNil(var_163_17) then
				if arg_160_1.var_.characterEffect1284ui_story and not isNil(var_163_17) then
					arg_160_1.var_.characterEffect1284ui_story.fillFlat = true
					arg_160_1.var_.characterEffect1284ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_160_1.time_ - 1.96599999815226) / var_163_18)
				end
			end

			if arg_160_1.time_ >= 1.96599999815226 + var_163_18 and arg_160_1.time_ < 1.96599999815226 + var_163_18 + arg_163_0 and not isNil(var_163_17) and arg_160_1.var_.characterEffect1284ui_story then
				arg_160_1.var_.characterEffect1284ui_story.fillFlat = true
				arg_160_1.var_.characterEffect1284ui_story.fillRatio = 0.5
			end

			if arg_160_1.frameCnt_ <= 1 then
				arg_160_1.dialog_:SetActive(false)
			end

			local var_163_19 = 4
			local var_163_20 = 0.775

			if 4 < arg_160_1.time_ and arg_160_1.time_ <= var_163_19 + arg_163_0 then
				arg_160_1.talkMaxDuration = 0

				arg_160_1.dialog_:SetActive(true)

				arg_160_1.dialogCg_.alpha = 0

				local var_163_21 = LeanTween.value(arg_160_1.dialog_, 0, 1, 0.3)

				var_163_21:setOnUpdate(LuaHelper.FloatAction(function(arg_164_0)
					arg_160_1.dialogCg_.alpha = arg_164_0
				end))
				var_163_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_160_1.dialog_)
					var_163_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_160_1.duration_ = arg_160_1.duration_ + 0.3

				SetActive(arg_160_1.leftNameGo_, false)

				arg_160_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_160_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_160_1:RecordName(arg_160_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_160_1.iconTrs_.gameObject, false)
				arg_160_1.callingController_:SetSelectedState("normal")

				local var_163_22 = arg_160_1:FormatText(arg_160_1:GetWordFromCfg(939062037).content)

				arg_160_1.text_.text = var_163_22

				LuaForUtil.ClearLinePrefixSymbol(arg_160_1.text_)

				local var_163_24 = 31 <= 0 and var_163_20 or var_163_20 * (utf8.len(var_163_22) / 31)

				if (31 <= 0 and var_163_20 or var_163_20 * (utf8.len(var_163_22) / 31)) > 0 and var_163_20 < var_163_24 then
					arg_160_1.talkMaxDuration = var_163_24
					var_163_19 = var_163_19 + 0.3

					if var_163_24 + var_163_19 > arg_160_1.duration_ then
						arg_160_1.duration_ = var_163_24 + var_163_19
					end
				end

				arg_160_1.text_.text = var_163_22
				arg_160_1.typewritter.percent = 0

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(false)
				arg_160_1:RecordContent(arg_160_1.text_.text)
			end

			local var_163_25 = var_163_19 + 0.3
			local var_163_26 = math.max(var_163_20, arg_160_1.talkMaxDuration)

			if var_163_19 + 0.3 <= arg_160_1.time_ and arg_160_1.time_ < var_163_25 + var_163_26 then
				arg_160_1.typewritter.percent = (arg_160_1.time_ - var_163_25) / var_163_26

				arg_160_1.typewritter:SetDirty()
			end

			if arg_160_1.time_ >= var_163_25 + var_163_26 and arg_160_1.time_ < var_163_25 + var_163_26 + arg_163_0 then
				arg_160_1.typewritter.percent = 1

				arg_160_1.typewritter:SetDirty()
				arg_160_1:ShowNextGo(true)
			end
		end

		arg_160_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1284ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1019ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_160_1:InitPlayNodeList()
	end,
	Play939062038 = function(arg_166_0, arg_166_1)
		arg_166_1.time_ = 0
		arg_166_1.frameCnt_ = 0
		arg_166_1.state_ = "playing"
		arg_166_1.curTalkId_ = 939062038
		arg_166_1.duration_ = 5

		SetActive(arg_166_1.tipsGo_, false)

		function arg_166_1.onSingleLineFinish_()
			arg_166_1.onSingleLineUpdate_ = nil
			arg_166_1.onSingleLineFinish_ = nil
			arg_166_1.state_ = "waiting"
		end

		function arg_166_1.playNext_(arg_168_0)
			if arg_168_0 == 1 then
				arg_166_0:Play939062039(arg_166_1)
			end
		end

		function arg_166_1.onSingleLineUpdate_(arg_169_0)
			if arg_166_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_169_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_166_1.stage_.transform)

				var_169_0.name = "1047ui_story"
				var_169_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_166_1.actors_["1047ui_story"] = var_169_0

				local var_169_1 = var_169_0:GetComponentInChildren(typeof(CharacterEffect))

				var_169_1.enabled = true

				local var_169_2 = GameObjectTools.GetOrAddComponent(var_169_0, typeof(DynamicBoneHelper))

				if var_169_2 then
					var_169_2:EnableDynamicBone(false)
				end

				arg_166_1:ShowWeapon(var_169_1.transform, false)

				arg_166_1.var_["1047ui_story" .. "Animator"] = var_169_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_166_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_166_1.var_["1047ui_story" .. "LipSync"] = var_169_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_169_3 = arg_166_1.actors_["1047ui_story"].transform

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1.var_.moveOldPos1047ui_story = var_169_3.localPosition
			end

			local var_169_4 = 0.001

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_4 then
				var_169_3.localPosition = Vector3.Lerp(arg_166_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_166_1.time_ - 0) / var_169_4)
				var_169_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_3.position).x, (manager.ui.mainCamera.transform.position - var_169_3.position).y, (manager.ui.mainCamera.transform.position - var_169_3.position).z)
				var_169_3.localEulerAngles.z = 0
				var_169_3.localEulerAngles.x = 0
				var_169_3.localEulerAngles = var_169_3.localEulerAngles
			end

			if arg_166_1.time_ >= 0 + var_169_4 and arg_166_1.time_ < 0 + var_169_4 + arg_169_0 then
				var_169_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_169_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_169_3.position).x, (manager.ui.mainCamera.transform.position - var_169_3.position).y, (manager.ui.mainCamera.transform.position - var_169_3.position).z)
				var_169_3.localEulerAngles.z = 0
				var_169_3.localEulerAngles.x = 0
				var_169_3.localEulerAngles = var_169_3.localEulerAngles
			end

			local var_169_5 = arg_166_1.actors_["1047ui_story"]

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1047ui_story == nil then
				arg_166_1.var_.characterEffect1047ui_story = var_169_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_169_6 = 0.200000002980232

			if 0 <= arg_166_1.time_ and arg_166_1.time_ < 0 + var_169_6 and not isNil(var_169_5) then
				if arg_166_1.var_.characterEffect1047ui_story and not isNil(var_169_5) then
					arg_166_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_166_1.time_ >= 0 + var_169_6 and arg_166_1.time_ < 0 + var_169_6 + arg_169_0 and not isNil(var_169_5) and arg_166_1.var_.characterEffect1047ui_story then
				arg_166_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= 0 + arg_169_0 then
				arg_166_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileC_biyan", "EmotionTimelineAnimator")
			end

			local var_169_8 = 0
			local var_169_9 = 1.05

			if 0 < arg_166_1.time_ and arg_166_1.time_ <= var_169_8 + arg_169_0 then
				arg_166_1.talkMaxDuration = 0
				arg_166_1.dialogCg_.alpha = 1

				arg_166_1.dialog_:SetActive(true)
				SetActive(arg_166_1.leftNameGo_, true)

				arg_166_1.leftNameTxt_.text = arg_166_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_166_1.leftNameTxt_.transform)

				arg_166_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_166_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_166_1:RecordName(arg_166_1.leftNameTxt_.text)
				SetActive(arg_166_1.iconTrs_.gameObject, false)
				arg_166_1.callingController_:SetSelectedState("normal")

				local var_169_10 = arg_166_1:FormatText(arg_166_1:GetWordFromCfg(939062038).content)

				arg_166_1.text_.text = var_169_10

				LuaForUtil.ClearLinePrefixSymbol(arg_166_1.text_)

				local var_169_12 = 42 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_10) / 42)

				if (42 <= 0 and var_169_9 or var_169_9 * (utf8.len(var_169_10) / 42)) > 0 and var_169_9 < var_169_12 then
					arg_166_1.talkMaxDuration = var_169_12

					if var_169_12 + var_169_8 > arg_166_1.duration_ then
						arg_166_1.duration_ = var_169_12 + var_169_8
					end
				end

				arg_166_1.text_.text = var_169_10
				arg_166_1.typewritter.percent = 0

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(false)
				arg_166_1:RecordContent(arg_166_1.text_.text)
			end

			local var_169_13 = math.max(var_169_9, arg_166_1.talkMaxDuration)

			if var_169_8 <= arg_166_1.time_ and arg_166_1.time_ < var_169_8 + var_169_13 then
				arg_166_1.typewritter.percent = (arg_166_1.time_ - var_169_8) / var_169_13

				arg_166_1.typewritter:SetDirty()
			end

			if arg_166_1.time_ >= var_169_8 + var_169_13 and arg_166_1.time_ < var_169_8 + var_169_13 + arg_169_0 then
				arg_166_1.typewritter.percent = 1

				arg_166_1.typewritter:SetDirty()
				arg_166_1:ShowNextGo(true)
			end
		end

		arg_166_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_166_1:InitPlayNodeList()
	end,
	Play939062039 = function(arg_170_0, arg_170_1)
		arg_170_1.time_ = 0
		arg_170_1.frameCnt_ = 0
		arg_170_1.state_ = "playing"
		arg_170_1.curTalkId_ = 939062039
		arg_170_1.duration_ = 5

		SetActive(arg_170_1.tipsGo_, false)

		function arg_170_1.onSingleLineFinish_()
			arg_170_1.onSingleLineUpdate_ = nil
			arg_170_1.onSingleLineFinish_ = nil
			arg_170_1.state_ = "waiting"
		end

		function arg_170_1.playNext_(arg_172_0)
			if arg_172_0 == 1 then
				arg_170_0:Play939062040(arg_170_1)
			end
		end

		function arg_170_1.onSingleLineUpdate_(arg_173_0)
			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 then
				arg_170_1.var_.moveOldPos1047ui_story = arg_170_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_173_0 = 0.001

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_0 then
				arg_170_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_170_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_170_1.time_ - 0) / var_173_0)
				arg_170_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1047ui_story"].transform.position).z)
				arg_170_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1047ui_story"].transform.localEulerAngles = arg_170_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_170_1.time_ >= 0 + var_173_0 and arg_170_1.time_ < 0 + var_173_0 + arg_173_0 then
				arg_170_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_170_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_170_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_170_1.actors_["1047ui_story"].transform.position).z)
				arg_170_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_170_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_170_1.actors_["1047ui_story"].transform.localEulerAngles = arg_170_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_173_1 = arg_170_1.actors_["1047ui_story"]

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= 0 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1047ui_story == nil then
				arg_170_1.var_.characterEffect1047ui_story = var_173_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_173_2 = 0.200000002980232

			if 0 <= arg_170_1.time_ and arg_170_1.time_ < 0 + var_173_2 and not isNil(var_173_1) then
				if arg_170_1.var_.characterEffect1047ui_story and not isNil(var_173_1) then
					arg_170_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_170_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_170_1.time_ - 0) / var_173_2)
				end
			end

			if arg_170_1.time_ >= 0 + var_173_2 and arg_170_1.time_ < 0 + var_173_2 + arg_173_0 and not isNil(var_173_1) and arg_170_1.var_.characterEffect1047ui_story then
				arg_170_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_170_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_173_3 = 0
			local var_173_4 = 1.7

			if 0 < arg_170_1.time_ and arg_170_1.time_ <= var_173_3 + arg_173_0 then
				arg_170_1.talkMaxDuration = 0
				arg_170_1.dialogCg_.alpha = 1

				arg_170_1.dialog_:SetActive(true)
				SetActive(arg_170_1.leftNameGo_, false)

				arg_170_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_170_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_170_1:RecordName(arg_170_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_170_1.iconTrs_.gameObject, false)
				arg_170_1.callingController_:SetSelectedState("normal")

				local var_173_5 = arg_170_1:FormatText(arg_170_1:GetWordFromCfg(939062039).content)

				arg_170_1.text_.text = var_173_5

				LuaForUtil.ClearLinePrefixSymbol(arg_170_1.text_)

				local var_173_7 = 68 <= 0 and var_173_4 or var_173_4 * (utf8.len(var_173_5) / 68)

				if (68 <= 0 and var_173_4 or var_173_4 * (utf8.len(var_173_5) / 68)) > 0 and var_173_4 < var_173_7 then
					arg_170_1.talkMaxDuration = var_173_7

					if var_173_7 + var_173_3 > arg_170_1.duration_ then
						arg_170_1.duration_ = var_173_7 + var_173_3
					end
				end

				arg_170_1.text_.text = var_173_5
				arg_170_1.typewritter.percent = 0

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(false)
				arg_170_1:RecordContent(arg_170_1.text_.text)
			end

			local var_173_8 = math.max(var_173_4, arg_170_1.talkMaxDuration)

			if var_173_3 <= arg_170_1.time_ and arg_170_1.time_ < var_173_3 + var_173_8 then
				arg_170_1.typewritter.percent = (arg_170_1.time_ - var_173_3) / var_173_8

				arg_170_1.typewritter:SetDirty()
			end

			if arg_170_1.time_ >= var_173_3 + var_173_8 and arg_170_1.time_ < var_173_3 + var_173_8 + arg_173_0 then
				arg_170_1.typewritter.percent = 1

				arg_170_1.typewritter:SetDirty()
				arg_170_1:ShowNextGo(true)
			end
		end

		arg_170_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_170_1:InitPlayNodeList()
	end,
	Play939062040 = function(arg_174_0, arg_174_1)
		arg_174_1.time_ = 0
		arg_174_1.frameCnt_ = 0
		arg_174_1.state_ = "playing"
		arg_174_1.curTalkId_ = 939062040
		arg_174_1.duration_ = 5

		SetActive(arg_174_1.tipsGo_, false)

		function arg_174_1.onSingleLineFinish_()
			arg_174_1.onSingleLineUpdate_ = nil
			arg_174_1.onSingleLineFinish_ = nil
			arg_174_1.state_ = "waiting"
		end

		function arg_174_1.playNext_(arg_176_0)
			if arg_176_0 == 1 then
				arg_174_0:Play939062041(arg_174_1)
			end
		end

		function arg_174_1.onSingleLineUpdate_(arg_177_0)
			local var_177_0 = 0.45

			if 0 < arg_174_1.time_ and arg_174_1.time_ <= 0 + arg_177_0 then
				arg_174_1.talkMaxDuration = 0
				arg_174_1.dialogCg_.alpha = 1

				arg_174_1.dialog_:SetActive(true)
				SetActive(arg_174_1.leftNameGo_, true)

				arg_174_1.leftNameTxt_.text = arg_174_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_174_1.leftNameTxt_.transform)

				arg_174_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_174_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_174_1:RecordName(arg_174_1.leftNameTxt_.text)
				SetActive(arg_174_1.iconTrs_.gameObject, true)
				arg_174_1.iconController_:SetSelectedState("hero")

				arg_174_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_174_1.callingController_:SetSelectedState("normal")

				arg_174_1.keyicon_.color = Color.New(1, 1, 1)
				arg_174_1.icon_.color = Color.New(1, 1, 1)

				local var_177_1 = arg_174_1:FormatText(arg_174_1:GetWordFromCfg(939062040).content)

				arg_174_1.text_.text = var_177_1

				LuaForUtil.ClearLinePrefixSymbol(arg_174_1.text_)

				local var_177_3 = 18 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 18)

				if (18 <= 0 and var_177_0 or var_177_0 * (utf8.len(var_177_1) / 18)) > 0 and var_177_0 < var_177_3 then
					arg_174_1.talkMaxDuration = var_177_3

					if var_177_3 + 0 > arg_174_1.duration_ then
						arg_174_1.duration_ = var_177_3 + 0
					end
				end

				arg_174_1.text_.text = var_177_1
				arg_174_1.typewritter.percent = 0

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(false)
				arg_174_1:RecordContent(arg_174_1.text_.text)
			end

			local var_177_4 = math.max(var_177_0, arg_174_1.talkMaxDuration)

			if 0 <= arg_174_1.time_ and arg_174_1.time_ < 0 + var_177_4 then
				arg_174_1.typewritter.percent = (arg_174_1.time_ - 0) / var_177_4

				arg_174_1.typewritter:SetDirty()
			end

			if arg_174_1.time_ >= 0 + var_177_4 and arg_174_1.time_ < 0 + var_177_4 + arg_177_0 then
				arg_174_1.typewritter.percent = 1

				arg_174_1.typewritter:SetDirty()
				arg_174_1:ShowNextGo(true)
			end
		end

		arg_174_1.nodeConfigList_ = {}

		arg_174_1:InitPlayNodeList()
	end,
	Play939062041 = function(arg_178_0, arg_178_1)
		arg_178_1.time_ = 0
		arg_178_1.frameCnt_ = 0
		arg_178_1.state_ = "playing"
		arg_178_1.curTalkId_ = 939062041
		arg_178_1.duration_ = 5

		SetActive(arg_178_1.tipsGo_, false)

		function arg_178_1.onSingleLineFinish_()
			arg_178_1.onSingleLineUpdate_ = nil
			arg_178_1.onSingleLineFinish_ = nil
			arg_178_1.state_ = "waiting"
		end

		function arg_178_1.playNext_(arg_180_0)
			if arg_180_0 == 1 then
				arg_178_0:Play939062042(arg_178_1)
			end
		end

		function arg_178_1.onSingleLineUpdate_(arg_181_0)
			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1.var_.moveOldPos1248ui_story = arg_178_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_181_0 = 0.001

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_0 then
				arg_178_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_178_1.var_.moveOldPos1248ui_story, Vector3.New(0, -0.775, -6.18), (arg_178_1.time_ - 0) / var_181_0)
				arg_178_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1248ui_story"].transform.position).z)
				arg_178_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1248ui_story"].transform.localEulerAngles = arg_178_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_178_1.time_ >= 0 + var_181_0 and arg_178_1.time_ < 0 + var_181_0 + arg_181_0 then
				arg_178_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0, -0.775, -6.18)
				arg_178_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_178_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_178_1.actors_["1248ui_story"].transform.position).z)
				arg_178_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_178_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_178_1.actors_["1248ui_story"].transform.localEulerAngles = arg_178_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_181_1 = arg_178_1.actors_["1248ui_story"]

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1248ui_story == nil then
				arg_178_1.var_.characterEffect1248ui_story = var_181_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_181_2 = 0.200000002980232

			if 0 <= arg_178_1.time_ and arg_178_1.time_ < 0 + var_181_2 and not isNil(var_181_1) then
				if arg_178_1.var_.characterEffect1248ui_story and not isNil(var_181_1) then
					arg_178_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_178_1.time_ >= 0 + var_181_2 and arg_178_1.time_ < 0 + var_181_2 + arg_181_0 and not isNil(var_181_1) and arg_178_1.var_.characterEffect1248ui_story then
				arg_178_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action1_1")
			end

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= 0 + arg_181_0 then
				arg_178_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_181_4 = 0
			local var_181_5 = 0.425

			if 0 < arg_178_1.time_ and arg_178_1.time_ <= var_181_4 + arg_181_0 then
				arg_178_1.talkMaxDuration = 0
				arg_178_1.dialogCg_.alpha = 1

				arg_178_1.dialog_:SetActive(true)
				SetActive(arg_178_1.leftNameGo_, true)

				arg_178_1.leftNameTxt_.text = arg_178_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_178_1.leftNameTxt_.transform)

				arg_178_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_178_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_178_1:RecordName(arg_178_1.leftNameTxt_.text)
				SetActive(arg_178_1.iconTrs_.gameObject, false)
				arg_178_1.callingController_:SetSelectedState("normal")

				local var_181_6 = arg_178_1:FormatText(arg_178_1:GetWordFromCfg(939062041).content)

				arg_178_1.text_.text = var_181_6

				LuaForUtil.ClearLinePrefixSymbol(arg_178_1.text_)

				local var_181_8 = 17 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_6) / 17)

				if (17 <= 0 and var_181_5 or var_181_5 * (utf8.len(var_181_6) / 17)) > 0 and var_181_5 < var_181_8 then
					arg_178_1.talkMaxDuration = var_181_8

					if var_181_8 + var_181_4 > arg_178_1.duration_ then
						arg_178_1.duration_ = var_181_8 + var_181_4
					end
				end

				arg_178_1.text_.text = var_181_6
				arg_178_1.typewritter.percent = 0

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(false)
				arg_178_1:RecordContent(arg_178_1.text_.text)
			end

			local var_181_9 = math.max(var_181_5, arg_178_1.talkMaxDuration)

			if var_181_4 <= arg_178_1.time_ and arg_178_1.time_ < var_181_4 + var_181_9 then
				arg_178_1.typewritter.percent = (arg_178_1.time_ - var_181_4) / var_181_9

				arg_178_1.typewritter:SetDirty()
			end

			if arg_178_1.time_ >= var_181_4 + var_181_9 and arg_178_1.time_ < var_181_4 + var_181_9 + arg_181_0 then
				arg_178_1.typewritter.percent = 1

				arg_178_1.typewritter:SetDirty()
				arg_178_1:ShowNextGo(true)
			end
		end

		arg_178_1.nodeConfigList_ = {
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

		arg_178_1:InitPlayNodeList()
	end,
	Play939062042 = function(arg_182_0, arg_182_1)
		arg_182_1.time_ = 0
		arg_182_1.frameCnt_ = 0
		arg_182_1.state_ = "playing"
		arg_182_1.curTalkId_ = 939062042
		arg_182_1.duration_ = 5

		SetActive(arg_182_1.tipsGo_, false)

		function arg_182_1.onSingleLineFinish_()
			arg_182_1.onSingleLineUpdate_ = nil
			arg_182_1.onSingleLineFinish_ = nil
			arg_182_1.state_ = "waiting"
		end

		function arg_182_1.playNext_(arg_184_0)
			if arg_184_0 == 1 then
				arg_182_0:Play939062043(arg_182_1)
			end
		end

		function arg_182_1.onSingleLineUpdate_(arg_185_0)
			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 then
				arg_182_1.var_.moveOldPos1248ui_story = arg_182_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_185_0 = 0.001

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_0 then
				arg_182_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_182_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_182_1.time_ - 0) / var_185_0)
				arg_182_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1248ui_story"].transform.position).z)
				arg_182_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1248ui_story"].transform.localEulerAngles = arg_182_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_182_1.time_ >= 0 + var_185_0 and arg_182_1.time_ < 0 + var_185_0 + arg_185_0 then
				arg_182_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_182_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_182_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_182_1.actors_["1248ui_story"].transform.position).z)
				arg_182_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_182_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_182_1.actors_["1248ui_story"].transform.localEulerAngles = arg_182_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_185_1 = arg_182_1.actors_["1248ui_story"]

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= 0 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1248ui_story == nil then
				arg_182_1.var_.characterEffect1248ui_story = var_185_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_185_2 = 0.200000002980232

			if 0 <= arg_182_1.time_ and arg_182_1.time_ < 0 + var_185_2 and not isNil(var_185_1) then
				if arg_182_1.var_.characterEffect1248ui_story and not isNil(var_185_1) then
					arg_182_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_182_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_182_1.time_ - 0) / var_185_2)
				end
			end

			if arg_182_1.time_ >= 0 + var_185_2 and arg_182_1.time_ < 0 + var_185_2 + arg_185_0 and not isNil(var_185_1) and arg_182_1.var_.characterEffect1248ui_story then
				arg_182_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_182_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_185_3 = 0
			local var_185_4 = 0.9

			if 0 < arg_182_1.time_ and arg_182_1.time_ <= var_185_3 + arg_185_0 then
				arg_182_1.talkMaxDuration = 0
				arg_182_1.dialogCg_.alpha = 1

				arg_182_1.dialog_:SetActive(true)
				SetActive(arg_182_1.leftNameGo_, false)

				arg_182_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_182_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_182_1:RecordName(arg_182_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_182_1.iconTrs_.gameObject, false)
				arg_182_1.callingController_:SetSelectedState("normal")

				local var_185_5 = arg_182_1:FormatText(arg_182_1:GetWordFromCfg(939062042).content)

				arg_182_1.text_.text = var_185_5

				LuaForUtil.ClearLinePrefixSymbol(arg_182_1.text_)

				local var_185_7 = 36 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 36)

				if (36 <= 0 and var_185_4 or var_185_4 * (utf8.len(var_185_5) / 36)) > 0 and var_185_4 < var_185_7 then
					arg_182_1.talkMaxDuration = var_185_7

					if var_185_7 + var_185_3 > arg_182_1.duration_ then
						arg_182_1.duration_ = var_185_7 + var_185_3
					end
				end

				arg_182_1.text_.text = var_185_5
				arg_182_1.typewritter.percent = 0

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(false)
				arg_182_1:RecordContent(arg_182_1.text_.text)
			end

			local var_185_8 = math.max(var_185_4, arg_182_1.talkMaxDuration)

			if var_185_3 <= arg_182_1.time_ and arg_182_1.time_ < var_185_3 + var_185_8 then
				arg_182_1.typewritter.percent = (arg_182_1.time_ - var_185_3) / var_185_8

				arg_182_1.typewritter:SetDirty()
			end

			if arg_182_1.time_ >= var_185_3 + var_185_8 and arg_182_1.time_ < var_185_3 + var_185_8 + arg_185_0 then
				arg_182_1.typewritter.percent = 1

				arg_182_1.typewritter:SetDirty()
				arg_182_1:ShowNextGo(true)
			end
		end

		arg_182_1.nodeConfigList_ = {
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

		arg_182_1:InitPlayNodeList()
	end,
	Play939062043 = function(arg_186_0, arg_186_1)
		arg_186_1.time_ = 0
		arg_186_1.frameCnt_ = 0
		arg_186_1.state_ = "playing"
		arg_186_1.curTalkId_ = 939062043
		arg_186_1.duration_ = 5

		SetActive(arg_186_1.tipsGo_, false)

		function arg_186_1.onSingleLineFinish_()
			arg_186_1.onSingleLineUpdate_ = nil
			arg_186_1.onSingleLineFinish_ = nil
			arg_186_1.state_ = "waiting"
		end

		function arg_186_1.playNext_(arg_188_0)
			if arg_188_0 == 1 then
				arg_186_0:Play939062044(arg_186_1)
			end
		end

		function arg_186_1.onSingleLineUpdate_(arg_189_0)
			if arg_186_1.actors_["1034ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1034ui_story"))) then
				local var_189_0 = Object.Instantiate(Asset.Load("Char/" .. "1034ui_story"), arg_186_1.stage_.transform)

				var_189_0.name = "1034ui_story"
				var_189_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_186_1.actors_["1034ui_story"] = var_189_0

				local var_189_1 = var_189_0:GetComponentInChildren(typeof(CharacterEffect))

				var_189_1.enabled = true

				local var_189_2 = GameObjectTools.GetOrAddComponent(var_189_0, typeof(DynamicBoneHelper))

				if var_189_2 then
					var_189_2:EnableDynamicBone(false)
				end

				arg_186_1:ShowWeapon(var_189_1.transform, false)

				arg_186_1.var_["1034ui_story" .. "Animator"] = var_189_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_186_1.var_["1034ui_story" .. "Animator"].applyRootMotion = true
				arg_186_1.var_["1034ui_story" .. "LipSync"] = var_189_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_189_3 = arg_186_1.actors_["1034ui_story"].transform

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1.var_.moveOldPos1034ui_story = var_189_3.localPosition
			end

			local var_189_4 = 0.001

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_4 then
				var_189_3.localPosition = Vector3.Lerp(arg_186_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_186_1.time_ - 0) / var_189_4)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			if arg_186_1.time_ >= 0 + var_189_4 and arg_186_1.time_ < 0 + var_189_4 + arg_189_0 then
				var_189_3.localPosition = Vector3.New(-0.7, -0.93, -6)
				var_189_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_189_3.position).x, (manager.ui.mainCamera.transform.position - var_189_3.position).y, (manager.ui.mainCamera.transform.position - var_189_3.position).z)
				var_189_3.localEulerAngles.z = 0
				var_189_3.localEulerAngles.x = 0
				var_189_3.localEulerAngles = var_189_3.localEulerAngles
			end

			local var_189_5 = arg_186_1.actors_["1034ui_story"]

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect1034ui_story == nil then
				arg_186_1.var_.characterEffect1034ui_story = var_189_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_189_6 = 0.200000002980232

			if 0 <= arg_186_1.time_ and arg_186_1.time_ < 0 + var_189_6 and not isNil(var_189_5) then
				if arg_186_1.var_.characterEffect1034ui_story and not isNil(var_189_5) then
					arg_186_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_186_1.time_ >= 0 + var_189_6 and arg_186_1.time_ < 0 + var_189_6 + arg_189_0 and not isNil(var_189_5) and arg_186_1.var_.characterEffect1034ui_story then
				arg_186_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action1_1")
			end

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= 0 + arg_189_0 then
				arg_186_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_189_8 = 0
			local var_189_9 = 0.4

			if 0 < arg_186_1.time_ and arg_186_1.time_ <= var_189_8 + arg_189_0 then
				arg_186_1.talkMaxDuration = 0
				arg_186_1.dialogCg_.alpha = 1

				arg_186_1.dialog_:SetActive(true)
				SetActive(arg_186_1.leftNameGo_, true)

				arg_186_1.leftNameTxt_.text = arg_186_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_186_1.leftNameTxt_.transform)

				arg_186_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_186_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_186_1:RecordName(arg_186_1.leftNameTxt_.text)
				SetActive(arg_186_1.iconTrs_.gameObject, false)
				arg_186_1.callingController_:SetSelectedState("normal")

				local var_189_10 = arg_186_1:FormatText(arg_186_1:GetWordFromCfg(939062043).content)

				arg_186_1.text_.text = var_189_10

				LuaForUtil.ClearLinePrefixSymbol(arg_186_1.text_)

				local var_189_12 = 16 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_10) / 16)

				if (16 <= 0 and var_189_9 or var_189_9 * (utf8.len(var_189_10) / 16)) > 0 and var_189_9 < var_189_12 then
					arg_186_1.talkMaxDuration = var_189_12

					if var_189_12 + var_189_8 > arg_186_1.duration_ then
						arg_186_1.duration_ = var_189_12 + var_189_8
					end
				end

				arg_186_1.text_.text = var_189_10
				arg_186_1.typewritter.percent = 0

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(false)
				arg_186_1:RecordContent(arg_186_1.text_.text)
			end

			local var_189_13 = math.max(var_189_9, arg_186_1.talkMaxDuration)

			if var_189_8 <= arg_186_1.time_ and arg_186_1.time_ < var_189_8 + var_189_13 then
				arg_186_1.typewritter.percent = (arg_186_1.time_ - var_189_8) / var_189_13

				arg_186_1.typewritter:SetDirty()
			end

			if arg_186_1.time_ >= var_189_8 + var_189_13 and arg_186_1.time_ < var_189_8 + var_189_13 + arg_189_0 then
				arg_186_1.typewritter.percent = 1

				arg_186_1.typewritter:SetDirty()
				arg_186_1:ShowNextGo(true)
			end
		end

		arg_186_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_186_1:InitPlayNodeList()
	end,
	Play939062044 = function(arg_190_0, arg_190_1)
		arg_190_1.time_ = 0
		arg_190_1.frameCnt_ = 0
		arg_190_1.state_ = "playing"
		arg_190_1.curTalkId_ = 939062044
		arg_190_1.duration_ = 5

		SetActive(arg_190_1.tipsGo_, false)

		function arg_190_1.onSingleLineFinish_()
			arg_190_1.onSingleLineUpdate_ = nil
			arg_190_1.onSingleLineFinish_ = nil
			arg_190_1.state_ = "waiting"
		end

		function arg_190_1.playNext_(arg_192_0)
			if arg_192_0 == 1 then
				arg_190_0:Play939062045(arg_190_1)
			end
		end

		function arg_190_1.onSingleLineUpdate_(arg_193_0)
			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1.var_.moveOldPos6148ui_story = arg_190_1.actors_["6148ui_story"].transform.localPosition

				local var_193_0 = GameObjectTools.GetOrAddComponent(arg_190_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_193_0 then
					var_193_0:EnableDynamicBone(false)
				end
			end

			local var_193_1 = 0.001

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_1 then
				arg_190_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_190_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_190_1.time_ - 0) / var_193_1)
				arg_190_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["6148ui_story"].transform.position).z)
				arg_190_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["6148ui_story"].transform.localEulerAngles = arg_190_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_190_1.time_ >= 0 + var_193_1 and arg_190_1.time_ < 0 + var_193_1 + arg_193_0 then
				arg_190_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_190_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_190_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_190_1.actors_["6148ui_story"].transform.position).z)
				arg_190_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_190_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_190_1.actors_["6148ui_story"].transform.localEulerAngles = arg_190_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_193_2 = GameObjectTools.GetOrAddComponent(arg_190_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_193_2 then
					var_193_2:EnableDynamicBone(true)
				end
			end

			local var_193_3 = arg_190_1.actors_["6148ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_3) and arg_190_1.var_.characterEffect6148ui_story == nil then
				arg_190_1.var_.characterEffect6148ui_story = var_193_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_4 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_4 and not isNil(var_193_3) then
				if arg_190_1.var_.characterEffect6148ui_story and not isNil(var_193_3) then
					arg_190_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_190_1.time_ >= 0 + var_193_4 and arg_190_1.time_ < 0 + var_193_4 + arg_193_0 and not isNil(var_193_3) and arg_190_1.var_.characterEffect6148ui_story then
				arg_190_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_193_6 = arg_190_1.actors_["1034ui_story"]

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 and not isNil(var_193_6) and arg_190_1.var_.characterEffect1034ui_story == nil then
				arg_190_1.var_.characterEffect1034ui_story = var_193_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_193_7 = 0.200000002980232

			if 0 <= arg_190_1.time_ and arg_190_1.time_ < 0 + var_193_7 and not isNil(var_193_6) then
				if arg_190_1.var_.characterEffect1034ui_story and not isNil(var_193_6) then
					arg_190_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_190_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_190_1.time_ - 0) / var_193_7)
				end
			end

			if arg_190_1.time_ >= 0 + var_193_7 and arg_190_1.time_ < 0 + var_193_7 + arg_193_0 and not isNil(var_193_6) and arg_190_1.var_.characterEffect1034ui_story then
				arg_190_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_190_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= 0 + arg_193_0 then
				arg_190_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_193_8 = 0
			local var_193_9 = 0.575

			if 0 < arg_190_1.time_ and arg_190_1.time_ <= var_193_8 + arg_193_0 then
				arg_190_1.talkMaxDuration = 0
				arg_190_1.dialogCg_.alpha = 1

				arg_190_1.dialog_:SetActive(true)
				SetActive(arg_190_1.leftNameGo_, true)

				arg_190_1.leftNameTxt_.text = arg_190_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_190_1.leftNameTxt_.transform)

				arg_190_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_190_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_190_1:RecordName(arg_190_1.leftNameTxt_.text)
				SetActive(arg_190_1.iconTrs_.gameObject, false)
				arg_190_1.callingController_:SetSelectedState("normal")

				local var_193_10 = arg_190_1:FormatText(arg_190_1:GetWordFromCfg(939062044).content)

				arg_190_1.text_.text = var_193_10

				LuaForUtil.ClearLinePrefixSymbol(arg_190_1.text_)

				local var_193_12 = 23 <= 0 and var_193_9 or var_193_9 * (utf8.len(var_193_10) / 23)

				if (23 <= 0 and var_193_9 or var_193_9 * (utf8.len(var_193_10) / 23)) > 0 and var_193_9 < var_193_12 then
					arg_190_1.talkMaxDuration = var_193_12

					if var_193_12 + var_193_8 > arg_190_1.duration_ then
						arg_190_1.duration_ = var_193_12 + var_193_8
					end
				end

				arg_190_1.text_.text = var_193_10
				arg_190_1.typewritter.percent = 0

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(false)
				arg_190_1:RecordContent(arg_190_1.text_.text)
			end

			local var_193_13 = math.max(var_193_9, arg_190_1.talkMaxDuration)

			if var_193_8 <= arg_190_1.time_ and arg_190_1.time_ < var_193_8 + var_193_13 then
				arg_190_1.typewritter.percent = (arg_190_1.time_ - var_193_8) / var_193_13

				arg_190_1.typewritter:SetDirty()
			end

			if arg_190_1.time_ >= var_193_8 + var_193_13 and arg_190_1.time_ < var_193_8 + var_193_13 + arg_193_0 then
				arg_190_1.typewritter.percent = 1

				arg_190_1.typewritter:SetDirty()
				arg_190_1:ShowNextGo(true)
			end
		end

		arg_190_1.nodeConfigList_ = {
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

		arg_190_1:InitPlayNodeList()
	end,
	Play939062045 = function(arg_194_0, arg_194_1)
		arg_194_1.time_ = 0
		arg_194_1.frameCnt_ = 0
		arg_194_1.state_ = "playing"
		arg_194_1.curTalkId_ = 939062045
		arg_194_1.duration_ = 5

		SetActive(arg_194_1.tipsGo_, false)

		function arg_194_1.onSingleLineFinish_()
			arg_194_1.onSingleLineUpdate_ = nil
			arg_194_1.onSingleLineFinish_ = nil
			arg_194_1.state_ = "waiting"
		end

		function arg_194_1.playNext_(arg_196_0)
			if arg_196_0 == 1 then
				arg_194_0:Play939062046(arg_194_1)
			end
		end

		function arg_194_1.onSingleLineUpdate_(arg_197_0)
			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1.var_.moveOldPos1034ui_story = arg_194_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_197_0 = 0.001

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_0 then
				arg_194_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_194_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_194_1.time_ - 0) / var_197_0)
				arg_194_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1034ui_story"].transform.position).z)
				arg_194_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1034ui_story"].transform.localEulerAngles = arg_194_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_194_1.time_ >= 0 + var_197_0 and arg_194_1.time_ < 0 + var_197_0 + arg_197_0 then
				arg_194_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_194_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_194_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_194_1.actors_["1034ui_story"].transform.position).z)
				arg_194_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_194_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_194_1.actors_["1034ui_story"].transform.localEulerAngles = arg_194_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_197_1 = arg_194_1.actors_["1034ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1034ui_story == nil then
				arg_194_1.var_.characterEffect1034ui_story = var_197_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_2 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_2 and not isNil(var_197_1) then
				if arg_194_1.var_.characterEffect1034ui_story and not isNil(var_197_1) then
					arg_194_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_194_1.time_ >= 0 + var_197_2 and arg_194_1.time_ < 0 + var_197_2 + arg_197_0 and not isNil(var_197_1) and arg_194_1.var_.characterEffect1034ui_story then
				arg_194_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			local var_197_4 = arg_194_1.actors_["6148ui_story"]

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 and not isNil(var_197_4) and arg_194_1.var_.characterEffect6148ui_story == nil then
				arg_194_1.var_.characterEffect6148ui_story = var_197_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_197_5 = 0.200000002980232

			if 0 <= arg_194_1.time_ and arg_194_1.time_ < 0 + var_197_5 and not isNil(var_197_4) then
				if arg_194_1.var_.characterEffect6148ui_story and not isNil(var_197_4) then
					arg_194_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_194_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_194_1.time_ - 0) / var_197_5)
				end
			end

			if arg_194_1.time_ >= 0 + var_197_5 and arg_194_1.time_ < 0 + var_197_5 + arg_197_0 and not isNil(var_197_4) and arg_194_1.var_.characterEffect6148ui_story then
				arg_194_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_194_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_1")
			end

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= 0 + arg_197_0 then
				arg_194_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_197_6 = 0
			local var_197_7 = 0.575

			if 0 < arg_194_1.time_ and arg_194_1.time_ <= var_197_6 + arg_197_0 then
				arg_194_1.talkMaxDuration = 0
				arg_194_1.dialogCg_.alpha = 1

				arg_194_1.dialog_:SetActive(true)
				SetActive(arg_194_1.leftNameGo_, true)

				arg_194_1.leftNameTxt_.text = arg_194_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_194_1.leftNameTxt_.transform)

				arg_194_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_194_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_194_1:RecordName(arg_194_1.leftNameTxt_.text)
				SetActive(arg_194_1.iconTrs_.gameObject, false)
				arg_194_1.callingController_:SetSelectedState("normal")

				local var_197_8 = arg_194_1:FormatText(arg_194_1:GetWordFromCfg(939062045).content)

				arg_194_1.text_.text = var_197_8

				LuaForUtil.ClearLinePrefixSymbol(arg_194_1.text_)

				local var_197_10 = 23 <= 0 and var_197_7 or var_197_7 * (utf8.len(var_197_8) / 23)

				if (23 <= 0 and var_197_7 or var_197_7 * (utf8.len(var_197_8) / 23)) > 0 and var_197_7 < var_197_10 then
					arg_194_1.talkMaxDuration = var_197_10

					if var_197_10 + var_197_6 > arg_194_1.duration_ then
						arg_194_1.duration_ = var_197_10 + var_197_6
					end
				end

				arg_194_1.text_.text = var_197_8
				arg_194_1.typewritter.percent = 0

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(false)
				arg_194_1:RecordContent(arg_194_1.text_.text)
			end

			local var_197_11 = math.max(var_197_7, arg_194_1.talkMaxDuration)

			if var_197_6 <= arg_194_1.time_ and arg_194_1.time_ < var_197_6 + var_197_11 then
				arg_194_1.typewritter.percent = (arg_194_1.time_ - var_197_6) / var_197_11

				arg_194_1.typewritter:SetDirty()
			end

			if arg_194_1.time_ >= var_197_6 + var_197_11 and arg_194_1.time_ < var_197_6 + var_197_11 + arg_197_0 then
				arg_194_1.typewritter.percent = 1

				arg_194_1.typewritter:SetDirty()
				arg_194_1:ShowNextGo(true)
			end
		end

		arg_194_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_194_1:InitPlayNodeList()
	end,
	Play939062046 = function(arg_198_0, arg_198_1)
		arg_198_1.time_ = 0
		arg_198_1.frameCnt_ = 0
		arg_198_1.state_ = "playing"
		arg_198_1.curTalkId_ = 939062046
		arg_198_1.duration_ = 5

		SetActive(arg_198_1.tipsGo_, false)

		function arg_198_1.onSingleLineFinish_()
			arg_198_1.onSingleLineUpdate_ = nil
			arg_198_1.onSingleLineFinish_ = nil
			arg_198_1.state_ = "waiting"
		end

		function arg_198_1.playNext_(arg_200_0)
			if arg_200_0 == 1 then
				arg_198_0:Play939062047(arg_198_1)
			end
		end

		function arg_198_1.onSingleLineUpdate_(arg_201_0)
			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1.var_.moveOldPos6148ui_story = arg_198_1.actors_["6148ui_story"].transform.localPosition

				local var_201_0 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_0 then
					var_201_0:EnableDynamicBone(false)
				end
			end

			local var_201_1 = 0.001

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_1 then
				arg_198_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_198_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_198_1.time_ - 0) / var_201_1)
				arg_198_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["6148ui_story"].transform.position).z)
				arg_198_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["6148ui_story"].transform.localEulerAngles = arg_198_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_198_1.time_ >= 0 + var_201_1 and arg_198_1.time_ < 0 + var_201_1 + arg_201_0 then
				arg_198_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_198_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_198_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_198_1.actors_["6148ui_story"].transform.position).z)
				arg_198_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_198_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_198_1.actors_["6148ui_story"].transform.localEulerAngles = arg_198_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_201_2 = GameObjectTools.GetOrAddComponent(arg_198_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_201_2 then
					var_201_2:EnableDynamicBone(true)
				end
			end

			local var_201_3 = arg_198_1.actors_["6148ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect6148ui_story == nil then
				arg_198_1.var_.characterEffect6148ui_story = var_201_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_4 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_4 and not isNil(var_201_3) then
				if arg_198_1.var_.characterEffect6148ui_story and not isNil(var_201_3) then
					arg_198_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_198_1.time_ >= 0 + var_201_4 and arg_198_1.time_ < 0 + var_201_4 + arg_201_0 and not isNil(var_201_3) and arg_198_1.var_.characterEffect6148ui_story then
				arg_198_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_201_6 = arg_198_1.actors_["1034ui_story"]

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect1034ui_story == nil then
				arg_198_1.var_.characterEffect1034ui_story = var_201_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_201_7 = 0.200000002980232

			if 0 <= arg_198_1.time_ and arg_198_1.time_ < 0 + var_201_7 and not isNil(var_201_6) then
				if arg_198_1.var_.characterEffect1034ui_story and not isNil(var_201_6) then
					arg_198_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_198_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_198_1.time_ - 0) / var_201_7)
				end
			end

			if arg_198_1.time_ >= 0 + var_201_7 and arg_198_1.time_ < 0 + var_201_7 + arg_201_0 and not isNil(var_201_6) and arg_198_1.var_.characterEffect1034ui_story then
				arg_198_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_198_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= 0 + arg_201_0 then
				arg_198_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_201_8 = 0
			local var_201_9 = 0.575

			if 0 < arg_198_1.time_ and arg_198_1.time_ <= var_201_8 + arg_201_0 then
				arg_198_1.talkMaxDuration = 0
				arg_198_1.dialogCg_.alpha = 1

				arg_198_1.dialog_:SetActive(true)
				SetActive(arg_198_1.leftNameGo_, true)

				arg_198_1.leftNameTxt_.text = arg_198_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_198_1.leftNameTxt_.transform)

				arg_198_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_198_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_198_1:RecordName(arg_198_1.leftNameTxt_.text)
				SetActive(arg_198_1.iconTrs_.gameObject, false)
				arg_198_1.callingController_:SetSelectedState("normal")

				local var_201_10 = arg_198_1:FormatText(arg_198_1:GetWordFromCfg(939062046).content)

				arg_198_1.text_.text = var_201_10

				LuaForUtil.ClearLinePrefixSymbol(arg_198_1.text_)

				local var_201_12 = 23 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_10) / 23)

				if (23 <= 0 and var_201_9 or var_201_9 * (utf8.len(var_201_10) / 23)) > 0 and var_201_9 < var_201_12 then
					arg_198_1.talkMaxDuration = var_201_12

					if var_201_12 + var_201_8 > arg_198_1.duration_ then
						arg_198_1.duration_ = var_201_12 + var_201_8
					end
				end

				arg_198_1.text_.text = var_201_10
				arg_198_1.typewritter.percent = 0

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(false)
				arg_198_1:RecordContent(arg_198_1.text_.text)
			end

			local var_201_13 = math.max(var_201_9, arg_198_1.talkMaxDuration)

			if var_201_8 <= arg_198_1.time_ and arg_198_1.time_ < var_201_8 + var_201_13 then
				arg_198_1.typewritter.percent = (arg_198_1.time_ - var_201_8) / var_201_13

				arg_198_1.typewritter:SetDirty()
			end

			if arg_198_1.time_ >= var_201_8 + var_201_13 and arg_198_1.time_ < var_201_8 + var_201_13 + arg_201_0 then
				arg_198_1.typewritter.percent = 1

				arg_198_1.typewritter:SetDirty()
				arg_198_1:ShowNextGo(true)
			end
		end

		arg_198_1.nodeConfigList_ = {
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

		arg_198_1:InitPlayNodeList()
	end,
	Play939062047 = function(arg_202_0, arg_202_1)
		arg_202_1.time_ = 0
		arg_202_1.frameCnt_ = 0
		arg_202_1.state_ = "playing"
		arg_202_1.curTalkId_ = 939062047
		arg_202_1.duration_ = 5

		SetActive(arg_202_1.tipsGo_, false)

		function arg_202_1.onSingleLineFinish_()
			arg_202_1.onSingleLineUpdate_ = nil
			arg_202_1.onSingleLineFinish_ = nil
			arg_202_1.state_ = "waiting"
		end

		function arg_202_1.playNext_(arg_204_0)
			if arg_204_0 == 1 then
				arg_202_0:Play939062048(arg_202_1)
			end
		end

		function arg_202_1.onSingleLineUpdate_(arg_205_0)
			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos6148ui_story = arg_202_1.actors_["6148ui_story"].transform.localPosition

				local var_205_0 = GameObjectTools.GetOrAddComponent(arg_202_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_205_0 then
					var_205_0:EnableDynamicBone(false)
				end
			end

			local var_205_1 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_1 then
				arg_202_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_1)
				arg_202_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["6148ui_story"].transform.position).z)
				arg_202_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["6148ui_story"].transform.localEulerAngles = arg_202_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_1 and arg_202_1.time_ < 0 + var_205_1 + arg_205_0 then
				arg_202_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_202_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_202_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_202_1.actors_["6148ui_story"].transform.position).z)
				arg_202_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_202_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_202_1.actors_["6148ui_story"].transform.localEulerAngles = arg_202_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_205_2 = GameObjectTools.GetOrAddComponent(arg_202_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_205_2 then
					var_205_2:EnableDynamicBone(true)
				end
			end

			local var_205_3 = arg_202_1.actors_["1034ui_story"].transform

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 then
				arg_202_1.var_.moveOldPos1034ui_story = var_205_3.localPosition
			end

			local var_205_4 = 0.001

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_4 then
				var_205_3.localPosition = Vector3.Lerp(arg_202_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_202_1.time_ - 0) / var_205_4)
				var_205_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_3.position).x, (manager.ui.mainCamera.transform.position - var_205_3.position).y, (manager.ui.mainCamera.transform.position - var_205_3.position).z)
				var_205_3.localEulerAngles.z = 0
				var_205_3.localEulerAngles.x = 0
				var_205_3.localEulerAngles = var_205_3.localEulerAngles
			end

			if arg_202_1.time_ >= 0 + var_205_4 and arg_202_1.time_ < 0 + var_205_4 + arg_205_0 then
				var_205_3.localPosition = Vector3.New(0, 100, 0)
				var_205_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_205_3.position).x, (manager.ui.mainCamera.transform.position - var_205_3.position).y, (manager.ui.mainCamera.transform.position - var_205_3.position).z)
				var_205_3.localEulerAngles.z = 0
				var_205_3.localEulerAngles.x = 0
				var_205_3.localEulerAngles = var_205_3.localEulerAngles
			end

			local var_205_5 = arg_202_1.actors_["6148ui_story"]

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= 0 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.characterEffect6148ui_story == nil then
				arg_202_1.var_.characterEffect6148ui_story = var_205_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_205_6 = 0.200000002980232

			if 0 <= arg_202_1.time_ and arg_202_1.time_ < 0 + var_205_6 and not isNil(var_205_5) then
				if arg_202_1.var_.characterEffect6148ui_story and not isNil(var_205_5) then
					arg_202_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_202_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_202_1.time_ - 0) / var_205_6)
				end
			end

			if arg_202_1.time_ >= 0 + var_205_6 and arg_202_1.time_ < 0 + var_205_6 + arg_205_0 and not isNil(var_205_5) and arg_202_1.var_.characterEffect6148ui_story then
				arg_202_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_202_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_205_7 = 0
			local var_205_8 = 0.775

			if 0 < arg_202_1.time_ and arg_202_1.time_ <= var_205_7 + arg_205_0 then
				arg_202_1.talkMaxDuration = 0
				arg_202_1.dialogCg_.alpha = 1

				arg_202_1.dialog_:SetActive(true)
				SetActive(arg_202_1.leftNameGo_, false)

				arg_202_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_202_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_202_1:RecordName(arg_202_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_202_1.iconTrs_.gameObject, false)
				arg_202_1.callingController_:SetSelectedState("normal")

				local var_205_9 = arg_202_1:FormatText(arg_202_1:GetWordFromCfg(939062047).content)

				arg_202_1.text_.text = var_205_9

				LuaForUtil.ClearLinePrefixSymbol(arg_202_1.text_)

				local var_205_11 = 31 <= 0 and var_205_8 or var_205_8 * (utf8.len(var_205_9) / 31)

				if (31 <= 0 and var_205_8 or var_205_8 * (utf8.len(var_205_9) / 31)) > 0 and var_205_8 < var_205_11 then
					arg_202_1.talkMaxDuration = var_205_11

					if var_205_11 + var_205_7 > arg_202_1.duration_ then
						arg_202_1.duration_ = var_205_11 + var_205_7
					end
				end

				arg_202_1.text_.text = var_205_9
				arg_202_1.typewritter.percent = 0

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(false)
				arg_202_1:RecordContent(arg_202_1.text_.text)
			end

			local var_205_12 = math.max(var_205_8, arg_202_1.talkMaxDuration)

			if var_205_7 <= arg_202_1.time_ and arg_202_1.time_ < var_205_7 + var_205_12 then
				arg_202_1.typewritter.percent = (arg_202_1.time_ - var_205_7) / var_205_12

				arg_202_1.typewritter:SetDirty()
			end

			if arg_202_1.time_ >= var_205_7 + var_205_12 and arg_202_1.time_ < var_205_7 + var_205_12 + arg_205_0 then
				arg_202_1.typewritter.percent = 1

				arg_202_1.typewritter:SetDirty()
				arg_202_1:ShowNextGo(true)
			end
		end

		arg_202_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_202_1:InitPlayNodeList()
	end,
	Play939062048 = function(arg_206_0, arg_206_1)
		arg_206_1.time_ = 0
		arg_206_1.frameCnt_ = 0
		arg_206_1.state_ = "playing"
		arg_206_1.curTalkId_ = 939062048
		arg_206_1.duration_ = 5

		SetActive(arg_206_1.tipsGo_, false)

		function arg_206_1.onSingleLineFinish_()
			arg_206_1.onSingleLineUpdate_ = nil
			arg_206_1.onSingleLineFinish_ = nil
			arg_206_1.state_ = "waiting"
		end

		function arg_206_1.playNext_(arg_208_0)
			if arg_208_0 == 1 then
				arg_206_0:Play939062049(arg_206_1)
			end
		end

		function arg_206_1.onSingleLineUpdate_(arg_209_0)
			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1.var_.moveOldPos1034ui_story = arg_206_1.actors_["1034ui_story"].transform.localPosition
			end

			local var_209_0 = 0.001

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_0 then
				arg_206_1.actors_["1034ui_story"].transform.localPosition = Vector3.Lerp(arg_206_1.var_.moveOldPos1034ui_story, Vector3.New(-0.7, -0.93, -6), (arg_206_1.time_ - 0) / var_209_0)
				arg_206_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1034ui_story"].transform.position).z)
				arg_206_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1034ui_story"].transform.localEulerAngles = arg_206_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			if arg_206_1.time_ >= 0 + var_209_0 and arg_206_1.time_ < 0 + var_209_0 + arg_209_0 then
				arg_206_1.actors_["1034ui_story"].transform.localPosition = Vector3.New(-0.7, -0.93, -6)
				arg_206_1.actors_["1034ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_206_1.actors_["1034ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1034ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_206_1.actors_["1034ui_story"].transform.position).z)
				arg_206_1.actors_["1034ui_story"].transform.localEulerAngles.z = 0
				arg_206_1.actors_["1034ui_story"].transform.localEulerAngles.x = 0
				arg_206_1.actors_["1034ui_story"].transform.localEulerAngles = arg_206_1.actors_["1034ui_story"].transform.localEulerAngles
			end

			local var_209_1 = arg_206_1.actors_["1034ui_story"]

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1034ui_story == nil then
				arg_206_1.var_.characterEffect1034ui_story = var_209_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_209_2 = 0.200000002980232

			if 0 <= arg_206_1.time_ and arg_206_1.time_ < 0 + var_209_2 and not isNil(var_209_1) then
				if arg_206_1.var_.characterEffect1034ui_story and not isNil(var_209_1) then
					arg_206_1.var_.characterEffect1034ui_story.fillFlat = false
				end
			end

			if arg_206_1.time_ >= 0 + var_209_2 and arg_206_1.time_ < 0 + var_209_2 + arg_209_0 and not isNil(var_209_1) and arg_206_1.var_.characterEffect1034ui_story then
				arg_206_1.var_.characterEffect1034ui_story.fillFlat = false
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/story1034/story1034action/1034action6_2")
			end

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= 0 + arg_209_0 then
				arg_206_1:PlayTimeline("1034ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_209_4 = 0
			local var_209_5 = 0.8

			if 0 < arg_206_1.time_ and arg_206_1.time_ <= var_209_4 + arg_209_0 then
				arg_206_1.talkMaxDuration = 0
				arg_206_1.dialogCg_.alpha = 1

				arg_206_1.dialog_:SetActive(true)
				SetActive(arg_206_1.leftNameGo_, true)

				arg_206_1.leftNameTxt_.text = arg_206_1:FormatText(StoryNameCfg[1109].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_206_1.leftNameTxt_.transform)

				arg_206_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_206_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_206_1:RecordName(arg_206_1.leftNameTxt_.text)
				SetActive(arg_206_1.iconTrs_.gameObject, false)
				arg_206_1.callingController_:SetSelectedState("normal")

				local var_209_6 = arg_206_1:FormatText(arg_206_1:GetWordFromCfg(939062048).content)

				arg_206_1.text_.text = var_209_6

				LuaForUtil.ClearLinePrefixSymbol(arg_206_1.text_)

				local var_209_8 = 32 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_6) / 32)

				if (32 <= 0 and var_209_5 or var_209_5 * (utf8.len(var_209_6) / 32)) > 0 and var_209_5 < var_209_8 then
					arg_206_1.talkMaxDuration = var_209_8

					if var_209_8 + var_209_4 > arg_206_1.duration_ then
						arg_206_1.duration_ = var_209_8 + var_209_4
					end
				end

				arg_206_1.text_.text = var_209_6
				arg_206_1.typewritter.percent = 0

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(false)
				arg_206_1:RecordContent(arg_206_1.text_.text)
			end

			local var_209_9 = math.max(var_209_5, arg_206_1.talkMaxDuration)

			if var_209_4 <= arg_206_1.time_ and arg_206_1.time_ < var_209_4 + var_209_9 then
				arg_206_1.typewritter.percent = (arg_206_1.time_ - var_209_4) / var_209_9

				arg_206_1.typewritter:SetDirty()
			end

			if arg_206_1.time_ >= var_209_4 + var_209_9 and arg_206_1.time_ < var_209_4 + var_209_9 + arg_209_0 then
				arg_206_1.typewritter.percent = 1

				arg_206_1.typewritter:SetDirty()
				arg_206_1:ShowNextGo(true)
			end
		end

		arg_206_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_206_1:InitPlayNodeList()
	end,
	Play939062049 = function(arg_210_0, arg_210_1)
		arg_210_1.time_ = 0
		arg_210_1.frameCnt_ = 0
		arg_210_1.state_ = "playing"
		arg_210_1.curTalkId_ = 939062049
		arg_210_1.duration_ = 5

		SetActive(arg_210_1.tipsGo_, false)

		function arg_210_1.onSingleLineFinish_()
			arg_210_1.onSingleLineUpdate_ = nil
			arg_210_1.onSingleLineFinish_ = nil
			arg_210_1.state_ = "waiting"
		end

		function arg_210_1.playNext_(arg_212_0)
			if arg_212_0 == 1 then
				arg_210_0:Play939062050(arg_210_1)
			end
		end

		function arg_210_1.onSingleLineUpdate_(arg_213_0)
			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1.var_.moveOldPos6148ui_story = arg_210_1.actors_["6148ui_story"].transform.localPosition

				local var_213_0 = GameObjectTools.GetOrAddComponent(arg_210_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_213_0 then
					var_213_0:EnableDynamicBone(false)
				end
			end

			local var_213_1 = 0.001

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_1 then
				arg_210_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_210_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_210_1.time_ - 0) / var_213_1)
				arg_210_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["6148ui_story"].transform.position).z)
				arg_210_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["6148ui_story"].transform.localEulerAngles = arg_210_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_210_1.time_ >= 0 + var_213_1 and arg_210_1.time_ < 0 + var_213_1 + arg_213_0 then
				arg_210_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_210_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_210_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_210_1.actors_["6148ui_story"].transform.position).z)
				arg_210_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_210_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_210_1.actors_["6148ui_story"].transform.localEulerAngles = arg_210_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_213_2 = GameObjectTools.GetOrAddComponent(arg_210_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_213_2 then
					var_213_2:EnableDynamicBone(true)
				end
			end

			local var_213_3 = arg_210_1.actors_["6148ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_3) and arg_210_1.var_.characterEffect6148ui_story == nil then
				arg_210_1.var_.characterEffect6148ui_story = var_213_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_4 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_4 and not isNil(var_213_3) then
				if arg_210_1.var_.characterEffect6148ui_story and not isNil(var_213_3) then
					arg_210_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_210_1.time_ >= 0 + var_213_4 and arg_210_1.time_ < 0 + var_213_4 + arg_213_0 and not isNil(var_213_3) and arg_210_1.var_.characterEffect6148ui_story then
				arg_210_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_213_6 = arg_210_1.actors_["1034ui_story"]

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect1034ui_story == nil then
				arg_210_1.var_.characterEffect1034ui_story = var_213_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_213_7 = 0.200000002980232

			if 0 <= arg_210_1.time_ and arg_210_1.time_ < 0 + var_213_7 and not isNil(var_213_6) then
				if arg_210_1.var_.characterEffect1034ui_story and not isNil(var_213_6) then
					arg_210_1.var_.characterEffect1034ui_story.fillFlat = true
					arg_210_1.var_.characterEffect1034ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_210_1.time_ - 0) / var_213_7)
				end
			end

			if arg_210_1.time_ >= 0 + var_213_7 and arg_210_1.time_ < 0 + var_213_7 + arg_213_0 and not isNil(var_213_6) and arg_210_1.var_.characterEffect1034ui_story then
				arg_210_1.var_.characterEffect1034ui_story.fillFlat = true
				arg_210_1.var_.characterEffect1034ui_story.fillRatio = 0.5
			end

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= 0 + arg_213_0 then
				arg_210_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_2")
			end

			local var_213_8 = 0
			local var_213_9 = 0.25

			if 0 < arg_210_1.time_ and arg_210_1.time_ <= var_213_8 + arg_213_0 then
				arg_210_1.talkMaxDuration = 0
				arg_210_1.dialogCg_.alpha = 1

				arg_210_1.dialog_:SetActive(true)
				SetActive(arg_210_1.leftNameGo_, true)

				arg_210_1.leftNameTxt_.text = arg_210_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_210_1.leftNameTxt_.transform)

				arg_210_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_210_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_210_1:RecordName(arg_210_1.leftNameTxt_.text)
				SetActive(arg_210_1.iconTrs_.gameObject, false)
				arg_210_1.callingController_:SetSelectedState("normal")

				local var_213_10 = arg_210_1:FormatText(arg_210_1:GetWordFromCfg(939062049).content)

				arg_210_1.text_.text = var_213_10

				LuaForUtil.ClearLinePrefixSymbol(arg_210_1.text_)

				local var_213_12 = 10 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_10) / 10)

				if (10 <= 0 and var_213_9 or var_213_9 * (utf8.len(var_213_10) / 10)) > 0 and var_213_9 < var_213_12 then
					arg_210_1.talkMaxDuration = var_213_12

					if var_213_12 + var_213_8 > arg_210_1.duration_ then
						arg_210_1.duration_ = var_213_12 + var_213_8
					end
				end

				arg_210_1.text_.text = var_213_10
				arg_210_1.typewritter.percent = 0

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(false)
				arg_210_1:RecordContent(arg_210_1.text_.text)
			end

			local var_213_13 = math.max(var_213_9, arg_210_1.talkMaxDuration)

			if var_213_8 <= arg_210_1.time_ and arg_210_1.time_ < var_213_8 + var_213_13 then
				arg_210_1.typewritter.percent = (arg_210_1.time_ - var_213_8) / var_213_13

				arg_210_1.typewritter:SetDirty()
			end

			if arg_210_1.time_ >= var_213_8 + var_213_13 and arg_210_1.time_ < var_213_8 + var_213_13 + arg_213_0 then
				arg_210_1.typewritter.percent = 1

				arg_210_1.typewritter:SetDirty()
				arg_210_1:ShowNextGo(true)
			end
		end

		arg_210_1.nodeConfigList_ = {
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

		arg_210_1:InitPlayNodeList()
	end,
	Play939062050 = function(arg_214_0, arg_214_1)
		arg_214_1.time_ = 0
		arg_214_1.frameCnt_ = 0
		arg_214_1.state_ = "playing"
		arg_214_1.curTalkId_ = 939062050
		arg_214_1.duration_ = 5

		SetActive(arg_214_1.tipsGo_, false)

		function arg_214_1.onSingleLineFinish_()
			arg_214_1.onSingleLineUpdate_ = nil
			arg_214_1.onSingleLineFinish_ = nil
			arg_214_1.state_ = "waiting"
		end

		function arg_214_1.playNext_(arg_216_0)
			if arg_216_0 == 1 then
				arg_214_0:Play939062051(arg_214_1)
			end
		end

		function arg_214_1.onSingleLineUpdate_(arg_217_0)
			if arg_214_1.actors_["1211ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1211ui_story"))) then
				local var_217_0 = Object.Instantiate(Asset.Load("Char/" .. "1211ui_story"), arg_214_1.stage_.transform)

				var_217_0.name = "1211ui_story"
				var_217_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_214_1.actors_["1211ui_story"] = var_217_0

				local var_217_1 = var_217_0:GetComponentInChildren(typeof(CharacterEffect))

				var_217_1.enabled = true

				local var_217_2 = GameObjectTools.GetOrAddComponent(var_217_0, typeof(DynamicBoneHelper))

				if var_217_2 then
					var_217_2:EnableDynamicBone(false)
				end

				arg_214_1:ShowWeapon(var_217_1.transform, false)

				arg_214_1.var_["1211ui_story" .. "Animator"] = var_217_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_214_1.var_["1211ui_story" .. "Animator"].applyRootMotion = true
				arg_214_1.var_["1211ui_story" .. "LipSync"] = var_217_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_217_3 = arg_214_1.actors_["1211ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1211ui_story = var_217_3.localPosition
			end

			local var_217_4 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_4 then
				var_217_3.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1211ui_story, Vector3.New(-0.7, -0.67, -6.07), (arg_214_1.time_ - 0) / var_217_4)
				var_217_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_3.position).x, (manager.ui.mainCamera.transform.position - var_217_3.position).y, (manager.ui.mainCamera.transform.position - var_217_3.position).z)
				var_217_3.localEulerAngles.z = 0
				var_217_3.localEulerAngles.x = 0
				var_217_3.localEulerAngles = var_217_3.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_4 and arg_214_1.time_ < 0 + var_217_4 + arg_217_0 then
				var_217_3.localPosition = Vector3.New(-0.7, -0.67, -6.07)
				var_217_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_3.position).x, (manager.ui.mainCamera.transform.position - var_217_3.position).y, (manager.ui.mainCamera.transform.position - var_217_3.position).z)
				var_217_3.localEulerAngles.z = 0
				var_217_3.localEulerAngles.x = 0
				var_217_3.localEulerAngles = var_217_3.localEulerAngles
			end

			local var_217_5 = arg_214_1.actors_["1034ui_story"].transform

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1.var_.moveOldPos1034ui_story = var_217_5.localPosition
			end

			local var_217_6 = 0.001

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_6 then
				var_217_5.localPosition = Vector3.Lerp(arg_214_1.var_.moveOldPos1034ui_story, Vector3.New(0, 100, 0), (arg_214_1.time_ - 0) / var_217_6)
				var_217_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_5.position).x, (manager.ui.mainCamera.transform.position - var_217_5.position).y, (manager.ui.mainCamera.transform.position - var_217_5.position).z)
				var_217_5.localEulerAngles.z = 0
				var_217_5.localEulerAngles.x = 0
				var_217_5.localEulerAngles = var_217_5.localEulerAngles
			end

			if arg_214_1.time_ >= 0 + var_217_6 and arg_214_1.time_ < 0 + var_217_6 + arg_217_0 then
				var_217_5.localPosition = Vector3.New(0, 100, 0)
				var_217_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_217_5.position).x, (manager.ui.mainCamera.transform.position - var_217_5.position).y, (manager.ui.mainCamera.transform.position - var_217_5.position).z)
				var_217_5.localEulerAngles.z = 0
				var_217_5.localEulerAngles.x = 0
				var_217_5.localEulerAngles = var_217_5.localEulerAngles
			end

			local var_217_7 = arg_214_1.actors_["1211ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.characterEffect1211ui_story == nil then
				arg_214_1.var_.characterEffect1211ui_story = var_217_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_8 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_8 and not isNil(var_217_7) then
				if arg_214_1.var_.characterEffect1211ui_story and not isNil(var_217_7) then
					arg_214_1.var_.characterEffect1211ui_story.fillFlat = false
				end
			end

			if arg_214_1.time_ >= 0 + var_217_8 and arg_214_1.time_ < 0 + var_217_8 + arg_217_0 and not isNil(var_217_7) and arg_214_1.var_.characterEffect1211ui_story then
				arg_214_1.var_.characterEffect1211ui_story.fillFlat = false
			end

			local var_217_10 = arg_214_1.actors_["6148ui_story"]

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 and not isNil(var_217_10) and arg_214_1.var_.characterEffect6148ui_story == nil then
				arg_214_1.var_.characterEffect6148ui_story = var_217_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_217_11 = 0.200000002980232

			if 0 <= arg_214_1.time_ and arg_214_1.time_ < 0 + var_217_11 and not isNil(var_217_10) then
				if arg_214_1.var_.characterEffect6148ui_story and not isNil(var_217_10) then
					arg_214_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_214_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_214_1.time_ - 0) / var_217_11)
				end
			end

			if arg_214_1.time_ >= 0 + var_217_11 and arg_214_1.time_ < 0 + var_217_11 + arg_217_0 and not isNil(var_217_10) and arg_214_1.var_.characterEffect6148ui_story then
				arg_214_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_214_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/story1211/story1211action/1211action3_1")
			end

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= 0 + arg_217_0 then
				arg_214_1:PlayTimeline("1211ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_217_12 = 0
			local var_217_13 = 0.55

			if 0 < arg_214_1.time_ and arg_214_1.time_ <= var_217_12 + arg_217_0 then
				arg_214_1.talkMaxDuration = 0
				arg_214_1.dialogCg_.alpha = 1

				arg_214_1.dialog_:SetActive(true)
				SetActive(arg_214_1.leftNameGo_, true)

				arg_214_1.leftNameTxt_.text = arg_214_1:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_214_1.leftNameTxt_.transform)

				arg_214_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_214_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_214_1:RecordName(arg_214_1.leftNameTxt_.text)
				SetActive(arg_214_1.iconTrs_.gameObject, false)
				arg_214_1.callingController_:SetSelectedState("normal")

				local var_217_14 = arg_214_1:FormatText(arg_214_1:GetWordFromCfg(939062050).content)

				arg_214_1.text_.text = var_217_14

				LuaForUtil.ClearLinePrefixSymbol(arg_214_1.text_)

				local var_217_16 = 22 <= 0 and var_217_13 or var_217_13 * (utf8.len(var_217_14) / 22)

				if (22 <= 0 and var_217_13 or var_217_13 * (utf8.len(var_217_14) / 22)) > 0 and var_217_13 < var_217_16 then
					arg_214_1.talkMaxDuration = var_217_16

					if var_217_16 + var_217_12 > arg_214_1.duration_ then
						arg_214_1.duration_ = var_217_16 + var_217_12
					end
				end

				arg_214_1.text_.text = var_217_14
				arg_214_1.typewritter.percent = 0

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(false)
				arg_214_1:RecordContent(arg_214_1.text_.text)
			end

			local var_217_17 = math.max(var_217_13, arg_214_1.talkMaxDuration)

			if var_217_12 <= arg_214_1.time_ and arg_214_1.time_ < var_217_12 + var_217_17 then
				arg_214_1.typewritter.percent = (arg_214_1.time_ - var_217_12) / var_217_17

				arg_214_1.typewritter:SetDirty()
			end

			if arg_214_1.time_ >= var_217_12 + var_217_17 and arg_214_1.time_ < var_217_12 + var_217_17 + arg_217_0 then
				arg_214_1.typewritter.percent = 1

				arg_214_1.typewritter:SetDirty()
				arg_214_1:ShowNextGo(true)
			end
		end

		arg_214_1.nodeConfigList_ = {
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
				actorName = "1034ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_214_1:InitPlayNodeList()
	end,
	Play939062051 = function(arg_218_0, arg_218_1)
		arg_218_1.time_ = 0
		arg_218_1.frameCnt_ = 0
		arg_218_1.state_ = "playing"
		arg_218_1.curTalkId_ = 939062051
		arg_218_1.duration_ = 5

		SetActive(arg_218_1.tipsGo_, false)

		function arg_218_1.onSingleLineFinish_()
			arg_218_1.onSingleLineUpdate_ = nil
			arg_218_1.onSingleLineFinish_ = nil
			arg_218_1.state_ = "waiting"
		end

		function arg_218_1.playNext_(arg_220_0)
			if arg_220_0 == 1 then
				arg_218_0:Play939062052(arg_218_1)
			end
		end

		function arg_218_1.onSingleLineUpdate_(arg_221_0)
			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos1211ui_story = arg_218_1.actors_["1211ui_story"].transform.localPosition
			end

			local var_221_0 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_0 then
				arg_218_1.actors_["1211ui_story"].transform.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos1211ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_0)
				arg_218_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1211ui_story"].transform.position).z)
				arg_218_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1211ui_story"].transform.localEulerAngles = arg_218_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_0 and arg_218_1.time_ < 0 + var_221_0 + arg_221_0 then
				arg_218_1.actors_["1211ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_218_1.actors_["1211ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_218_1.actors_["1211ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1211ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_218_1.actors_["1211ui_story"].transform.position).z)
				arg_218_1.actors_["1211ui_story"].transform.localEulerAngles.z = 0
				arg_218_1.actors_["1211ui_story"].transform.localEulerAngles.x = 0
				arg_218_1.actors_["1211ui_story"].transform.localEulerAngles = arg_218_1.actors_["1211ui_story"].transform.localEulerAngles
			end

			local var_221_1 = arg_218_1.actors_["6148ui_story"].transform

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 then
				arg_218_1.var_.moveOldPos6148ui_story = var_221_1.localPosition

				local var_221_2 = GameObjectTools.GetOrAddComponent(var_221_1.gameObject, typeof(DynamicBoneHelper))

				if var_221_2 then
					var_221_2:EnableDynamicBone(false)
				end
			end

			local var_221_3 = 0.001

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_3 then
				var_221_1.localPosition = Vector3.Lerp(arg_218_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_218_1.time_ - 0) / var_221_3)
				var_221_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_1.position).x, (manager.ui.mainCamera.transform.position - var_221_1.position).y, (manager.ui.mainCamera.transform.position - var_221_1.position).z)
				var_221_1.localEulerAngles.z = 0
				var_221_1.localEulerAngles.x = 0
				var_221_1.localEulerAngles = var_221_1.localEulerAngles
			end

			if arg_218_1.time_ >= 0 + var_221_3 and arg_218_1.time_ < 0 + var_221_3 + arg_221_0 then
				var_221_1.localPosition = Vector3.New(0, 100, 0)
				var_221_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_221_1.position).x, (manager.ui.mainCamera.transform.position - var_221_1.position).y, (manager.ui.mainCamera.transform.position - var_221_1.position).z)
				var_221_1.localEulerAngles.z = 0
				var_221_1.localEulerAngles.x = 0
				var_221_1.localEulerAngles = var_221_1.localEulerAngles

				local var_221_4 = GameObjectTools.GetOrAddComponent(var_221_1.gameObject, typeof(DynamicBoneHelper))

				if var_221_4 then
					var_221_4:EnableDynamicBone(true)
				end
			end

			local var_221_5 = arg_218_1.actors_["1211ui_story"]

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= 0 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1211ui_story == nil then
				arg_218_1.var_.characterEffect1211ui_story = var_221_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_221_6 = 0.200000002980232

			if 0 <= arg_218_1.time_ and arg_218_1.time_ < 0 + var_221_6 and not isNil(var_221_5) then
				if arg_218_1.var_.characterEffect1211ui_story and not isNil(var_221_5) then
					arg_218_1.var_.characterEffect1211ui_story.fillFlat = true
					arg_218_1.var_.characterEffect1211ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_218_1.time_ - 0) / var_221_6)
				end
			end

			if arg_218_1.time_ >= 0 + var_221_6 and arg_218_1.time_ < 0 + var_221_6 + arg_221_0 and not isNil(var_221_5) and arg_218_1.var_.characterEffect1211ui_story then
				arg_218_1.var_.characterEffect1211ui_story.fillFlat = true
				arg_218_1.var_.characterEffect1211ui_story.fillRatio = 0.5
			end

			local var_221_7 = 0
			local var_221_8 = 0.675

			if 0 < arg_218_1.time_ and arg_218_1.time_ <= var_221_7 + arg_221_0 then
				arg_218_1.talkMaxDuration = 0
				arg_218_1.dialogCg_.alpha = 1

				arg_218_1.dialog_:SetActive(true)
				SetActive(arg_218_1.leftNameGo_, false)

				arg_218_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_218_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_218_1:RecordName(arg_218_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_218_1.iconTrs_.gameObject, false)
				arg_218_1.callingController_:SetSelectedState("normal")

				local var_221_9 = arg_218_1:FormatText(arg_218_1:GetWordFromCfg(939062051).content)

				arg_218_1.text_.text = var_221_9

				LuaForUtil.ClearLinePrefixSymbol(arg_218_1.text_)

				local var_221_11 = 27 <= 0 and var_221_8 or var_221_8 * (utf8.len(var_221_9) / 27)

				if (27 <= 0 and var_221_8 or var_221_8 * (utf8.len(var_221_9) / 27)) > 0 and var_221_8 < var_221_11 then
					arg_218_1.talkMaxDuration = var_221_11

					if var_221_11 + var_221_7 > arg_218_1.duration_ then
						arg_218_1.duration_ = var_221_11 + var_221_7
					end
				end

				arg_218_1.text_.text = var_221_9
				arg_218_1.typewritter.percent = 0

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(false)
				arg_218_1:RecordContent(arg_218_1.text_.text)
			end

			local var_221_12 = math.max(var_221_8, arg_218_1.talkMaxDuration)

			if var_221_7 <= arg_218_1.time_ and arg_218_1.time_ < var_221_7 + var_221_12 then
				arg_218_1.typewritter.percent = (arg_218_1.time_ - var_221_7) / var_221_12

				arg_218_1.typewritter:SetDirty()
			end

			if arg_218_1.time_ >= var_221_7 + var_221_12 and arg_218_1.time_ < var_221_7 + var_221_12 + arg_221_0 then
				arg_218_1.typewritter.percent = 1

				arg_218_1.typewritter:SetDirty()
				arg_218_1:ShowNextGo(true)
			end
		end

		arg_218_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_218_1:InitPlayNodeList()
	end,
	Play939062052 = function(arg_222_0, arg_222_1)
		arg_222_1.time_ = 0
		arg_222_1.frameCnt_ = 0
		arg_222_1.state_ = "playing"
		arg_222_1.curTalkId_ = 939062052
		arg_222_1.duration_ = 5

		SetActive(arg_222_1.tipsGo_, false)

		function arg_222_1.onSingleLineFinish_()
			arg_222_1.onSingleLineUpdate_ = nil
			arg_222_1.onSingleLineFinish_ = nil
			arg_222_1.state_ = "waiting"
		end

		function arg_222_1.playNext_(arg_224_0)
			if arg_224_0 == 1 then
				arg_222_0:Play939062053(arg_222_1)
			end
		end

		function arg_222_1.onSingleLineUpdate_(arg_225_0)
			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1.var_.moveOldPos1054ui_story = arg_222_1.actors_["1054ui_story"].transform.localPosition

				local var_225_0 = GameObjectTools.GetOrAddComponent(arg_222_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_225_0 then
					var_225_0:EnableDynamicBone(false)
				end
			end

			local var_225_1 = 0.001

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_1 then
				arg_222_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_222_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_222_1.time_ - 0) / var_225_1)
				arg_222_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1054ui_story"].transform.position).z)
				arg_222_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1054ui_story"].transform.localEulerAngles = arg_222_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_222_1.time_ >= 0 + var_225_1 and arg_222_1.time_ < 0 + var_225_1 + arg_225_0 then
				arg_222_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_222_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_222_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_222_1.actors_["1054ui_story"].transform.position).z)
				arg_222_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_222_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_222_1.actors_["1054ui_story"].transform.localEulerAngles = arg_222_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_225_2 = GameObjectTools.GetOrAddComponent(arg_222_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_225_2 then
					var_225_2:EnableDynamicBone(true)
				end
			end

			local var_225_3 = arg_222_1.actors_["1054ui_story"]

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect1054ui_story == nil then
				arg_222_1.var_.characterEffect1054ui_story = var_225_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_225_4 = 0.200000002980232

			if 0 <= arg_222_1.time_ and arg_222_1.time_ < 0 + var_225_4 and not isNil(var_225_3) then
				if arg_222_1.var_.characterEffect1054ui_story and not isNil(var_225_3) then
					arg_222_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_222_1.time_ >= 0 + var_225_4 and arg_222_1.time_ < 0 + var_225_4 + arg_225_0 and not isNil(var_225_3) and arg_222_1.var_.characterEffect1054ui_story then
				arg_222_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= 0 + arg_225_0 then
				arg_222_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_youyu", "EmotionTimelineAnimator")
			end

			local var_225_6 = 0
			local var_225_7 = 0.8

			if 0 < arg_222_1.time_ and arg_222_1.time_ <= var_225_6 + arg_225_0 then
				arg_222_1.talkMaxDuration = 0
				arg_222_1.dialogCg_.alpha = 1

				arg_222_1.dialog_:SetActive(true)
				SetActive(arg_222_1.leftNameGo_, true)

				arg_222_1.leftNameTxt_.text = arg_222_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_222_1.leftNameTxt_.transform)

				arg_222_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_222_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_222_1:RecordName(arg_222_1.leftNameTxt_.text)
				SetActive(arg_222_1.iconTrs_.gameObject, false)
				arg_222_1.callingController_:SetSelectedState("normal")

				local var_225_8 = arg_222_1:FormatText(arg_222_1:GetWordFromCfg(939062052).content)

				arg_222_1.text_.text = var_225_8

				LuaForUtil.ClearLinePrefixSymbol(arg_222_1.text_)

				local var_225_10 = 32 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_8) / 32)

				if (32 <= 0 and var_225_7 or var_225_7 * (utf8.len(var_225_8) / 32)) > 0 and var_225_7 < var_225_10 then
					arg_222_1.talkMaxDuration = var_225_10

					if var_225_10 + var_225_6 > arg_222_1.duration_ then
						arg_222_1.duration_ = var_225_10 + var_225_6
					end
				end

				arg_222_1.text_.text = var_225_8
				arg_222_1.typewritter.percent = 0

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(false)
				arg_222_1:RecordContent(arg_222_1.text_.text)
			end

			local var_225_11 = math.max(var_225_7, arg_222_1.talkMaxDuration)

			if var_225_6 <= arg_222_1.time_ and arg_222_1.time_ < var_225_6 + var_225_11 then
				arg_222_1.typewritter.percent = (arg_222_1.time_ - var_225_6) / var_225_11

				arg_222_1.typewritter:SetDirty()
			end

			if arg_222_1.time_ >= var_225_6 + var_225_11 and arg_222_1.time_ < var_225_6 + var_225_11 + arg_225_0 then
				arg_222_1.typewritter.percent = 1

				arg_222_1.typewritter:SetDirty()
				arg_222_1:ShowNextGo(true)
			end
		end

		arg_222_1.nodeConfigList_ = {
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

		arg_222_1:InitPlayNodeList()
	end,
	Play939062053 = function(arg_226_0, arg_226_1)
		arg_226_1.time_ = 0
		arg_226_1.frameCnt_ = 0
		arg_226_1.state_ = "playing"
		arg_226_1.curTalkId_ = 939062053
		arg_226_1.duration_ = 5

		SetActive(arg_226_1.tipsGo_, false)

		function arg_226_1.onSingleLineFinish_()
			arg_226_1.onSingleLineUpdate_ = nil
			arg_226_1.onSingleLineFinish_ = nil
			arg_226_1.state_ = "waiting"
		end

		function arg_226_1.playNext_(arg_228_0)
			if arg_228_0 == 1 then
				arg_226_0:Play939062054(arg_226_1)
			end
		end

		function arg_226_1.onSingleLineUpdate_(arg_229_0)
			if 0 < arg_226_1.time_ and arg_226_1.time_ <= 0 + arg_229_0 and not isNil(arg_226_1.actors_["1054ui_story"]) and arg_226_1.var_.characterEffect1054ui_story == nil then
				arg_226_1.var_.characterEffect1054ui_story = arg_226_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_229_0 = 0.200000002980232

			if 0 <= arg_226_1.time_ and arg_226_1.time_ < 0 + var_229_0 and not isNil(arg_226_1.actors_["1054ui_story"]) then
				if arg_226_1.var_.characterEffect1054ui_story and not isNil(arg_226_1.actors_["1054ui_story"]) then
					arg_226_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_226_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_226_1.time_ - 0) / var_229_0)
				end
			end

			if arg_226_1.time_ >= 0 + var_229_0 and arg_226_1.time_ < 0 + var_229_0 + arg_229_0 and not isNil(arg_226_1.actors_["1054ui_story"]) and arg_226_1.var_.characterEffect1054ui_story then
				arg_226_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_226_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_229_1 = 0
			local var_229_2 = 0.375

			if 0 < arg_226_1.time_ and arg_226_1.time_ <= var_229_1 + arg_229_0 then
				arg_226_1.talkMaxDuration = 0
				arg_226_1.dialogCg_.alpha = 1

				arg_226_1.dialog_:SetActive(true)
				SetActive(arg_226_1.leftNameGo_, true)

				arg_226_1.leftNameTxt_.text = arg_226_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_226_1.leftNameTxt_.transform)

				arg_226_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_226_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_226_1:RecordName(arg_226_1.leftNameTxt_.text)
				SetActive(arg_226_1.iconTrs_.gameObject, true)
				arg_226_1.iconController_:SetSelectedState("hero")

				arg_226_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_226_1.callingController_:SetSelectedState("normal")

				arg_226_1.keyicon_.color = Color.New(1, 1, 1)
				arg_226_1.icon_.color = Color.New(1, 1, 1)

				local var_229_3 = arg_226_1:FormatText(arg_226_1:GetWordFromCfg(939062053).content)

				arg_226_1.text_.text = var_229_3

				LuaForUtil.ClearLinePrefixSymbol(arg_226_1.text_)

				local var_229_5 = 15 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 15)

				if (15 <= 0 and var_229_2 or var_229_2 * (utf8.len(var_229_3) / 15)) > 0 and var_229_2 < var_229_5 then
					arg_226_1.talkMaxDuration = var_229_5

					if var_229_5 + var_229_1 > arg_226_1.duration_ then
						arg_226_1.duration_ = var_229_5 + var_229_1
					end
				end

				arg_226_1.text_.text = var_229_3
				arg_226_1.typewritter.percent = 0

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(false)
				arg_226_1:RecordContent(arg_226_1.text_.text)
			end

			local var_229_6 = math.max(var_229_2, arg_226_1.talkMaxDuration)

			if var_229_1 <= arg_226_1.time_ and arg_226_1.time_ < var_229_1 + var_229_6 then
				arg_226_1.typewritter.percent = (arg_226_1.time_ - var_229_1) / var_229_6

				arg_226_1.typewritter:SetDirty()
			end

			if arg_226_1.time_ >= var_229_1 + var_229_6 and arg_226_1.time_ < var_229_1 + var_229_6 + arg_229_0 then
				arg_226_1.typewritter.percent = 1

				arg_226_1.typewritter:SetDirty()
				arg_226_1:ShowNextGo(true)
			end
		end

		arg_226_1.nodeConfigList_ = {}

		arg_226_1:InitPlayNodeList()
	end,
	Play939062054 = function(arg_230_0, arg_230_1)
		arg_230_1.time_ = 0
		arg_230_1.frameCnt_ = 0
		arg_230_1.state_ = "playing"
		arg_230_1.curTalkId_ = 939062054
		arg_230_1.duration_ = 5

		SetActive(arg_230_1.tipsGo_, false)

		function arg_230_1.onSingleLineFinish_()
			arg_230_1.onSingleLineUpdate_ = nil
			arg_230_1.onSingleLineFinish_ = nil
			arg_230_1.state_ = "waiting"
		end

		function arg_230_1.playNext_(arg_232_0)
			if arg_232_0 == 1 then
				arg_230_0:Play939062055(arg_230_1)
			end
		end

		function arg_230_1.onSingleLineUpdate_(arg_233_0)
			local var_233_0 = 0.7

			if 0 < arg_230_1.time_ and arg_230_1.time_ <= 0 + arg_233_0 then
				arg_230_1.talkMaxDuration = 0
				arg_230_1.dialogCg_.alpha = 1

				arg_230_1.dialog_:SetActive(true)
				SetActive(arg_230_1.leftNameGo_, false)

				arg_230_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_230_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_230_1:RecordName(arg_230_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_230_1.iconTrs_.gameObject, false)
				arg_230_1.callingController_:SetSelectedState("normal")

				local var_233_1 = arg_230_1:FormatText(arg_230_1:GetWordFromCfg(939062054).content)

				arg_230_1.text_.text = var_233_1

				LuaForUtil.ClearLinePrefixSymbol(arg_230_1.text_)

				local var_233_3 = 28 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 28)

				if (28 <= 0 and var_233_0 or var_233_0 * (utf8.len(var_233_1) / 28)) > 0 and var_233_0 < var_233_3 then
					arg_230_1.talkMaxDuration = var_233_3

					if var_233_3 + 0 > arg_230_1.duration_ then
						arg_230_1.duration_ = var_233_3 + 0
					end
				end

				arg_230_1.text_.text = var_233_1
				arg_230_1.typewritter.percent = 0

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(false)
				arg_230_1:RecordContent(arg_230_1.text_.text)
			end

			local var_233_4 = math.max(var_233_0, arg_230_1.talkMaxDuration)

			if 0 <= arg_230_1.time_ and arg_230_1.time_ < 0 + var_233_4 then
				arg_230_1.typewritter.percent = (arg_230_1.time_ - 0) / var_233_4

				arg_230_1.typewritter:SetDirty()
			end

			if arg_230_1.time_ >= 0 + var_233_4 and arg_230_1.time_ < 0 + var_233_4 + arg_233_0 then
				arg_230_1.typewritter.percent = 1

				arg_230_1.typewritter:SetDirty()
				arg_230_1:ShowNextGo(true)
			end
		end

		arg_230_1.nodeConfigList_ = {}

		arg_230_1:InitPlayNodeList()
	end,
	Play939062055 = function(arg_234_0, arg_234_1)
		arg_234_1.time_ = 0
		arg_234_1.frameCnt_ = 0
		arg_234_1.state_ = "playing"
		arg_234_1.curTalkId_ = 939062055
		arg_234_1.duration_ = 5

		SetActive(arg_234_1.tipsGo_, false)

		function arg_234_1.onSingleLineFinish_()
			arg_234_1.onSingleLineUpdate_ = nil
			arg_234_1.onSingleLineFinish_ = nil
			arg_234_1.state_ = "waiting"
		end

		function arg_234_1.playNext_(arg_236_0)
			if arg_236_0 == 1 then
				arg_234_0:Play939062056(arg_234_1)
			end
		end

		function arg_234_1.onSingleLineUpdate_(arg_237_0)
			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1.var_.moveOldPos1054ui_story = arg_234_1.actors_["1054ui_story"].transform.localPosition

				local var_237_0 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_0 then
					var_237_0:EnableDynamicBone(false)
				end
			end

			local var_237_1 = 0.001

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_1 then
				arg_234_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_234_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_234_1.time_ - 0) / var_237_1)
				arg_234_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1054ui_story"].transform.position).z)
				arg_234_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1054ui_story"].transform.localEulerAngles = arg_234_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_234_1.time_ >= 0 + var_237_1 and arg_234_1.time_ < 0 + var_237_1 + arg_237_0 then
				arg_234_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_234_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_234_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_234_1.actors_["1054ui_story"].transform.position).z)
				arg_234_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_234_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_234_1.actors_["1054ui_story"].transform.localEulerAngles = arg_234_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_237_2 = GameObjectTools.GetOrAddComponent(arg_234_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_237_2 then
					var_237_2:EnableDynamicBone(true)
				end
			end

			local var_237_3 = arg_234_1.actors_["1054ui_story"]

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1054ui_story == nil then
				arg_234_1.var_.characterEffect1054ui_story = var_237_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_237_4 = 0.200000002980232

			if 0 <= arg_234_1.time_ and arg_234_1.time_ < 0 + var_237_4 and not isNil(var_237_3) then
				if arg_234_1.var_.characterEffect1054ui_story and not isNil(var_237_3) then
					arg_234_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_234_1.time_ >= 0 + var_237_4 and arg_234_1.time_ < 0 + var_237_4 + arg_237_0 and not isNil(var_237_3) and arg_234_1.var_.characterEffect1054ui_story then
				arg_234_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_1")
			end

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= 0 + arg_237_0 then
				arg_234_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_237_6 = 0
			local var_237_7 = 1.025

			if 0 < arg_234_1.time_ and arg_234_1.time_ <= var_237_6 + arg_237_0 then
				arg_234_1.talkMaxDuration = 0
				arg_234_1.dialogCg_.alpha = 1

				arg_234_1.dialog_:SetActive(true)
				SetActive(arg_234_1.leftNameGo_, true)

				arg_234_1.leftNameTxt_.text = arg_234_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_234_1.leftNameTxt_.transform)

				arg_234_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_234_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_234_1:RecordName(arg_234_1.leftNameTxt_.text)
				SetActive(arg_234_1.iconTrs_.gameObject, false)
				arg_234_1.callingController_:SetSelectedState("normal")

				local var_237_8 = arg_234_1:FormatText(arg_234_1:GetWordFromCfg(939062055).content)

				arg_234_1.text_.text = var_237_8

				LuaForUtil.ClearLinePrefixSymbol(arg_234_1.text_)

				local var_237_10 = 41 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_8) / 41)

				if (41 <= 0 and var_237_7 or var_237_7 * (utf8.len(var_237_8) / 41)) > 0 and var_237_7 < var_237_10 then
					arg_234_1.talkMaxDuration = var_237_10

					if var_237_10 + var_237_6 > arg_234_1.duration_ then
						arg_234_1.duration_ = var_237_10 + var_237_6
					end
				end

				arg_234_1.text_.text = var_237_8
				arg_234_1.typewritter.percent = 0

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(false)
				arg_234_1:RecordContent(arg_234_1.text_.text)
			end

			local var_237_11 = math.max(var_237_7, arg_234_1.talkMaxDuration)

			if var_237_6 <= arg_234_1.time_ and arg_234_1.time_ < var_237_6 + var_237_11 then
				arg_234_1.typewritter.percent = (arg_234_1.time_ - var_237_6) / var_237_11

				arg_234_1.typewritter:SetDirty()
			end

			if arg_234_1.time_ >= var_237_6 + var_237_11 and arg_234_1.time_ < var_237_6 + var_237_11 + arg_237_0 then
				arg_234_1.typewritter.percent = 1

				arg_234_1.typewritter:SetDirty()
				arg_234_1:ShowNextGo(true)
			end
		end

		arg_234_1.nodeConfigList_ = {
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

		arg_234_1:InitPlayNodeList()
	end,
	Play939062056 = function(arg_238_0, arg_238_1)
		arg_238_1.time_ = 0
		arg_238_1.frameCnt_ = 0
		arg_238_1.state_ = "playing"
		arg_238_1.curTalkId_ = 939062056
		arg_238_1.duration_ = 5

		SetActive(arg_238_1.tipsGo_, false)

		function arg_238_1.onSingleLineFinish_()
			arg_238_1.onSingleLineUpdate_ = nil
			arg_238_1.onSingleLineFinish_ = nil
			arg_238_1.state_ = "waiting"
		end

		function arg_238_1.playNext_(arg_240_0)
			if arg_240_0 == 1 then
				arg_238_0:Play939062057(arg_238_1)
			end
		end

		function arg_238_1.onSingleLineUpdate_(arg_241_0)
			if 0 < arg_238_1.time_ and arg_238_1.time_ <= 0 + arg_241_0 and not isNil(arg_238_1.actors_["1054ui_story"]) and arg_238_1.var_.characterEffect1054ui_story == nil then
				arg_238_1.var_.characterEffect1054ui_story = arg_238_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_241_0 = 0.200000002980232

			if 0 <= arg_238_1.time_ and arg_238_1.time_ < 0 + var_241_0 and not isNil(arg_238_1.actors_["1054ui_story"]) then
				if arg_238_1.var_.characterEffect1054ui_story and not isNil(arg_238_1.actors_["1054ui_story"]) then
					arg_238_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_238_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_238_1.time_ - 0) / var_241_0)
				end
			end

			if arg_238_1.time_ >= 0 + var_241_0 and arg_238_1.time_ < 0 + var_241_0 + arg_241_0 and not isNil(arg_238_1.actors_["1054ui_story"]) and arg_238_1.var_.characterEffect1054ui_story then
				arg_238_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_238_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_241_1 = 0
			local var_241_2 = 0.875

			if 0 < arg_238_1.time_ and arg_238_1.time_ <= var_241_1 + arg_241_0 then
				arg_238_1.talkMaxDuration = 0
				arg_238_1.dialogCg_.alpha = 1

				arg_238_1.dialog_:SetActive(true)
				SetActive(arg_238_1.leftNameGo_, true)

				arg_238_1.leftNameTxt_.text = arg_238_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_238_1.leftNameTxt_.transform)

				arg_238_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_238_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_238_1:RecordName(arg_238_1.leftNameTxt_.text)
				SetActive(arg_238_1.iconTrs_.gameObject, true)
				arg_238_1.iconController_:SetSelectedState("hero")

				arg_238_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_238_1.callingController_:SetSelectedState("normal")

				arg_238_1.keyicon_.color = Color.New(1, 1, 1)
				arg_238_1.icon_.color = Color.New(1, 1, 1)

				local var_241_3 = arg_238_1:FormatText(arg_238_1:GetWordFromCfg(939062056).content)

				arg_238_1.text_.text = var_241_3

				LuaForUtil.ClearLinePrefixSymbol(arg_238_1.text_)

				local var_241_5 = 35 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 35)

				if (35 <= 0 and var_241_2 or var_241_2 * (utf8.len(var_241_3) / 35)) > 0 and var_241_2 < var_241_5 then
					arg_238_1.talkMaxDuration = var_241_5

					if var_241_5 + var_241_1 > arg_238_1.duration_ then
						arg_238_1.duration_ = var_241_5 + var_241_1
					end
				end

				arg_238_1.text_.text = var_241_3
				arg_238_1.typewritter.percent = 0

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(false)
				arg_238_1:RecordContent(arg_238_1.text_.text)
			end

			local var_241_6 = math.max(var_241_2, arg_238_1.talkMaxDuration)

			if var_241_1 <= arg_238_1.time_ and arg_238_1.time_ < var_241_1 + var_241_6 then
				arg_238_1.typewritter.percent = (arg_238_1.time_ - var_241_1) / var_241_6

				arg_238_1.typewritter:SetDirty()
			end

			if arg_238_1.time_ >= var_241_1 + var_241_6 and arg_238_1.time_ < var_241_1 + var_241_6 + arg_241_0 then
				arg_238_1.typewritter.percent = 1

				arg_238_1.typewritter:SetDirty()
				arg_238_1:ShowNextGo(true)
			end
		end

		arg_238_1.nodeConfigList_ = {}

		arg_238_1:InitPlayNodeList()
	end,
	Play939062057 = function(arg_242_0, arg_242_1)
		arg_242_1.time_ = 0
		arg_242_1.frameCnt_ = 0
		arg_242_1.state_ = "playing"
		arg_242_1.curTalkId_ = 939062057
		arg_242_1.duration_ = 5

		SetActive(arg_242_1.tipsGo_, false)

		function arg_242_1.onSingleLineFinish_()
			arg_242_1.onSingleLineUpdate_ = nil
			arg_242_1.onSingleLineFinish_ = nil
			arg_242_1.state_ = "waiting"
		end

		function arg_242_1.playNext_(arg_244_0)
			if arg_244_0 == 1 then
				arg_242_0:Play939062058(arg_242_1)
			end
		end

		function arg_242_1.onSingleLineUpdate_(arg_245_0)
			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1.var_.moveOldPos1054ui_story = arg_242_1.actors_["1054ui_story"].transform.localPosition

				local var_245_0 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_0 then
					var_245_0:EnableDynamicBone(false)
				end
			end

			local var_245_1 = 0.001

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_1 then
				arg_242_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_242_1.var_.moveOldPos1054ui_story, Vector3.New(0, -0.985, -6), (arg_242_1.time_ - 0) / var_245_1)
				arg_242_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1054ui_story"].transform.position).z)
				arg_242_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1054ui_story"].transform.localEulerAngles = arg_242_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_242_1.time_ >= 0 + var_245_1 and arg_242_1.time_ < 0 + var_245_1 + arg_245_0 then
				arg_242_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, -0.985, -6)
				arg_242_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_242_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_242_1.actors_["1054ui_story"].transform.position).z)
				arg_242_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_242_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_242_1.actors_["1054ui_story"].transform.localEulerAngles = arg_242_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_245_2 = GameObjectTools.GetOrAddComponent(arg_242_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_245_2 then
					var_245_2:EnableDynamicBone(true)
				end
			end

			local var_245_3 = arg_242_1.actors_["1054ui_story"]

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1054ui_story == nil then
				arg_242_1.var_.characterEffect1054ui_story = var_245_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_245_4 = 0.200000002980232

			if 0 <= arg_242_1.time_ and arg_242_1.time_ < 0 + var_245_4 and not isNil(var_245_3) then
				if arg_242_1.var_.characterEffect1054ui_story and not isNil(var_245_3) then
					arg_242_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_242_1.time_ >= 0 + var_245_4 and arg_242_1.time_ < 0 + var_245_4 + arg_245_0 and not isNil(var_245_3) and arg_242_1.var_.characterEffect1054ui_story then
				arg_242_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= 0 + arg_245_0 then
				arg_242_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action5_2")
			end

			local var_245_6 = 0
			local var_245_7 = 0.7

			if 0 < arg_242_1.time_ and arg_242_1.time_ <= var_245_6 + arg_245_0 then
				arg_242_1.talkMaxDuration = 0
				arg_242_1.dialogCg_.alpha = 1

				arg_242_1.dialog_:SetActive(true)
				SetActive(arg_242_1.leftNameGo_, true)

				arg_242_1.leftNameTxt_.text = arg_242_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_242_1.leftNameTxt_.transform)

				arg_242_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_242_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_242_1:RecordName(arg_242_1.leftNameTxt_.text)
				SetActive(arg_242_1.iconTrs_.gameObject, false)
				arg_242_1.callingController_:SetSelectedState("normal")

				local var_245_8 = arg_242_1:FormatText(arg_242_1:GetWordFromCfg(939062057).content)

				arg_242_1.text_.text = var_245_8

				LuaForUtil.ClearLinePrefixSymbol(arg_242_1.text_)

				local var_245_10 = 28 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_8) / 28)

				if (28 <= 0 and var_245_7 or var_245_7 * (utf8.len(var_245_8) / 28)) > 0 and var_245_7 < var_245_10 then
					arg_242_1.talkMaxDuration = var_245_10

					if var_245_10 + var_245_6 > arg_242_1.duration_ then
						arg_242_1.duration_ = var_245_10 + var_245_6
					end
				end

				arg_242_1.text_.text = var_245_8
				arg_242_1.typewritter.percent = 0

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(false)
				arg_242_1:RecordContent(arg_242_1.text_.text)
			end

			local var_245_11 = math.max(var_245_7, arg_242_1.talkMaxDuration)

			if var_245_6 <= arg_242_1.time_ and arg_242_1.time_ < var_245_6 + var_245_11 then
				arg_242_1.typewritter.percent = (arg_242_1.time_ - var_245_6) / var_245_11

				arg_242_1.typewritter:SetDirty()
			end

			if arg_242_1.time_ >= var_245_6 + var_245_11 and arg_242_1.time_ < var_245_6 + var_245_11 + arg_245_0 then
				arg_242_1.typewritter.percent = 1

				arg_242_1.typewritter:SetDirty()
				arg_242_1:ShowNextGo(true)
			end
		end

		arg_242_1.nodeConfigList_ = {
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

		arg_242_1:InitPlayNodeList()
	end,
	Play939062058 = function(arg_246_0, arg_246_1)
		arg_246_1.time_ = 0
		arg_246_1.frameCnt_ = 0
		arg_246_1.state_ = "playing"
		arg_246_1.curTalkId_ = 939062058
		arg_246_1.duration_ = 1

		SetActive(arg_246_1.tipsGo_, false)

		function arg_246_1.onSingleLineFinish_()
			arg_246_1.onSingleLineUpdate_ = nil
			arg_246_1.onSingleLineFinish_ = nil
			arg_246_1.state_ = "waiting"

			SetActive(arg_246_1.choicesGo_, true)

			for iter_247_0, iter_247_1 in ipairs(arg_246_1.choices_) do
				SetActive(iter_247_1.go, iter_247_0 <= 1)
			end

			arg_246_1.choices_[1].txt.text = arg_246_1:FormatText(StoryChoiceCfg[1683].name)
		end

		function arg_246_1.playNext_(arg_248_0)
			if arg_248_0 == 1 then
				arg_246_0:Play939062059(arg_246_1)
			end

			arg_246_1:RecordChoiceLog(939062058, 1683)
		end

		function arg_246_1.onSingleLineUpdate_(arg_249_0)
			if 0 < arg_246_1.time_ and arg_246_1.time_ <= 0 + arg_249_0 and not isNil(arg_246_1.actors_["1054ui_story"]) and arg_246_1.var_.characterEffect1054ui_story == nil then
				arg_246_1.var_.characterEffect1054ui_story = arg_246_1.actors_["1054ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_249_0 = 0.200000002980232

			if 0 <= arg_246_1.time_ and arg_246_1.time_ < 0 + var_249_0 and not isNil(arg_246_1.actors_["1054ui_story"]) then
				if arg_246_1.var_.characterEffect1054ui_story and not isNil(arg_246_1.actors_["1054ui_story"]) then
					arg_246_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_246_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_246_1.time_ - 0) / var_249_0)
				end
			end

			if arg_246_1.time_ >= 0 + var_249_0 and arg_246_1.time_ < 0 + var_249_0 + arg_249_0 and not isNil(arg_246_1.actors_["1054ui_story"]) and arg_246_1.var_.characterEffect1054ui_story then
				arg_246_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_246_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			local var_249_1 = 0

			if 0 < arg_246_1.time_ and arg_246_1.time_ <= var_249_1 + arg_249_0 then
				arg_246_1.allBtn_.enabled = false
			end

			if arg_246_1.time_ >= var_249_1 + 1 and arg_246_1.time_ < var_249_1 + 1 + arg_249_0 then
				arg_246_1.allBtn_.enabled = true
			end
		end

		arg_246_1.nodeConfigList_ = {}

		arg_246_1:InitPlayNodeList()
	end,
	Play939062059 = function(arg_250_0, arg_250_1)
		arg_250_1.time_ = 0
		arg_250_1.frameCnt_ = 0
		arg_250_1.state_ = "playing"
		arg_250_1.curTalkId_ = 939062059
		arg_250_1.duration_ = 5

		SetActive(arg_250_1.tipsGo_, false)

		function arg_250_1.onSingleLineFinish_()
			arg_250_1.onSingleLineUpdate_ = nil
			arg_250_1.onSingleLineFinish_ = nil
			arg_250_1.state_ = "waiting"
		end

		function arg_250_1.playNext_(arg_252_0)
			if arg_252_0 == 1 then
				arg_250_0:Play939062060(arg_250_1)
			end
		end

		function arg_250_1.onSingleLineUpdate_(arg_253_0)
			if 0 < arg_250_1.time_ and arg_250_1.time_ <= 0 + arg_253_0 then
				arg_250_1.var_.moveOldPos1054ui_story = arg_250_1.actors_["1054ui_story"].transform.localPosition

				local var_253_0 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_0 then
					var_253_0:EnableDynamicBone(false)
				end
			end

			local var_253_1 = 0.001

			if 0 <= arg_250_1.time_ and arg_250_1.time_ < 0 + var_253_1 then
				arg_250_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_250_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_250_1.time_ - 0) / var_253_1)
				arg_250_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1054ui_story"].transform.position).z)
				arg_250_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1054ui_story"].transform.localEulerAngles = arg_250_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_250_1.time_ >= 0 + var_253_1 and arg_250_1.time_ < 0 + var_253_1 + arg_253_0 then
				arg_250_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_250_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_250_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_250_1.actors_["1054ui_story"].transform.position).z)
				arg_250_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_250_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_250_1.actors_["1054ui_story"].transform.localEulerAngles = arg_250_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_253_2 = GameObjectTools.GetOrAddComponent(arg_250_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_253_2 then
					var_253_2:EnableDynamicBone(true)
				end
			end

			local var_253_3 = 0
			local var_253_4 = 0.9

			if 0 < arg_250_1.time_ and arg_250_1.time_ <= var_253_3 + arg_253_0 then
				arg_250_1.talkMaxDuration = 0
				arg_250_1.dialogCg_.alpha = 1

				arg_250_1.dialog_:SetActive(true)
				SetActive(arg_250_1.leftNameGo_, false)

				arg_250_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_250_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_250_1:RecordName(arg_250_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_250_1.iconTrs_.gameObject, false)
				arg_250_1.callingController_:SetSelectedState("normal")

				local var_253_5 = arg_250_1:FormatText(arg_250_1:GetWordFromCfg(939062059).content)

				arg_250_1.text_.text = var_253_5

				LuaForUtil.ClearLinePrefixSymbol(arg_250_1.text_)

				local var_253_7 = 36 <= 0 and var_253_4 or var_253_4 * (utf8.len(var_253_5) / 36)

				if (36 <= 0 and var_253_4 or var_253_4 * (utf8.len(var_253_5) / 36)) > 0 and var_253_4 < var_253_7 then
					arg_250_1.talkMaxDuration = var_253_7

					if var_253_7 + var_253_3 > arg_250_1.duration_ then
						arg_250_1.duration_ = var_253_7 + var_253_3
					end
				end

				arg_250_1.text_.text = var_253_5
				arg_250_1.typewritter.percent = 0

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(false)
				arg_250_1:RecordContent(arg_250_1.text_.text)
			end

			local var_253_8 = math.max(var_253_4, arg_250_1.talkMaxDuration)

			if var_253_3 <= arg_250_1.time_ and arg_250_1.time_ < var_253_3 + var_253_8 then
				arg_250_1.typewritter.percent = (arg_250_1.time_ - var_253_3) / var_253_8

				arg_250_1.typewritter:SetDirty()
			end

			if arg_250_1.time_ >= var_253_3 + var_253_8 and arg_250_1.time_ < var_253_3 + var_253_8 + arg_253_0 then
				arg_250_1.typewritter.percent = 1

				arg_250_1.typewritter:SetDirty()
				arg_250_1:ShowNextGo(true)
			end
		end

		arg_250_1.nodeConfigList_ = {
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

		arg_250_1:InitPlayNodeList()
	end,
	Play939062060 = function(arg_254_0, arg_254_1)
		arg_254_1.time_ = 0
		arg_254_1.frameCnt_ = 0
		arg_254_1.state_ = "playing"
		arg_254_1.curTalkId_ = 939062060
		arg_254_1.duration_ = 5

		SetActive(arg_254_1.tipsGo_, false)

		function arg_254_1.onSingleLineFinish_()
			arg_254_1.onSingleLineUpdate_ = nil
			arg_254_1.onSingleLineFinish_ = nil
			arg_254_1.state_ = "waiting"
		end

		function arg_254_1.playNext_(arg_256_0)
			if arg_256_0 == 1 then
				arg_254_0:Play939062061(arg_254_1)
			end
		end

		function arg_254_1.onSingleLineUpdate_(arg_257_0)
			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1.var_.moveOldPos1047ui_story = arg_254_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_257_0 = 0.001

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_0 then
				arg_254_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_254_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_254_1.time_ - 0) / var_257_0)
				arg_254_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).z)
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles = arg_254_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_254_1.time_ >= 0 + var_257_0 and arg_254_1.time_ < 0 + var_257_0 + arg_257_0 then
				arg_254_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_254_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_254_1.actors_["1047ui_story"].transform.position).z)
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_254_1.actors_["1047ui_story"].transform.localEulerAngles = arg_254_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_257_1 = arg_254_1.actors_["1047ui_story"]

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1047ui_story == nil then
				arg_254_1.var_.characterEffect1047ui_story = var_257_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_257_2 = 0.200000002980232

			if 0 <= arg_254_1.time_ and arg_254_1.time_ < 0 + var_257_2 and not isNil(var_257_1) then
				if arg_254_1.var_.characterEffect1047ui_story and not isNil(var_257_1) then
					arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_254_1.time_ >= 0 + var_257_2 and arg_254_1.time_ < 0 + var_257_2 + arg_257_0 and not isNil(var_257_1) and arg_254_1.var_.characterEffect1047ui_story then
				arg_254_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= 0 + arg_257_0 then
				arg_254_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_257_4 = 0
			local var_257_5 = 0.225

			if 0 < arg_254_1.time_ and arg_254_1.time_ <= var_257_4 + arg_257_0 then
				arg_254_1.talkMaxDuration = 0
				arg_254_1.dialogCg_.alpha = 1

				arg_254_1.dialog_:SetActive(true)
				SetActive(arg_254_1.leftNameGo_, true)

				arg_254_1.leftNameTxt_.text = arg_254_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_254_1.leftNameTxt_.transform)

				arg_254_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_254_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_254_1:RecordName(arg_254_1.leftNameTxt_.text)
				SetActive(arg_254_1.iconTrs_.gameObject, false)
				arg_254_1.callingController_:SetSelectedState("normal")

				local var_257_6 = arg_254_1:FormatText(arg_254_1:GetWordFromCfg(939062060).content)

				arg_254_1.text_.text = var_257_6

				LuaForUtil.ClearLinePrefixSymbol(arg_254_1.text_)

				local var_257_8 = 9 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_6) / 9)

				if (9 <= 0 and var_257_5 or var_257_5 * (utf8.len(var_257_6) / 9)) > 0 and var_257_5 < var_257_8 then
					arg_254_1.talkMaxDuration = var_257_8

					if var_257_8 + var_257_4 > arg_254_1.duration_ then
						arg_254_1.duration_ = var_257_8 + var_257_4
					end
				end

				arg_254_1.text_.text = var_257_6
				arg_254_1.typewritter.percent = 0

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(false)
				arg_254_1:RecordContent(arg_254_1.text_.text)
			end

			local var_257_9 = math.max(var_257_5, arg_254_1.talkMaxDuration)

			if var_257_4 <= arg_254_1.time_ and arg_254_1.time_ < var_257_4 + var_257_9 then
				arg_254_1.typewritter.percent = (arg_254_1.time_ - var_257_4) / var_257_9

				arg_254_1.typewritter:SetDirty()
			end

			if arg_254_1.time_ >= var_257_4 + var_257_9 and arg_254_1.time_ < var_257_4 + var_257_9 + arg_257_0 then
				arg_254_1.typewritter.percent = 1

				arg_254_1.typewritter:SetDirty()
				arg_254_1:ShowNextGo(true)
			end
		end

		arg_254_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_254_1:InitPlayNodeList()
	end,
	Play939062061 = function(arg_258_0, arg_258_1)
		arg_258_1.time_ = 0
		arg_258_1.frameCnt_ = 0
		arg_258_1.state_ = "playing"
		arg_258_1.curTalkId_ = 939062061
		arg_258_1.duration_ = 5

		SetActive(arg_258_1.tipsGo_, false)

		function arg_258_1.onSingleLineFinish_()
			arg_258_1.onSingleLineUpdate_ = nil
			arg_258_1.onSingleLineFinish_ = nil
			arg_258_1.state_ = "waiting"
		end

		function arg_258_1.playNext_(arg_260_0)
			if arg_260_0 == 1 then
				arg_258_0:Play939062062(arg_258_1)
			end
		end

		function arg_258_1.onSingleLineUpdate_(arg_261_0)
			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1.var_.moveOldPos6148ui_story = arg_258_1.actors_["6148ui_story"].transform.localPosition

				local var_261_0 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_0 then
					var_261_0:EnableDynamicBone(false)
				end
			end

			local var_261_1 = 0.001

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_1 then
				arg_258_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_258_1.var_.moveOldPos6148ui_story, Vector3.New(0.7, -0.985, -6), (arg_258_1.time_ - 0) / var_261_1)
				arg_258_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["6148ui_story"].transform.position).z)
				arg_258_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["6148ui_story"].transform.localEulerAngles = arg_258_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_258_1.time_ >= 0 + var_261_1 and arg_258_1.time_ < 0 + var_261_1 + arg_261_0 then
				arg_258_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0.7, -0.985, -6)
				arg_258_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_258_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_258_1.actors_["6148ui_story"].transform.position).z)
				arg_258_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_258_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_258_1.actors_["6148ui_story"].transform.localEulerAngles = arg_258_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_261_2 = GameObjectTools.GetOrAddComponent(arg_258_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_261_2 then
					var_261_2:EnableDynamicBone(true)
				end
			end

			local var_261_3 = arg_258_1.actors_["6148ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect6148ui_story == nil then
				arg_258_1.var_.characterEffect6148ui_story = var_261_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_4 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_4 and not isNil(var_261_3) then
				if arg_258_1.var_.characterEffect6148ui_story and not isNil(var_261_3) then
					arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_258_1.time_ >= 0 + var_261_4 and arg_258_1.time_ < 0 + var_261_4 + arg_261_0 and not isNil(var_261_3) and arg_258_1.var_.characterEffect6148ui_story then
				arg_258_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			local var_261_6 = arg_258_1.actors_["1047ui_story"]

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1047ui_story == nil then
				arg_258_1.var_.characterEffect1047ui_story = var_261_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_261_7 = 0.200000002980232

			if 0 <= arg_258_1.time_ and arg_258_1.time_ < 0 + var_261_7 and not isNil(var_261_6) then
				if arg_258_1.var_.characterEffect1047ui_story and not isNil(var_261_6) then
					arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_258_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_258_1.time_ - 0) / var_261_7)
				end
			end

			if arg_258_1.time_ >= 0 + var_261_7 and arg_258_1.time_ < 0 + var_261_7 + arg_261_0 and not isNil(var_261_6) and arg_258_1.var_.characterEffect1047ui_story then
				arg_258_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_258_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action1_1")
			end

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= 0 + arg_261_0 then
				arg_258_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_261_8 = 0
			local var_261_9 = 0.35

			if 0 < arg_258_1.time_ and arg_258_1.time_ <= var_261_8 + arg_261_0 then
				arg_258_1.talkMaxDuration = 0
				arg_258_1.dialogCg_.alpha = 1

				arg_258_1.dialog_:SetActive(true)
				SetActive(arg_258_1.leftNameGo_, true)

				arg_258_1.leftNameTxt_.text = arg_258_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_258_1.leftNameTxt_.transform)

				arg_258_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_258_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_258_1:RecordName(arg_258_1.leftNameTxt_.text)
				SetActive(arg_258_1.iconTrs_.gameObject, false)
				arg_258_1.callingController_:SetSelectedState("normal")

				local var_261_10 = arg_258_1:FormatText(arg_258_1:GetWordFromCfg(939062061).content)

				arg_258_1.text_.text = var_261_10

				LuaForUtil.ClearLinePrefixSymbol(arg_258_1.text_)

				local var_261_12 = 14 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_10) / 14)

				if (14 <= 0 and var_261_9 or var_261_9 * (utf8.len(var_261_10) / 14)) > 0 and var_261_9 < var_261_12 then
					arg_258_1.talkMaxDuration = var_261_12

					if var_261_12 + var_261_8 > arg_258_1.duration_ then
						arg_258_1.duration_ = var_261_12 + var_261_8
					end
				end

				arg_258_1.text_.text = var_261_10
				arg_258_1.typewritter.percent = 0

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(false)
				arg_258_1:RecordContent(arg_258_1.text_.text)
			end

			local var_261_13 = math.max(var_261_9, arg_258_1.talkMaxDuration)

			if var_261_8 <= arg_258_1.time_ and arg_258_1.time_ < var_261_8 + var_261_13 then
				arg_258_1.typewritter.percent = (arg_258_1.time_ - var_261_8) / var_261_13

				arg_258_1.typewritter:SetDirty()
			end

			if arg_258_1.time_ >= var_261_8 + var_261_13 and arg_258_1.time_ < var_261_8 + var_261_13 + arg_261_0 then
				arg_258_1.typewritter.percent = 1

				arg_258_1.typewritter:SetDirty()
				arg_258_1:ShowNextGo(true)
			end
		end

		arg_258_1.nodeConfigList_ = {
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

		arg_258_1:InitPlayNodeList()
	end,
	Play939062062 = function(arg_262_0, arg_262_1)
		arg_262_1.time_ = 0
		arg_262_1.frameCnt_ = 0
		arg_262_1.state_ = "playing"
		arg_262_1.curTalkId_ = 939062062
		arg_262_1.duration_ = 5

		SetActive(arg_262_1.tipsGo_, false)

		function arg_262_1.onSingleLineFinish_()
			arg_262_1.onSingleLineUpdate_ = nil
			arg_262_1.onSingleLineFinish_ = nil
			arg_262_1.state_ = "waiting"
		end

		function arg_262_1.playNext_(arg_264_0)
			if arg_264_0 == 1 then
				arg_262_0:Play939062063(arg_262_1)
			end
		end

		function arg_262_1.onSingleLineUpdate_(arg_265_0)
			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos6148ui_story = arg_262_1.actors_["6148ui_story"].transform.localPosition

				local var_265_0 = GameObjectTools.GetOrAddComponent(arg_262_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_265_0 then
					var_265_0:EnableDynamicBone(false)
				end
			end

			local var_265_1 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_1 then
				arg_262_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_1)
				arg_262_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["6148ui_story"].transform.position).z)
				arg_262_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["6148ui_story"].transform.localEulerAngles = arg_262_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_1 and arg_262_1.time_ < 0 + var_265_1 + arg_265_0 then
				arg_262_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_262_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_262_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_262_1.actors_["6148ui_story"].transform.position).z)
				arg_262_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_262_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_262_1.actors_["6148ui_story"].transform.localEulerAngles = arg_262_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_265_2 = GameObjectTools.GetOrAddComponent(arg_262_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_265_2 then
					var_265_2:EnableDynamicBone(true)
				end
			end

			local var_265_3 = arg_262_1.actors_["1047ui_story"].transform

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 then
				arg_262_1.var_.moveOldPos1047ui_story = var_265_3.localPosition
			end

			local var_265_4 = 0.001

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_4 then
				var_265_3.localPosition = Vector3.Lerp(arg_262_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_262_1.time_ - 0) / var_265_4)
				var_265_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_3.position).x, (manager.ui.mainCamera.transform.position - var_265_3.position).y, (manager.ui.mainCamera.transform.position - var_265_3.position).z)
				var_265_3.localEulerAngles.z = 0
				var_265_3.localEulerAngles.x = 0
				var_265_3.localEulerAngles = var_265_3.localEulerAngles
			end

			if arg_262_1.time_ >= 0 + var_265_4 and arg_262_1.time_ < 0 + var_265_4 + arg_265_0 then
				var_265_3.localPosition = Vector3.New(0, 100, 0)
				var_265_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_265_3.position).x, (manager.ui.mainCamera.transform.position - var_265_3.position).y, (manager.ui.mainCamera.transform.position - var_265_3.position).z)
				var_265_3.localEulerAngles.z = 0
				var_265_3.localEulerAngles.x = 0
				var_265_3.localEulerAngles = var_265_3.localEulerAngles
			end

			local var_265_5 = arg_262_1.actors_["6148ui_story"]

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= 0 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.characterEffect6148ui_story == nil then
				arg_262_1.var_.characterEffect6148ui_story = var_265_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_265_6 = 0.200000002980232

			if 0 <= arg_262_1.time_ and arg_262_1.time_ < 0 + var_265_6 and not isNil(var_265_5) then
				if arg_262_1.var_.characterEffect6148ui_story and not isNil(var_265_5) then
					arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_262_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_262_1.time_ - 0) / var_265_6)
				end
			end

			if arg_262_1.time_ >= 0 + var_265_6 and arg_262_1.time_ < 0 + var_265_6 + arg_265_0 and not isNil(var_265_5) and arg_262_1.var_.characterEffect6148ui_story then
				arg_262_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_262_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			local var_265_7 = 0
			local var_265_8 = 0.575

			if 0 < arg_262_1.time_ and arg_262_1.time_ <= var_265_7 + arg_265_0 then
				arg_262_1.talkMaxDuration = 0
				arg_262_1.dialogCg_.alpha = 1

				arg_262_1.dialog_:SetActive(true)
				SetActive(arg_262_1.leftNameGo_, false)

				arg_262_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_262_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_262_1:RecordName(arg_262_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_262_1.iconTrs_.gameObject, false)
				arg_262_1.callingController_:SetSelectedState("normal")

				local var_265_9 = arg_262_1:FormatText(arg_262_1:GetWordFromCfg(939062062).content)

				arg_262_1.text_.text = var_265_9

				LuaForUtil.ClearLinePrefixSymbol(arg_262_1.text_)

				local var_265_11 = 23 <= 0 and var_265_8 or var_265_8 * (utf8.len(var_265_9) / 23)

				if (23 <= 0 and var_265_8 or var_265_8 * (utf8.len(var_265_9) / 23)) > 0 and var_265_8 < var_265_11 then
					arg_262_1.talkMaxDuration = var_265_11

					if var_265_11 + var_265_7 > arg_262_1.duration_ then
						arg_262_1.duration_ = var_265_11 + var_265_7
					end
				end

				arg_262_1.text_.text = var_265_9
				arg_262_1.typewritter.percent = 0

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(false)
				arg_262_1:RecordContent(arg_262_1.text_.text)
			end

			local var_265_12 = math.max(var_265_8, arg_262_1.talkMaxDuration)

			if var_265_7 <= arg_262_1.time_ and arg_262_1.time_ < var_265_7 + var_265_12 then
				arg_262_1.typewritter.percent = (arg_262_1.time_ - var_265_7) / var_265_12

				arg_262_1.typewritter:SetDirty()
			end

			if arg_262_1.time_ >= var_265_7 + var_265_12 and arg_262_1.time_ < var_265_7 + var_265_12 + arg_265_0 then
				arg_262_1.typewritter.percent = 1

				arg_262_1.typewritter:SetDirty()
				arg_262_1:ShowNextGo(true)
			end
		end

		arg_262_1.nodeConfigList_ = {
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
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_262_1:InitPlayNodeList()
	end,
	Play939062063 = function(arg_266_0, arg_266_1)
		arg_266_1.time_ = 0
		arg_266_1.frameCnt_ = 0
		arg_266_1.state_ = "playing"
		arg_266_1.curTalkId_ = 939062063
		arg_266_1.duration_ = 5

		SetActive(arg_266_1.tipsGo_, false)

		function arg_266_1.onSingleLineFinish_()
			arg_266_1.onSingleLineUpdate_ = nil
			arg_266_1.onSingleLineFinish_ = nil
			arg_266_1.state_ = "waiting"
		end

		function arg_266_1.playNext_(arg_268_0)
			if arg_268_0 == 1 then
				arg_266_0:Play939062064(arg_266_1)
			end
		end

		function arg_266_1.onSingleLineUpdate_(arg_269_0)
			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1.var_.moveOldPos1054ui_story = arg_266_1.actors_["1054ui_story"].transform.localPosition

				local var_269_0 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_0 then
					var_269_0:EnableDynamicBone(false)
				end
			end

			local var_269_1 = 0.001

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_1 then
				arg_266_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_266_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_266_1.time_ - 0) / var_269_1)
				arg_266_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1054ui_story"].transform.position).z)
				arg_266_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1054ui_story"].transform.localEulerAngles = arg_266_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_266_1.time_ >= 0 + var_269_1 and arg_266_1.time_ < 0 + var_269_1 + arg_269_0 then
				arg_266_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_266_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_266_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_266_1.actors_["1054ui_story"].transform.position).z)
				arg_266_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_266_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_266_1.actors_["1054ui_story"].transform.localEulerAngles = arg_266_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_269_2 = GameObjectTools.GetOrAddComponent(arg_266_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_269_2 then
					var_269_2:EnableDynamicBone(true)
				end
			end

			local var_269_3 = arg_266_1.actors_["1054ui_story"]

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect1054ui_story == nil then
				arg_266_1.var_.characterEffect1054ui_story = var_269_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_269_4 = 0.200000002980232

			if 0 <= arg_266_1.time_ and arg_266_1.time_ < 0 + var_269_4 and not isNil(var_269_3) then
				if arg_266_1.var_.characterEffect1054ui_story and not isNil(var_269_3) then
					arg_266_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_266_1.time_ >= 0 + var_269_4 and arg_266_1.time_ < 0 + var_269_4 + arg_269_0 and not isNil(var_269_3) and arg_266_1.var_.characterEffect1054ui_story then
				arg_266_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action1_1")
			end

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= 0 + arg_269_0 then
				arg_266_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_wubiaoqing", "EmotionTimelineAnimator")
			end

			local var_269_6 = 0
			local var_269_7 = 0.575

			if 0 < arg_266_1.time_ and arg_266_1.time_ <= var_269_6 + arg_269_0 then
				arg_266_1.talkMaxDuration = 0
				arg_266_1.dialogCg_.alpha = 1

				arg_266_1.dialog_:SetActive(true)
				SetActive(arg_266_1.leftNameGo_, true)

				arg_266_1.leftNameTxt_.text = arg_266_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_266_1.leftNameTxt_.transform)

				arg_266_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_266_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_266_1:RecordName(arg_266_1.leftNameTxt_.text)
				SetActive(arg_266_1.iconTrs_.gameObject, false)
				arg_266_1.callingController_:SetSelectedState("normal")

				local var_269_8 = arg_266_1:FormatText(arg_266_1:GetWordFromCfg(939062063).content)

				arg_266_1.text_.text = var_269_8

				LuaForUtil.ClearLinePrefixSymbol(arg_266_1.text_)

				local var_269_10 = 23 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_8) / 23)

				if (23 <= 0 and var_269_7 or var_269_7 * (utf8.len(var_269_8) / 23)) > 0 and var_269_7 < var_269_10 then
					arg_266_1.talkMaxDuration = var_269_10

					if var_269_10 + var_269_6 > arg_266_1.duration_ then
						arg_266_1.duration_ = var_269_10 + var_269_6
					end
				end

				arg_266_1.text_.text = var_269_8
				arg_266_1.typewritter.percent = 0

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(false)
				arg_266_1:RecordContent(arg_266_1.text_.text)
			end

			local var_269_11 = math.max(var_269_7, arg_266_1.talkMaxDuration)

			if var_269_6 <= arg_266_1.time_ and arg_266_1.time_ < var_269_6 + var_269_11 then
				arg_266_1.typewritter.percent = (arg_266_1.time_ - var_269_6) / var_269_11

				arg_266_1.typewritter:SetDirty()
			end

			if arg_266_1.time_ >= var_269_6 + var_269_11 and arg_266_1.time_ < var_269_6 + var_269_11 + arg_269_0 then
				arg_266_1.typewritter.percent = 1

				arg_266_1.typewritter:SetDirty()
				arg_266_1:ShowNextGo(true)
			end
		end

		arg_266_1.nodeConfigList_ = {
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

		arg_266_1:InitPlayNodeList()
	end,
	Play939062064 = function(arg_270_0, arg_270_1)
		arg_270_1.time_ = 0
		arg_270_1.frameCnt_ = 0
		arg_270_1.state_ = "playing"
		arg_270_1.curTalkId_ = 939062064
		arg_270_1.duration_ = 5

		SetActive(arg_270_1.tipsGo_, false)

		function arg_270_1.onSingleLineFinish_()
			arg_270_1.onSingleLineUpdate_ = nil
			arg_270_1.onSingleLineFinish_ = nil
			arg_270_1.state_ = "waiting"
		end

		function arg_270_1.playNext_(arg_272_0)
			if arg_272_0 == 1 then
				arg_270_0:Play939062065(arg_270_1)
			end
		end

		function arg_270_1.onSingleLineUpdate_(arg_273_0)
			if arg_270_1.actors_["1042ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1042ui_story"))) then
				local var_273_0 = Object.Instantiate(Asset.Load("Char/" .. "1042ui_story"), arg_270_1.stage_.transform)

				var_273_0.name = "1042ui_story"
				var_273_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_270_1.actors_["1042ui_story"] = var_273_0

				local var_273_1 = var_273_0:GetComponentInChildren(typeof(CharacterEffect))

				var_273_1.enabled = true

				local var_273_2 = GameObjectTools.GetOrAddComponent(var_273_0, typeof(DynamicBoneHelper))

				if var_273_2 then
					var_273_2:EnableDynamicBone(false)
				end

				arg_270_1:ShowWeapon(var_273_1.transform, false)

				arg_270_1.var_["1042ui_story" .. "Animator"] = var_273_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_270_1.var_["1042ui_story" .. "Animator"].applyRootMotion = true
				arg_270_1.var_["1042ui_story" .. "LipSync"] = var_273_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_273_3 = arg_270_1.actors_["1042ui_story"].transform

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1.var_.moveOldPos1042ui_story = var_273_3.localPosition
			end

			local var_273_4 = 0.001

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_4 then
				var_273_3.localPosition = Vector3.Lerp(arg_270_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_270_1.time_ - 0) / var_273_4)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			if arg_270_1.time_ >= 0 + var_273_4 and arg_270_1.time_ < 0 + var_273_4 + arg_273_0 then
				var_273_3.localPosition = Vector3.New(0.7, -1.06, -6.2)
				var_273_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_273_3.position).x, (manager.ui.mainCamera.transform.position - var_273_3.position).y, (manager.ui.mainCamera.transform.position - var_273_3.position).z)
				var_273_3.localEulerAngles.z = 0
				var_273_3.localEulerAngles.x = 0
				var_273_3.localEulerAngles = var_273_3.localEulerAngles
			end

			local var_273_5 = arg_270_1.actors_["1042ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1042ui_story == nil then
				arg_270_1.var_.characterEffect1042ui_story = var_273_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_6 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_6 and not isNil(var_273_5) then
				if arg_270_1.var_.characterEffect1042ui_story and not isNil(var_273_5) then
					arg_270_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_270_1.time_ >= 0 + var_273_6 and arg_270_1.time_ < 0 + var_273_6 + arg_273_0 and not isNil(var_273_5) and arg_270_1.var_.characterEffect1042ui_story then
				arg_270_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_273_8 = arg_270_1.actors_["1054ui_story"]

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.characterEffect1054ui_story == nil then
				arg_270_1.var_.characterEffect1054ui_story = var_273_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_273_9 = 0.200000002980232

			if 0 <= arg_270_1.time_ and arg_270_1.time_ < 0 + var_273_9 and not isNil(var_273_8) then
				if arg_270_1.var_.characterEffect1054ui_story and not isNil(var_273_8) then
					arg_270_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_270_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_270_1.time_ - 0) / var_273_9)
				end
			end

			if arg_270_1.time_ >= 0 + var_273_9 and arg_270_1.time_ < 0 + var_273_9 + arg_273_0 and not isNil(var_273_8) and arg_270_1.var_.characterEffect1054ui_story then
				arg_270_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_270_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action1_1")
			end

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= 0 + arg_273_0 then
				arg_270_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_273_10 = 0
			local var_273_11 = 0.7

			if 0 < arg_270_1.time_ and arg_270_1.time_ <= var_273_10 + arg_273_0 then
				arg_270_1.talkMaxDuration = 0
				arg_270_1.dialogCg_.alpha = 1

				arg_270_1.dialog_:SetActive(true)
				SetActive(arg_270_1.leftNameGo_, true)

				arg_270_1.leftNameTxt_.text = arg_270_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_270_1.leftNameTxt_.transform)

				arg_270_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_270_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_270_1:RecordName(arg_270_1.leftNameTxt_.text)
				SetActive(arg_270_1.iconTrs_.gameObject, false)
				arg_270_1.callingController_:SetSelectedState("normal")

				local var_273_12 = arg_270_1:FormatText(arg_270_1:GetWordFromCfg(939062064).content)

				arg_270_1.text_.text = var_273_12

				LuaForUtil.ClearLinePrefixSymbol(arg_270_1.text_)

				local var_273_14 = 28 <= 0 and var_273_11 or var_273_11 * (utf8.len(var_273_12) / 28)

				if (28 <= 0 and var_273_11 or var_273_11 * (utf8.len(var_273_12) / 28)) > 0 and var_273_11 < var_273_14 then
					arg_270_1.talkMaxDuration = var_273_14

					if var_273_14 + var_273_10 > arg_270_1.duration_ then
						arg_270_1.duration_ = var_273_14 + var_273_10
					end
				end

				arg_270_1.text_.text = var_273_12
				arg_270_1.typewritter.percent = 0

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(false)
				arg_270_1:RecordContent(arg_270_1.text_.text)
			end

			local var_273_15 = math.max(var_273_11, arg_270_1.talkMaxDuration)

			if var_273_10 <= arg_270_1.time_ and arg_270_1.time_ < var_273_10 + var_273_15 then
				arg_270_1.typewritter.percent = (arg_270_1.time_ - var_273_10) / var_273_15

				arg_270_1.typewritter:SetDirty()
			end

			if arg_270_1.time_ >= var_273_10 + var_273_15 and arg_270_1.time_ < var_273_10 + var_273_15 + arg_273_0 then
				arg_270_1.typewritter.percent = 1

				arg_270_1.typewritter:SetDirty()
				arg_270_1:ShowNextGo(true)
			end
		end

		arg_270_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_270_1:InitPlayNodeList()
	end,
	Play939062065 = function(arg_274_0, arg_274_1)
		arg_274_1.time_ = 0
		arg_274_1.frameCnt_ = 0
		arg_274_1.state_ = "playing"
		arg_274_1.curTalkId_ = 939062065
		arg_274_1.duration_ = 5

		SetActive(arg_274_1.tipsGo_, false)

		function arg_274_1.onSingleLineFinish_()
			arg_274_1.onSingleLineUpdate_ = nil
			arg_274_1.onSingleLineFinish_ = nil
			arg_274_1.state_ = "waiting"
		end

		function arg_274_1.playNext_(arg_276_0)
			if arg_276_0 == 1 then
				arg_274_0:Play939062066(arg_274_1)
			end
		end

		function arg_274_1.onSingleLineUpdate_(arg_277_0)
			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1042ui_story = arg_274_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_277_0 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_0 then
				arg_274_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_0)
				arg_274_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1042ui_story"].transform.position).z)
				arg_274_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1042ui_story"].transform.localEulerAngles = arg_274_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_0 and arg_274_1.time_ < 0 + var_277_0 + arg_277_0 then
				arg_274_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_274_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_274_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_274_1.actors_["1042ui_story"].transform.position).z)
				arg_274_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_274_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_274_1.actors_["1042ui_story"].transform.localEulerAngles = arg_274_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_277_1 = arg_274_1.actors_["1054ui_story"].transform

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 then
				arg_274_1.var_.moveOldPos1054ui_story = var_277_1.localPosition

				local var_277_2 = GameObjectTools.GetOrAddComponent(var_277_1.gameObject, typeof(DynamicBoneHelper))

				if var_277_2 then
					var_277_2:EnableDynamicBone(false)
				end
			end

			local var_277_3 = 0.001

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_3 then
				var_277_1.localPosition = Vector3.Lerp(arg_274_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_274_1.time_ - 0) / var_277_3)
				var_277_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_1.position).x, (manager.ui.mainCamera.transform.position - var_277_1.position).y, (manager.ui.mainCamera.transform.position - var_277_1.position).z)
				var_277_1.localEulerAngles.z = 0
				var_277_1.localEulerAngles.x = 0
				var_277_1.localEulerAngles = var_277_1.localEulerAngles
			end

			if arg_274_1.time_ >= 0 + var_277_3 and arg_274_1.time_ < 0 + var_277_3 + arg_277_0 then
				var_277_1.localPosition = Vector3.New(0, 100, 0)
				var_277_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_277_1.position).x, (manager.ui.mainCamera.transform.position - var_277_1.position).y, (manager.ui.mainCamera.transform.position - var_277_1.position).z)
				var_277_1.localEulerAngles.z = 0
				var_277_1.localEulerAngles.x = 0
				var_277_1.localEulerAngles = var_277_1.localEulerAngles

				local var_277_4 = GameObjectTools.GetOrAddComponent(var_277_1.gameObject, typeof(DynamicBoneHelper))

				if var_277_4 then
					var_277_4:EnableDynamicBone(true)
				end
			end

			local var_277_5 = arg_274_1.actors_["1042ui_story"]

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= 0 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.characterEffect1042ui_story == nil then
				arg_274_1.var_.characterEffect1042ui_story = var_277_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_277_6 = 0.200000002980232

			if 0 <= arg_274_1.time_ and arg_274_1.time_ < 0 + var_277_6 and not isNil(var_277_5) then
				if arg_274_1.var_.characterEffect1042ui_story and not isNil(var_277_5) then
					arg_274_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_274_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_274_1.time_ - 0) / var_277_6)
				end
			end

			if arg_274_1.time_ >= 0 + var_277_6 and arg_274_1.time_ < 0 + var_277_6 + arg_277_0 and not isNil(var_277_5) and arg_274_1.var_.characterEffect1042ui_story then
				arg_274_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_274_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			local var_277_7 = 0
			local var_277_8 = 0.725

			if 0 < arg_274_1.time_ and arg_274_1.time_ <= var_277_7 + arg_277_0 then
				arg_274_1.talkMaxDuration = 0
				arg_274_1.dialogCg_.alpha = 1

				arg_274_1.dialog_:SetActive(true)
				SetActive(arg_274_1.leftNameGo_, false)

				arg_274_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_274_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_274_1:RecordName(arg_274_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_274_1.iconTrs_.gameObject, false)
				arg_274_1.callingController_:SetSelectedState("normal")

				local var_277_9 = arg_274_1:FormatText(arg_274_1:GetWordFromCfg(939062065).content)

				arg_274_1.text_.text = var_277_9

				LuaForUtil.ClearLinePrefixSymbol(arg_274_1.text_)

				local var_277_11 = 29 <= 0 and var_277_8 or var_277_8 * (utf8.len(var_277_9) / 29)

				if (29 <= 0 and var_277_8 or var_277_8 * (utf8.len(var_277_9) / 29)) > 0 and var_277_8 < var_277_11 then
					arg_274_1.talkMaxDuration = var_277_11

					if var_277_11 + var_277_7 > arg_274_1.duration_ then
						arg_274_1.duration_ = var_277_11 + var_277_7
					end
				end

				arg_274_1.text_.text = var_277_9
				arg_274_1.typewritter.percent = 0

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(false)
				arg_274_1:RecordContent(arg_274_1.text_.text)
			end

			local var_277_12 = math.max(var_277_8, arg_274_1.talkMaxDuration)

			if var_277_7 <= arg_274_1.time_ and arg_274_1.time_ < var_277_7 + var_277_12 then
				arg_274_1.typewritter.percent = (arg_274_1.time_ - var_277_7) / var_277_12

				arg_274_1.typewritter:SetDirty()
			end

			if arg_274_1.time_ >= var_277_7 + var_277_12 and arg_274_1.time_ < var_277_7 + var_277_12 + arg_277_0 then
				arg_274_1.typewritter.percent = 1

				arg_274_1.typewritter:SetDirty()
				arg_274_1:ShowNextGo(true)
			end
		end

		arg_274_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
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

		arg_274_1:InitPlayNodeList()
	end,
	Play939062066 = function(arg_278_0, arg_278_1)
		arg_278_1.time_ = 0
		arg_278_1.frameCnt_ = 0
		arg_278_1.state_ = "playing"
		arg_278_1.curTalkId_ = 939062066
		arg_278_1.duration_ = 5

		SetActive(arg_278_1.tipsGo_, false)

		function arg_278_1.onSingleLineFinish_()
			arg_278_1.onSingleLineUpdate_ = nil
			arg_278_1.onSingleLineFinish_ = nil
			arg_278_1.state_ = "waiting"
		end

		function arg_278_1.playNext_(arg_280_0)
			if arg_280_0 == 1 then
				arg_278_0:Play939062067(arg_278_1)
			end
		end

		function arg_278_1.onSingleLineUpdate_(arg_281_0)
			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1.var_.moveOldPos6148ui_story = arg_278_1.actors_["6148ui_story"].transform.localPosition

				local var_281_0 = GameObjectTools.GetOrAddComponent(arg_278_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_281_0 then
					var_281_0:EnableDynamicBone(false)
				end
			end

			local var_281_1 = 0.001

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_1 then
				arg_278_1.actors_["6148ui_story"].transform.localPosition = Vector3.Lerp(arg_278_1.var_.moveOldPos6148ui_story, Vector3.New(-0.7, -0.985, -6), (arg_278_1.time_ - 0) / var_281_1)
				arg_278_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["6148ui_story"].transform.position).z)
				arg_278_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["6148ui_story"].transform.localEulerAngles = arg_278_1.actors_["6148ui_story"].transform.localEulerAngles
			end

			if arg_278_1.time_ >= 0 + var_281_1 and arg_278_1.time_ < 0 + var_281_1 + arg_281_0 then
				arg_278_1.actors_["6148ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_278_1.actors_["6148ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_278_1.actors_["6148ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["6148ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_278_1.actors_["6148ui_story"].transform.position).z)
				arg_278_1.actors_["6148ui_story"].transform.localEulerAngles.z = 0
				arg_278_1.actors_["6148ui_story"].transform.localEulerAngles.x = 0
				arg_278_1.actors_["6148ui_story"].transform.localEulerAngles = arg_278_1.actors_["6148ui_story"].transform.localEulerAngles

				local var_281_2 = GameObjectTools.GetOrAddComponent(arg_278_1.actors_["6148ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_281_2 then
					var_281_2:EnableDynamicBone(true)
				end
			end

			local var_281_3 = arg_278_1.actors_["6148ui_story"]

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 and not isNil(var_281_3) and arg_278_1.var_.characterEffect6148ui_story == nil then
				arg_278_1.var_.characterEffect6148ui_story = var_281_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_281_4 = 0.200000002980232

			if 0 <= arg_278_1.time_ and arg_278_1.time_ < 0 + var_281_4 and not isNil(var_281_3) then
				if arg_278_1.var_.characterEffect6148ui_story and not isNil(var_281_3) then
					arg_278_1.var_.characterEffect6148ui_story.fillFlat = false
				end
			end

			if arg_278_1.time_ >= 0 + var_281_4 and arg_278_1.time_ < 0 + var_281_4 + arg_281_0 and not isNil(var_281_3) and arg_278_1.var_.characterEffect6148ui_story then
				arg_278_1.var_.characterEffect6148ui_story.fillFlat = false
			end

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= 0 + arg_281_0 then
				arg_278_1:PlayTimeline("6148ui_story", "StoryTimeline/CharAction/story6148/story6148action/6148action6_1")
			end

			local var_281_6 = 0
			local var_281_7 = 0.425

			if 0 < arg_278_1.time_ and arg_278_1.time_ <= var_281_6 + arg_281_0 then
				arg_278_1.talkMaxDuration = 0
				arg_278_1.dialogCg_.alpha = 1

				arg_278_1.dialog_:SetActive(true)
				SetActive(arg_278_1.leftNameGo_, true)

				arg_278_1.leftNameTxt_.text = arg_278_1:FormatText(StoryNameCfg[1488].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_278_1.leftNameTxt_.transform)

				arg_278_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_278_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_278_1:RecordName(arg_278_1.leftNameTxt_.text)
				SetActive(arg_278_1.iconTrs_.gameObject, false)
				arg_278_1.callingController_:SetSelectedState("normal")

				local var_281_8 = arg_278_1:FormatText(arg_278_1:GetWordFromCfg(939062066).content)

				arg_278_1.text_.text = var_281_8

				LuaForUtil.ClearLinePrefixSymbol(arg_278_1.text_)

				local var_281_10 = 17 <= 0 and var_281_7 or var_281_7 * (utf8.len(var_281_8) / 17)

				if (17 <= 0 and var_281_7 or var_281_7 * (utf8.len(var_281_8) / 17)) > 0 and var_281_7 < var_281_10 then
					arg_278_1.talkMaxDuration = var_281_10

					if var_281_10 + var_281_6 > arg_278_1.duration_ then
						arg_278_1.duration_ = var_281_10 + var_281_6
					end
				end

				arg_278_1.text_.text = var_281_8
				arg_278_1.typewritter.percent = 0

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(false)
				arg_278_1:RecordContent(arg_278_1.text_.text)
			end

			local var_281_11 = math.max(var_281_7, arg_278_1.talkMaxDuration)

			if var_281_6 <= arg_278_1.time_ and arg_278_1.time_ < var_281_6 + var_281_11 then
				arg_278_1.typewritter.percent = (arg_278_1.time_ - var_281_6) / var_281_11

				arg_278_1.typewritter:SetDirty()
			end

			if arg_278_1.time_ >= var_281_6 + var_281_11 and arg_278_1.time_ < var_281_6 + var_281_11 + arg_281_0 then
				arg_278_1.typewritter.percent = 1

				arg_278_1.typewritter:SetDirty()
				arg_278_1:ShowNextGo(true)
			end
		end

		arg_278_1.nodeConfigList_ = {
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

		arg_278_1:InitPlayNodeList()
	end,
	Play939062067 = function(arg_282_0, arg_282_1)
		arg_282_1.time_ = 0
		arg_282_1.frameCnt_ = 0
		arg_282_1.state_ = "playing"
		arg_282_1.curTalkId_ = 939062067
		arg_282_1.duration_ = 5

		SetActive(arg_282_1.tipsGo_, false)

		function arg_282_1.onSingleLineFinish_()
			arg_282_1.onSingleLineUpdate_ = nil
			arg_282_1.onSingleLineFinish_ = nil
			arg_282_1.state_ = "waiting"
		end

		function arg_282_1.playNext_(arg_284_0)
			if arg_284_0 == 1 then
				arg_282_0:Play939062068(arg_282_1)
			end
		end

		function arg_282_1.onSingleLineUpdate_(arg_285_0)
			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1.var_.moveOldPos1042ui_story = arg_282_1.actors_["1042ui_story"].transform.localPosition
			end

			local var_285_0 = 0.001

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_0 then
				arg_282_1.actors_["1042ui_story"].transform.localPosition = Vector3.Lerp(arg_282_1.var_.moveOldPos1042ui_story, Vector3.New(0.7, -1.06, -6.2), (arg_282_1.time_ - 0) / var_285_0)
				arg_282_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1042ui_story"].transform.position).z)
				arg_282_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1042ui_story"].transform.localEulerAngles = arg_282_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			if arg_282_1.time_ >= 0 + var_285_0 and arg_282_1.time_ < 0 + var_285_0 + arg_285_0 then
				arg_282_1.actors_["1042ui_story"].transform.localPosition = Vector3.New(0.7, -1.06, -6.2)
				arg_282_1.actors_["1042ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_282_1.actors_["1042ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1042ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_282_1.actors_["1042ui_story"].transform.position).z)
				arg_282_1.actors_["1042ui_story"].transform.localEulerAngles.z = 0
				arg_282_1.actors_["1042ui_story"].transform.localEulerAngles.x = 0
				arg_282_1.actors_["1042ui_story"].transform.localEulerAngles = arg_282_1.actors_["1042ui_story"].transform.localEulerAngles
			end

			local var_285_1 = arg_282_1.actors_["1042ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1042ui_story == nil then
				arg_282_1.var_.characterEffect1042ui_story = var_285_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_2 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_2 and not isNil(var_285_1) then
				if arg_282_1.var_.characterEffect1042ui_story and not isNil(var_285_1) then
					arg_282_1.var_.characterEffect1042ui_story.fillFlat = false
				end
			end

			if arg_282_1.time_ >= 0 + var_285_2 and arg_282_1.time_ < 0 + var_285_2 + arg_285_0 and not isNil(var_285_1) and arg_282_1.var_.characterEffect1042ui_story then
				arg_282_1.var_.characterEffect1042ui_story.fillFlat = false
			end

			local var_285_4 = arg_282_1.actors_["6148ui_story"]

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 and not isNil(var_285_4) and arg_282_1.var_.characterEffect6148ui_story == nil then
				arg_282_1.var_.characterEffect6148ui_story = var_285_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_285_5 = 0.200000002980232

			if 0 <= arg_282_1.time_ and arg_282_1.time_ < 0 + var_285_5 and not isNil(var_285_4) then
				if arg_282_1.var_.characterEffect6148ui_story and not isNil(var_285_4) then
					arg_282_1.var_.characterEffect6148ui_story.fillFlat = true
					arg_282_1.var_.characterEffect6148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_282_1.time_ - 0) / var_285_5)
				end
			end

			if arg_282_1.time_ >= 0 + var_285_5 and arg_282_1.time_ < 0 + var_285_5 + arg_285_0 and not isNil(var_285_4) and arg_282_1.var_.characterEffect6148ui_story then
				arg_282_1.var_.characterEffect6148ui_story.fillFlat = true
				arg_282_1.var_.characterEffect6148ui_story.fillRatio = 0.5
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/story1042/story1042action/1042action2_1")
			end

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= 0 + arg_285_0 then
				arg_282_1:PlayTimeline("1042ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva", "EmotionTimelineAnimator")
			end

			local var_285_6 = 0
			local var_285_7 = 0.625

			if 0 < arg_282_1.time_ and arg_282_1.time_ <= var_285_6 + arg_285_0 then
				arg_282_1.talkMaxDuration = 0
				arg_282_1.dialogCg_.alpha = 1

				arg_282_1.dialog_:SetActive(true)
				SetActive(arg_282_1.leftNameGo_, true)

				arg_282_1.leftNameTxt_.text = arg_282_1:FormatText(StoryNameCfg[205].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_282_1.leftNameTxt_.transform)

				arg_282_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_282_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_282_1:RecordName(arg_282_1.leftNameTxt_.text)
				SetActive(arg_282_1.iconTrs_.gameObject, false)
				arg_282_1.callingController_:SetSelectedState("normal")

				local var_285_8 = arg_282_1:FormatText(arg_282_1:GetWordFromCfg(939062067).content)

				arg_282_1.text_.text = var_285_8

				LuaForUtil.ClearLinePrefixSymbol(arg_282_1.text_)

				local var_285_10 = 25 <= 0 and var_285_7 or var_285_7 * (utf8.len(var_285_8) / 25)

				if (25 <= 0 and var_285_7 or var_285_7 * (utf8.len(var_285_8) / 25)) > 0 and var_285_7 < var_285_10 then
					arg_282_1.talkMaxDuration = var_285_10

					if var_285_10 + var_285_6 > arg_282_1.duration_ then
						arg_282_1.duration_ = var_285_10 + var_285_6
					end
				end

				arg_282_1.text_.text = var_285_8
				arg_282_1.typewritter.percent = 0

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(false)
				arg_282_1:RecordContent(arg_282_1.text_.text)
			end

			local var_285_11 = math.max(var_285_7, arg_282_1.talkMaxDuration)

			if var_285_6 <= arg_282_1.time_ and arg_282_1.time_ < var_285_6 + var_285_11 then
				arg_282_1.typewritter.percent = (arg_282_1.time_ - var_285_6) / var_285_11

				arg_282_1.typewritter:SetDirty()
			end

			if arg_282_1.time_ >= var_285_6 + var_285_11 and arg_282_1.time_ < var_285_6 + var_285_11 + arg_285_0 then
				arg_282_1.typewritter.percent = 1

				arg_282_1.typewritter:SetDirty()
				arg_282_1:ShowNextGo(true)
			end
		end

		arg_282_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_282_1:InitPlayNodeList()
	end,
	Play939062068 = function(arg_286_0, arg_286_1)
		arg_286_1.time_ = 0
		arg_286_1.frameCnt_ = 0
		arg_286_1.state_ = "playing"
		arg_286_1.curTalkId_ = 939062068
		arg_286_1.duration_ = 5

		SetActive(arg_286_1.tipsGo_, false)

		function arg_286_1.onSingleLineFinish_()
			arg_286_1.onSingleLineUpdate_ = nil
			arg_286_1.onSingleLineFinish_ = nil
			arg_286_1.state_ = "waiting"
		end

		function arg_286_1.playNext_(arg_288_0)
			if arg_288_0 == 1 then
				arg_286_0:Play939062069(arg_286_1)
			end
		end

		function arg_286_1.onSingleLineUpdate_(arg_289_0)
			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos1054ui_story = arg_286_1.actors_["1054ui_story"].transform.localPosition

				local var_289_0 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_0 then
					var_289_0:EnableDynamicBone(false)
				end
			end

			local var_289_1 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_1 then
				arg_286_1.actors_["1054ui_story"].transform.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos1054ui_story, Vector3.New(-0.7, -0.985, -6), (arg_286_1.time_ - 0) / var_289_1)
				arg_286_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1054ui_story"].transform.position).z)
				arg_286_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1054ui_story"].transform.localEulerAngles = arg_286_1.actors_["1054ui_story"].transform.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_1 and arg_286_1.time_ < 0 + var_289_1 + arg_289_0 then
				arg_286_1.actors_["1054ui_story"].transform.localPosition = Vector3.New(-0.7, -0.985, -6)
				arg_286_1.actors_["1054ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_286_1.actors_["1054ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1054ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_286_1.actors_["1054ui_story"].transform.position).z)
				arg_286_1.actors_["1054ui_story"].transform.localEulerAngles.z = 0
				arg_286_1.actors_["1054ui_story"].transform.localEulerAngles.x = 0
				arg_286_1.actors_["1054ui_story"].transform.localEulerAngles = arg_286_1.actors_["1054ui_story"].transform.localEulerAngles

				local var_289_2 = GameObjectTools.GetOrAddComponent(arg_286_1.actors_["1054ui_story"].transform.gameObject, typeof(DynamicBoneHelper))

				if var_289_2 then
					var_289_2:EnableDynamicBone(true)
				end
			end

			local var_289_3 = arg_286_1.actors_["6148ui_story"].transform

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1.var_.moveOldPos6148ui_story = var_289_3.localPosition

				local var_289_4 = GameObjectTools.GetOrAddComponent(var_289_3.gameObject, typeof(DynamicBoneHelper))

				if var_289_4 then
					var_289_4:EnableDynamicBone(false)
				end
			end

			local var_289_5 = 0.001

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_5 then
				var_289_3.localPosition = Vector3.Lerp(arg_286_1.var_.moveOldPos6148ui_story, Vector3.New(0, 100, 0), (arg_286_1.time_ - 0) / var_289_5)
				var_289_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_3.position).x, (manager.ui.mainCamera.transform.position - var_289_3.position).y, (manager.ui.mainCamera.transform.position - var_289_3.position).z)
				var_289_3.localEulerAngles.z = 0
				var_289_3.localEulerAngles.x = 0
				var_289_3.localEulerAngles = var_289_3.localEulerAngles
			end

			if arg_286_1.time_ >= 0 + var_289_5 and arg_286_1.time_ < 0 + var_289_5 + arg_289_0 then
				var_289_3.localPosition = Vector3.New(0, 100, 0)
				var_289_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_289_3.position).x, (manager.ui.mainCamera.transform.position - var_289_3.position).y, (manager.ui.mainCamera.transform.position - var_289_3.position).z)
				var_289_3.localEulerAngles.z = 0
				var_289_3.localEulerAngles.x = 0
				var_289_3.localEulerAngles = var_289_3.localEulerAngles

				local var_289_6 = GameObjectTools.GetOrAddComponent(var_289_3.gameObject, typeof(DynamicBoneHelper))

				if var_289_6 then
					var_289_6:EnableDynamicBone(true)
				end
			end

			local var_289_7 = arg_286_1.actors_["1054ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_7) and arg_286_1.var_.characterEffect1054ui_story == nil then
				arg_286_1.var_.characterEffect1054ui_story = var_289_7:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_8 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_8 and not isNil(var_289_7) then
				if arg_286_1.var_.characterEffect1054ui_story and not isNil(var_289_7) then
					arg_286_1.var_.characterEffect1054ui_story.fillFlat = false
				end
			end

			if arg_286_1.time_ >= 0 + var_289_8 and arg_286_1.time_ < 0 + var_289_8 + arg_289_0 and not isNil(var_289_7) and arg_286_1.var_.characterEffect1054ui_story then
				arg_286_1.var_.characterEffect1054ui_story.fillFlat = false
			end

			local var_289_10 = arg_286_1.actors_["1042ui_story"]

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 and not isNil(var_289_10) and arg_286_1.var_.characterEffect1042ui_story == nil then
				arg_286_1.var_.characterEffect1042ui_story = var_289_10:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_289_11 = 0.200000002980232

			if 0 <= arg_286_1.time_ and arg_286_1.time_ < 0 + var_289_11 and not isNil(var_289_10) then
				if arg_286_1.var_.characterEffect1042ui_story and not isNil(var_289_10) then
					arg_286_1.var_.characterEffect1042ui_story.fillFlat = true
					arg_286_1.var_.characterEffect1042ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_286_1.time_ - 0) / var_289_11)
				end
			end

			if arg_286_1.time_ >= 0 + var_289_11 and arg_286_1.time_ < 0 + var_289_11 + arg_289_0 and not isNil(var_289_10) and arg_286_1.var_.characterEffect1042ui_story then
				arg_286_1.var_.characterEffect1042ui_story.fillFlat = true
				arg_286_1.var_.characterEffect1042ui_story.fillRatio = 0.5
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/story1054/story1054action/1054action3_1")
			end

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= 0 + arg_289_0 then
				arg_286_1:PlayTimeline("1054ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_289_12 = 0
			local var_289_13 = 0.15

			if 0 < arg_286_1.time_ and arg_286_1.time_ <= var_289_12 + arg_289_0 then
				arg_286_1.talkMaxDuration = 0
				arg_286_1.dialogCg_.alpha = 1

				arg_286_1.dialog_:SetActive(true)
				SetActive(arg_286_1.leftNameGo_, true)

				arg_286_1.leftNameTxt_.text = arg_286_1:FormatText(StoryNameCfg[1487].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_286_1.leftNameTxt_.transform)

				arg_286_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_286_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_286_1:RecordName(arg_286_1.leftNameTxt_.text)
				SetActive(arg_286_1.iconTrs_.gameObject, false)
				arg_286_1.callingController_:SetSelectedState("normal")

				local var_289_14 = arg_286_1:FormatText(arg_286_1:GetWordFromCfg(939062068).content)

				arg_286_1.text_.text = var_289_14

				LuaForUtil.ClearLinePrefixSymbol(arg_286_1.text_)

				local var_289_16 = 6 <= 0 and var_289_13 or var_289_13 * (utf8.len(var_289_14) / 6)

				if (6 <= 0 and var_289_13 or var_289_13 * (utf8.len(var_289_14) / 6)) > 0 and var_289_13 < var_289_16 then
					arg_286_1.talkMaxDuration = var_289_16

					if var_289_16 + var_289_12 > arg_286_1.duration_ then
						arg_286_1.duration_ = var_289_16 + var_289_12
					end
				end

				arg_286_1.text_.text = var_289_14
				arg_286_1.typewritter.percent = 0

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(false)
				arg_286_1:RecordContent(arg_286_1.text_.text)
			end

			local var_289_17 = math.max(var_289_13, arg_286_1.talkMaxDuration)

			if var_289_12 <= arg_286_1.time_ and arg_286_1.time_ < var_289_12 + var_289_17 then
				arg_286_1.typewritter.percent = (arg_286_1.time_ - var_289_12) / var_289_17

				arg_286_1.typewritter:SetDirty()
			end

			if arg_286_1.time_ >= var_289_12 + var_289_17 and arg_286_1.time_ < var_289_12 + var_289_17 + arg_289_0 then
				arg_286_1.typewritter.percent = 1

				arg_286_1.typewritter:SetDirty()
				arg_286_1:ShowNextGo(true)
			end
		end

		arg_286_1.nodeConfigList_ = {
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
				actorName = "6148ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_286_1:InitPlayNodeList()
	end,
	Play939062069 = function(arg_290_0, arg_290_1)
		arg_290_1.time_ = 0
		arg_290_1.frameCnt_ = 0
		arg_290_1.state_ = "playing"
		arg_290_1.curTalkId_ = 939062069
		arg_290_1.duration_ = 5

		SetActive(arg_290_1.tipsGo_, false)

		function arg_290_1.onSingleLineFinish_()
			arg_290_1.onSingleLineUpdate_ = nil
			arg_290_1.onSingleLineFinish_ = nil
			arg_290_1.state_ = "waiting"
		end

		function arg_290_1.playNext_(arg_292_0)
			if arg_292_0 == 1 then
				arg_290_0:Play939062070(arg_290_1)
			end
		end

		function arg_290_1.onSingleLineUpdate_(arg_293_0)
			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1248ui_story = arg_290_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_293_0 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_0 then
				arg_290_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1248ui_story, Vector3.New(0.7, -0.775, -6.18), (arg_290_1.time_ - 0) / var_293_0)
				arg_290_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1248ui_story"].transform.position).z)
				arg_290_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1248ui_story"].transform.localEulerAngles = arg_290_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_0 and arg_290_1.time_ < 0 + var_293_0 + arg_293_0 then
				arg_290_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0.7, -0.775, -6.18)
				arg_290_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_290_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_290_1.actors_["1248ui_story"].transform.position).z)
				arg_290_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_290_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_290_1.actors_["1248ui_story"].transform.localEulerAngles = arg_290_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_293_1 = arg_290_1.actors_["1042ui_story"].transform

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1.var_.moveOldPos1042ui_story = var_293_1.localPosition
			end

			local var_293_2 = 0.001

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_2 then
				var_293_1.localPosition = Vector3.Lerp(arg_290_1.var_.moveOldPos1042ui_story, Vector3.New(0, 100, 0), (arg_290_1.time_ - 0) / var_293_2)
				var_293_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_1.position).x, (manager.ui.mainCamera.transform.position - var_293_1.position).y, (manager.ui.mainCamera.transform.position - var_293_1.position).z)
				var_293_1.localEulerAngles.z = 0
				var_293_1.localEulerAngles.x = 0
				var_293_1.localEulerAngles = var_293_1.localEulerAngles
			end

			if arg_290_1.time_ >= 0 + var_293_2 and arg_290_1.time_ < 0 + var_293_2 + arg_293_0 then
				var_293_1.localPosition = Vector3.New(0, 100, 0)
				var_293_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_293_1.position).x, (manager.ui.mainCamera.transform.position - var_293_1.position).y, (manager.ui.mainCamera.transform.position - var_293_1.position).z)
				var_293_1.localEulerAngles.z = 0
				var_293_1.localEulerAngles.x = 0
				var_293_1.localEulerAngles = var_293_1.localEulerAngles
			end

			local var_293_3 = arg_290_1.actors_["1248ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_3) and arg_290_1.var_.characterEffect1248ui_story == nil then
				arg_290_1.var_.characterEffect1248ui_story = var_293_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_4 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_4 and not isNil(var_293_3) then
				if arg_290_1.var_.characterEffect1248ui_story and not isNil(var_293_3) then
					arg_290_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_290_1.time_ >= 0 + var_293_4 and arg_290_1.time_ < 0 + var_293_4 + arg_293_0 and not isNil(var_293_3) and arg_290_1.var_.characterEffect1248ui_story then
				arg_290_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			local var_293_6 = arg_290_1.actors_["1054ui_story"]

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 and not isNil(var_293_6) and arg_290_1.var_.characterEffect1054ui_story == nil then
				arg_290_1.var_.characterEffect1054ui_story = var_293_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_293_7 = 0.200000002980232

			if 0 <= arg_290_1.time_ and arg_290_1.time_ < 0 + var_293_7 and not isNil(var_293_6) then
				if arg_290_1.var_.characterEffect1054ui_story and not isNil(var_293_6) then
					arg_290_1.var_.characterEffect1054ui_story.fillFlat = true
					arg_290_1.var_.characterEffect1054ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_290_1.time_ - 0) / var_293_7)
				end
			end

			if arg_290_1.time_ >= 0 + var_293_7 and arg_290_1.time_ < 0 + var_293_7 + arg_293_0 and not isNil(var_293_6) and arg_290_1.var_.characterEffect1054ui_story then
				arg_290_1.var_.characterEffect1054ui_story.fillFlat = true
				arg_290_1.var_.characterEffect1054ui_story.fillRatio = 0.5
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_1")
			end

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= 0 + arg_293_0 then
				arg_290_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_293_8 = 0
			local var_293_9 = 0.625

			if 0 < arg_290_1.time_ and arg_290_1.time_ <= var_293_8 + arg_293_0 then
				arg_290_1.talkMaxDuration = 0
				arg_290_1.dialogCg_.alpha = 1

				arg_290_1.dialog_:SetActive(true)
				SetActive(arg_290_1.leftNameGo_, true)

				arg_290_1.leftNameTxt_.text = arg_290_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_290_1.leftNameTxt_.transform)

				arg_290_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_290_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_290_1:RecordName(arg_290_1.leftNameTxt_.text)
				SetActive(arg_290_1.iconTrs_.gameObject, false)
				arg_290_1.callingController_:SetSelectedState("normal")

				local var_293_10 = arg_290_1:FormatText(arg_290_1:GetWordFromCfg(939062069).content)

				arg_290_1.text_.text = var_293_10

				LuaForUtil.ClearLinePrefixSymbol(arg_290_1.text_)

				local var_293_12 = 25 <= 0 and var_293_9 or var_293_9 * (utf8.len(var_293_10) / 25)

				if (25 <= 0 and var_293_9 or var_293_9 * (utf8.len(var_293_10) / 25)) > 0 and var_293_9 < var_293_12 then
					arg_290_1.talkMaxDuration = var_293_12

					if var_293_12 + var_293_8 > arg_290_1.duration_ then
						arg_290_1.duration_ = var_293_12 + var_293_8
					end
				end

				arg_290_1.text_.text = var_293_10
				arg_290_1.typewritter.percent = 0

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(false)
				arg_290_1:RecordContent(arg_290_1.text_.text)
			end

			local var_293_13 = math.max(var_293_9, arg_290_1.talkMaxDuration)

			if var_293_8 <= arg_290_1.time_ and arg_290_1.time_ < var_293_8 + var_293_13 then
				arg_290_1.typewritter.percent = (arg_290_1.time_ - var_293_8) / var_293_13

				arg_290_1.typewritter:SetDirty()
			end

			if arg_290_1.time_ >= var_293_8 + var_293_13 and arg_290_1.time_ < var_293_8 + var_293_13 + arg_293_0 then
				arg_290_1.typewritter.percent = 1

				arg_290_1.typewritter:SetDirty()
				arg_290_1:ShowNextGo(true)
			end
		end

		arg_290_1.nodeConfigList_ = {
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
				actorName = "1042ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_290_1:InitPlayNodeList()
	end,
	Play939062070 = function(arg_294_0, arg_294_1)
		arg_294_1.time_ = 0
		arg_294_1.frameCnt_ = 0
		arg_294_1.state_ = "playing"
		arg_294_1.curTalkId_ = 939062070
		arg_294_1.duration_ = 5

		SetActive(arg_294_1.tipsGo_, false)

		function arg_294_1.onSingleLineFinish_()
			arg_294_1.onSingleLineUpdate_ = nil
			arg_294_1.onSingleLineFinish_ = nil
			arg_294_1.state_ = "waiting"
		end

		function arg_294_1.playNext_(arg_296_0)
			if arg_296_0 == 1 then
				arg_294_0:Play939062071(arg_294_1)
			end
		end

		function arg_294_1.onSingleLineUpdate_(arg_297_0)
			if 0 < arg_294_1.time_ and arg_294_1.time_ <= 0 + arg_297_0 and not isNil(arg_294_1.actors_["1248ui_story"]) and arg_294_1.var_.characterEffect1248ui_story == nil then
				arg_294_1.var_.characterEffect1248ui_story = arg_294_1.actors_["1248ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_297_0 = 0.200000002980232

			if 0 <= arg_294_1.time_ and arg_294_1.time_ < 0 + var_297_0 and not isNil(arg_294_1.actors_["1248ui_story"]) then
				if arg_294_1.var_.characterEffect1248ui_story and not isNil(arg_294_1.actors_["1248ui_story"]) then
					arg_294_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_294_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_294_1.time_ - 0) / var_297_0)
				end
			end

			if arg_294_1.time_ >= 0 + var_297_0 and arg_294_1.time_ < 0 + var_297_0 + arg_297_0 and not isNil(arg_294_1.actors_["1248ui_story"]) and arg_294_1.var_.characterEffect1248ui_story then
				arg_294_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_294_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			local var_297_1 = 0
			local var_297_2 = 0.425

			if 0 < arg_294_1.time_ and arg_294_1.time_ <= var_297_1 + arg_297_0 then
				arg_294_1.talkMaxDuration = 0
				arg_294_1.dialogCg_.alpha = 1

				arg_294_1.dialog_:SetActive(true)
				SetActive(arg_294_1.leftNameGo_, true)

				arg_294_1.leftNameTxt_.text = arg_294_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_294_1.leftNameTxt_.transform)

				arg_294_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_294_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_294_1:RecordName(arg_294_1.leftNameTxt_.text)
				SetActive(arg_294_1.iconTrs_.gameObject, true)
				arg_294_1.iconController_:SetSelectedState("hero")

				arg_294_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_294_1.callingController_:SetSelectedState("normal")

				arg_294_1.keyicon_.color = Color.New(1, 1, 1)
				arg_294_1.icon_.color = Color.New(1, 1, 1)

				local var_297_3 = arg_294_1:FormatText(arg_294_1:GetWordFromCfg(939062070).content)

				arg_294_1.text_.text = var_297_3

				LuaForUtil.ClearLinePrefixSymbol(arg_294_1.text_)

				local var_297_5 = 17 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 17)

				if (17 <= 0 and var_297_2 or var_297_2 * (utf8.len(var_297_3) / 17)) > 0 and var_297_2 < var_297_5 then
					arg_294_1.talkMaxDuration = var_297_5

					if var_297_5 + var_297_1 > arg_294_1.duration_ then
						arg_294_1.duration_ = var_297_5 + var_297_1
					end
				end

				arg_294_1.text_.text = var_297_3
				arg_294_1.typewritter.percent = 0

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(false)
				arg_294_1:RecordContent(arg_294_1.text_.text)
			end

			local var_297_6 = math.max(var_297_2, arg_294_1.talkMaxDuration)

			if var_297_1 <= arg_294_1.time_ and arg_294_1.time_ < var_297_1 + var_297_6 then
				arg_294_1.typewritter.percent = (arg_294_1.time_ - var_297_1) / var_297_6

				arg_294_1.typewritter:SetDirty()
			end

			if arg_294_1.time_ >= var_297_1 + var_297_6 and arg_294_1.time_ < var_297_1 + var_297_6 + arg_297_0 then
				arg_294_1.typewritter.percent = 1

				arg_294_1.typewritter:SetDirty()
				arg_294_1:ShowNextGo(true)
			end
		end

		arg_294_1.nodeConfigList_ = {}

		arg_294_1:InitPlayNodeList()
	end,
	Play939062071 = function(arg_298_0, arg_298_1)
		arg_298_1.time_ = 0
		arg_298_1.frameCnt_ = 0
		arg_298_1.state_ = "playing"
		arg_298_1.curTalkId_ = 939062071
		arg_298_1.duration_ = 5

		SetActive(arg_298_1.tipsGo_, false)

		function arg_298_1.onSingleLineFinish_()
			arg_298_1.onSingleLineUpdate_ = nil
			arg_298_1.onSingleLineFinish_ = nil
			arg_298_1.state_ = "waiting"
		end

		function arg_298_1.playNext_(arg_300_0)
			if arg_300_0 == 1 then
				arg_298_0:Play939062072(arg_298_1)
			end
		end

		function arg_298_1.onSingleLineUpdate_(arg_301_0)
			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1.var_.moveOldPos1248ui_story = arg_298_1.actors_["1248ui_story"].transform.localPosition
			end

			local var_301_0 = 0.001

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_0 then
				arg_298_1.actors_["1248ui_story"].transform.localPosition = Vector3.Lerp(arg_298_1.var_.moveOldPos1248ui_story, Vector3.New(0.7, -0.775, -6.18), (arg_298_1.time_ - 0) / var_301_0)
				arg_298_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1248ui_story"].transform.position).z)
				arg_298_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1248ui_story"].transform.localEulerAngles = arg_298_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			if arg_298_1.time_ >= 0 + var_301_0 and arg_298_1.time_ < 0 + var_301_0 + arg_301_0 then
				arg_298_1.actors_["1248ui_story"].transform.localPosition = Vector3.New(0.7, -0.775, -6.18)
				arg_298_1.actors_["1248ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_298_1.actors_["1248ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1248ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_298_1.actors_["1248ui_story"].transform.position).z)
				arg_298_1.actors_["1248ui_story"].transform.localEulerAngles.z = 0
				arg_298_1.actors_["1248ui_story"].transform.localEulerAngles.x = 0
				arg_298_1.actors_["1248ui_story"].transform.localEulerAngles = arg_298_1.actors_["1248ui_story"].transform.localEulerAngles
			end

			local var_301_1 = arg_298_1.actors_["1248ui_story"]

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect1248ui_story == nil then
				arg_298_1.var_.characterEffect1248ui_story = var_301_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_301_2 = 0.200000002980232

			if 0 <= arg_298_1.time_ and arg_298_1.time_ < 0 + var_301_2 and not isNil(var_301_1) then
				if arg_298_1.var_.characterEffect1248ui_story and not isNil(var_301_1) then
					arg_298_1.var_.characterEffect1248ui_story.fillFlat = false
				end
			end

			if arg_298_1.time_ >= 0 + var_301_2 and arg_298_1.time_ < 0 + var_301_2 + arg_301_0 and not isNil(var_301_1) and arg_298_1.var_.characterEffect1248ui_story then
				arg_298_1.var_.characterEffect1248ui_story.fillFlat = false
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/story1248/story1248action/1248action7_2")
			end

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= 0 + arg_301_0 then
				arg_298_1:PlayTimeline("1248ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_301_4 = 0
			local var_301_5 = 1.475

			if 0 < arg_298_1.time_ and arg_298_1.time_ <= var_301_4 + arg_301_0 then
				arg_298_1.talkMaxDuration = 0
				arg_298_1.dialogCg_.alpha = 1

				arg_298_1.dialog_:SetActive(true)
				SetActive(arg_298_1.leftNameGo_, true)

				arg_298_1.leftNameTxt_.text = arg_298_1:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_298_1.leftNameTxt_.transform)

				arg_298_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_298_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_298_1:RecordName(arg_298_1.leftNameTxt_.text)
				SetActive(arg_298_1.iconTrs_.gameObject, false)
				arg_298_1.callingController_:SetSelectedState("normal")

				local var_301_6 = arg_298_1:FormatText(arg_298_1:GetWordFromCfg(939062071).content)

				arg_298_1.text_.text = var_301_6

				LuaForUtil.ClearLinePrefixSymbol(arg_298_1.text_)

				local var_301_8 = 59 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_6) / 59)

				if (59 <= 0 and var_301_5 or var_301_5 * (utf8.len(var_301_6) / 59)) > 0 and var_301_5 < var_301_8 then
					arg_298_1.talkMaxDuration = var_301_8

					if var_301_8 + var_301_4 > arg_298_1.duration_ then
						arg_298_1.duration_ = var_301_8 + var_301_4
					end
				end

				arg_298_1.text_.text = var_301_6
				arg_298_1.typewritter.percent = 0

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(false)
				arg_298_1:RecordContent(arg_298_1.text_.text)
			end

			local var_301_9 = math.max(var_301_5, arg_298_1.talkMaxDuration)

			if var_301_4 <= arg_298_1.time_ and arg_298_1.time_ < var_301_4 + var_301_9 then
				arg_298_1.typewritter.percent = (arg_298_1.time_ - var_301_4) / var_301_9

				arg_298_1.typewritter:SetDirty()
			end

			if arg_298_1.time_ >= var_301_4 + var_301_9 and arg_298_1.time_ < var_301_4 + var_301_9 + arg_301_0 then
				arg_298_1.typewritter.percent = 1

				arg_298_1.typewritter:SetDirty()
				arg_298_1:ShowNextGo(true)
			end
		end

		arg_298_1.nodeConfigList_ = {
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

		arg_298_1:InitPlayNodeList()
	end,
	Play939062072 = function(arg_302_0, arg_302_1)
		arg_302_1.time_ = 0
		arg_302_1.frameCnt_ = 0
		arg_302_1.state_ = "playing"
		arg_302_1.curTalkId_ = 939062072
		arg_302_1.duration_ = 5

		SetActive(arg_302_1.tipsGo_, false)

		function arg_302_1.onSingleLineFinish_()
			arg_302_1.onSingleLineUpdate_ = nil
			arg_302_1.onSingleLineFinish_ = nil
			arg_302_1.state_ = "waiting"
		end

		function arg_302_1.playNext_(arg_304_0)
			if arg_304_0 == 1 then
				arg_302_0:Play939062073(arg_302_1)
			end
		end

		function arg_302_1.onSingleLineUpdate_(arg_305_0)
			if arg_302_1.actors_["1081ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1081ui_story"))) then
				local var_305_0 = Object.Instantiate(Asset.Load("Char/" .. "1081ui_story"), arg_302_1.stage_.transform)

				var_305_0.name = "1081ui_story"
				var_305_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_302_1.actors_["1081ui_story"] = var_305_0

				local var_305_1 = var_305_0:GetComponentInChildren(typeof(CharacterEffect))

				var_305_1.enabled = true

				local var_305_2 = GameObjectTools.GetOrAddComponent(var_305_0, typeof(DynamicBoneHelper))

				if var_305_2 then
					var_305_2:EnableDynamicBone(false)
				end

				arg_302_1:ShowWeapon(var_305_1.transform, false)

				arg_302_1.var_["1081ui_story" .. "Animator"] = var_305_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_302_1.var_["1081ui_story" .. "Animator"].applyRootMotion = true
				arg_302_1.var_["1081ui_story" .. "LipSync"] = var_305_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_305_3 = arg_302_1.actors_["1081ui_story"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1081ui_story = var_305_3.localPosition
			end

			local var_305_4 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_4 then
				var_305_3.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1081ui_story, Vector3.New(0, -0.92, -5.8), (arg_302_1.time_ - 0) / var_305_4)
				var_305_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_3.position).x, (manager.ui.mainCamera.transform.position - var_305_3.position).y, (manager.ui.mainCamera.transform.position - var_305_3.position).z)
				var_305_3.localEulerAngles.z = 0
				var_305_3.localEulerAngles.x = 0
				var_305_3.localEulerAngles = var_305_3.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_4 and arg_302_1.time_ < 0 + var_305_4 + arg_305_0 then
				var_305_3.localPosition = Vector3.New(0, -0.92, -5.8)
				var_305_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_3.position).x, (manager.ui.mainCamera.transform.position - var_305_3.position).y, (manager.ui.mainCamera.transform.position - var_305_3.position).z)
				var_305_3.localEulerAngles.z = 0
				var_305_3.localEulerAngles.x = 0
				var_305_3.localEulerAngles = var_305_3.localEulerAngles
			end

			local var_305_5 = arg_302_1.actors_["1248ui_story"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1248ui_story = var_305_5.localPosition
			end

			local var_305_6 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_6 then
				var_305_5.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1248ui_story, Vector3.New(0, 100, 0), (arg_302_1.time_ - 0) / var_305_6)
				var_305_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_5.position).x, (manager.ui.mainCamera.transform.position - var_305_5.position).y, (manager.ui.mainCamera.transform.position - var_305_5.position).z)
				var_305_5.localEulerAngles.z = 0
				var_305_5.localEulerAngles.x = 0
				var_305_5.localEulerAngles = var_305_5.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_6 and arg_302_1.time_ < 0 + var_305_6 + arg_305_0 then
				var_305_5.localPosition = Vector3.New(0, 100, 0)
				var_305_5.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_5.position).x, (manager.ui.mainCamera.transform.position - var_305_5.position).y, (manager.ui.mainCamera.transform.position - var_305_5.position).z)
				var_305_5.localEulerAngles.z = 0
				var_305_5.localEulerAngles.x = 0
				var_305_5.localEulerAngles = var_305_5.localEulerAngles
			end

			local var_305_7 = arg_302_1.actors_["1054ui_story"].transform

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1.var_.moveOldPos1054ui_story = var_305_7.localPosition

				local var_305_8 = GameObjectTools.GetOrAddComponent(var_305_7.gameObject, typeof(DynamicBoneHelper))

				if var_305_8 then
					var_305_8:EnableDynamicBone(false)
				end
			end

			local var_305_9 = 0.001

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_9 then
				var_305_7.localPosition = Vector3.Lerp(arg_302_1.var_.moveOldPos1054ui_story, Vector3.New(0, 100, 0), (arg_302_1.time_ - 0) / var_305_9)
				var_305_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_7.position).x, (manager.ui.mainCamera.transform.position - var_305_7.position).y, (manager.ui.mainCamera.transform.position - var_305_7.position).z)
				var_305_7.localEulerAngles.z = 0
				var_305_7.localEulerAngles.x = 0
				var_305_7.localEulerAngles = var_305_7.localEulerAngles
			end

			if arg_302_1.time_ >= 0 + var_305_9 and arg_302_1.time_ < 0 + var_305_9 + arg_305_0 then
				var_305_7.localPosition = Vector3.New(0, 100, 0)
				var_305_7.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_305_7.position).x, (manager.ui.mainCamera.transform.position - var_305_7.position).y, (manager.ui.mainCamera.transform.position - var_305_7.position).z)
				var_305_7.localEulerAngles.z = 0
				var_305_7.localEulerAngles.x = 0
				var_305_7.localEulerAngles = var_305_7.localEulerAngles

				local var_305_10 = GameObjectTools.GetOrAddComponent(var_305_7.gameObject, typeof(DynamicBoneHelper))

				if var_305_10 then
					var_305_10:EnableDynamicBone(true)
				end
			end

			local var_305_11 = arg_302_1.actors_["1081ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_11) and arg_302_1.var_.characterEffect1081ui_story == nil then
				arg_302_1.var_.characterEffect1081ui_story = var_305_11:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_12 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_12 and not isNil(var_305_11) then
				if arg_302_1.var_.characterEffect1081ui_story and not isNil(var_305_11) then
					arg_302_1.var_.characterEffect1081ui_story.fillFlat = false
				end
			end

			if arg_302_1.time_ >= 0 + var_305_12 and arg_302_1.time_ < 0 + var_305_12 + arg_305_0 and not isNil(var_305_11) and arg_302_1.var_.characterEffect1081ui_story then
				arg_302_1.var_.characterEffect1081ui_story.fillFlat = false
			end

			local var_305_14 = arg_302_1.actors_["1248ui_story"]

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 and not isNil(var_305_14) and arg_302_1.var_.characterEffect1248ui_story == nil then
				arg_302_1.var_.characterEffect1248ui_story = var_305_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_305_15 = 0.200000002980232

			if 0 <= arg_302_1.time_ and arg_302_1.time_ < 0 + var_305_15 and not isNil(var_305_14) then
				if arg_302_1.var_.characterEffect1248ui_story and not isNil(var_305_14) then
					arg_302_1.var_.characterEffect1248ui_story.fillFlat = true
					arg_302_1.var_.characterEffect1248ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_302_1.time_ - 0) / var_305_15)
				end
			end

			if arg_302_1.time_ >= 0 + var_305_15 and arg_302_1.time_ < 0 + var_305_15 + arg_305_0 and not isNil(var_305_14) and arg_302_1.var_.characterEffect1248ui_story then
				arg_302_1.var_.characterEffect1248ui_story.fillFlat = true
				arg_302_1.var_.characterEffect1248ui_story.fillRatio = 0.5
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/story1081/story1081action/1081action2_1")
			end

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= 0 + arg_305_0 then
				arg_302_1:PlayTimeline("1081ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_305_16 = 0
			local var_305_17 = 1.275

			if 0 < arg_302_1.time_ and arg_302_1.time_ <= var_305_16 + arg_305_0 then
				arg_302_1.talkMaxDuration = 0
				arg_302_1.dialogCg_.alpha = 1

				arg_302_1.dialog_:SetActive(true)
				SetActive(arg_302_1.leftNameGo_, true)

				arg_302_1.leftNameTxt_.text = arg_302_1:FormatText(StoryNameCfg[202].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_302_1.leftNameTxt_.transform)

				arg_302_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_302_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_302_1:RecordName(arg_302_1.leftNameTxt_.text)
				SetActive(arg_302_1.iconTrs_.gameObject, false)
				arg_302_1.callingController_:SetSelectedState("normal")

				local var_305_18 = arg_302_1:FormatText(arg_302_1:GetWordFromCfg(939062072).content)

				arg_302_1.text_.text = var_305_18

				LuaForUtil.ClearLinePrefixSymbol(arg_302_1.text_)

				local var_305_20 = 51 <= 0 and var_305_17 or var_305_17 * (utf8.len(var_305_18) / 51)

				if (51 <= 0 and var_305_17 or var_305_17 * (utf8.len(var_305_18) / 51)) > 0 and var_305_17 < var_305_20 then
					arg_302_1.talkMaxDuration = var_305_20

					if var_305_20 + var_305_16 > arg_302_1.duration_ then
						arg_302_1.duration_ = var_305_20 + var_305_16
					end
				end

				arg_302_1.text_.text = var_305_18
				arg_302_1.typewritter.percent = 0

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(false)
				arg_302_1:RecordContent(arg_302_1.text_.text)
			end

			local var_305_21 = math.max(var_305_17, arg_302_1.talkMaxDuration)

			if var_305_16 <= arg_302_1.time_ and arg_302_1.time_ < var_305_16 + var_305_21 then
				arg_302_1.typewritter.percent = (arg_302_1.time_ - var_305_16) / var_305_21

				arg_302_1.typewritter:SetDirty()
			end

			if arg_302_1.time_ >= var_305_16 + var_305_21 and arg_302_1.time_ < var_305_16 + var_305_21 + arg_305_0 then
				arg_302_1.typewritter.percent = 1

				arg_302_1.typewritter:SetDirty()
				arg_302_1:ShowNextGo(true)
			end
		end

		arg_302_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1081ui_story",
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

		arg_302_1:InitPlayNodeList()
	end,
	Play939062073 = function(arg_306_0, arg_306_1)
		arg_306_1.time_ = 0
		arg_306_1.frameCnt_ = 0
		arg_306_1.state_ = "playing"
		arg_306_1.curTalkId_ = 939062073
		arg_306_1.duration_ = 5

		SetActive(arg_306_1.tipsGo_, false)

		function arg_306_1.onSingleLineFinish_()
			arg_306_1.onSingleLineUpdate_ = nil
			arg_306_1.onSingleLineFinish_ = nil
			arg_306_1.state_ = "waiting"
			arg_306_1.auto_ = false
		end

		function arg_306_1.playNext_(arg_308_0)
			arg_306_1.onStoryFinished_()
		end

		function arg_306_1.onSingleLineUpdate_(arg_309_0)
			if 0 < arg_306_1.time_ and arg_306_1.time_ <= 0 + arg_309_0 and not isNil(arg_306_1.actors_["1081ui_story"]) and arg_306_1.var_.characterEffect1081ui_story == nil then
				arg_306_1.var_.characterEffect1081ui_story = arg_306_1.actors_["1081ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_309_0 = 0.200000002980232

			if 0 <= arg_306_1.time_ and arg_306_1.time_ < 0 + var_309_0 and not isNil(arg_306_1.actors_["1081ui_story"]) then
				if arg_306_1.var_.characterEffect1081ui_story and not isNil(arg_306_1.actors_["1081ui_story"]) then
					arg_306_1.var_.characterEffect1081ui_story.fillFlat = true
					arg_306_1.var_.characterEffect1081ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_306_1.time_ - 0) / var_309_0)
				end
			end

			if arg_306_1.time_ >= 0 + var_309_0 and arg_306_1.time_ < 0 + var_309_0 + arg_309_0 and not isNil(arg_306_1.actors_["1081ui_story"]) and arg_306_1.var_.characterEffect1081ui_story then
				arg_306_1.var_.characterEffect1081ui_story.fillFlat = true
				arg_306_1.var_.characterEffect1081ui_story.fillRatio = 0.5
			end

			local var_309_1 = 0
			local var_309_2 = 0.4

			if 0 < arg_306_1.time_ and arg_306_1.time_ <= var_309_1 + arg_309_0 then
				arg_306_1.talkMaxDuration = 0
				arg_306_1.dialogCg_.alpha = 1

				arg_306_1.dialog_:SetActive(true)
				SetActive(arg_306_1.leftNameGo_, true)

				arg_306_1.leftNameTxt_.text = arg_306_1:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_306_1.leftNameTxt_.transform)

				arg_306_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_306_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_306_1:RecordName(arg_306_1.leftNameTxt_.text)
				SetActive(arg_306_1.iconTrs_.gameObject, true)
				arg_306_1.iconController_:SetSelectedState("hero")

				arg_306_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_admin01")

				arg_306_1.callingController_:SetSelectedState("normal")

				arg_306_1.keyicon_.color = Color.New(1, 1, 1)
				arg_306_1.icon_.color = Color.New(1, 1, 1)

				local var_309_3 = arg_306_1:FormatText(arg_306_1:GetWordFromCfg(939062073).content)

				arg_306_1.text_.text = var_309_3

				LuaForUtil.ClearLinePrefixSymbol(arg_306_1.text_)

				local var_309_5 = 16 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 16)

				if (16 <= 0 and var_309_2 or var_309_2 * (utf8.len(var_309_3) / 16)) > 0 and var_309_2 < var_309_5 then
					arg_306_1.talkMaxDuration = var_309_5

					if var_309_5 + var_309_1 > arg_306_1.duration_ then
						arg_306_1.duration_ = var_309_5 + var_309_1
					end
				end

				arg_306_1.text_.text = var_309_3
				arg_306_1.typewritter.percent = 0

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(false)
				arg_306_1:RecordContent(arg_306_1.text_.text)
			end

			local var_309_6 = math.max(var_309_2, arg_306_1.talkMaxDuration)

			if var_309_1 <= arg_306_1.time_ and arg_306_1.time_ < var_309_1 + var_309_6 then
				arg_306_1.typewritter.percent = (arg_306_1.time_ - var_309_1) / var_309_6

				arg_306_1.typewritter:SetDirty()
			end

			if arg_306_1.time_ >= var_309_1 + var_309_6 and arg_306_1.time_ < var_309_1 + var_309_6 + arg_309_0 then
				arg_306_1.typewritter.percent = 1

				arg_306_1.typewritter:SetDirty()
				arg_306_1:ShowNextGo(true)
			end
		end

		arg_306_1.nodeConfigList_ = {}

		arg_306_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I06",
		"TextureConfig/Background/STblack",
		"TextureConfig/Background/ST12",
		"TextureConfig/Background/I03"
	},
	voices = {},
	skipMarkers = {
		939062016,
		939062021
	}
}
