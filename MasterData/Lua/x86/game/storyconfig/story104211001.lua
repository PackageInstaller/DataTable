return {
	Play421101001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 421101001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play421101002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if 2 < arg_1_1.time_ and arg_1_1.time_ <= 2 + arg_4_0 then
				arg_1_1.allBtn_.enabled = false
			end

			if arg_1_1.time_ >= 2 + 1.06666666666667 and arg_1_1.time_ < 2 + 1.06666666666667 + arg_4_0 then
				arg_1_1.allBtn_.enabled = true
			end

			local var_4_0 = "I23f"

			if arg_1_1.bgs_.I23f == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = arg_1_1.bgs_.I23f.transform

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1.var_.moveOldPosI23f = var_4_2.localPosition
			end

			local var_4_3 = 0.1

			if 0 <= arg_1_1.time_ and arg_1_1.time_ < 0 + var_4_3 then
				var_4_2.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosI23f, Vector3.New(0, 1, 10), (arg_1_1.time_ - 0) / var_4_3)
			end

			if arg_1_1.time_ >= 0 + var_4_3 and arg_1_1.time_ < 0 + var_4_3 + arg_4_0 then
				var_4_2.localPosition = Vector3.New(0, 1, 10)
			end

			local var_4_4 = arg_1_1.bgs_.I23f.transform

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1.var_.moveOldPosI23f = var_4_4.localPosition
			end

			local var_4_5 = 1.9

			if 0.1 <= arg_1_1.time_ and arg_1_1.time_ < 0.1 + var_4_5 then
				var_4_4.localPosition = Vector3.Lerp(arg_1_1.var_.moveOldPosI23f, Vector3.New(0, 1, 9), (arg_1_1.time_ - 0.1) / var_4_5)
			end

			if arg_1_1.time_ >= 0.1 + var_4_5 and arg_1_1.time_ < 0.1 + var_4_5 + arg_4_0 then
				var_4_4.localPosition = Vector3.New(0, 1, 9)
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_6 = arg_1_1.bgs_.I23f

				arg_1_1.bgs_.I23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_6.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_7 = var_4_6:GetComponent("SpriteRenderer")

				if var_4_7 and var_4_7.sprite then
					local var_4_8 = 2 * (var_4_6.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_6.transform.localScale = Vector3.New(var_4_8 / var_4_7.sprite.bounds.size.y < var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x and var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x or var_4_8 / var_4_7.sprite.bounds.size.y, var_4_8 / var_4_7.sprite.bounds.size.y < var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x and var_4_8 * manager.ui.mainCameraCom_.aspect / var_4_7.sprite.bounds.size.x or var_4_8 / var_4_7.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "I23f" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_9 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_9 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_10 = 2

			if var_4_9 <= arg_1_1.time_ and arg_1_1.time_ < var_4_9 + var_4_10 then
				local var_4_11 = Color.New(0, 0, 0)

				var_4_11.a = Mathf.Lerp(1, 0, (arg_1_1.time_ - var_4_9) / var_4_10)
				arg_1_1.mask_.color = var_4_11
			end

			if arg_1_1.time_ >= var_4_9 + var_4_10 and arg_1_1.time_ < var_4_9 + var_4_10 + arg_4_0 then
				local var_4_12 = Color.New(0, 0, 0)

				arg_1_1.mask_.enabled = false
				var_4_12.a = 0
				arg_1_1.mask_.color = var_4_12
			end

			if 0.1 < arg_1_1.time_ and arg_1_1.time_ <= 0.1 + arg_4_0 then
				arg_1_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_dark", "")
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

				local var_4_16 = manager.audio:GetAudioName("ui_battle", "ui_battle_stopbgm")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_16 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_16

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_16
						arg_1_1.bgmTxt2_.text = var_4_16
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

			if 0.433333333333333 < arg_1_1.time_ and arg_1_1.time_ <= 0.433333333333333 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_3_story_star", "bgm_activity_4_3_story_star", "bgm_activity_4_3_story_star.awb")

				local var_4_19 = manager.audio:GetAudioName("bgm_activity_4_3_story_star", "bgm_activity_4_3_story_star")

				if "" ~= "" then
					if arg_1_1.bgmTxt_.text ~= var_4_19 and arg_1_1.bgmTxt_.text ~= "" then
						if arg_1_1.bgmTxt2_.text ~= "" then
							arg_1_1.bgmTxt_.text = arg_1_1.bgmTxt2_.text
						end

						arg_1_1.bgmTxt2_.text = var_4_19

						arg_1_1.musicChangeAnimator_:Play("music_change", 0, 0)
					else
						arg_1_1.bgmTxt_.text = var_4_19
						arg_1_1.bgmTxt2_.text = var_4_19
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

			local var_4_20 = 2
			local var_4_21 = 1.65

			if 2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_20 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				arg_1_1.dialogCg_.alpha = 0

				local var_4_22 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_22:setOnUpdate(LuaHelper.FloatAction(function(arg_7_0)
					arg_1_1.dialogCg_.alpha = arg_7_0
				end))
				var_4_22:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_22:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_23 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(421101001).content)

				arg_1_1.text_.text = var_4_23

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_25 = 66 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 66)

				if (66 <= 0 and var_4_21 or var_4_21 * (utf8.len(var_4_23) / 66)) > 0 and var_4_21 < var_4_25 then
					arg_1_1.talkMaxDuration = var_4_25
					var_4_20 = var_4_20 + 0.3

					if var_4_25 + var_4_20 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_25 + var_4_20
					end
				end

				arg_1_1.text_.text = var_4_23
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_26 = var_4_20 + 0.3
			local var_4_27 = math.max(var_4_21, arg_1_1.talkMaxDuration)

			if var_4_20 + 0.3 <= arg_1_1.time_ and arg_1_1.time_ < var_4_26 + var_4_27 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_26) / var_4_27

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_26 + var_4_27 and arg_1_1.time_ < var_4_26 + var_4_27 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end

		arg_1_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "I23f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "I23f",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.9,
				className = "StoryMoveNode",
				startTime = 0.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_1_1:InitPlayNodeList()
	end,
	Play421101002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 421101002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play421101003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			if 0.1 < arg_9_1.time_ and arg_9_1.time_ <= 0.1 + arg_12_0 then
				arg_9_1:AudioAction("play", "effect", "se_story_143", "se_story_143_door04", "")
			end

			local var_12_1 = 0
			local var_12_2 = 1.125

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= var_12_1 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_3 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(421101002).content)

				arg_9_1.text_.text = var_12_3

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_5 = 45 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 45)

				if (45 <= 0 and var_12_2 or var_12_2 * (utf8.len(var_12_3) / 45)) > 0 and var_12_2 < var_12_5 then
					arg_9_1.talkMaxDuration = var_12_5

					if var_12_5 + var_12_1 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_5 + var_12_1
					end
				end

				arg_9_1.text_.text = var_12_3
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_6 = math.max(var_12_2, arg_9_1.talkMaxDuration)

			if var_12_1 <= arg_9_1.time_ and arg_9_1.time_ < var_12_1 + var_12_6 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - var_12_1) / var_12_6

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= var_12_1 + var_12_6 and arg_9_1.time_ < var_12_1 + var_12_6 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play421101003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 421101003
		arg_13_1.duration_ = 5.2

		local var_13_0 = {
			zh = 4.3,
			ja = 5.2
		}
		local var_13_1 = manager.audio:GetLocalizationFlag()

		if var_13_0[var_13_1] ~= nil then
			arg_13_1.duration_ = var_13_0[var_13_1]
		end

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play421101004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["10145ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10145ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "10145ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "10145ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["10145ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["10145ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["10145ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["10145ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["10145ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos10145ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -1, -6.2)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["10145ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10145ui_story == nil then
				arg_13_1.var_.characterEffect10145ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect10145ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect10145ui_story then
				arg_13_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action6_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.55

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:GetWordFromCfg(421101003)
				local var_16_11 = arg_13_1:FormatText(var_16_10.content)

				arg_13_1.text_.text = var_16_11

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_13 = 22 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 22)

				if (22 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_11) / 22)) > 0 and var_16_9 < var_16_13 then
					arg_13_1.talkMaxDuration = var_16_13

					if var_16_13 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_13 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_11
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101003", "story_v_out_421101.awb") ~= 0 then
					local var_16_14 = manager.audio:GetVoiceLength("story_v_out_421101", "421101003", "story_v_out_421101.awb") / 1000

					if var_16_14 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_14 + var_16_8
					end

					if var_16_10.prefab_name ~= "" and arg_13_1.actors_[var_16_10.prefab_name] ~= nil then
						local var_16_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_13_1.actors_[var_16_10.prefab_name].transform, "story_v_out_421101", "421101003", "story_v_out_421101.awb")

						arg_13_1:RecordAudio("421101003", var_16_15)
						arg_13_1:RecordAudio("421101003", var_16_15)
					else
						arg_13_1:AudioAction("play", "voice", "story_v_out_421101", "421101003", "story_v_out_421101.awb")
					end

					arg_13_1:RecordHistoryTalkVoice("story_v_out_421101", "421101003", "story_v_out_421101.awb")
				end

				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_16 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_16 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_16

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_16 and arg_13_1.time_ < var_16_8 + var_16_16 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421101004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 421101004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play421101005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos10145ui_story = arg_17_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).z)
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles = arg_17_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["10145ui_story"].transform.position).z)
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["10145ui_story"].transform.localEulerAngles = arg_17_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0.133333333333333 < arg_17_1.time_ and arg_17_1.time_ <= 0.133333333333333 + arg_20_0 then
				arg_17_1:AudioAction("play", "effect", "se_story_143", "se_story_143_magic", "")
			end

			local var_20_2 = 0
			local var_20_3 = 1.45

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_2 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_4 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(421101004).content)

				arg_17_1.text_.text = var_20_4

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_6 = 58 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 58)

				if (58 <= 0 and var_20_3 or var_20_3 * (utf8.len(var_20_4) / 58)) > 0 and var_20_3 < var_20_6 then
					arg_17_1.talkMaxDuration = var_20_6

					if var_20_6 + var_20_2 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_6 + var_20_2
					end
				end

				arg_17_1.text_.text = var_20_4
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_7 = math.max(var_20_3, arg_17_1.talkMaxDuration)

			if var_20_2 <= arg_17_1.time_ and arg_17_1.time_ < var_20_2 + var_20_7 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_2) / var_20_7

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_2 + var_20_7 and arg_17_1.time_ < var_20_2 + var_20_7 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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
	Play421101005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 421101005
		arg_21_1.duration_ = 5.07

		local var_21_0 = {
			zh = 2.7,
			ja = 5.066
		}
		local var_21_1 = manager.audio:GetLocalizationFlag()

		if var_21_0[var_21_1] ~= nil then
			arg_21_1.duration_ = var_21_0[var_21_1]
		end

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play421101006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if arg_21_1.actors_["1047ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1047ui_story"))) then
				local var_24_0 = Object.Instantiate(Asset.Load("Char/" .. "1047ui_story"), arg_21_1.stage_.transform)

				var_24_0.name = "1047ui_story"
				var_24_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_21_1.actors_["1047ui_story"] = var_24_0

				local var_24_1 = var_24_0:GetComponentInChildren(typeof(CharacterEffect))

				var_24_1.enabled = true

				local var_24_2 = GameObjectTools.GetOrAddComponent(var_24_0, typeof(DynamicBoneHelper))

				if var_24_2 then
					var_24_2:EnableDynamicBone(false)
				end

				arg_21_1:ShowWeapon(var_24_1.transform, false)

				arg_21_1.var_["1047ui_story" .. "Animator"] = var_24_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_21_1.var_["1047ui_story" .. "Animator"].applyRootMotion = true
				arg_21_1.var_["1047ui_story" .. "LipSync"] = var_24_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_24_3 = arg_21_1.actors_["1047ui_story"].transform

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1047ui_story = var_24_3.localPosition

				arg_21_1:ShowWeapon(arg_21_1.var_["1047ui_story" .. "Animator"].transform, false)
			end

			local var_24_4 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_4 then
				var_24_3.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_21_1.time_ - 0) / var_24_4)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_4 and arg_21_1.time_ < 0 + var_24_4 + arg_24_0 then
				var_24_3.localPosition = Vector3.New(0, -1.13, -6.2)
				var_24_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_24_3.position).x, (manager.ui.mainCamera.transform.position - var_24_3.position).y, (manager.ui.mainCamera.transform.position - var_24_3.position).z)
				var_24_3.localEulerAngles.z = 0
				var_24_3.localEulerAngles.x = 0
				var_24_3.localEulerAngles = var_24_3.localEulerAngles
			end

			local var_24_5 = arg_21_1.actors_["1047ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1047ui_story == nil then
				arg_21_1.var_.characterEffect1047ui_story = var_24_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_6 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_6 and not isNil(var_24_5) then
				if arg_21_1.var_.characterEffect1047ui_story and not isNil(var_24_5) then
					arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_6 and arg_21_1.time_ < 0 + var_24_6 + arg_24_0 and not isNil(var_24_5) and arg_21_1.var_.characterEffect1047ui_story then
				arg_21_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_24_8 = 0
			local var_24_9 = 0.275

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_8 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_10 = arg_21_1:GetWordFromCfg(421101005)
				local var_24_11 = arg_21_1:FormatText(var_24_10.content)

				arg_21_1.text_.text = var_24_11

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_13 = 11 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 11)

				if (11 <= 0 and var_24_9 or var_24_9 * (utf8.len(var_24_11) / 11)) > 0 and var_24_9 < var_24_13 then
					arg_21_1.talkMaxDuration = var_24_13

					if var_24_13 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_13 + var_24_8
					end
				end

				arg_21_1.text_.text = var_24_11
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101005", "story_v_out_421101.awb") ~= 0 then
					local var_24_14 = manager.audio:GetVoiceLength("story_v_out_421101", "421101005", "story_v_out_421101.awb") / 1000

					if var_24_14 + var_24_8 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_14 + var_24_8
					end

					if var_24_10.prefab_name ~= "" and arg_21_1.actors_[var_24_10.prefab_name] ~= nil then
						local var_24_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_21_1.actors_[var_24_10.prefab_name].transform, "story_v_out_421101", "421101005", "story_v_out_421101.awb")

						arg_21_1:RecordAudio("421101005", var_24_15)
						arg_21_1:RecordAudio("421101005", var_24_15)
					else
						arg_21_1:AudioAction("play", "voice", "story_v_out_421101", "421101005", "story_v_out_421101.awb")
					end

					arg_21_1:RecordHistoryTalkVoice("story_v_out_421101", "421101005", "story_v_out_421101.awb")
				end

				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_16 = math.max(var_24_9, arg_21_1.talkMaxDuration)

			if var_24_8 <= arg_21_1.time_ and arg_21_1.time_ < var_24_8 + var_24_16 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_8) / var_24_16

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_8 + var_24_16 and arg_21_1.time_ < var_24_8 + var_24_16 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
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

		arg_21_1:InitPlayNodeList()
	end,
	Play421101006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 421101006
		arg_25_1.duration_ = 2.1

		local var_25_0 = {
			zh = 1.999999999999,
			ja = 2.1
		}
		local var_25_1 = manager.audio:GetLocalizationFlag()

		if var_25_0[var_25_1] ~= nil then
			arg_25_1.duration_ = var_25_0[var_25_1]
		end

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play421101007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10145ui_story = arg_25_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_28_0 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_0 then
				arg_25_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_25_1.time_ - 0) / var_28_0)
				arg_25_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10145ui_story"].transform.position).z)
				arg_25_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10145ui_story"].transform.localEulerAngles = arg_25_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_0 and arg_25_1.time_ < 0 + var_28_0 + arg_28_0 then
				arg_25_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_25_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_25_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_25_1.actors_["10145ui_story"].transform.position).z)
				arg_25_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_25_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_25_1.actors_["10145ui_story"].transform.localEulerAngles = arg_25_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_28_1 = arg_25_1.actors_["1047ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos1047ui_story = var_28_1.localPosition
			end

			local var_28_2 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_2 then
				var_28_1.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_25_1.time_ - 0) / var_28_2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_2 and arg_25_1.time_ < 0 + var_28_2 + arg_28_0 then
				var_28_1.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				var_28_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_1.position).x, (manager.ui.mainCamera.transform.position - var_28_1.position).y, (manager.ui.mainCamera.transform.position - var_28_1.position).z)
				var_28_1.localEulerAngles.z = 0
				var_28_1.localEulerAngles.x = 0
				var_28_1.localEulerAngles = var_28_1.localEulerAngles
			end

			local var_28_3 = arg_25_1.actors_["10145ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect10145ui_story == nil then
				arg_25_1.var_.characterEffect10145ui_story = var_28_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_4 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 and not isNil(var_28_3) then
				if arg_25_1.var_.characterEffect10145ui_story and not isNil(var_28_3) then
					arg_25_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 and not isNil(var_28_3) and arg_25_1.var_.characterEffect10145ui_story then
				arg_25_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_28_6 = arg_25_1.actors_["1047ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1047ui_story == nil then
				arg_25_1.var_.characterEffect1047ui_story = var_28_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_7 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_7 and not isNil(var_28_6) then
				if arg_25_1.var_.characterEffect1047ui_story and not isNil(var_28_6) then
					arg_25_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_7)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_7 and arg_25_1.time_ < 0 + var_28_7 + arg_28_0 and not isNil(var_28_6) and arg_25_1.var_.characterEffect1047ui_story then
				arg_25_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			local var_28_8 = 0
			local var_28_9 = 0.2

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_8 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_10 = arg_25_1:GetWordFromCfg(421101006)
				local var_28_11 = arg_25_1:FormatText(var_28_10.content)

				arg_25_1.text_.text = var_28_11

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_13 = 8 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 8)

				if (8 <= 0 and var_28_9 or var_28_9 * (utf8.len(var_28_11) / 8)) > 0 and var_28_9 < var_28_13 then
					arg_25_1.talkMaxDuration = var_28_13

					if var_28_13 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_13 + var_28_8
					end
				end

				arg_25_1.text_.text = var_28_11
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101006", "story_v_out_421101.awb") ~= 0 then
					local var_28_14 = manager.audio:GetVoiceLength("story_v_out_421101", "421101006", "story_v_out_421101.awb") / 1000

					if var_28_14 + var_28_8 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_8
					end

					if var_28_10.prefab_name ~= "" and arg_25_1.actors_[var_28_10.prefab_name] ~= nil then
						local var_28_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_25_1.actors_[var_28_10.prefab_name].transform, "story_v_out_421101", "421101006", "story_v_out_421101.awb")

						arg_25_1:RecordAudio("421101006", var_28_15)
						arg_25_1:RecordAudio("421101006", var_28_15)
					else
						arg_25_1:AudioAction("play", "voice", "story_v_out_421101", "421101006", "story_v_out_421101.awb")
					end

					arg_25_1:RecordHistoryTalkVoice("story_v_out_421101", "421101006", "story_v_out_421101.awb")
				end

				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_16 = math.max(var_28_9, arg_25_1.talkMaxDuration)

			if var_28_8 <= arg_25_1.time_ and arg_25_1.time_ < var_28_8 + var_28_16 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_8) / var_28_16

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_8 + var_28_16 and arg_25_1.time_ < var_28_8 + var_28_16 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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

		arg_25_1:InitPlayNodeList()
	end,
	Play421101007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 421101007
		arg_29_1.duration_ = 9.13

		local var_29_0 = {
			zh = 7.466,
			ja = 9.133
		}
		local var_29_1 = manager.audio:GetLocalizationFlag()

		if var_29_0[var_29_1] ~= nil then
			arg_29_1.duration_ = var_29_0[var_29_1]
		end

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play421101008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1.var_.moveOldPos1047ui_story = arg_29_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_32_0 = 0.001

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 then
				arg_29_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_29_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_29_1.time_ - 0) / var_32_0)
				arg_29_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).z)
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles = arg_29_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 then
				arg_29_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_29_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_29_1.actors_["1047ui_story"].transform.position).z)
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_29_1.actors_["1047ui_story"].transform.localEulerAngles = arg_29_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_32_1 = arg_29_1.actors_["1047ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1047ui_story == nil then
				arg_29_1.var_.characterEffect1047ui_story = var_32_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_2 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_2 and not isNil(var_32_1) then
				if arg_29_1.var_.characterEffect1047ui_story and not isNil(var_32_1) then
					arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_2 and arg_29_1.time_ < 0 + var_32_2 + arg_32_0 and not isNil(var_32_1) and arg_29_1.var_.characterEffect1047ui_story then
				arg_29_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_32_4 = arg_29_1.actors_["10145ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10145ui_story == nil then
				arg_29_1.var_.characterEffect10145ui_story = var_32_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_5 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_5 and not isNil(var_32_4) then
				if arg_29_1.var_.characterEffect10145ui_story and not isNil(var_32_4) then
					arg_29_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_5)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_5 and arg_29_1.time_ < 0 + var_32_5 + arg_32_0 and not isNil(var_32_4) and arg_29_1.var_.characterEffect10145ui_story then
				arg_29_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_32_6 = 0
			local var_32_7 = 0.725

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_6 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_8 = arg_29_1:GetWordFromCfg(421101007)
				local var_32_9 = arg_29_1:FormatText(var_32_8.content)

				arg_29_1.text_.text = var_32_9

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_11 = 29 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 29)

				if (29 <= 0 and var_32_7 or var_32_7 * (utf8.len(var_32_9) / 29)) > 0 and var_32_7 < var_32_11 then
					arg_29_1.talkMaxDuration = var_32_11

					if var_32_11 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_11 + var_32_6
					end
				end

				arg_29_1.text_.text = var_32_9
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101007", "story_v_out_421101.awb") ~= 0 then
					local var_32_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101007", "story_v_out_421101.awb") / 1000

					if var_32_12 + var_32_6 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_12 + var_32_6
					end

					if var_32_8.prefab_name ~= "" and arg_29_1.actors_[var_32_8.prefab_name] ~= nil then
						local var_32_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_29_1.actors_[var_32_8.prefab_name].transform, "story_v_out_421101", "421101007", "story_v_out_421101.awb")

						arg_29_1:RecordAudio("421101007", var_32_13)
						arg_29_1:RecordAudio("421101007", var_32_13)
					else
						arg_29_1:AudioAction("play", "voice", "story_v_out_421101", "421101007", "story_v_out_421101.awb")
					end

					arg_29_1:RecordHistoryTalkVoice("story_v_out_421101", "421101007", "story_v_out_421101.awb")
				end

				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_14 = math.max(var_32_7, arg_29_1.talkMaxDuration)

			if var_32_6 <= arg_29_1.time_ and arg_29_1.time_ < var_32_6 + var_32_14 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_6) / var_32_14

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_6 + var_32_14 and arg_29_1.time_ < var_32_6 + var_32_14 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {
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

		arg_29_1:InitPlayNodeList()
	end,
	Play421101008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 421101008
		arg_33_1.duration_ = 7.8

		local var_33_0 = {
			zh = 6,
			ja = 7.8
		}
		local var_33_1 = manager.audio:GetLocalizationFlag()

		if var_33_0[var_33_1] ~= nil then
			arg_33_1.duration_ = var_33_0[var_33_1]
		end

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play421101009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1.var_.moveOldPos10145ui_story = arg_33_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_36_0 = 0.001

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 then
				arg_33_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_33_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_33_1.time_ - 0) / var_36_0)
				arg_33_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).z)
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles = arg_33_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 then
				arg_33_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_33_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_33_1.actors_["10145ui_story"].transform.position).z)
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_33_1.actors_["10145ui_story"].transform.localEulerAngles = arg_33_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_36_1 = arg_33_1.actors_["10145ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10145ui_story == nil then
				arg_33_1.var_.characterEffect10145ui_story = var_36_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_2 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_2 and not isNil(var_36_1) then
				if arg_33_1.var_.characterEffect10145ui_story and not isNil(var_36_1) then
					arg_33_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_2 and arg_33_1.time_ < 0 + var_36_2 + arg_36_0 and not isNil(var_36_1) and arg_33_1.var_.characterEffect10145ui_story then
				arg_33_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_36_4 = arg_33_1.actors_["1047ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1047ui_story == nil then
				arg_33_1.var_.characterEffect1047ui_story = var_36_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_5 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_5 and not isNil(var_36_4) then
				if arg_33_1.var_.characterEffect1047ui_story and not isNil(var_36_4) then
					arg_33_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_5)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_5 and arg_33_1.time_ < 0 + var_36_5 + arg_36_0 and not isNil(var_36_4) and arg_33_1.var_.characterEffect1047ui_story then
				arg_33_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_36_6 = 0
			local var_36_7 = 0.55

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_6 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_8 = arg_33_1:GetWordFromCfg(421101008)
				local var_36_9 = arg_33_1:FormatText(var_36_8.content)

				arg_33_1.text_.text = var_36_9

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_11 = 22 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 22)

				if (22 <= 0 and var_36_7 or var_36_7 * (utf8.len(var_36_9) / 22)) > 0 and var_36_7 < var_36_11 then
					arg_33_1.talkMaxDuration = var_36_11

					if var_36_11 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_11 + var_36_6
					end
				end

				arg_33_1.text_.text = var_36_9
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101008", "story_v_out_421101.awb") ~= 0 then
					local var_36_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101008", "story_v_out_421101.awb") / 1000

					if var_36_12 + var_36_6 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_12 + var_36_6
					end

					if var_36_8.prefab_name ~= "" and arg_33_1.actors_[var_36_8.prefab_name] ~= nil then
						local var_36_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_33_1.actors_[var_36_8.prefab_name].transform, "story_v_out_421101", "421101008", "story_v_out_421101.awb")

						arg_33_1:RecordAudio("421101008", var_36_13)
						arg_33_1:RecordAudio("421101008", var_36_13)
					else
						arg_33_1:AudioAction("play", "voice", "story_v_out_421101", "421101008", "story_v_out_421101.awb")
					end

					arg_33_1:RecordHistoryTalkVoice("story_v_out_421101", "421101008", "story_v_out_421101.awb")
				end

				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_14 = math.max(var_36_7, arg_33_1.talkMaxDuration)

			if var_36_6 <= arg_33_1.time_ and arg_33_1.time_ < var_36_6 + var_36_14 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_6) / var_36_14

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_6 + var_36_14 and arg_33_1.time_ < var_36_6 + var_36_14 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_33_1:InitPlayNodeList()
	end,
	Play421101009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 421101009
		arg_37_1.duration_ = 11.73

		local var_37_0 = {
			zh = 7.5,
			ja = 11.733
		}
		local var_37_1 = manager.audio:GetLocalizationFlag()

		if var_37_0[var_37_1] ~= nil then
			arg_37_1.duration_ = var_37_0[var_37_1]
		end

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play421101010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1.var_.moveOldPos1047ui_story = arg_37_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_40_0 = 0.001

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_37_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_37_1.time_ - 0) / var_40_0)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 then
				arg_37_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_37_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_37_1.actors_["1047ui_story"].transform.position).z)
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_37_1.actors_["1047ui_story"].transform.localEulerAngles = arg_37_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_40_1 = arg_37_1.actors_["1047ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story == nil then
				arg_37_1.var_.characterEffect1047ui_story = var_40_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_2 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_2 and not isNil(var_40_1) then
				if arg_37_1.var_.characterEffect1047ui_story and not isNil(var_40_1) then
					arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_2 and arg_37_1.time_ < 0 + var_40_2 + arg_40_0 and not isNil(var_40_1) and arg_37_1.var_.characterEffect1047ui_story then
				arg_37_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_40_4 = arg_37_1.actors_["10145ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10145ui_story == nil then
				arg_37_1.var_.characterEffect10145ui_story = var_40_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_5 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_5 and not isNil(var_40_4) then
				if arg_37_1.var_.characterEffect10145ui_story and not isNil(var_40_4) then
					arg_37_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_5)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_5 and arg_37_1.time_ < 0 + var_40_5 + arg_40_0 and not isNil(var_40_4) and arg_37_1.var_.characterEffect10145ui_story then
				arg_37_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_40_6 = 0
			local var_40_7 = 1.175

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_6 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_8 = arg_37_1:GetWordFromCfg(421101009)
				local var_40_9 = arg_37_1:FormatText(var_40_8.content)

				arg_37_1.text_.text = var_40_9

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_11 = 47 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 47)

				if (47 <= 0 and var_40_7 or var_40_7 * (utf8.len(var_40_9) / 47)) > 0 and var_40_7 < var_40_11 then
					arg_37_1.talkMaxDuration = var_40_11

					if var_40_11 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_11 + var_40_6
					end
				end

				arg_37_1.text_.text = var_40_9
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101009", "story_v_out_421101.awb") ~= 0 then
					local var_40_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101009", "story_v_out_421101.awb") / 1000

					if var_40_12 + var_40_6 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_12 + var_40_6
					end

					if var_40_8.prefab_name ~= "" and arg_37_1.actors_[var_40_8.prefab_name] ~= nil then
						local var_40_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_37_1.actors_[var_40_8.prefab_name].transform, "story_v_out_421101", "421101009", "story_v_out_421101.awb")

						arg_37_1:RecordAudio("421101009", var_40_13)
						arg_37_1:RecordAudio("421101009", var_40_13)
					else
						arg_37_1:AudioAction("play", "voice", "story_v_out_421101", "421101009", "story_v_out_421101.awb")
					end

					arg_37_1:RecordHistoryTalkVoice("story_v_out_421101", "421101009", "story_v_out_421101.awb")
				end

				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_14 = math.max(var_40_7, arg_37_1.talkMaxDuration)

			if var_40_6 <= arg_37_1.time_ and arg_37_1.time_ < var_40_6 + var_40_14 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_6) / var_40_14

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_6 + var_40_14 and arg_37_1.time_ < var_40_6 + var_40_14 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {
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

		arg_37_1:InitPlayNodeList()
	end,
	Play421101010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 421101010
		arg_41_1.duration_ = 5.87

		local var_41_0 = {
			zh = 5.866,
			ja = 5.633
		}
		local var_41_1 = manager.audio:GetLocalizationFlag()

		if var_41_0[var_41_1] ~= nil then
			arg_41_1.duration_ = var_41_0[var_41_1]
		end

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play421101011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos10145ui_story = arg_41_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_44_0 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 then
				arg_41_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_41_1.time_ - 0) / var_44_0)
				arg_41_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10145ui_story"].transform.position).z)
				arg_41_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10145ui_story"].transform.localEulerAngles = arg_41_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 then
				arg_41_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_41_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_41_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_41_1.actors_["10145ui_story"].transform.position).z)
				arg_41_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_41_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_41_1.actors_["10145ui_story"].transform.localEulerAngles = arg_41_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_44_1 = arg_41_1.actors_["10145ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10145ui_story == nil then
				arg_41_1.var_.characterEffect10145ui_story = var_44_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_2 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 and not isNil(var_44_1) then
				if arg_41_1.var_.characterEffect10145ui_story and not isNil(var_44_1) then
					arg_41_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 and not isNil(var_44_1) and arg_41_1.var_.characterEffect10145ui_story then
				arg_41_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_44_4 = arg_41_1.actors_["1047ui_story"]

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1047ui_story == nil then
				arg_41_1.var_.characterEffect1047ui_story = var_44_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_5 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_5 and not isNil(var_44_4) then
				if arg_41_1.var_.characterEffect1047ui_story and not isNil(var_44_4) then
					arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_5)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_5 and arg_41_1.time_ < 0 + var_44_5 + arg_44_0 and not isNil(var_44_4) and arg_41_1.var_.characterEffect1047ui_story then
				arg_41_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_44_6 = 0
			local var_44_7 = 0.625

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_6 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, true)

				arg_41_1.leftNameTxt_.text = arg_41_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_41_1.leftNameTxt_.transform)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1.leftNameTxt_.text)
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_8 = arg_41_1:GetWordFromCfg(421101010)
				local var_44_9 = arg_41_1:FormatText(var_44_8.content)

				arg_41_1.text_.text = var_44_9

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_11 = 25 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 25)

				if (25 <= 0 and var_44_7 or var_44_7 * (utf8.len(var_44_9) / 25)) > 0 and var_44_7 < var_44_11 then
					arg_41_1.talkMaxDuration = var_44_11

					if var_44_11 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_11 + var_44_6
					end
				end

				arg_41_1.text_.text = var_44_9
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101010", "story_v_out_421101.awb") ~= 0 then
					local var_44_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101010", "story_v_out_421101.awb") / 1000

					if var_44_12 + var_44_6 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_12 + var_44_6
					end

					if var_44_8.prefab_name ~= "" and arg_41_1.actors_[var_44_8.prefab_name] ~= nil then
						local var_44_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_41_1.actors_[var_44_8.prefab_name].transform, "story_v_out_421101", "421101010", "story_v_out_421101.awb")

						arg_41_1:RecordAudio("421101010", var_44_13)
						arg_41_1:RecordAudio("421101010", var_44_13)
					else
						arg_41_1:AudioAction("play", "voice", "story_v_out_421101", "421101010", "story_v_out_421101.awb")
					end

					arg_41_1:RecordHistoryTalkVoice("story_v_out_421101", "421101010", "story_v_out_421101.awb")
				end

				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_14 = math.max(var_44_7, arg_41_1.talkMaxDuration)

			if var_44_6 <= arg_41_1.time_ and arg_41_1.time_ < var_44_6 + var_44_14 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_6) / var_44_14

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_6 + var_44_14 and arg_41_1.time_ < var_44_6 + var_44_14 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play421101011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 421101011
		arg_45_1.duration_ = 3.9

		local var_45_0 = {
			zh = 2.966,
			ja = 3.9
		}
		local var_45_1 = manager.audio:GetLocalizationFlag()

		if var_45_0[var_45_1] ~= nil then
			arg_45_1.duration_ = var_45_0[var_45_1]
		end

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play421101012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1047ui_story = arg_45_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_48_0 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 then
				arg_45_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_45_1.time_ - 0) / var_48_0)
				arg_45_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).z)
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles = arg_45_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 then
				arg_45_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_45_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_45_1.actors_["1047ui_story"].transform.position).z)
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_45_1.actors_["1047ui_story"].transform.localEulerAngles = arg_45_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_48_1 = arg_45_1.actors_["1047ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1047ui_story == nil then
				arg_45_1.var_.characterEffect1047ui_story = var_48_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_2 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_2 and not isNil(var_48_1) then
				if arg_45_1.var_.characterEffect1047ui_story and not isNil(var_48_1) then
					arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_2 and arg_45_1.time_ < 0 + var_48_2 + arg_48_0 and not isNil(var_48_1) and arg_45_1.var_.characterEffect1047ui_story then
				arg_45_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_48_4 = arg_45_1.actors_["10145ui_story"]

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect10145ui_story == nil then
				arg_45_1.var_.characterEffect10145ui_story = var_48_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_5 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_5 and not isNil(var_48_4) then
				if arg_45_1.var_.characterEffect10145ui_story and not isNil(var_48_4) then
					arg_45_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_45_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_45_1.time_ - 0) / var_48_5)
				end
			end

			if arg_45_1.time_ >= 0 + var_48_5 and arg_45_1.time_ < 0 + var_48_5 + arg_48_0 and not isNil(var_48_4) and arg_45_1.var_.characterEffect10145ui_story then
				arg_45_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_45_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_48_6 = 0
			local var_48_7 = 0.4

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_6 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_8 = arg_45_1:GetWordFromCfg(421101011)
				local var_48_9 = arg_45_1:FormatText(var_48_8.content)

				arg_45_1.text_.text = var_48_9

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_11 = 16 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 16)

				if (16 <= 0 and var_48_7 or var_48_7 * (utf8.len(var_48_9) / 16)) > 0 and var_48_7 < var_48_11 then
					arg_45_1.talkMaxDuration = var_48_11

					if var_48_11 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_11 + var_48_6
					end
				end

				arg_45_1.text_.text = var_48_9
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101011", "story_v_out_421101.awb") ~= 0 then
					local var_48_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101011", "story_v_out_421101.awb") / 1000

					if var_48_12 + var_48_6 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_12 + var_48_6
					end

					if var_48_8.prefab_name ~= "" and arg_45_1.actors_[var_48_8.prefab_name] ~= nil then
						local var_48_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_45_1.actors_[var_48_8.prefab_name].transform, "story_v_out_421101", "421101011", "story_v_out_421101.awb")

						arg_45_1:RecordAudio("421101011", var_48_13)
						arg_45_1:RecordAudio("421101011", var_48_13)
					else
						arg_45_1:AudioAction("play", "voice", "story_v_out_421101", "421101011", "story_v_out_421101.awb")
					end

					arg_45_1:RecordHistoryTalkVoice("story_v_out_421101", "421101011", "story_v_out_421101.awb")
				end

				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_14 = math.max(var_48_7, arg_45_1.talkMaxDuration)

			if var_48_6 <= arg_45_1.time_ and arg_45_1.time_ < var_48_6 + var_48_14 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_6) / var_48_14

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_6 + var_48_14 and arg_45_1.time_ < var_48_6 + var_48_14 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
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

		arg_45_1:InitPlayNodeList()
	end,
	Play421101012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 421101012
		arg_49_1.duration_ = 9.17

		local var_49_0 = {
			zh = 9.166,
			ja = 7.533
		}
		local var_49_1 = manager.audio:GetLocalizationFlag()

		if var_49_0[var_49_1] ~= nil then
			arg_49_1.duration_ = var_49_0[var_49_1]
		end

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play421101013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.var_.moveOldPos10145ui_story = arg_49_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_52_0 = 0.001

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_0 then
				arg_49_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_49_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_49_1.time_ - 0) / var_52_0)
				arg_49_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).z)
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles = arg_49_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_49_1.time_ >= 0 + var_52_0 and arg_49_1.time_ < 0 + var_52_0 + arg_52_0 then
				arg_49_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_49_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_49_1.actors_["10145ui_story"].transform.position).z)
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_49_1.actors_["10145ui_story"].transform.localEulerAngles = arg_49_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_52_1 = arg_49_1.actors_["10145ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10145ui_story == nil then
				arg_49_1.var_.characterEffect10145ui_story = var_52_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_2 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_2 and not isNil(var_52_1) then
				if arg_49_1.var_.characterEffect10145ui_story and not isNil(var_52_1) then
					arg_49_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_49_1.time_ >= 0 + var_52_2 and arg_49_1.time_ < 0 + var_52_2 + arg_52_0 and not isNil(var_52_1) and arg_49_1.var_.characterEffect10145ui_story then
				arg_49_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_52_4 = arg_49_1.actors_["1047ui_story"]

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1047ui_story == nil then
				arg_49_1.var_.characterEffect1047ui_story = var_52_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_52_5 = 0.200000002980232

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_5 and not isNil(var_52_4) then
				if arg_49_1.var_.characterEffect1047ui_story and not isNil(var_52_4) then
					arg_49_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_49_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_49_1.time_ - 0) / var_52_5)
				end
			end

			if arg_49_1.time_ >= 0 + var_52_5 and arg_49_1.time_ < 0 + var_52_5 + arg_52_0 and not isNil(var_52_4) and arg_49_1.var_.characterEffect1047ui_story then
				arg_49_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_49_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action5_1")
			end

			local var_52_6 = 0
			local var_52_7 = 0.95

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= var_52_6 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_8 = arg_49_1:GetWordFromCfg(421101012)
				local var_52_9 = arg_49_1:FormatText(var_52_8.content)

				arg_49_1.text_.text = var_52_9

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_11 = 38 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 38)

				if (38 <= 0 and var_52_7 or var_52_7 * (utf8.len(var_52_9) / 38)) > 0 and var_52_7 < var_52_11 then
					arg_49_1.talkMaxDuration = var_52_11

					if var_52_11 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_11 + var_52_6
					end
				end

				arg_49_1.text_.text = var_52_9
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101012", "story_v_out_421101.awb") ~= 0 then
					local var_52_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101012", "story_v_out_421101.awb") / 1000

					if var_52_12 + var_52_6 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_12 + var_52_6
					end

					if var_52_8.prefab_name ~= "" and arg_49_1.actors_[var_52_8.prefab_name] ~= nil then
						local var_52_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_49_1.actors_[var_52_8.prefab_name].transform, "story_v_out_421101", "421101012", "story_v_out_421101.awb")

						arg_49_1:RecordAudio("421101012", var_52_13)
						arg_49_1:RecordAudio("421101012", var_52_13)
					else
						arg_49_1:AudioAction("play", "voice", "story_v_out_421101", "421101012", "story_v_out_421101.awb")
					end

					arg_49_1:RecordHistoryTalkVoice("story_v_out_421101", "421101012", "story_v_out_421101.awb")
				end

				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_14 = math.max(var_52_7, arg_49_1.talkMaxDuration)

			if var_52_6 <= arg_49_1.time_ and arg_49_1.time_ < var_52_6 + var_52_14 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - var_52_6) / var_52_14

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= var_52_6 + var_52_14 and arg_49_1.time_ < var_52_6 + var_52_14 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_49_1:InitPlayNodeList()
	end,
	Play421101013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 421101013
		arg_53_1.duration_ = 10.67

		local var_53_0 = {
			zh = 7.9,
			ja = 10.666
		}
		local var_53_1 = manager.audio:GetLocalizationFlag()

		if var_53_0[var_53_1] ~= nil then
			arg_53_1.duration_ = var_53_0[var_53_1]
		end

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play421101014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if arg_53_1.bgs_.B13a == nil then
				local var_56_0 = Object.Instantiate(arg_53_1.paintGo_)

				var_56_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "B13a")
				var_56_0.name = "B13a"
				var_56_0.transform.parent = arg_53_1.stage_.transform
				var_56_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_53_1.bgs_.B13a = var_56_0
			end

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= 2 + arg_56_0 then
				local var_56_1 = arg_53_1.bgs_.B13a

				arg_53_1.bgs_.B13a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_56_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_56_2 = var_56_1:GetComponent("SpriteRenderer")

				if var_56_2 and var_56_2.sprite then
					local var_56_3 = 2 * (var_56_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_56_1.transform.localScale = Vector3.New(var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, var_56_3 / var_56_2.sprite.bounds.size.y < var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x and var_56_3 * manager.ui.mainCameraCom_.aspect / var_56_2.sprite.bounds.size.x or var_56_3 / var_56_2.sprite.bounds.size.y, 0)
				end

				for iter_56_0, iter_56_1 in pairs(arg_53_1.bgs_) do
					if iter_56_0 ~= "B13a" then
						iter_56_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_56_4 = 4

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_4 + arg_56_0 then
				arg_53_1.allBtn_.enabled = false
			end

			if arg_53_1.time_ >= var_56_4 + 0.3 and arg_53_1.time_ < var_56_4 + 0.3 + arg_56_0 then
				arg_53_1.allBtn_.enabled = true
			end

			local var_56_5 = 0

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_5 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_6 = 2

			if var_56_5 <= arg_53_1.time_ and arg_53_1.time_ < var_56_5 + var_56_6 then
				local var_56_7 = Color.New(0, 0, 0)

				var_56_7.a = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_5) / var_56_6)
				arg_53_1.mask_.color = var_56_7
			end

			if arg_53_1.time_ >= var_56_5 + var_56_6 and arg_53_1.time_ < var_56_5 + var_56_6 + arg_56_0 then
				local var_56_8 = Color.New(0, 0, 0)

				var_56_8.a = 1
				arg_53_1.mask_.color = var_56_8
			end

			local var_56_9 = 2

			if 2 < arg_53_1.time_ and arg_53_1.time_ <= var_56_9 + arg_56_0 then
				arg_53_1.mask_.enabled = true
				arg_53_1.mask_.raycastTarget = true

				arg_53_1:SetGaussion(false)
			end

			local var_56_10 = 2

			if var_56_9 <= arg_53_1.time_ and arg_53_1.time_ < var_56_9 + var_56_10 then
				local var_56_11 = Color.New(0, 0, 0)

				var_56_11.a = Mathf.Lerp(1, 0, (arg_53_1.time_ - var_56_9) / var_56_10)
				arg_53_1.mask_.color = var_56_11
			end

			if arg_53_1.time_ >= var_56_9 + var_56_10 and arg_53_1.time_ < var_56_9 + var_56_10 + arg_56_0 then
				local var_56_12 = Color.New(0, 0, 0)

				arg_53_1.mask_.enabled = false
				var_56_12.a = 0
				arg_53_1.mask_.color = var_56_12
			end

			local var_56_13 = arg_53_1.actors_["1047ui_story"].transform

			if 1.96599999815226 < arg_53_1.time_ and arg_53_1.time_ <= 1.96599999815226 + arg_56_0 then
				arg_53_1.var_.moveOldPos1047ui_story = var_56_13.localPosition
			end

			local var_56_14 = 0.001

			if 1.96599999815226 <= arg_53_1.time_ and arg_53_1.time_ < 1.96599999815226 + var_56_14 then
				var_56_13.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 1.96599999815226) / var_56_14)
				var_56_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_13.position).x, (manager.ui.mainCamera.transform.position - var_56_13.position).y, (manager.ui.mainCamera.transform.position - var_56_13.position).z)
				var_56_13.localEulerAngles.z = 0
				var_56_13.localEulerAngles.x = 0
				var_56_13.localEulerAngles = var_56_13.localEulerAngles
			end

			if arg_53_1.time_ >= 1.96599999815226 + var_56_14 and arg_53_1.time_ < 1.96599999815226 + var_56_14 + arg_56_0 then
				var_56_13.localPosition = Vector3.New(0, 100, 0)
				var_56_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_13.position).x, (manager.ui.mainCamera.transform.position - var_56_13.position).y, (manager.ui.mainCamera.transform.position - var_56_13.position).z)
				var_56_13.localEulerAngles.z = 0
				var_56_13.localEulerAngles.x = 0
				var_56_13.localEulerAngles = var_56_13.localEulerAngles
			end

			local var_56_15 = arg_53_1.actors_["10145ui_story"].transform

			if 1.96666666666667 < arg_53_1.time_ and arg_53_1.time_ <= 1.96666666666667 + arg_56_0 then
				arg_53_1.var_.moveOldPos10145ui_story = var_56_15.localPosition
			end

			local var_56_16 = 0.001

			if 1.96666666666667 <= arg_53_1.time_ and arg_53_1.time_ < 1.96666666666667 + var_56_16 then
				var_56_15.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_53_1.time_ - 1.96666666666667) / var_56_16)
				var_56_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_15.position).x, (manager.ui.mainCamera.transform.position - var_56_15.position).y, (manager.ui.mainCamera.transform.position - var_56_15.position).z)
				var_56_15.localEulerAngles.z = 0
				var_56_15.localEulerAngles.x = 0
				var_56_15.localEulerAngles = var_56_15.localEulerAngles
			end

			if arg_53_1.time_ >= 1.96666666666667 + var_56_16 and arg_53_1.time_ < 1.96666666666667 + var_56_16 + arg_56_0 then
				var_56_15.localPosition = Vector3.New(0, 100, 0)
				var_56_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_15.position).x, (manager.ui.mainCamera.transform.position - var_56_15.position).y, (manager.ui.mainCamera.transform.position - var_56_15.position).z)
				var_56_15.localEulerAngles.z = 0
				var_56_15.localEulerAngles.x = 0
				var_56_15.localEulerAngles = var_56_15.localEulerAngles
			end

			local var_56_17 = arg_53_1.actors_["10145ui_story"].transform

			if 3.83333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 3.83333333333333 + arg_56_0 then
				arg_53_1.var_.moveOldPos10145ui_story = var_56_17.localPosition
			end

			local var_56_18 = 0.001

			if 3.83333333333333 <= arg_53_1.time_ and arg_53_1.time_ < 3.83333333333333 + var_56_18 then
				var_56_17.localPosition = Vector3.Lerp(arg_53_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_53_1.time_ - 3.83333333333333) / var_56_18)
				var_56_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_17.position).x, (manager.ui.mainCamera.transform.position - var_56_17.position).y, (manager.ui.mainCamera.transform.position - var_56_17.position).z)
				var_56_17.localEulerAngles.z = 0
				var_56_17.localEulerAngles.x = 0
				var_56_17.localEulerAngles = var_56_17.localEulerAngles
			end

			if arg_53_1.time_ >= 3.83333333333333 + var_56_18 and arg_53_1.time_ < 3.83333333333333 + var_56_18 + arg_56_0 then
				var_56_17.localPosition = Vector3.New(0, -1, -6.2)
				var_56_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_56_17.position).x, (manager.ui.mainCamera.transform.position - var_56_17.position).y, (manager.ui.mainCamera.transform.position - var_56_17.position).z)
				var_56_17.localEulerAngles.z = 0
				var_56_17.localEulerAngles.x = 0
				var_56_17.localEulerAngles = var_56_17.localEulerAngles
			end

			local var_56_19 = arg_53_1.actors_["10145ui_story"]

			if 3.83333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 3.83333333333333 + arg_56_0 and not isNil(var_56_19) and arg_53_1.var_.characterEffect10145ui_story == nil then
				arg_53_1.var_.characterEffect10145ui_story = var_56_19:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_56_20 = 0.200000002980232

			if 3.83333333333333 <= arg_53_1.time_ and arg_53_1.time_ < 3.83333333333333 + var_56_20 and not isNil(var_56_19) then
				if arg_53_1.var_.characterEffect10145ui_story and not isNil(var_56_19) then
					arg_53_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_53_1.time_ >= 3.83333333333333 + var_56_20 and arg_53_1.time_ < 3.83333333333333 + var_56_20 + arg_56_0 and not isNil(var_56_19) and arg_53_1.var_.characterEffect10145ui_story then
				arg_53_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 3.83333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 3.83333333333333 + arg_56_0 then
				arg_53_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			if 3.83333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 3.83333333333333 + arg_56_0 then
				arg_53_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_jingyaA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_53_1.time_ and arg_53_1.time_ <= 0.1 + arg_56_0 then
				arg_53_1:AudioAction("stop", "effect", "se_story_143", "se_story_143_amb_dark", "")
			end

			if 1.53333333333333 < arg_53_1.time_ and arg_53_1.time_ <= 1.53333333333333 + arg_56_0 then
				arg_53_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			local var_56_24 = 2.00066666851441

			arg_53_1.isInRecall_ = false

			if var_56_24 < arg_53_1.time_ and arg_53_1.time_ <= var_56_24 + arg_56_0 then
				arg_53_1.screenFilterGo_:SetActive(true)

				arg_53_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_56_2, iter_56_3 in pairs(arg_53_1.actors_) do
					for iter_56_4, iter_56_5 in ipairs((iter_56_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_56_5.color = iter_56_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_56_25 = 0.0166666666666667

			if var_56_24 <= arg_53_1.time_ and arg_53_1.time_ < var_56_24 + var_56_25 then
				arg_53_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_24) / var_56_25)
			end

			if arg_53_1.time_ >= var_56_24 + var_56_25 and arg_53_1.time_ < var_56_24 + var_56_25 + arg_56_0 then
				arg_53_1.screenFilterEffect_.weight = 1
			end

			local var_56_26 = 2.00066666851441

			arg_53_1.isInRecall_ = false

			if var_56_26 < arg_53_1.time_ and arg_53_1.time_ <= var_56_26 + arg_56_0 then
				arg_53_1.screenFilterGo_:SetActive(true)

				arg_53_1.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")

				for iter_56_6, iter_56_7 in pairs(arg_53_1.actors_) do
					for iter_56_8, iter_56_9 in ipairs((iter_56_7:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_56_9.color = iter_56_9.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_56_27 = 0.0166666666666667

			if var_56_26 <= arg_53_1.time_ and arg_53_1.time_ < var_56_26 + var_56_27 then
				arg_53_1.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (arg_53_1.time_ - var_56_26) / var_56_27)
			end

			if arg_53_1.time_ >= var_56_26 + var_56_27 and arg_53_1.time_ < var_56_26 + var_56_27 + arg_56_0 then
				arg_53_1.screenFilterEffect_.weight = 1
			end

			if arg_53_1.frameCnt_ <= 1 then
				arg_53_1.dialog_:SetActive(false)
			end

			local var_56_28 = 4
			local var_56_29 = 0.525

			if 4 < arg_53_1.time_ and arg_53_1.time_ <= var_56_28 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0

				arg_53_1.dialog_:SetActive(true)

				arg_53_1.dialogCg_.alpha = 0

				local var_56_30 = LeanTween.value(arg_53_1.dialog_, 0, 1, 0.3)

				var_56_30:setOnUpdate(LuaHelper.FloatAction(function(arg_57_0)
					arg_53_1.dialogCg_.alpha = arg_57_0
				end))
				var_56_30:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_53_1.dialog_)
					var_56_30:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_53_1.duration_ = arg_53_1.duration_ + 0.3

				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_31 = arg_53_1:GetWordFromCfg(421101013)
				local var_56_32 = arg_53_1:FormatText(var_56_31.content)

				arg_53_1.text_.text = var_56_32

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_34 = 21 <= 0 and var_56_29 or var_56_29 * (utf8.len(var_56_32) / 21)

				if (21 <= 0 and var_56_29 or var_56_29 * (utf8.len(var_56_32) / 21)) > 0 and var_56_29 < var_56_34 then
					arg_53_1.talkMaxDuration = var_56_34
					var_56_28 = var_56_28 + 0.3

					if var_56_34 + var_56_28 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_34 + var_56_28
					end
				end

				arg_53_1.text_.text = var_56_32
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101013", "story_v_out_421101.awb") ~= 0 then
					local var_56_35 = manager.audio:GetVoiceLength("story_v_out_421101", "421101013", "story_v_out_421101.awb") / 1000

					if var_56_35 + var_56_28 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_35 + var_56_28
					end

					if var_56_31.prefab_name ~= "" and arg_53_1.actors_[var_56_31.prefab_name] ~= nil then
						local var_56_36 = LuaForUtil.PlayVoiceWithCriLipsync(arg_53_1.actors_[var_56_31.prefab_name].transform, "story_v_out_421101", "421101013", "story_v_out_421101.awb")

						arg_53_1:RecordAudio("421101013", var_56_36)
						arg_53_1:RecordAudio("421101013", var_56_36)
					else
						arg_53_1:AudioAction("play", "voice", "story_v_out_421101", "421101013", "story_v_out_421101.awb")
					end

					arg_53_1:RecordHistoryTalkVoice("story_v_out_421101", "421101013", "story_v_out_421101.awb")
				end

				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_37 = var_56_28 + 0.3
			local var_56_38 = math.max(var_56_29, arg_53_1.talkMaxDuration)

			if var_56_28 + 0.3 <= arg_53_1.time_ and arg_53_1.time_ < var_56_37 + var_56_38 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_37) / var_56_38

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_37 + var_56_38 and arg_53_1.time_ < var_56_37 + var_56_38 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.83333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_53_1:InitPlayNodeList()
	end,
	Play421101014 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 421101014
		arg_59_1.duration_ = 3.07

		local var_59_0 = {
			zh = 1.999999999999,
			ja = 3.066
		}
		local var_59_1 = manager.audio:GetLocalizationFlag()

		if var_59_0[var_59_1] ~= nil then
			arg_59_1.duration_ = var_59_0[var_59_1]
		end

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play421101015(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos1047ui_story = arg_59_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_62_0 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_0 then
				arg_59_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_59_1.time_ - 0) / var_62_0)
				arg_59_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1047ui_story"].transform.position).z)
				arg_59_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1047ui_story"].transform.localEulerAngles = arg_59_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_0 and arg_59_1.time_ < 0 + var_62_0 + arg_62_0 then
				arg_59_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_59_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_59_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_59_1.actors_["1047ui_story"].transform.position).z)
				arg_59_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_59_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_59_1.actors_["1047ui_story"].transform.localEulerAngles = arg_59_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_62_1 = arg_59_1.actors_["1047ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1047ui_story == nil then
				arg_59_1.var_.characterEffect1047ui_story = var_62_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_2 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_2 and not isNil(var_62_1) then
				if arg_59_1.var_.characterEffect1047ui_story and not isNil(var_62_1) then
					arg_59_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_59_1.time_ >= 0 + var_62_2 and arg_59_1.time_ < 0 + var_62_2 + arg_62_0 and not isNil(var_62_1) and arg_59_1.var_.characterEffect1047ui_story then
				arg_59_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_1")
			end

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_62_4 = arg_59_1.actors_["10145ui_story"].transform

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 then
				arg_59_1.var_.moveOldPos10145ui_story = var_62_4.localPosition
			end

			local var_62_5 = 0.001

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_5 then
				var_62_4.localPosition = Vector3.Lerp(arg_59_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_59_1.time_ - 0) / var_62_5)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			if arg_59_1.time_ >= 0 + var_62_5 and arg_59_1.time_ < 0 + var_62_5 + arg_62_0 then
				var_62_4.localPosition = Vector3.New(0.78, -1, -6.2)
				var_62_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_62_4.position).x, (manager.ui.mainCamera.transform.position - var_62_4.position).y, (manager.ui.mainCamera.transform.position - var_62_4.position).z)
				var_62_4.localEulerAngles.z = 0
				var_62_4.localEulerAngles.x = 0
				var_62_4.localEulerAngles = var_62_4.localEulerAngles
			end

			local var_62_6 = arg_59_1.actors_["10145ui_story"]

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= 0 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect10145ui_story == nil then
				arg_59_1.var_.characterEffect10145ui_story = var_62_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_62_7 = 0.200000002980232

			if 0 <= arg_59_1.time_ and arg_59_1.time_ < 0 + var_62_7 and not isNil(var_62_6) then
				if arg_59_1.var_.characterEffect10145ui_story and not isNil(var_62_6) then
					arg_59_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_59_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_59_1.time_ - 0) / var_62_7)
				end
			end

			if arg_59_1.time_ >= 0 + var_62_7 and arg_59_1.time_ < 0 + var_62_7 + arg_62_0 and not isNil(var_62_6) and arg_59_1.var_.characterEffect10145ui_story then
				arg_59_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_59_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			local var_62_8 = 0
			local var_62_9 = 0.2

			if 0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_8 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, true)

				arg_59_1.leftNameTxt_.text = arg_59_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_59_1.leftNameTxt_.transform)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1.leftNameTxt_.text)
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_10 = arg_59_1:GetWordFromCfg(421101014)
				local var_62_11 = arg_59_1:FormatText(var_62_10.content)

				arg_59_1.text_.text = var_62_11

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_13 = 8 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 8)

				if (8 <= 0 and var_62_9 or var_62_9 * (utf8.len(var_62_11) / 8)) > 0 and var_62_9 < var_62_13 then
					arg_59_1.talkMaxDuration = var_62_13

					if var_62_13 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_13 + var_62_8
					end
				end

				arg_59_1.text_.text = var_62_11
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101014", "story_v_out_421101.awb") ~= 0 then
					local var_62_14 = manager.audio:GetVoiceLength("story_v_out_421101", "421101014", "story_v_out_421101.awb") / 1000

					if var_62_14 + var_62_8 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_14 + var_62_8
					end

					if var_62_10.prefab_name ~= "" and arg_59_1.actors_[var_62_10.prefab_name] ~= nil then
						local var_62_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_59_1.actors_[var_62_10.prefab_name].transform, "story_v_out_421101", "421101014", "story_v_out_421101.awb")

						arg_59_1:RecordAudio("421101014", var_62_15)
						arg_59_1:RecordAudio("421101014", var_62_15)
					else
						arg_59_1:AudioAction("play", "voice", "story_v_out_421101", "421101014", "story_v_out_421101.awb")
					end

					arg_59_1:RecordHistoryTalkVoice("story_v_out_421101", "421101014", "story_v_out_421101.awb")
				end

				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_16 = math.max(var_62_9, arg_59_1.talkMaxDuration)

			if var_62_8 <= arg_59_1.time_ and arg_59_1.time_ < var_62_8 + var_62_16 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_8) / var_62_16

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_8 + var_62_16 and arg_59_1.time_ < var_62_8 + var_62_16 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end

		arg_59_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_59_1:InitPlayNodeList()
	end,
	Play421101015 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 421101015
		arg_63_1.duration_ = 6.17

		local var_63_0 = {
			zh = 5.066,
			ja = 6.166
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play421101016(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1.var_.moveOldPos10145ui_story = arg_63_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_66_0 = 0.001

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_0 then
				arg_63_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_63_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_63_1.time_ - 0) / var_66_0)
				arg_63_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10145ui_story"].transform.position).z)
				arg_63_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["10145ui_story"].transform.localEulerAngles = arg_63_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_63_1.time_ >= 0 + var_66_0 and arg_63_1.time_ < 0 + var_66_0 + arg_66_0 then
				arg_63_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_63_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_63_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_63_1.actors_["10145ui_story"].transform.position).z)
				arg_63_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_63_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_63_1.actors_["10145ui_story"].transform.localEulerAngles = arg_63_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_66_1 = arg_63_1.actors_["10145ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10145ui_story == nil then
				arg_63_1.var_.characterEffect10145ui_story = var_66_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_2 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_2 and not isNil(var_66_1) then
				if arg_63_1.var_.characterEffect10145ui_story and not isNil(var_66_1) then
					arg_63_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_63_1.time_ >= 0 + var_66_2 and arg_63_1.time_ < 0 + var_66_2 + arg_66_0 and not isNil(var_66_1) and arg_63_1.var_.characterEffect10145ui_story then
				arg_63_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_66_4 = arg_63_1.actors_["1047ui_story"]

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1047ui_story == nil then
				arg_63_1.var_.characterEffect1047ui_story = var_66_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_66_5 = 0.200000002980232

			if 0 <= arg_63_1.time_ and arg_63_1.time_ < 0 + var_66_5 and not isNil(var_66_4) then
				if arg_63_1.var_.characterEffect1047ui_story and not isNil(var_66_4) then
					arg_63_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_63_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_63_1.time_ - 0) / var_66_5)
				end
			end

			if arg_63_1.time_ >= 0 + var_66_5 and arg_63_1.time_ < 0 + var_66_5 + arg_66_0 and not isNil(var_66_4) and arg_63_1.var_.characterEffect1047ui_story then
				arg_63_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_63_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_2")
			end

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= 0 + arg_66_0 then
				arg_63_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_66_6 = 0
			local var_66_7 = 0.7

			if 0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_6 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				arg_63_1.leftNameTxt_.text = arg_63_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, false)
				arg_63_1.callingController_:SetSelectedState("normal")

				local var_66_8 = arg_63_1:GetWordFromCfg(421101015)
				local var_66_9 = arg_63_1:FormatText(var_66_8.content)

				arg_63_1.text_.text = var_66_9

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_11 = 28 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_9) / 28)

				if (28 <= 0 and var_66_7 or var_66_7 * (utf8.len(var_66_9) / 28)) > 0 and var_66_7 < var_66_11 then
					arg_63_1.talkMaxDuration = var_66_11

					if var_66_11 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_11 + var_66_6
					end
				end

				arg_63_1.text_.text = var_66_9
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101015", "story_v_out_421101.awb") ~= 0 then
					local var_66_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101015", "story_v_out_421101.awb") / 1000

					if var_66_12 + var_66_6 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_12 + var_66_6
					end

					if var_66_8.prefab_name ~= "" and arg_63_1.actors_[var_66_8.prefab_name] ~= nil then
						local var_66_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_8.prefab_name].transform, "story_v_out_421101", "421101015", "story_v_out_421101.awb")

						arg_63_1:RecordAudio("421101015", var_66_13)
						arg_63_1:RecordAudio("421101015", var_66_13)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_421101", "421101015", "story_v_out_421101.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_421101", "421101015", "story_v_out_421101.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_14 = math.max(var_66_7, arg_63_1.talkMaxDuration)

			if var_66_6 <= arg_63_1.time_ and arg_63_1.time_ < var_66_6 + var_66_14 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_6) / var_66_14

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_6 + var_66_14 and arg_63_1.time_ < var_66_6 + var_66_14 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end

		arg_63_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_63_1:InitPlayNodeList()
	end,
	Play421101016 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 421101016
		arg_67_1.duration_ = 2

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play421101017(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1.var_.moveOldPos1047ui_story = arg_67_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_70_0 = 0.001

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_0 then
				arg_67_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_67_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_67_1.time_ - 0) / var_70_0)
				arg_67_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).z)
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles = arg_67_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_67_1.time_ >= 0 + var_70_0 and arg_67_1.time_ < 0 + var_70_0 + arg_70_0 then
				arg_67_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_67_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_67_1.actors_["1047ui_story"].transform.position).z)
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_67_1.actors_["1047ui_story"].transform.localEulerAngles = arg_67_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_70_1 = arg_67_1.actors_["1047ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1047ui_story == nil then
				arg_67_1.var_.characterEffect1047ui_story = var_70_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_2 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_2 and not isNil(var_70_1) then
				if arg_67_1.var_.characterEffect1047ui_story and not isNil(var_70_1) then
					arg_67_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_67_1.time_ >= 0 + var_70_2 and arg_67_1.time_ < 0 + var_70_2 + arg_70_0 and not isNil(var_70_1) and arg_67_1.var_.characterEffect1047ui_story then
				arg_67_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_70_4 = arg_67_1.actors_["10145ui_story"]

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect10145ui_story == nil then
				arg_67_1.var_.characterEffect10145ui_story = var_70_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_70_5 = 0.200000002980232

			if 0 <= arg_67_1.time_ and arg_67_1.time_ < 0 + var_70_5 and not isNil(var_70_4) then
				if arg_67_1.var_.characterEffect10145ui_story and not isNil(var_70_4) then
					arg_67_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_67_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_67_1.time_ - 0) / var_70_5)
				end
			end

			if arg_67_1.time_ >= 0 + var_70_5 and arg_67_1.time_ < 0 + var_70_5 + arg_70_0 and not isNil(var_70_4) and arg_67_1.var_.characterEffect10145ui_story then
				arg_67_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_67_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= 0 + arg_70_0 then
				arg_67_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action2_2")
			end

			local var_70_6 = 0
			local var_70_7 = 0.125

			if 0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_6 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				arg_67_1.leftNameTxt_.text = arg_67_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, false)
				arg_67_1.callingController_:SetSelectedState("normal")

				local var_70_8 = arg_67_1:GetWordFromCfg(421101016)
				local var_70_9 = arg_67_1:FormatText(var_70_8.content)

				arg_67_1.text_.text = var_70_9

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_11 = 5 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 5)

				if (5 <= 0 and var_70_7 or var_70_7 * (utf8.len(var_70_9) / 5)) > 0 and var_70_7 < var_70_11 then
					arg_67_1.talkMaxDuration = var_70_11

					if var_70_11 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_11 + var_70_6
					end
				end

				arg_67_1.text_.text = var_70_9
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101016", "story_v_out_421101.awb") ~= 0 then
					local var_70_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101016", "story_v_out_421101.awb") / 1000

					if var_70_12 + var_70_6 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_12 + var_70_6
					end

					if var_70_8.prefab_name ~= "" and arg_67_1.actors_[var_70_8.prefab_name] ~= nil then
						local var_70_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_8.prefab_name].transform, "story_v_out_421101", "421101016", "story_v_out_421101.awb")

						arg_67_1:RecordAudio("421101016", var_70_13)
						arg_67_1:RecordAudio("421101016", var_70_13)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_421101", "421101016", "story_v_out_421101.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_421101", "421101016", "story_v_out_421101.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_14 = math.max(var_70_7, arg_67_1.talkMaxDuration)

			if var_70_6 <= arg_67_1.time_ and arg_67_1.time_ < var_70_6 + var_70_14 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_6) / var_70_14

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_6 + var_70_14 and arg_67_1.time_ < var_70_6 + var_70_14 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end

		arg_67_1.nodeConfigList_ = {
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

		arg_67_1:InitPlayNodeList()
	end,
	Play421101017 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 421101017
		arg_71_1.duration_ = 11.57

		local var_71_0 = {
			zh = 9,
			ja = 11.566
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play421101018(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1.var_.moveOldPos10145ui_story = arg_71_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_74_0 = 0.001

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_0 then
				arg_71_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_71_1.time_ - 0) / var_74_0)
				arg_71_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10145ui_story"].transform.position).z)
				arg_71_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10145ui_story"].transform.localEulerAngles = arg_71_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_71_1.time_ >= 0 + var_74_0 and arg_71_1.time_ < 0 + var_74_0 + arg_74_0 then
				arg_71_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_71_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_71_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_71_1.actors_["10145ui_story"].transform.position).z)
				arg_71_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_71_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_71_1.actors_["10145ui_story"].transform.localEulerAngles = arg_71_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_74_1 = arg_71_1.actors_["10145ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10145ui_story == nil then
				arg_71_1.var_.characterEffect10145ui_story = var_74_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_2 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_2 and not isNil(var_74_1) then
				if arg_71_1.var_.characterEffect10145ui_story and not isNil(var_74_1) then
					arg_71_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= 0 + var_74_2 and arg_71_1.time_ < 0 + var_74_2 + arg_74_0 and not isNil(var_74_1) and arg_71_1.var_.characterEffect10145ui_story then
				arg_71_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_74_4 = arg_71_1.actors_["1047ui_story"]

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1047ui_story == nil then
				arg_71_1.var_.characterEffect1047ui_story = var_74_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_5 = 0.200000002980232

			if 0 <= arg_71_1.time_ and arg_71_1.time_ < 0 + var_74_5 and not isNil(var_74_4) then
				if arg_71_1.var_.characterEffect1047ui_story and not isNil(var_74_4) then
					arg_71_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_71_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_71_1.time_ - 0) / var_74_5)
				end
			end

			if arg_71_1.time_ >= 0 + var_74_5 and arg_71_1.time_ < 0 + var_74_5 + arg_74_0 and not isNil(var_74_4) and arg_71_1.var_.characterEffect1047ui_story then
				arg_71_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_71_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= 0 + arg_74_0 then
				arg_71_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			local var_74_6 = 0
			local var_74_7 = 1.225

			if 0 < arg_71_1.time_ and arg_71_1.time_ <= var_74_6 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				arg_71_1.leftNameTxt_.text = arg_71_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_8 = arg_71_1:GetWordFromCfg(421101017)
				local var_74_9 = arg_71_1:FormatText(var_74_8.content)

				arg_71_1.text_.text = var_74_9

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_11 = 49 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 49)

				if (49 <= 0 and var_74_7 or var_74_7 * (utf8.len(var_74_9) / 49)) > 0 and var_74_7 < var_74_11 then
					arg_71_1.talkMaxDuration = var_74_11

					if var_74_11 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_11 + var_74_6
					end
				end

				arg_71_1.text_.text = var_74_9
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101017", "story_v_out_421101.awb") ~= 0 then
					local var_74_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101017", "story_v_out_421101.awb") / 1000

					if var_74_12 + var_74_6 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_12 + var_74_6
					end

					if var_74_8.prefab_name ~= "" and arg_71_1.actors_[var_74_8.prefab_name] ~= nil then
						local var_74_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_8.prefab_name].transform, "story_v_out_421101", "421101017", "story_v_out_421101.awb")

						arg_71_1:RecordAudio("421101017", var_74_13)
						arg_71_1:RecordAudio("421101017", var_74_13)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_421101", "421101017", "story_v_out_421101.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_421101", "421101017", "story_v_out_421101.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_14 = math.max(var_74_7, arg_71_1.talkMaxDuration)

			if var_74_6 <= arg_71_1.time_ and arg_71_1.time_ < var_74_6 + var_74_14 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_6) / var_74_14

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_6 + var_74_14 and arg_71_1.time_ < var_74_6 + var_74_14 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end

		arg_71_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_71_1:InitPlayNodeList()
	end,
	Play421101018 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 421101018
		arg_75_1.duration_ = 5

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play421101019(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos10145ui_story = arg_75_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_78_0 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_0 then
				arg_75_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_0)
				arg_75_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10145ui_story"].transform.position).z)
				arg_75_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10145ui_story"].transform.localEulerAngles = arg_75_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_0 and arg_75_1.time_ < 0 + var_78_0 + arg_78_0 then
				arg_75_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_75_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_75_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_75_1.actors_["10145ui_story"].transform.position).z)
				arg_75_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_75_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_75_1.actors_["10145ui_story"].transform.localEulerAngles = arg_75_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_78_1 = arg_75_1.actors_["1047ui_story"].transform

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= 0 + arg_78_0 then
				arg_75_1.var_.moveOldPos1047ui_story = var_78_1.localPosition
			end

			local var_78_2 = 0.001

			if 0 <= arg_75_1.time_ and arg_75_1.time_ < 0 + var_78_2 then
				var_78_1.localPosition = Vector3.Lerp(arg_75_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_75_1.time_ - 0) / var_78_2)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			if arg_75_1.time_ >= 0 + var_78_2 and arg_75_1.time_ < 0 + var_78_2 + arg_78_0 then
				var_78_1.localPosition = Vector3.New(0, 100, 0)
				var_78_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_78_1.position).x, (manager.ui.mainCamera.transform.position - var_78_1.position).y, (manager.ui.mainCamera.transform.position - var_78_1.position).z)
				var_78_1.localEulerAngles.z = 0
				var_78_1.localEulerAngles.x = 0
				var_78_1.localEulerAngles = var_78_1.localEulerAngles
			end

			local var_78_3 = 0
			local var_78_4 = 1.225

			if 0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_3 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, false)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_5 = arg_75_1:FormatText(arg_75_1:GetWordFromCfg(421101018).content)

				arg_75_1.text_.text = var_78_5

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_7 = 49 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 49)

				if (49 <= 0 and var_78_4 or var_78_4 * (utf8.len(var_78_5) / 49)) > 0 and var_78_4 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_3 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_3
					end
				end

				arg_75_1.text_.text = var_78_5
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)
				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_8 = math.max(var_78_4, arg_75_1.talkMaxDuration)

			if var_78_3 <= arg_75_1.time_ and arg_75_1.time_ < var_78_3 + var_78_8 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_3) / var_78_8

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_3 + var_78_8 and arg_75_1.time_ < var_78_3 + var_78_8 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end

		arg_75_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
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

		arg_75_1:InitPlayNodeList()
	end,
	Play421101019 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 421101019
		arg_79_1.duration_ = 14.83

		local var_79_0 = {
			zh = 8.733,
			ja = 14.833
		}
		local var_79_1 = manager.audio:GetLocalizationFlag()

		if var_79_0[var_79_1] ~= nil then
			arg_79_1.duration_ = var_79_0[var_79_1]
		end

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play421101020(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1.var_.moveOldPos10145ui_story = arg_79_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_82_0 = 0.001

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_0 then
				arg_79_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_79_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_79_1.time_ - 0) / var_82_0)
				arg_79_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10145ui_story"].transform.position).z)
				arg_79_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10145ui_story"].transform.localEulerAngles = arg_79_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_79_1.time_ >= 0 + var_82_0 and arg_79_1.time_ < 0 + var_82_0 + arg_82_0 then
				arg_79_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_79_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_79_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_79_1.actors_["10145ui_story"].transform.position).z)
				arg_79_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_79_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_79_1.actors_["10145ui_story"].transform.localEulerAngles = arg_79_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_82_1 = arg_79_1.actors_["10145ui_story"]

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10145ui_story == nil then
				arg_79_1.var_.characterEffect10145ui_story = var_82_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if 0 <= arg_79_1.time_ and arg_79_1.time_ < 0 + var_82_2 and not isNil(var_82_1) then
				if arg_79_1.var_.characterEffect10145ui_story and not isNil(var_82_1) then
					arg_79_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_79_1.time_ >= 0 + var_82_2 and arg_79_1.time_ < 0 + var_82_2 + arg_82_0 and not isNil(var_82_1) and arg_79_1.var_.characterEffect10145ui_story then
				arg_79_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= 0 + arg_82_0 then
				arg_79_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_82_4 = 0
			local var_82_5 = 1.1

			if 0 < arg_79_1.time_ and arg_79_1.time_ <= var_82_4 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, true)

				arg_79_1.leftNameTxt_.text = arg_79_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_79_1.leftNameTxt_.transform)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1.leftNameTxt_.text)
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_6 = arg_79_1:GetWordFromCfg(421101019)
				local var_82_7 = arg_79_1:FormatText(var_82_6.content)

				arg_79_1.text_.text = var_82_7

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_9 = 44 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 44)

				if (44 <= 0 and var_82_5 or var_82_5 * (utf8.len(var_82_7) / 44)) > 0 and var_82_5 < var_82_9 then
					arg_79_1.talkMaxDuration = var_82_9

					if var_82_9 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_9 + var_82_4
					end
				end

				arg_79_1.text_.text = var_82_7
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101019", "story_v_out_421101.awb") ~= 0 then
					local var_82_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101019", "story_v_out_421101.awb") / 1000

					if var_82_10 + var_82_4 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_10 + var_82_4
					end

					if var_82_6.prefab_name ~= "" and arg_79_1.actors_[var_82_6.prefab_name] ~= nil then
						local var_82_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_79_1.actors_[var_82_6.prefab_name].transform, "story_v_out_421101", "421101019", "story_v_out_421101.awb")

						arg_79_1:RecordAudio("421101019", var_82_11)
						arg_79_1:RecordAudio("421101019", var_82_11)
					else
						arg_79_1:AudioAction("play", "voice", "story_v_out_421101", "421101019", "story_v_out_421101.awb")
					end

					arg_79_1:RecordHistoryTalkVoice("story_v_out_421101", "421101019", "story_v_out_421101.awb")
				end

				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_12 = math.max(var_82_5, arg_79_1.talkMaxDuration)

			if var_82_4 <= arg_79_1.time_ and arg_79_1.time_ < var_82_4 + var_82_12 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_4) / var_82_12

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_4 + var_82_12 and arg_79_1.time_ < var_82_4 + var_82_12 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end

		arg_79_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_79_1:InitPlayNodeList()
	end,
	Play421101020 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 421101020
		arg_83_1.duration_ = 12.03

		local var_83_0 = {
			zh = 9.366,
			ja = 12.033
		}
		local var_83_1 = manager.audio:GetLocalizationFlag()

		if var_83_0[var_83_1] ~= nil then
			arg_83_1.duration_ = var_83_0[var_83_1]
		end

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play421101021(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 1.3

			if 0 < arg_83_1.time_ and arg_83_1.time_ <= 0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, true)

				arg_83_1.leftNameTxt_.text = arg_83_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_83_1.leftNameTxt_.transform)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1.leftNameTxt_.text)
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_1 = arg_83_1:GetWordFromCfg(421101020)
				local var_86_2 = arg_83_1:FormatText(var_86_1.content)

				arg_83_1.text_.text = var_86_2

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 52 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 52)

				if (52 <= 0 and var_86_0 or var_86_0 * (utf8.len(var_86_2) / 52)) > 0 and var_86_0 < var_86_4 then
					arg_83_1.talkMaxDuration = var_86_4

					if var_86_4 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_4 + 0
					end
				end

				arg_83_1.text_.text = var_86_2
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101020", "story_v_out_421101.awb") ~= 0 then
					local var_86_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101020", "story_v_out_421101.awb") / 1000

					if var_86_5 + 0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_5 + 0
					end

					if var_86_1.prefab_name ~= "" and arg_83_1.actors_[var_86_1.prefab_name] ~= nil then
						local var_86_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_83_1.actors_[var_86_1.prefab_name].transform, "story_v_out_421101", "421101020", "story_v_out_421101.awb")

						arg_83_1:RecordAudio("421101020", var_86_6)
						arg_83_1:RecordAudio("421101020", var_86_6)
					else
						arg_83_1:AudioAction("play", "voice", "story_v_out_421101", "421101020", "story_v_out_421101.awb")
					end

					arg_83_1:RecordHistoryTalkVoice("story_v_out_421101", "421101020", "story_v_out_421101.awb")
				end

				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_0, arg_83_1.talkMaxDuration)

			if 0 <= arg_83_1.time_ and arg_83_1.time_ < 0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - 0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= 0 + var_86_7 and arg_83_1.time_ < 0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end

		arg_83_1.nodeConfigList_ = {}

		arg_83_1:InitPlayNodeList()
	end,
	Play421101021 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 421101021
		arg_87_1.duration_ = 16.53

		local var_87_0 = {
			zh = 12.8,
			ja = 16.533
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play421101022(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action5_1")
			end

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= 0 + arg_90_0 then
				arg_87_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_90_0 = 0
			local var_90_1 = 1.25

			if 0 < arg_87_1.time_ and arg_87_1.time_ <= var_90_0 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0
				arg_87_1.dialogCg_.alpha = 1

				arg_87_1.dialog_:SetActive(true)
				SetActive(arg_87_1.leftNameGo_, true)

				arg_87_1.leftNameTxt_.text = arg_87_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_2 = arg_87_1:GetWordFromCfg(421101021)
				local var_90_3 = arg_87_1:FormatText(var_90_2.content)

				arg_87_1.text_.text = var_90_3

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_5 = 50 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 50)

				if (50 <= 0 and var_90_1 or var_90_1 * (utf8.len(var_90_3) / 50)) > 0 and var_90_1 < var_90_5 then
					arg_87_1.talkMaxDuration = var_90_5

					if var_90_5 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_5 + var_90_0
					end
				end

				arg_87_1.text_.text = var_90_3
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101021", "story_v_out_421101.awb") ~= 0 then
					local var_90_6 = manager.audio:GetVoiceLength("story_v_out_421101", "421101021", "story_v_out_421101.awb") / 1000

					if var_90_6 + var_90_0 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_6 + var_90_0
					end

					if var_90_2.prefab_name ~= "" and arg_87_1.actors_[var_90_2.prefab_name] ~= nil then
						local var_90_7 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_2.prefab_name].transform, "story_v_out_421101", "421101021", "story_v_out_421101.awb")

						arg_87_1:RecordAudio("421101021", var_90_7)
						arg_87_1:RecordAudio("421101021", var_90_7)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_421101", "421101021", "story_v_out_421101.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_421101", "421101021", "story_v_out_421101.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_8 = math.max(var_90_1, arg_87_1.talkMaxDuration)

			if var_90_0 <= arg_87_1.time_ and arg_87_1.time_ < var_90_0 + var_90_8 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_0) / var_90_8

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_0 + var_90_8 and arg_87_1.time_ < var_90_0 + var_90_8 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end

		arg_87_1.nodeConfigList_ = {}

		arg_87_1:InitPlayNodeList()
	end,
	Play421101022 = function(arg_91_0, arg_91_1)
		arg_91_1.time_ = 0
		arg_91_1.frameCnt_ = 0
		arg_91_1.state_ = "playing"
		arg_91_1.curTalkId_ = 421101022
		arg_91_1.duration_ = 17.43

		local var_91_0 = {
			zh = 16.366,
			ja = 17.433
		}
		local var_91_1 = manager.audio:GetLocalizationFlag()

		if var_91_0[var_91_1] ~= nil then
			arg_91_1.duration_ = var_91_0[var_91_1]
		end

		SetActive(arg_91_1.tipsGo_, false)

		function arg_91_1.onSingleLineFinish_()
			arg_91_1.onSingleLineUpdate_ = nil
			arg_91_1.onSingleLineFinish_ = nil
			arg_91_1.state_ = "waiting"
		end

		function arg_91_1.playNext_(arg_93_0)
			if arg_93_0 == 1 then
				arg_91_0:Play421101023(arg_91_1)
			end
		end

		function arg_91_1.onSingleLineUpdate_(arg_94_0)
			if 2 < arg_91_1.time_ and arg_91_1.time_ <= 2 + arg_94_0 then
				local var_94_0 = arg_91_1.bgs_.I23f

				arg_91_1.bgs_.I23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_94_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_94_1 = var_94_0:GetComponent("SpriteRenderer")

				if var_94_1 and var_94_1.sprite then
					local var_94_2 = 2 * (var_94_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_94_0.transform.localScale = Vector3.New(var_94_2 / var_94_1.sprite.bounds.size.y < var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x and var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x or var_94_2 / var_94_1.sprite.bounds.size.y, var_94_2 / var_94_1.sprite.bounds.size.y < var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x and var_94_2 * manager.ui.mainCameraCom_.aspect / var_94_1.sprite.bounds.size.x or var_94_2 / var_94_1.sprite.bounds.size.y, 0)
				end

				for iter_94_0, iter_94_1 in pairs(arg_91_1.bgs_) do
					if iter_94_0 ~= "I23f" then
						iter_94_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_94_3 = 4

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_3 + arg_94_0 then
				arg_91_1.allBtn_.enabled = false
			end

			if arg_91_1.time_ >= var_94_3 + 1 and arg_91_1.time_ < var_94_3 + 1 + arg_94_0 then
				arg_91_1.allBtn_.enabled = true
			end

			local var_94_4 = 0

			if 0 < arg_91_1.time_ and arg_91_1.time_ <= var_94_4 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_5 = 2

			if var_94_4 <= arg_91_1.time_ and arg_91_1.time_ < var_94_4 + var_94_5 then
				local var_94_6 = Color.New(0, 0, 0)

				var_94_6.a = Mathf.Lerp(0, 1, (arg_91_1.time_ - var_94_4) / var_94_5)
				arg_91_1.mask_.color = var_94_6
			end

			if arg_91_1.time_ >= var_94_4 + var_94_5 and arg_91_1.time_ < var_94_4 + var_94_5 + arg_94_0 then
				local var_94_7 = Color.New(0, 0, 0)

				var_94_7.a = 1
				arg_91_1.mask_.color = var_94_7
			end

			local var_94_8 = 2

			if 2 < arg_91_1.time_ and arg_91_1.time_ <= var_94_8 + arg_94_0 then
				arg_91_1.mask_.enabled = true
				arg_91_1.mask_.raycastTarget = true

				arg_91_1:SetGaussion(false)
			end

			local var_94_9 = 2

			if var_94_8 <= arg_91_1.time_ and arg_91_1.time_ < var_94_8 + var_94_9 then
				local var_94_10 = Color.New(0, 0, 0)

				var_94_10.a = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_8) / var_94_9)
				arg_91_1.mask_.color = var_94_10
			end

			if arg_91_1.time_ >= var_94_8 + var_94_9 and arg_91_1.time_ < var_94_8 + var_94_9 + arg_94_0 then
				local var_94_11 = Color.New(0, 0, 0)

				arg_91_1.mask_.enabled = false
				var_94_11.a = 0
				arg_91_1.mask_.color = var_94_11
			end

			local var_94_12 = arg_91_1.actors_["10145ui_story"].transform

			if 1.96599999815226 < arg_91_1.time_ and arg_91_1.time_ <= 1.96599999815226 + arg_94_0 then
				arg_91_1.var_.moveOldPos10145ui_story = var_94_12.localPosition
			end

			local var_94_13 = 0.001

			if 1.96599999815226 <= arg_91_1.time_ and arg_91_1.time_ < 1.96599999815226 + var_94_13 then
				var_94_12.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_91_1.time_ - 1.96599999815226) / var_94_13)
				var_94_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_12.position).x, (manager.ui.mainCamera.transform.position - var_94_12.position).y, (manager.ui.mainCamera.transform.position - var_94_12.position).z)
				var_94_12.localEulerAngles.z = 0
				var_94_12.localEulerAngles.x = 0
				var_94_12.localEulerAngles = var_94_12.localEulerAngles
			end

			if arg_91_1.time_ >= 1.96599999815226 + var_94_13 and arg_91_1.time_ < 1.96599999815226 + var_94_13 + arg_94_0 then
				var_94_12.localPosition = Vector3.New(0, 100, 0)
				var_94_12.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_12.position).x, (manager.ui.mainCamera.transform.position - var_94_12.position).y, (manager.ui.mainCamera.transform.position - var_94_12.position).z)
				var_94_12.localEulerAngles.z = 0
				var_94_12.localEulerAngles.x = 0
				var_94_12.localEulerAngles = var_94_12.localEulerAngles
			end

			local var_94_14 = arg_91_1.actors_["10145ui_story"].transform

			if 3.8 < arg_91_1.time_ and arg_91_1.time_ <= 3.8 + arg_94_0 then
				arg_91_1.var_.moveOldPos10145ui_story = var_94_14.localPosition
			end

			local var_94_15 = 0.001

			if 3.8 <= arg_91_1.time_ and arg_91_1.time_ < 3.8 + var_94_15 then
				var_94_14.localPosition = Vector3.Lerp(arg_91_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_91_1.time_ - 3.8) / var_94_15)
				var_94_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_14.position).x, (manager.ui.mainCamera.transform.position - var_94_14.position).y, (manager.ui.mainCamera.transform.position - var_94_14.position).z)
				var_94_14.localEulerAngles.z = 0
				var_94_14.localEulerAngles.x = 0
				var_94_14.localEulerAngles = var_94_14.localEulerAngles
			end

			if arg_91_1.time_ >= 3.8 + var_94_15 and arg_91_1.time_ < 3.8 + var_94_15 + arg_94_0 then
				var_94_14.localPosition = Vector3.New(0, -1, -6.2)
				var_94_14.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_94_14.position).x, (manager.ui.mainCamera.transform.position - var_94_14.position).y, (manager.ui.mainCamera.transform.position - var_94_14.position).z)
				var_94_14.localEulerAngles.z = 0
				var_94_14.localEulerAngles.x = 0
				var_94_14.localEulerAngles = var_94_14.localEulerAngles
			end

			local var_94_16 = arg_91_1.actors_["10145ui_story"]

			if 3.8 < arg_91_1.time_ and arg_91_1.time_ <= 3.8 + arg_94_0 and not isNil(var_94_16) and arg_91_1.var_.characterEffect10145ui_story == nil then
				arg_91_1.var_.characterEffect10145ui_story = var_94_16:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_94_17 = 0.200000002980232

			if 3.8 <= arg_91_1.time_ and arg_91_1.time_ < 3.8 + var_94_17 and not isNil(var_94_16) then
				if arg_91_1.var_.characterEffect10145ui_story and not isNil(var_94_16) then
					arg_91_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_91_1.time_ >= 3.8 + var_94_17 and arg_91_1.time_ < 3.8 + var_94_17 + arg_94_0 and not isNil(var_94_16) and arg_91_1.var_.characterEffect10145ui_story then
				arg_91_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 3.8 < arg_91_1.time_ and arg_91_1.time_ <= 3.8 + arg_94_0 then
				arg_91_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 3.8 < arg_91_1.time_ and arg_91_1.time_ <= 3.8 + arg_94_0 then
				arg_91_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			if 0.1 < arg_91_1.time_ and arg_91_1.time_ <= 0.1 + arg_94_0 then
				arg_91_1:AudioAction("stop", "effect", "se_story_121_04", "se_story_121_04_officeambience_loop", "")
			end

			if 1.53333333333333 < arg_91_1.time_ and arg_91_1.time_ <= 1.53333333333333 + arg_94_0 then
				arg_91_1:AudioAction("play", "effect", "se_story_143", "se_story_143_amb_dark", "")
			end

			local var_94_21 = 1.98333333333333

			arg_91_1.isInRecall_ = false

			if var_94_21 < arg_91_1.time_ and arg_91_1.time_ <= var_94_21 + arg_94_0 then
				arg_91_1.screenFilterGo_:SetActive(false)

				for iter_94_2, iter_94_3 in pairs(arg_91_1.actors_) do
					for iter_94_4, iter_94_5 in ipairs((iter_94_3:GetComponentsInChildren(typeof(Image), true):ToTable())) do
						iter_94_5.color = iter_94_5.color.r > 0.51 and Color.New(1, 1, 1) or Color.New(0.5, 0.5, 0.5)
					end
				end
			end

			local var_94_22 = 0.0166666666666667

			if var_94_21 <= arg_91_1.time_ and arg_91_1.time_ < var_94_21 + var_94_22 then
				arg_91_1.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (arg_91_1.time_ - var_94_21) / var_94_22)
			end

			if arg_91_1.time_ >= var_94_21 + var_94_22 and arg_91_1.time_ < var_94_21 + var_94_22 + arg_94_0 then
				arg_91_1.screenFilterEffect_.weight = 0
			end

			if arg_91_1.frameCnt_ <= 1 then
				arg_91_1.dialog_:SetActive(false)
			end

			local var_94_23 = 4
			local var_94_24 = 1.35

			if 4 < arg_91_1.time_ and arg_91_1.time_ <= var_94_23 + arg_94_0 then
				arg_91_1.talkMaxDuration = 0

				arg_91_1.dialog_:SetActive(true)

				arg_91_1.dialogCg_.alpha = 0

				local var_94_25 = LeanTween.value(arg_91_1.dialog_, 0, 1, 0.3)

				var_94_25:setOnUpdate(LuaHelper.FloatAction(function(arg_95_0)
					arg_91_1.dialogCg_.alpha = arg_95_0
				end))
				var_94_25:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_91_1.dialog_)
					var_94_25:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_91_1.duration_ = arg_91_1.duration_ + 0.3

				SetActive(arg_91_1.leftNameGo_, true)

				arg_91_1.leftNameTxt_.text = arg_91_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_91_1.leftNameTxt_.transform)

				arg_91_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_91_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_91_1:RecordName(arg_91_1.leftNameTxt_.text)
				SetActive(arg_91_1.iconTrs_.gameObject, false)
				arg_91_1.callingController_:SetSelectedState("normal")

				local var_94_26 = arg_91_1:GetWordFromCfg(421101022)
				local var_94_27 = arg_91_1:FormatText(var_94_26.content)

				arg_91_1.text_.text = var_94_27

				LuaForUtil.ClearLinePrefixSymbol(arg_91_1.text_)

				local var_94_29 = 54 <= 0 and var_94_24 or var_94_24 * (utf8.len(var_94_27) / 54)

				if (54 <= 0 and var_94_24 or var_94_24 * (utf8.len(var_94_27) / 54)) > 0 and var_94_24 < var_94_29 then
					arg_91_1.talkMaxDuration = var_94_29
					var_94_23 = var_94_23 + 0.3

					if var_94_29 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_29 + var_94_23
					end
				end

				arg_91_1.text_.text = var_94_27
				arg_91_1.typewritter.percent = 0

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101022", "story_v_out_421101.awb") ~= 0 then
					local var_94_30 = manager.audio:GetVoiceLength("story_v_out_421101", "421101022", "story_v_out_421101.awb") / 1000

					if var_94_30 + var_94_23 > arg_91_1.duration_ then
						arg_91_1.duration_ = var_94_30 + var_94_23
					end

					if var_94_26.prefab_name ~= "" and arg_91_1.actors_[var_94_26.prefab_name] ~= nil then
						local var_94_31 = LuaForUtil.PlayVoiceWithCriLipsync(arg_91_1.actors_[var_94_26.prefab_name].transform, "story_v_out_421101", "421101022", "story_v_out_421101.awb")

						arg_91_1:RecordAudio("421101022", var_94_31)
						arg_91_1:RecordAudio("421101022", var_94_31)
					else
						arg_91_1:AudioAction("play", "voice", "story_v_out_421101", "421101022", "story_v_out_421101.awb")
					end

					arg_91_1:RecordHistoryTalkVoice("story_v_out_421101", "421101022", "story_v_out_421101.awb")
				end

				arg_91_1:RecordContent(arg_91_1.text_.text)
			end

			local var_94_32 = var_94_23 + 0.3
			local var_94_33 = math.max(var_94_24, arg_91_1.talkMaxDuration)

			if var_94_23 + 0.3 <= arg_91_1.time_ and arg_91_1.time_ < var_94_32 + var_94_33 then
				arg_91_1.typewritter.percent = (arg_91_1.time_ - var_94_32) / var_94_33

				arg_91_1.typewritter:SetDirty()
			end

			if arg_91_1.time_ >= var_94_32 + var_94_33 and arg_91_1.time_ < var_94_32 + var_94_33 + arg_94_0 then
				arg_91_1.typewritter.percent = 1

				arg_91_1.typewritter:SetDirty()
				arg_91_1:ShowNextGo(true)
			end
		end

		arg_91_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1.96599999815226,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 3.8,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_91_1:InitPlayNodeList()
	end,
	Play421101023 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 421101023
		arg_97_1.duration_ = 11.2

		local var_97_0 = {
			zh = 8.6,
			ja = 11.2
		}
		local var_97_1 = manager.audio:GetLocalizationFlag()

		if var_97_0[var_97_1] ~= nil then
			arg_97_1.duration_ = var_97_0[var_97_1]
		end

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play421101024(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1.var_.moveOldPos10145ui_story = arg_97_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_100_0 = 0.001

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 then
				arg_97_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_97_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_97_1.time_ - 0) / var_100_0)
				arg_97_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).z)
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles = arg_97_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 then
				arg_97_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_97_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_97_1.actors_["10145ui_story"].transform.position).z)
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_97_1.actors_["10145ui_story"].transform.localEulerAngles = arg_97_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			local var_100_1 = 0
			local var_100_2 = 1.2

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_1 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_3 = arg_97_1:GetWordFromCfg(421101023)
				local var_100_4 = arg_97_1:FormatText(var_100_3.content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 48 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 48)

				if (48 <= 0 and var_100_2 or var_100_2 * (utf8.len(var_100_4) / 48)) > 0 and var_100_2 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_1
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101023", "story_v_out_421101.awb") ~= 0 then
					local var_100_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101023", "story_v_out_421101.awb") / 1000

					if var_100_7 + var_100_1 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_7 + var_100_1
					end

					if var_100_3.prefab_name ~= "" and arg_97_1.actors_[var_100_3.prefab_name] ~= nil then
						local var_100_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_3.prefab_name].transform, "story_v_out_421101", "421101023", "story_v_out_421101.awb")

						arg_97_1:RecordAudio("421101023", var_100_8)
						arg_97_1:RecordAudio("421101023", var_100_8)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_421101", "421101023", "story_v_out_421101.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_421101", "421101023", "story_v_out_421101.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_9 = math.max(var_100_2, arg_97_1.talkMaxDuration)

			if var_100_1 <= arg_97_1.time_ and arg_97_1.time_ < var_100_1 + var_100_9 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_1) / var_100_9

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_1 + var_100_9 and arg_97_1.time_ < var_100_1 + var_100_9 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_97_1:InitPlayNodeList()
	end,
	Play421101024 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 421101024
		arg_101_1.duration_ = 10.17

		local var_101_0 = {
			zh = 7.1,
			ja = 10.166
		}
		local var_101_1 = manager.audio:GetLocalizationFlag()

		if var_101_0[var_101_1] ~= nil then
			arg_101_1.duration_ = var_101_0[var_101_1]
		end

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play421101025(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos1047ui_story = arg_101_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_104_0 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 then
				arg_101_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_101_1.time_ - 0) / var_104_0)
				arg_101_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1047ui_story"].transform.position).z)
				arg_101_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1047ui_story"].transform.localEulerAngles = arg_101_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 then
				arg_101_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_101_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_101_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_101_1.actors_["1047ui_story"].transform.position).z)
				arg_101_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_101_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_101_1.actors_["1047ui_story"].transform.localEulerAngles = arg_101_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_104_1 = arg_101_1.actors_["10145ui_story"].transform

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1.var_.moveOldPos10145ui_story = var_104_1.localPosition
			end

			local var_104_2 = 0.001

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_2 then
				var_104_1.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_101_1.time_ - 0) / var_104_2)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			if arg_101_1.time_ >= 0 + var_104_2 and arg_101_1.time_ < 0 + var_104_2 + arg_104_0 then
				var_104_1.localPosition = Vector3.New(-0.65, -1, -6.2)
				var_104_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_104_1.position).x, (manager.ui.mainCamera.transform.position - var_104_1.position).y, (manager.ui.mainCamera.transform.position - var_104_1.position).z)
				var_104_1.localEulerAngles.z = 0
				var_104_1.localEulerAngles.x = 0
				var_104_1.localEulerAngles = var_104_1.localEulerAngles
			end

			local var_104_3 = arg_101_1.actors_["1047ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1047ui_story == nil then
				arg_101_1.var_.characterEffect1047ui_story = var_104_3:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_4 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_4 and not isNil(var_104_3) then
				if arg_101_1.var_.characterEffect1047ui_story and not isNil(var_104_3) then
					arg_101_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_4 and arg_101_1.time_ < 0 + var_104_4 + arg_104_0 and not isNil(var_104_3) and arg_101_1.var_.characterEffect1047ui_story then
				arg_101_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_104_6 = arg_101_1.actors_["10145ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10145ui_story == nil then
				arg_101_1.var_.characterEffect10145ui_story = var_104_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_7 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_7 and not isNil(var_104_6) then
				if arg_101_1.var_.characterEffect10145ui_story and not isNil(var_104_6) then
					arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_7)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_7 and arg_101_1.time_ < 0 + var_104_7 + arg_104_0 and not isNil(var_104_6) and arg_101_1.var_.characterEffect10145ui_story then
				arg_101_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoC", "EmotionTimelineAnimator")
			end

			local var_104_8 = 0
			local var_104_9 = 0.825

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_8 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_10 = arg_101_1:GetWordFromCfg(421101024)
				local var_104_11 = arg_101_1:FormatText(var_104_10.content)

				arg_101_1.text_.text = var_104_11

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_13 = 33 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 33)

				if (33 <= 0 and var_104_9 or var_104_9 * (utf8.len(var_104_11) / 33)) > 0 and var_104_9 < var_104_13 then
					arg_101_1.talkMaxDuration = var_104_13

					if var_104_13 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_13 + var_104_8
					end
				end

				arg_101_1.text_.text = var_104_11
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101024", "story_v_out_421101.awb") ~= 0 then
					local var_104_14 = manager.audio:GetVoiceLength("story_v_out_421101", "421101024", "story_v_out_421101.awb") / 1000

					if var_104_14 + var_104_8 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_14 + var_104_8
					end

					if var_104_10.prefab_name ~= "" and arg_101_1.actors_[var_104_10.prefab_name] ~= nil then
						local var_104_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_101_1.actors_[var_104_10.prefab_name].transform, "story_v_out_421101", "421101024", "story_v_out_421101.awb")

						arg_101_1:RecordAudio("421101024", var_104_15)
						arg_101_1:RecordAudio("421101024", var_104_15)
					else
						arg_101_1:AudioAction("play", "voice", "story_v_out_421101", "421101024", "story_v_out_421101.awb")
					end

					arg_101_1:RecordHistoryTalkVoice("story_v_out_421101", "421101024", "story_v_out_421101.awb")
				end

				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_16 = math.max(var_104_9, arg_101_1.talkMaxDuration)

			if var_104_8 <= arg_101_1.time_ and arg_101_1.time_ < var_104_8 + var_104_16 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_8) / var_104_16

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_8 + var_104_16 and arg_101_1.time_ < var_104_8 + var_104_16 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_101_1:InitPlayNodeList()
	end,
	Play421101025 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 421101025
		arg_105_1.duration_ = 6.4

		local var_105_0 = {
			zh = 5.866,
			ja = 6.4
		}
		local var_105_1 = manager.audio:GetLocalizationFlag()

		if var_105_0[var_105_1] ~= nil then
			arg_105_1.duration_ = var_105_0[var_105_1]
		end

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play421101026(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1.var_.moveOldPos10145ui_story = arg_105_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_108_0 = 0.001

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 then
				arg_105_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_105_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_105_1.time_ - 0) / var_108_0)
				arg_105_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).z)
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles = arg_105_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 then
				arg_105_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_105_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_105_1.actors_["10145ui_story"].transform.position).z)
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_105_1.actors_["10145ui_story"].transform.localEulerAngles = arg_105_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_108_1 = arg_105_1.actors_["10145ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10145ui_story == nil then
				arg_105_1.var_.characterEffect10145ui_story = var_108_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_2 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_2 and not isNil(var_108_1) then
				if arg_105_1.var_.characterEffect10145ui_story and not isNil(var_108_1) then
					arg_105_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_105_1.time_ >= 0 + var_108_2 and arg_105_1.time_ < 0 + var_108_2 + arg_108_0 and not isNil(var_108_1) and arg_105_1.var_.characterEffect10145ui_story then
				arg_105_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_108_4 = arg_105_1.actors_["1047ui_story"]

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1047ui_story == nil then
				arg_105_1.var_.characterEffect1047ui_story = var_108_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_5 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_5 and not isNil(var_108_4) then
				if arg_105_1.var_.characterEffect1047ui_story and not isNil(var_108_4) then
					arg_105_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_5)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_5 and arg_105_1.time_ < 0 + var_108_5 + arg_108_0 and not isNil(var_108_4) and arg_105_1.var_.characterEffect1047ui_story then
				arg_105_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 then
				arg_105_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_2")
			end

			local var_108_6 = 0
			local var_108_7 = 0.675

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_6 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, true)

				arg_105_1.leftNameTxt_.text = arg_105_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_105_1.leftNameTxt_.transform)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1.leftNameTxt_.text)
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_8 = arg_105_1:GetWordFromCfg(421101025)
				local var_108_9 = arg_105_1:FormatText(var_108_8.content)

				arg_105_1.text_.text = var_108_9

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_11 = 27 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 27)

				if (27 <= 0 and var_108_7 or var_108_7 * (utf8.len(var_108_9) / 27)) > 0 and var_108_7 < var_108_11 then
					arg_105_1.talkMaxDuration = var_108_11

					if var_108_11 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_11 + var_108_6
					end
				end

				arg_105_1.text_.text = var_108_9
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101025", "story_v_out_421101.awb") ~= 0 then
					local var_108_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101025", "story_v_out_421101.awb") / 1000

					if var_108_12 + var_108_6 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_12 + var_108_6
					end

					if var_108_8.prefab_name ~= "" and arg_105_1.actors_[var_108_8.prefab_name] ~= nil then
						local var_108_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_105_1.actors_[var_108_8.prefab_name].transform, "story_v_out_421101", "421101025", "story_v_out_421101.awb")

						arg_105_1:RecordAudio("421101025", var_108_13)
						arg_105_1:RecordAudio("421101025", var_108_13)
					else
						arg_105_1:AudioAction("play", "voice", "story_v_out_421101", "421101025", "story_v_out_421101.awb")
					end

					arg_105_1:RecordHistoryTalkVoice("story_v_out_421101", "421101025", "story_v_out_421101.awb")
				end

				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_14 = math.max(var_108_7, arg_105_1.talkMaxDuration)

			if var_108_6 <= arg_105_1.time_ and arg_105_1.time_ < var_108_6 + var_108_14 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_6) / var_108_14

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_6 + var_108_14 and arg_105_1.time_ < var_108_6 + var_108_14 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_105_1:InitPlayNodeList()
	end,
	Play421101026 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 421101026
		arg_109_1.duration_ = 4.9

		local var_109_0 = {
			zh = 2.3,
			ja = 4.9
		}
		local var_109_1 = manager.audio:GetLocalizationFlag()

		if var_109_0[var_109_1] ~= nil then
			arg_109_1.duration_ = var_109_0[var_109_1]
		end

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play421101027(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1.var_.moveOldPos1047ui_story = arg_109_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_112_0 = 0.001

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 then
				arg_109_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_109_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_109_1.time_ - 0) / var_112_0)
				arg_109_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1047ui_story"].transform.position).z)
				arg_109_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1047ui_story"].transform.localEulerAngles = arg_109_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 then
				arg_109_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_109_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_109_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_109_1.actors_["1047ui_story"].transform.position).z)
				arg_109_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_109_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_109_1.actors_["1047ui_story"].transform.localEulerAngles = arg_109_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_112_1 = arg_109_1.actors_["1047ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1047ui_story == nil then
				arg_109_1.var_.characterEffect1047ui_story = var_112_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_2 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_2 and not isNil(var_112_1) then
				if arg_109_1.var_.characterEffect1047ui_story and not isNil(var_112_1) then
					arg_109_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_2 and arg_109_1.time_ < 0 + var_112_2 + arg_112_0 and not isNil(var_112_1) and arg_109_1.var_.characterEffect1047ui_story then
				arg_109_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_112_4 = arg_109_1.actors_["10145ui_story"]

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10145ui_story == nil then
				arg_109_1.var_.characterEffect10145ui_story = var_112_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_5 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_5 and not isNil(var_112_4) then
				if arg_109_1.var_.characterEffect10145ui_story and not isNil(var_112_4) then
					arg_109_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_109_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_109_1.time_ - 0) / var_112_5)
				end
			end

			if arg_109_1.time_ >= 0 + var_112_5 and arg_109_1.time_ < 0 + var_112_5 + arg_112_0 and not isNil(var_112_4) and arg_109_1.var_.characterEffect10145ui_story then
				arg_109_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_109_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_112_6 = 0
			local var_112_7 = 0.3

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_6 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_8 = arg_109_1:GetWordFromCfg(421101026)
				local var_112_9 = arg_109_1:FormatText(var_112_8.content)

				arg_109_1.text_.text = var_112_9

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_11 = 12 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 12)

				if (12 <= 0 and var_112_7 or var_112_7 * (utf8.len(var_112_9) / 12)) > 0 and var_112_7 < var_112_11 then
					arg_109_1.talkMaxDuration = var_112_11

					if var_112_11 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_11 + var_112_6
					end
				end

				arg_109_1.text_.text = var_112_9
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101026", "story_v_out_421101.awb") ~= 0 then
					local var_112_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101026", "story_v_out_421101.awb") / 1000

					if var_112_12 + var_112_6 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_12 + var_112_6
					end

					if var_112_8.prefab_name ~= "" and arg_109_1.actors_[var_112_8.prefab_name] ~= nil then
						local var_112_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_109_1.actors_[var_112_8.prefab_name].transform, "story_v_out_421101", "421101026", "story_v_out_421101.awb")

						arg_109_1:RecordAudio("421101026", var_112_13)
						arg_109_1:RecordAudio("421101026", var_112_13)
					else
						arg_109_1:AudioAction("play", "voice", "story_v_out_421101", "421101026", "story_v_out_421101.awb")
					end

					arg_109_1:RecordHistoryTalkVoice("story_v_out_421101", "421101026", "story_v_out_421101.awb")
				end

				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_14 = math.max(var_112_7, arg_109_1.talkMaxDuration)

			if var_112_6 <= arg_109_1.time_ and arg_109_1.time_ < var_112_6 + var_112_14 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_6) / var_112_14

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_6 + var_112_14 and arg_109_1.time_ < var_112_6 + var_112_14 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {
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

		arg_109_1:InitPlayNodeList()
	end,
	Play421101027 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 421101027
		arg_113_1.duration_ = 2.63

		local var_113_0 = {
			zh = 2,
			ja = 2.633
		}
		local var_113_1 = manager.audio:GetLocalizationFlag()

		if var_113_0[var_113_1] ~= nil then
			arg_113_1.duration_ = var_113_0[var_113_1]
		end

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play421101028(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1.var_.moveOldPos10145ui_story = arg_113_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_116_0 = 0.001

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 then
				arg_113_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_113_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_113_1.time_ - 0) / var_116_0)
				arg_113_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).z)
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles = arg_113_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 then
				arg_113_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_113_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_113_1.actors_["10145ui_story"].transform.position).z)
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_113_1.actors_["10145ui_story"].transform.localEulerAngles = arg_113_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_116_1 = arg_113_1.actors_["10145ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10145ui_story == nil then
				arg_113_1.var_.characterEffect10145ui_story = var_116_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_2 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_2 and not isNil(var_116_1) then
				if arg_113_1.var_.characterEffect10145ui_story and not isNil(var_116_1) then
					arg_113_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_2 and arg_113_1.time_ < 0 + var_116_2 + arg_116_0 and not isNil(var_116_1) and arg_113_1.var_.characterEffect10145ui_story then
				arg_113_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_116_4 = arg_113_1.actors_["1047ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1047ui_story == nil then
				arg_113_1.var_.characterEffect1047ui_story = var_116_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_5 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_5 and not isNil(var_116_4) then
				if arg_113_1.var_.characterEffect1047ui_story and not isNil(var_116_4) then
					arg_113_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_113_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_5)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_5 and arg_113_1.time_ < 0 + var_116_5 + arg_116_0 and not isNil(var_116_4) and arg_113_1.var_.characterEffect1047ui_story then
				arg_113_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_113_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_1")
			end

			local var_116_6 = 0
			local var_116_7 = 0.175

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_6 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_8 = arg_113_1:GetWordFromCfg(421101027)
				local var_116_9 = arg_113_1:FormatText(var_116_8.content)

				arg_113_1.text_.text = var_116_9

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_11 = 10 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 10)

				if (10 <= 0 and var_116_7 or var_116_7 * (utf8.len(var_116_9) / 10)) > 0 and var_116_7 < var_116_11 then
					arg_113_1.talkMaxDuration = var_116_11

					if var_116_11 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_11 + var_116_6
					end
				end

				arg_113_1.text_.text = var_116_9
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101027", "story_v_out_421101.awb") ~= 0 then
					local var_116_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101027", "story_v_out_421101.awb") / 1000

					if var_116_12 + var_116_6 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_12 + var_116_6
					end

					if var_116_8.prefab_name ~= "" and arg_113_1.actors_[var_116_8.prefab_name] ~= nil then
						local var_116_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_113_1.actors_[var_116_8.prefab_name].transform, "story_v_out_421101", "421101027", "story_v_out_421101.awb")

						arg_113_1:RecordAudio("421101027", var_116_13)
						arg_113_1:RecordAudio("421101027", var_116_13)
					else
						arg_113_1:AudioAction("play", "voice", "story_v_out_421101", "421101027", "story_v_out_421101.awb")
					end

					arg_113_1:RecordHistoryTalkVoice("story_v_out_421101", "421101027", "story_v_out_421101.awb")
				end

				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_14 = math.max(var_116_7, arg_113_1.talkMaxDuration)

			if var_116_6 <= arg_113_1.time_ and arg_113_1.time_ < var_116_6 + var_116_14 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_6) / var_116_14

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_6 + var_116_14 and arg_113_1.time_ < var_116_6 + var_116_14 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_113_1:InitPlayNodeList()
	end,
	Play421101028 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 421101028
		arg_117_1.duration_ = 15.47

		local var_117_0 = {
			zh = 11.633,
			ja = 15.466
		}
		local var_117_1 = manager.audio:GetLocalizationFlag()

		if var_117_0[var_117_1] ~= nil then
			arg_117_1.duration_ = var_117_0[var_117_1]
		end

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play421101029(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1.var_.moveOldPos1047ui_story = arg_117_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_120_0 = 0.001

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 then
				arg_117_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_117_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_117_1.time_ - 0) / var_120_0)
				arg_117_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).z)
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles = arg_117_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 then
				arg_117_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_117_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_117_1.actors_["1047ui_story"].transform.position).z)
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_117_1.actors_["1047ui_story"].transform.localEulerAngles = arg_117_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_120_1 = arg_117_1.actors_["1047ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1047ui_story == nil then
				arg_117_1.var_.characterEffect1047ui_story = var_120_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_2 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_2 and not isNil(var_120_1) then
				if arg_117_1.var_.characterEffect1047ui_story and not isNil(var_120_1) then
					arg_117_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_117_1.time_ >= 0 + var_120_2 and arg_117_1.time_ < 0 + var_120_2 + arg_120_0 and not isNil(var_120_1) and arg_117_1.var_.characterEffect1047ui_story then
				arg_117_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_120_4 = arg_117_1.actors_["10145ui_story"]

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10145ui_story == nil then
				arg_117_1.var_.characterEffect10145ui_story = var_120_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_5 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_5 and not isNil(var_120_4) then
				if arg_117_1.var_.characterEffect10145ui_story and not isNil(var_120_4) then
					arg_117_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_117_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_5)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_5 and arg_117_1.time_ < 0 + var_120_5 + arg_120_0 and not isNil(var_120_4) and arg_117_1.var_.characterEffect10145ui_story then
				arg_117_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_117_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 then
				arg_117_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_120_6 = 0
			local var_120_7 = 1.15

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_6 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, true)

				arg_117_1.leftNameTxt_.text = arg_117_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_117_1.leftNameTxt_.transform)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1.leftNameTxt_.text)
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_8 = arg_117_1:GetWordFromCfg(421101028)
				local var_120_9 = arg_117_1:FormatText(var_120_8.content)

				arg_117_1.text_.text = var_120_9

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_11 = 46 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 46)

				if (46 <= 0 and var_120_7 or var_120_7 * (utf8.len(var_120_9) / 46)) > 0 and var_120_7 < var_120_11 then
					arg_117_1.talkMaxDuration = var_120_11

					if var_120_11 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_11 + var_120_6
					end
				end

				arg_117_1.text_.text = var_120_9
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101028", "story_v_out_421101.awb") ~= 0 then
					local var_120_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101028", "story_v_out_421101.awb") / 1000

					if var_120_12 + var_120_6 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_12 + var_120_6
					end

					if var_120_8.prefab_name ~= "" and arg_117_1.actors_[var_120_8.prefab_name] ~= nil then
						local var_120_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_117_1.actors_[var_120_8.prefab_name].transform, "story_v_out_421101", "421101028", "story_v_out_421101.awb")

						arg_117_1:RecordAudio("421101028", var_120_13)
						arg_117_1:RecordAudio("421101028", var_120_13)
					else
						arg_117_1:AudioAction("play", "voice", "story_v_out_421101", "421101028", "story_v_out_421101.awb")
					end

					arg_117_1:RecordHistoryTalkVoice("story_v_out_421101", "421101028", "story_v_out_421101.awb")
				end

				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_14 = math.max(var_120_7, arg_117_1.talkMaxDuration)

			if var_120_6 <= arg_117_1.time_ and arg_117_1.time_ < var_120_6 + var_120_14 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_6) / var_120_14

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_6 + var_120_14 and arg_117_1.time_ < var_120_6 + var_120_14 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {
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

		arg_117_1:InitPlayNodeList()
	end,
	Play421101029 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 421101029
		arg_121_1.duration_ = 3.9

		local var_121_0 = {
			zh = 3.7,
			ja = 3.9
		}
		local var_121_1 = manager.audio:GetLocalizationFlag()

		if var_121_0[var_121_1] ~= nil then
			arg_121_1.duration_ = var_121_0[var_121_1]
		end

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play421101030(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1.var_.moveOldPos1047ui_story = arg_121_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_124_0 = 0.001

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 then
				arg_121_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_121_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_121_1.time_ - 0) / var_124_0)
				arg_121_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1047ui_story"].transform.position).z)
				arg_121_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1047ui_story"].transform.localEulerAngles = arg_121_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 then
				arg_121_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_121_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_121_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_121_1.actors_["1047ui_story"].transform.position).z)
				arg_121_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_121_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_121_1.actors_["1047ui_story"].transform.localEulerAngles = arg_121_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			local var_124_1 = 0
			local var_124_2 = 0.325

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_1 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_3 = arg_121_1:GetWordFromCfg(421101029)
				local var_124_4 = arg_121_1:FormatText(var_124_3.content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 13 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 13)

				if (13 <= 0 and var_124_2 or var_124_2 * (utf8.len(var_124_4) / 13)) > 0 and var_124_2 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_1
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101029", "story_v_out_421101.awb") ~= 0 then
					local var_124_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101029", "story_v_out_421101.awb") / 1000

					if var_124_7 + var_124_1 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_7 + var_124_1
					end

					if var_124_3.prefab_name ~= "" and arg_121_1.actors_[var_124_3.prefab_name] ~= nil then
						local var_124_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_121_1.actors_[var_124_3.prefab_name].transform, "story_v_out_421101", "421101029", "story_v_out_421101.awb")

						arg_121_1:RecordAudio("421101029", var_124_8)
						arg_121_1:RecordAudio("421101029", var_124_8)
					else
						arg_121_1:AudioAction("play", "voice", "story_v_out_421101", "421101029", "story_v_out_421101.awb")
					end

					arg_121_1:RecordHistoryTalkVoice("story_v_out_421101", "421101029", "story_v_out_421101.awb")
				end

				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_9 = math.max(var_124_2, arg_121_1.talkMaxDuration)

			if var_124_1 <= arg_121_1.time_ and arg_121_1.time_ < var_124_1 + var_124_9 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_1) / var_124_9

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_1 + var_124_9 and arg_121_1.time_ < var_124_1 + var_124_9 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {
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

		arg_121_1:InitPlayNodeList()
	end,
	Play421101030 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 421101030
		arg_125_1.duration_ = 3

		local var_125_0 = {
			zh = 1.999999999999,
			ja = 3
		}
		local var_125_1 = manager.audio:GetLocalizationFlag()

		if var_125_0[var_125_1] ~= nil then
			arg_125_1.duration_ = var_125_0[var_125_1]
		end

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play421101031(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1.var_.moveOldPos10145ui_story = arg_125_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_128_0 = 0.001

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_0 then
				arg_125_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_125_1.time_ - 0) / var_128_0)
				arg_125_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).z)
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles = arg_125_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_125_1.time_ >= 0 + var_128_0 and arg_125_1.time_ < 0 + var_128_0 + arg_128_0 then
				arg_125_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_125_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_125_1.actors_["10145ui_story"].transform.position).z)
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_125_1.actors_["10145ui_story"].transform.localEulerAngles = arg_125_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_128_1 = arg_125_1.actors_["10145ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10145ui_story == nil then
				arg_125_1.var_.characterEffect10145ui_story = var_128_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_2 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_2 and not isNil(var_128_1) then
				if arg_125_1.var_.characterEffect10145ui_story and not isNil(var_128_1) then
					arg_125_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_125_1.time_ >= 0 + var_128_2 and arg_125_1.time_ < 0 + var_128_2 + arg_128_0 and not isNil(var_128_1) and arg_125_1.var_.characterEffect10145ui_story then
				arg_125_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_128_4 = arg_125_1.actors_["1047ui_story"]

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1047ui_story == nil then
				arg_125_1.var_.characterEffect1047ui_story = var_128_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_5 = 0.200000002980232

			if 0 <= arg_125_1.time_ and arg_125_1.time_ < 0 + var_128_5 and not isNil(var_128_4) then
				if arg_125_1.var_.characterEffect1047ui_story and not isNil(var_128_4) then
					arg_125_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 0) / var_128_5)
				end
			end

			if arg_125_1.time_ >= 0 + var_128_5 and arg_125_1.time_ < 0 + var_128_5 + arg_128_0 and not isNil(var_128_4) and arg_125_1.var_.characterEffect1047ui_story then
				arg_125_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action4_2")
			end

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= 0 + arg_128_0 then
				arg_125_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_128_6 = 0
			local var_128_7 = 0.175

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_6 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0
				arg_125_1.dialogCg_.alpha = 1

				arg_125_1.dialog_:SetActive(true)
				SetActive(arg_125_1.leftNameGo_, true)

				arg_125_1.leftNameTxt_.text = arg_125_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_125_1.leftNameTxt_.transform)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1.leftNameTxt_.text)
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_8 = arg_125_1:GetWordFromCfg(421101030)
				local var_128_9 = arg_125_1:FormatText(var_128_8.content)

				arg_125_1.text_.text = var_128_9

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_11 = 7 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 7)

				if (7 <= 0 and var_128_7 or var_128_7 * (utf8.len(var_128_9) / 7)) > 0 and var_128_7 < var_128_11 then
					arg_125_1.talkMaxDuration = var_128_11

					if var_128_11 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_11 + var_128_6
					end
				end

				arg_125_1.text_.text = var_128_9
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101030", "story_v_out_421101.awb") ~= 0 then
					local var_128_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101030", "story_v_out_421101.awb") / 1000

					if var_128_12 + var_128_6 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_12 + var_128_6
					end

					if var_128_8.prefab_name ~= "" and arg_125_1.actors_[var_128_8.prefab_name] ~= nil then
						local var_128_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_125_1.actors_[var_128_8.prefab_name].transform, "story_v_out_421101", "421101030", "story_v_out_421101.awb")

						arg_125_1:RecordAudio("421101030", var_128_13)
						arg_125_1:RecordAudio("421101030", var_128_13)
					else
						arg_125_1:AudioAction("play", "voice", "story_v_out_421101", "421101030", "story_v_out_421101.awb")
					end

					arg_125_1:RecordHistoryTalkVoice("story_v_out_421101", "421101030", "story_v_out_421101.awb")
				end

				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_14 = math.max(var_128_7, arg_125_1.talkMaxDuration)

			if var_128_6 <= arg_125_1.time_ and arg_125_1.time_ < var_128_6 + var_128_14 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_6) / var_128_14

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_6 + var_128_14 and arg_125_1.time_ < var_128_6 + var_128_14 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play421101031 = function(arg_129_0, arg_129_1)
		arg_129_1.time_ = 0
		arg_129_1.frameCnt_ = 0
		arg_129_1.state_ = "playing"
		arg_129_1.curTalkId_ = 421101031
		arg_129_1.duration_ = 21

		local var_129_0 = {
			zh = 13.933,
			ja = 21
		}
		local var_129_1 = manager.audio:GetLocalizationFlag()

		if var_129_0[var_129_1] ~= nil then
			arg_129_1.duration_ = var_129_0[var_129_1]
		end

		SetActive(arg_129_1.tipsGo_, false)

		function arg_129_1.onSingleLineFinish_()
			arg_129_1.onSingleLineUpdate_ = nil
			arg_129_1.onSingleLineFinish_ = nil
			arg_129_1.state_ = "waiting"
		end

		function arg_129_1.playNext_(arg_131_0)
			if arg_131_0 == 1 then
				arg_129_0:Play421101032(arg_129_1)
			end
		end

		function arg_129_1.onSingleLineUpdate_(arg_132_0)
			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1.var_.moveOldPos1047ui_story = arg_129_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_132_0 = 0.001

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_0 then
				arg_129_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_129_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_129_1.time_ - 0) / var_132_0)
				arg_129_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1047ui_story"].transform.position).z)
				arg_129_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1047ui_story"].transform.localEulerAngles = arg_129_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_129_1.time_ >= 0 + var_132_0 and arg_129_1.time_ < 0 + var_132_0 + arg_132_0 then
				arg_129_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_129_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_129_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_129_1.actors_["1047ui_story"].transform.position).z)
				arg_129_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_129_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_129_1.actors_["1047ui_story"].transform.localEulerAngles = arg_129_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_132_1 = arg_129_1.actors_["1047ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1047ui_story == nil then
				arg_129_1.var_.characterEffect1047ui_story = var_132_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_2 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_2 and not isNil(var_132_1) then
				if arg_129_1.var_.characterEffect1047ui_story and not isNil(var_132_1) then
					arg_129_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_129_1.time_ >= 0 + var_132_2 and arg_129_1.time_ < 0 + var_132_2 + arg_132_0 and not isNil(var_132_1) and arg_129_1.var_.characterEffect1047ui_story then
				arg_129_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_132_4 = arg_129_1.actors_["10145ui_story"]

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10145ui_story == nil then
				arg_129_1.var_.characterEffect10145ui_story = var_132_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_132_5 = 0.200000002980232

			if 0 <= arg_129_1.time_ and arg_129_1.time_ < 0 + var_132_5 and not isNil(var_132_4) then
				if arg_129_1.var_.characterEffect10145ui_story and not isNil(var_132_4) then
					arg_129_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_129_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_129_1.time_ - 0) / var_132_5)
				end
			end

			if arg_129_1.time_ >= 0 + var_132_5 and arg_129_1.time_ < 0 + var_132_5 + arg_132_0 and not isNil(var_132_4) and arg_129_1.var_.characterEffect10145ui_story then
				arg_129_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_129_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047actionlink/1047action437")
			end

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= 0 + arg_132_0 then
				arg_129_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_132_6 = 0
			local var_132_7 = 1.325

			if 0 < arg_129_1.time_ and arg_129_1.time_ <= var_132_6 + arg_132_0 then
				arg_129_1.talkMaxDuration = 0
				arg_129_1.dialogCg_.alpha = 1

				arg_129_1.dialog_:SetActive(true)
				SetActive(arg_129_1.leftNameGo_, true)

				arg_129_1.leftNameTxt_.text = arg_129_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_129_1.leftNameTxt_.transform)

				arg_129_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_129_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_129_1:RecordName(arg_129_1.leftNameTxt_.text)
				SetActive(arg_129_1.iconTrs_.gameObject, false)
				arg_129_1.callingController_:SetSelectedState("normal")

				local var_132_8 = arg_129_1:GetWordFromCfg(421101031)
				local var_132_9 = arg_129_1:FormatText(var_132_8.content)

				arg_129_1.text_.text = var_132_9

				LuaForUtil.ClearLinePrefixSymbol(arg_129_1.text_)

				local var_132_11 = 53 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 53)

				if (53 <= 0 and var_132_7 or var_132_7 * (utf8.len(var_132_9) / 53)) > 0 and var_132_7 < var_132_11 then
					arg_129_1.talkMaxDuration = var_132_11

					if var_132_11 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_11 + var_132_6
					end
				end

				arg_129_1.text_.text = var_132_9
				arg_129_1.typewritter.percent = 0

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101031", "story_v_out_421101.awb") ~= 0 then
					local var_132_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101031", "story_v_out_421101.awb") / 1000

					if var_132_12 + var_132_6 > arg_129_1.duration_ then
						arg_129_1.duration_ = var_132_12 + var_132_6
					end

					if var_132_8.prefab_name ~= "" and arg_129_1.actors_[var_132_8.prefab_name] ~= nil then
						local var_132_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_129_1.actors_[var_132_8.prefab_name].transform, "story_v_out_421101", "421101031", "story_v_out_421101.awb")

						arg_129_1:RecordAudio("421101031", var_132_13)
						arg_129_1:RecordAudio("421101031", var_132_13)
					else
						arg_129_1:AudioAction("play", "voice", "story_v_out_421101", "421101031", "story_v_out_421101.awb")
					end

					arg_129_1:RecordHistoryTalkVoice("story_v_out_421101", "421101031", "story_v_out_421101.awb")
				end

				arg_129_1:RecordContent(arg_129_1.text_.text)
			end

			local var_132_14 = math.max(var_132_7, arg_129_1.talkMaxDuration)

			if var_132_6 <= arg_129_1.time_ and arg_129_1.time_ < var_132_6 + var_132_14 then
				arg_129_1.typewritter.percent = (arg_129_1.time_ - var_132_6) / var_132_14

				arg_129_1.typewritter:SetDirty()
			end

			if arg_129_1.time_ >= var_132_6 + var_132_14 and arg_129_1.time_ < var_132_6 + var_132_14 + arg_132_0 then
				arg_129_1.typewritter.percent = 1

				arg_129_1.typewritter:SetDirty()
				arg_129_1:ShowNextGo(true)
			end
		end

		arg_129_1.nodeConfigList_ = {
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

		arg_129_1:InitPlayNodeList()
	end,
	Play421101032 = function(arg_133_0, arg_133_1)
		arg_133_1.time_ = 0
		arg_133_1.frameCnt_ = 0
		arg_133_1.state_ = "playing"
		arg_133_1.curTalkId_ = 421101032
		arg_133_1.duration_ = 2.8

		local var_133_0 = {
			zh = 1.999999999999,
			ja = 2.8
		}
		local var_133_1 = manager.audio:GetLocalizationFlag()

		if var_133_0[var_133_1] ~= nil then
			arg_133_1.duration_ = var_133_0[var_133_1]
		end

		SetActive(arg_133_1.tipsGo_, false)

		function arg_133_1.onSingleLineFinish_()
			arg_133_1.onSingleLineUpdate_ = nil
			arg_133_1.onSingleLineFinish_ = nil
			arg_133_1.state_ = "waiting"
		end

		function arg_133_1.playNext_(arg_135_0)
			if arg_135_0 == 1 then
				arg_133_0:Play421101033(arg_133_1)
			end
		end

		function arg_133_1.onSingleLineUpdate_(arg_136_0)
			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1.var_.moveOldPos10145ui_story = arg_133_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_136_0 = 0.001

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_0 then
				arg_133_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_133_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_133_1.time_ - 0) / var_136_0)
				arg_133_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10145ui_story"].transform.position).z)
				arg_133_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10145ui_story"].transform.localEulerAngles = arg_133_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_133_1.time_ >= 0 + var_136_0 and arg_133_1.time_ < 0 + var_136_0 + arg_136_0 then
				arg_133_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_133_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_133_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_133_1.actors_["10145ui_story"].transform.position).z)
				arg_133_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_133_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_133_1.actors_["10145ui_story"].transform.localEulerAngles = arg_133_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_136_1 = arg_133_1.actors_["10145ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10145ui_story == nil then
				arg_133_1.var_.characterEffect10145ui_story = var_136_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_2 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_2 and not isNil(var_136_1) then
				if arg_133_1.var_.characterEffect10145ui_story and not isNil(var_136_1) then
					arg_133_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_133_1.time_ >= 0 + var_136_2 and arg_133_1.time_ < 0 + var_136_2 + arg_136_0 and not isNil(var_136_1) and arg_133_1.var_.characterEffect10145ui_story then
				arg_133_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_136_4 = arg_133_1.actors_["1047ui_story"]

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1047ui_story == nil then
				arg_133_1.var_.characterEffect1047ui_story = var_136_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_136_5 = 0.200000002980232

			if 0 <= arg_133_1.time_ and arg_133_1.time_ < 0 + var_136_5 and not isNil(var_136_4) then
				if arg_133_1.var_.characterEffect1047ui_story and not isNil(var_136_4) then
					arg_133_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_133_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_133_1.time_ - 0) / var_136_5)
				end
			end

			if arg_133_1.time_ >= 0 + var_136_5 and arg_133_1.time_ < 0 + var_136_5 + arg_136_0 and not isNil(var_136_4) and arg_133_1.var_.characterEffect1047ui_story then
				arg_133_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_133_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= 0 + arg_136_0 then
				arg_133_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiA", "EmotionTimelineAnimator")
			end

			local var_136_6 = 0
			local var_136_7 = 0.225

			if 0 < arg_133_1.time_ and arg_133_1.time_ <= var_136_6 + arg_136_0 then
				arg_133_1.talkMaxDuration = 0
				arg_133_1.dialogCg_.alpha = 1

				arg_133_1.dialog_:SetActive(true)
				SetActive(arg_133_1.leftNameGo_, true)

				arg_133_1.leftNameTxt_.text = arg_133_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_133_1.leftNameTxt_.transform)

				arg_133_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_133_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_133_1:RecordName(arg_133_1.leftNameTxt_.text)
				SetActive(arg_133_1.iconTrs_.gameObject, false)
				arg_133_1.callingController_:SetSelectedState("normal")

				local var_136_8 = arg_133_1:GetWordFromCfg(421101032)
				local var_136_9 = arg_133_1:FormatText(var_136_8.content)

				arg_133_1.text_.text = var_136_9

				LuaForUtil.ClearLinePrefixSymbol(arg_133_1.text_)

				local var_136_11 = 9 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 9)

				if (9 <= 0 and var_136_7 or var_136_7 * (utf8.len(var_136_9) / 9)) > 0 and var_136_7 < var_136_11 then
					arg_133_1.talkMaxDuration = var_136_11

					if var_136_11 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_11 + var_136_6
					end
				end

				arg_133_1.text_.text = var_136_9
				arg_133_1.typewritter.percent = 0

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101032", "story_v_out_421101.awb") ~= 0 then
					local var_136_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101032", "story_v_out_421101.awb") / 1000

					if var_136_12 + var_136_6 > arg_133_1.duration_ then
						arg_133_1.duration_ = var_136_12 + var_136_6
					end

					if var_136_8.prefab_name ~= "" and arg_133_1.actors_[var_136_8.prefab_name] ~= nil then
						local var_136_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_133_1.actors_[var_136_8.prefab_name].transform, "story_v_out_421101", "421101032", "story_v_out_421101.awb")

						arg_133_1:RecordAudio("421101032", var_136_13)
						arg_133_1:RecordAudio("421101032", var_136_13)
					else
						arg_133_1:AudioAction("play", "voice", "story_v_out_421101", "421101032", "story_v_out_421101.awb")
					end

					arg_133_1:RecordHistoryTalkVoice("story_v_out_421101", "421101032", "story_v_out_421101.awb")
				end

				arg_133_1:RecordContent(arg_133_1.text_.text)
			end

			local var_136_14 = math.max(var_136_7, arg_133_1.talkMaxDuration)

			if var_136_6 <= arg_133_1.time_ and arg_133_1.time_ < var_136_6 + var_136_14 then
				arg_133_1.typewritter.percent = (arg_133_1.time_ - var_136_6) / var_136_14

				arg_133_1.typewritter:SetDirty()
			end

			if arg_133_1.time_ >= var_136_6 + var_136_14 and arg_133_1.time_ < var_136_6 + var_136_14 + arg_136_0 then
				arg_133_1.typewritter.percent = 1

				arg_133_1.typewritter:SetDirty()
				arg_133_1:ShowNextGo(true)
			end
		end

		arg_133_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_133_1:InitPlayNodeList()
	end,
	Play421101033 = function(arg_137_0, arg_137_1)
		arg_137_1.time_ = 0
		arg_137_1.frameCnt_ = 0
		arg_137_1.state_ = "playing"
		arg_137_1.curTalkId_ = 421101033
		arg_137_1.duration_ = 18.8

		local var_137_0 = {
			zh = 14.233,
			ja = 18.8
		}
		local var_137_1 = manager.audio:GetLocalizationFlag()

		if var_137_0[var_137_1] ~= nil then
			arg_137_1.duration_ = var_137_0[var_137_1]
		end

		SetActive(arg_137_1.tipsGo_, false)

		function arg_137_1.onSingleLineFinish_()
			arg_137_1.onSingleLineUpdate_ = nil
			arg_137_1.onSingleLineFinish_ = nil
			arg_137_1.state_ = "waiting"
		end

		function arg_137_1.playNext_(arg_139_0)
			if arg_139_0 == 1 then
				arg_137_0:Play421101034(arg_137_1)
			end
		end

		function arg_137_1.onSingleLineUpdate_(arg_140_0)
			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1.var_.moveOldPos1047ui_story = arg_137_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_140_0 = 0.001

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_0 then
				arg_137_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_137_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_137_1.time_ - 0) / var_140_0)
				arg_137_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1047ui_story"].transform.position).z)
				arg_137_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1047ui_story"].transform.localEulerAngles = arg_137_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_137_1.time_ >= 0 + var_140_0 and arg_137_1.time_ < 0 + var_140_0 + arg_140_0 then
				arg_137_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_137_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_137_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_137_1.actors_["1047ui_story"].transform.position).z)
				arg_137_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_137_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_137_1.actors_["1047ui_story"].transform.localEulerAngles = arg_137_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_140_1 = arg_137_1.actors_["1047ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1047ui_story == nil then
				arg_137_1.var_.characterEffect1047ui_story = var_140_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_2 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_2 and not isNil(var_140_1) then
				if arg_137_1.var_.characterEffect1047ui_story and not isNil(var_140_1) then
					arg_137_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_137_1.time_ >= 0 + var_140_2 and arg_137_1.time_ < 0 + var_140_2 + arg_140_0 and not isNil(var_140_1) and arg_137_1.var_.characterEffect1047ui_story then
				arg_137_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_140_4 = arg_137_1.actors_["10145ui_story"]

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10145ui_story == nil then
				arg_137_1.var_.characterEffect10145ui_story = var_140_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_140_5 = 0.200000002980232

			if 0 <= arg_137_1.time_ and arg_137_1.time_ < 0 + var_140_5 and not isNil(var_140_4) then
				if arg_137_1.var_.characterEffect10145ui_story and not isNil(var_140_4) then
					arg_137_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_137_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_137_1.time_ - 0) / var_140_5)
				end
			end

			if arg_137_1.time_ >= 0 + var_140_5 and arg_137_1.time_ < 0 + var_140_5 + arg_140_0 and not isNil(var_140_4) and arg_137_1.var_.characterEffect10145ui_story then
				arg_137_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_137_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= 0 + arg_140_0 then
				arg_137_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_140_6 = 0
			local var_140_7 = 1.55

			if 0 < arg_137_1.time_ and arg_137_1.time_ <= var_140_6 + arg_140_0 then
				arg_137_1.talkMaxDuration = 0
				arg_137_1.dialogCg_.alpha = 1

				arg_137_1.dialog_:SetActive(true)
				SetActive(arg_137_1.leftNameGo_, true)

				arg_137_1.leftNameTxt_.text = arg_137_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_137_1.leftNameTxt_.transform)

				arg_137_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_137_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_137_1:RecordName(arg_137_1.leftNameTxt_.text)
				SetActive(arg_137_1.iconTrs_.gameObject, false)
				arg_137_1.callingController_:SetSelectedState("normal")

				local var_140_8 = arg_137_1:GetWordFromCfg(421101033)
				local var_140_9 = arg_137_1:FormatText(var_140_8.content)

				arg_137_1.text_.text = var_140_9

				LuaForUtil.ClearLinePrefixSymbol(arg_137_1.text_)

				local var_140_11 = 62 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 62)

				if (62 <= 0 and var_140_7 or var_140_7 * (utf8.len(var_140_9) / 62)) > 0 and var_140_7 < var_140_11 then
					arg_137_1.talkMaxDuration = var_140_11

					if var_140_11 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_11 + var_140_6
					end
				end

				arg_137_1.text_.text = var_140_9
				arg_137_1.typewritter.percent = 0

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101033", "story_v_out_421101.awb") ~= 0 then
					local var_140_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101033", "story_v_out_421101.awb") / 1000

					if var_140_12 + var_140_6 > arg_137_1.duration_ then
						arg_137_1.duration_ = var_140_12 + var_140_6
					end

					if var_140_8.prefab_name ~= "" and arg_137_1.actors_[var_140_8.prefab_name] ~= nil then
						local var_140_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_137_1.actors_[var_140_8.prefab_name].transform, "story_v_out_421101", "421101033", "story_v_out_421101.awb")

						arg_137_1:RecordAudio("421101033", var_140_13)
						arg_137_1:RecordAudio("421101033", var_140_13)
					else
						arg_137_1:AudioAction("play", "voice", "story_v_out_421101", "421101033", "story_v_out_421101.awb")
					end

					arg_137_1:RecordHistoryTalkVoice("story_v_out_421101", "421101033", "story_v_out_421101.awb")
				end

				arg_137_1:RecordContent(arg_137_1.text_.text)
			end

			local var_140_14 = math.max(var_140_7, arg_137_1.talkMaxDuration)

			if var_140_6 <= arg_137_1.time_ and arg_137_1.time_ < var_140_6 + var_140_14 then
				arg_137_1.typewritter.percent = (arg_137_1.time_ - var_140_6) / var_140_14

				arg_137_1.typewritter:SetDirty()
			end

			if arg_137_1.time_ >= var_140_6 + var_140_14 and arg_137_1.time_ < var_140_6 + var_140_14 + arg_140_0 then
				arg_137_1.typewritter.percent = 1

				arg_137_1.typewritter:SetDirty()
				arg_137_1:ShowNextGo(true)
			end
		end

		arg_137_1.nodeConfigList_ = {
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

		arg_137_1:InitPlayNodeList()
	end,
	Play421101034 = function(arg_141_0, arg_141_1)
		arg_141_1.time_ = 0
		arg_141_1.frameCnt_ = 0
		arg_141_1.state_ = "playing"
		arg_141_1.curTalkId_ = 421101034
		arg_141_1.duration_ = 4.97

		local var_141_0 = {
			zh = 4.966,
			ja = 4.833
		}
		local var_141_1 = manager.audio:GetLocalizationFlag()

		if var_141_0[var_141_1] ~= nil then
			arg_141_1.duration_ = var_141_0[var_141_1]
		end

		SetActive(arg_141_1.tipsGo_, false)

		function arg_141_1.onSingleLineFinish_()
			arg_141_1.onSingleLineUpdate_ = nil
			arg_141_1.onSingleLineFinish_ = nil
			arg_141_1.state_ = "waiting"
		end

		function arg_141_1.playNext_(arg_143_0)
			if arg_143_0 == 1 then
				arg_141_0:Play421101035(arg_141_1)
			end
		end

		function arg_141_1.onSingleLineUpdate_(arg_144_0)
			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1.var_.moveOldPos1047ui_story = arg_141_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_144_0 = 0.001

			if 0 <= arg_141_1.time_ and arg_141_1.time_ < 0 + var_144_0 then
				arg_141_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_141_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_141_1.time_ - 0) / var_144_0)
				arg_141_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).z)
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles = arg_141_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_141_1.time_ >= 0 + var_144_0 and arg_141_1.time_ < 0 + var_144_0 + arg_144_0 then
				arg_141_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_141_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_141_1.actors_["1047ui_story"].transform.position).z)
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_141_1.actors_["1047ui_story"].transform.localEulerAngles = arg_141_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= 0 + arg_144_0 then
				arg_141_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_144_1 = 0
			local var_144_2 = 0.525

			if 0 < arg_141_1.time_ and arg_141_1.time_ <= var_144_1 + arg_144_0 then
				arg_141_1.talkMaxDuration = 0
				arg_141_1.dialogCg_.alpha = 1

				arg_141_1.dialog_:SetActive(true)
				SetActive(arg_141_1.leftNameGo_, true)

				arg_141_1.leftNameTxt_.text = arg_141_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_141_1.leftNameTxt_.transform)

				arg_141_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_141_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_141_1:RecordName(arg_141_1.leftNameTxt_.text)
				SetActive(arg_141_1.iconTrs_.gameObject, false)
				arg_141_1.callingController_:SetSelectedState("normal")

				local var_144_3 = arg_141_1:GetWordFromCfg(421101034)
				local var_144_4 = arg_141_1:FormatText(var_144_3.content)

				arg_141_1.text_.text = var_144_4

				LuaForUtil.ClearLinePrefixSymbol(arg_141_1.text_)

				local var_144_6 = 21 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 21)

				if (21 <= 0 and var_144_2 or var_144_2 * (utf8.len(var_144_4) / 21)) > 0 and var_144_2 < var_144_6 then
					arg_141_1.talkMaxDuration = var_144_6

					if var_144_6 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_6 + var_144_1
					end
				end

				arg_141_1.text_.text = var_144_4
				arg_141_1.typewritter.percent = 0

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101034", "story_v_out_421101.awb") ~= 0 then
					local var_144_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101034", "story_v_out_421101.awb") / 1000

					if var_144_7 + var_144_1 > arg_141_1.duration_ then
						arg_141_1.duration_ = var_144_7 + var_144_1
					end

					if var_144_3.prefab_name ~= "" and arg_141_1.actors_[var_144_3.prefab_name] ~= nil then
						local var_144_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_141_1.actors_[var_144_3.prefab_name].transform, "story_v_out_421101", "421101034", "story_v_out_421101.awb")

						arg_141_1:RecordAudio("421101034", var_144_8)
						arg_141_1:RecordAudio("421101034", var_144_8)
					else
						arg_141_1:AudioAction("play", "voice", "story_v_out_421101", "421101034", "story_v_out_421101.awb")
					end

					arg_141_1:RecordHistoryTalkVoice("story_v_out_421101", "421101034", "story_v_out_421101.awb")
				end

				arg_141_1:RecordContent(arg_141_1.text_.text)
			end

			local var_144_9 = math.max(var_144_2, arg_141_1.talkMaxDuration)

			if var_144_1 <= arg_141_1.time_ and arg_141_1.time_ < var_144_1 + var_144_9 then
				arg_141_1.typewritter.percent = (arg_141_1.time_ - var_144_1) / var_144_9

				arg_141_1.typewritter:SetDirty()
			end

			if arg_141_1.time_ >= var_144_1 + var_144_9 and arg_141_1.time_ < var_144_1 + var_144_9 + arg_144_0 then
				arg_141_1.typewritter.percent = 1

				arg_141_1.typewritter:SetDirty()
				arg_141_1:ShowNextGo(true)
			end
		end

		arg_141_1.nodeConfigList_ = {
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

		arg_141_1:InitPlayNodeList()
	end,
	Play421101035 = function(arg_145_0, arg_145_1)
		arg_145_1.time_ = 0
		arg_145_1.frameCnt_ = 0
		arg_145_1.state_ = "playing"
		arg_145_1.curTalkId_ = 421101035
		arg_145_1.duration_ = 4.07

		local var_145_0 = {
			zh = 4.066,
			ja = 3.433
		}
		local var_145_1 = manager.audio:GetLocalizationFlag()

		if var_145_0[var_145_1] ~= nil then
			arg_145_1.duration_ = var_145_0[var_145_1]
		end

		SetActive(arg_145_1.tipsGo_, false)

		function arg_145_1.onSingleLineFinish_()
			arg_145_1.onSingleLineUpdate_ = nil
			arg_145_1.onSingleLineFinish_ = nil
			arg_145_1.state_ = "waiting"
		end

		function arg_145_1.playNext_(arg_147_0)
			if arg_147_0 == 1 then
				arg_145_0:Play421101036(arg_145_1)
			end
		end

		function arg_145_1.onSingleLineUpdate_(arg_148_0)
			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1.var_.moveOldPos10145ui_story = arg_145_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_148_0 = 0.001

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_0 then
				arg_145_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_145_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_145_1.time_ - 0) / var_148_0)
				arg_145_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).z)
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles = arg_145_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_145_1.time_ >= 0 + var_148_0 and arg_145_1.time_ < 0 + var_148_0 + arg_148_0 then
				arg_145_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_145_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_145_1.actors_["10145ui_story"].transform.position).z)
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_145_1.actors_["10145ui_story"].transform.localEulerAngles = arg_145_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_148_1 = arg_145_1.actors_["10145ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10145ui_story == nil then
				arg_145_1.var_.characterEffect10145ui_story = var_148_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_2 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_2 and not isNil(var_148_1) then
				if arg_145_1.var_.characterEffect10145ui_story and not isNil(var_148_1) then
					arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_145_1.time_ >= 0 + var_148_2 and arg_145_1.time_ < 0 + var_148_2 + arg_148_0 and not isNil(var_148_1) and arg_145_1.var_.characterEffect10145ui_story then
				arg_145_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_148_4 = arg_145_1.actors_["1047ui_story"]

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1047ui_story == nil then
				arg_145_1.var_.characterEffect1047ui_story = var_148_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_148_5 = 0.200000002980232

			if 0 <= arg_145_1.time_ and arg_145_1.time_ < 0 + var_148_5 and not isNil(var_148_4) then
				if arg_145_1.var_.characterEffect1047ui_story and not isNil(var_148_4) then
					arg_145_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_145_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_145_1.time_ - 0) / var_148_5)
				end
			end

			if arg_145_1.time_ >= 0 + var_148_5 and arg_145_1.time_ < 0 + var_148_5 + arg_148_0 and not isNil(var_148_4) and arg_145_1.var_.characterEffect1047ui_story then
				arg_145_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_145_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_2")
			end

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= 0 + arg_148_0 then
				arg_145_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_148_6 = 0
			local var_148_7 = 0.4

			if 0 < arg_145_1.time_ and arg_145_1.time_ <= var_148_6 + arg_148_0 then
				arg_145_1.talkMaxDuration = 0
				arg_145_1.dialogCg_.alpha = 1

				arg_145_1.dialog_:SetActive(true)
				SetActive(arg_145_1.leftNameGo_, true)

				arg_145_1.leftNameTxt_.text = arg_145_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_145_1.leftNameTxt_.transform)

				arg_145_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_145_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_145_1:RecordName(arg_145_1.leftNameTxt_.text)
				SetActive(arg_145_1.iconTrs_.gameObject, false)
				arg_145_1.callingController_:SetSelectedState("normal")

				local var_148_8 = arg_145_1:GetWordFromCfg(421101035)
				local var_148_9 = arg_145_1:FormatText(var_148_8.content)

				arg_145_1.text_.text = var_148_9

				LuaForUtil.ClearLinePrefixSymbol(arg_145_1.text_)

				local var_148_11 = 16 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 16)

				if (16 <= 0 and var_148_7 or var_148_7 * (utf8.len(var_148_9) / 16)) > 0 and var_148_7 < var_148_11 then
					arg_145_1.talkMaxDuration = var_148_11

					if var_148_11 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_11 + var_148_6
					end
				end

				arg_145_1.text_.text = var_148_9
				arg_145_1.typewritter.percent = 0

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101035", "story_v_out_421101.awb") ~= 0 then
					local var_148_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101035", "story_v_out_421101.awb") / 1000

					if var_148_12 + var_148_6 > arg_145_1.duration_ then
						arg_145_1.duration_ = var_148_12 + var_148_6
					end

					if var_148_8.prefab_name ~= "" and arg_145_1.actors_[var_148_8.prefab_name] ~= nil then
						local var_148_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_145_1.actors_[var_148_8.prefab_name].transform, "story_v_out_421101", "421101035", "story_v_out_421101.awb")

						arg_145_1:RecordAudio("421101035", var_148_13)
						arg_145_1:RecordAudio("421101035", var_148_13)
					else
						arg_145_1:AudioAction("play", "voice", "story_v_out_421101", "421101035", "story_v_out_421101.awb")
					end

					arg_145_1:RecordHistoryTalkVoice("story_v_out_421101", "421101035", "story_v_out_421101.awb")
				end

				arg_145_1:RecordContent(arg_145_1.text_.text)
			end

			local var_148_14 = math.max(var_148_7, arg_145_1.talkMaxDuration)

			if var_148_6 <= arg_145_1.time_ and arg_145_1.time_ < var_148_6 + var_148_14 then
				arg_145_1.typewritter.percent = (arg_145_1.time_ - var_148_6) / var_148_14

				arg_145_1.typewritter:SetDirty()
			end

			if arg_145_1.time_ >= var_148_6 + var_148_14 and arg_145_1.time_ < var_148_6 + var_148_14 + arg_148_0 then
				arg_145_1.typewritter.percent = 1

				arg_145_1.typewritter:SetDirty()
				arg_145_1:ShowNextGo(true)
			end
		end

		arg_145_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_145_1:InitPlayNodeList()
	end,
	Play421101036 = function(arg_149_0, arg_149_1)
		arg_149_1.time_ = 0
		arg_149_1.frameCnt_ = 0
		arg_149_1.state_ = "playing"
		arg_149_1.curTalkId_ = 421101036
		arg_149_1.duration_ = 12.27

		local var_149_0 = {
			zh = 8.533,
			ja = 12.266
		}
		local var_149_1 = manager.audio:GetLocalizationFlag()

		if var_149_0[var_149_1] ~= nil then
			arg_149_1.duration_ = var_149_0[var_149_1]
		end

		SetActive(arg_149_1.tipsGo_, false)

		function arg_149_1.onSingleLineFinish_()
			arg_149_1.onSingleLineUpdate_ = nil
			arg_149_1.onSingleLineFinish_ = nil
			arg_149_1.state_ = "waiting"
		end

		function arg_149_1.playNext_(arg_151_0)
			if arg_151_0 == 1 then
				arg_149_0:Play421101037(arg_149_1)
			end
		end

		function arg_149_1.onSingleLineUpdate_(arg_152_0)
			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1.var_.moveOldPos1047ui_story = arg_149_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_152_0 = 0.001

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_0 then
				arg_149_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_149_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_149_1.time_ - 0) / var_152_0)
				arg_149_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1047ui_story"].transform.position).z)
				arg_149_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1047ui_story"].transform.localEulerAngles = arg_149_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_149_1.time_ >= 0 + var_152_0 and arg_149_1.time_ < 0 + var_152_0 + arg_152_0 then
				arg_149_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_149_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_149_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_149_1.actors_["1047ui_story"].transform.position).z)
				arg_149_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_149_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_149_1.actors_["1047ui_story"].transform.localEulerAngles = arg_149_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_152_1 = arg_149_1.actors_["1047ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1047ui_story == nil then
				arg_149_1.var_.characterEffect1047ui_story = var_152_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_2 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_2 and not isNil(var_152_1) then
				if arg_149_1.var_.characterEffect1047ui_story and not isNil(var_152_1) then
					arg_149_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_149_1.time_ >= 0 + var_152_2 and arg_149_1.time_ < 0 + var_152_2 + arg_152_0 and not isNil(var_152_1) and arg_149_1.var_.characterEffect1047ui_story then
				arg_149_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_152_4 = arg_149_1.actors_["10145ui_story"]

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10145ui_story == nil then
				arg_149_1.var_.characterEffect10145ui_story = var_152_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_152_5 = 0.200000002980232

			if 0 <= arg_149_1.time_ and arg_149_1.time_ < 0 + var_152_5 and not isNil(var_152_4) then
				if arg_149_1.var_.characterEffect10145ui_story and not isNil(var_152_4) then
					arg_149_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_149_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_149_1.time_ - 0) / var_152_5)
				end
			end

			if arg_149_1.time_ >= 0 + var_152_5 and arg_149_1.time_ < 0 + var_152_5 + arg_152_0 and not isNil(var_152_4) and arg_149_1.var_.characterEffect10145ui_story then
				arg_149_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_149_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_1")
			end

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= 0 + arg_152_0 then
				arg_149_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_152_6 = 0
			local var_152_7 = 0.975

			if 0 < arg_149_1.time_ and arg_149_1.time_ <= var_152_6 + arg_152_0 then
				arg_149_1.talkMaxDuration = 0
				arg_149_1.dialogCg_.alpha = 1

				arg_149_1.dialog_:SetActive(true)
				SetActive(arg_149_1.leftNameGo_, true)

				arg_149_1.leftNameTxt_.text = arg_149_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_149_1.leftNameTxt_.transform)

				arg_149_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_149_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_149_1:RecordName(arg_149_1.leftNameTxt_.text)
				SetActive(arg_149_1.iconTrs_.gameObject, false)
				arg_149_1.callingController_:SetSelectedState("normal")

				local var_152_8 = arg_149_1:GetWordFromCfg(421101036)
				local var_152_9 = arg_149_1:FormatText(var_152_8.content)

				arg_149_1.text_.text = var_152_9

				LuaForUtil.ClearLinePrefixSymbol(arg_149_1.text_)

				local var_152_11 = 39 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 39)

				if (39 <= 0 and var_152_7 or var_152_7 * (utf8.len(var_152_9) / 39)) > 0 and var_152_7 < var_152_11 then
					arg_149_1.talkMaxDuration = var_152_11

					if var_152_11 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_11 + var_152_6
					end
				end

				arg_149_1.text_.text = var_152_9
				arg_149_1.typewritter.percent = 0

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101036", "story_v_out_421101.awb") ~= 0 then
					local var_152_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101036", "story_v_out_421101.awb") / 1000

					if var_152_12 + var_152_6 > arg_149_1.duration_ then
						arg_149_1.duration_ = var_152_12 + var_152_6
					end

					if var_152_8.prefab_name ~= "" and arg_149_1.actors_[var_152_8.prefab_name] ~= nil then
						local var_152_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_149_1.actors_[var_152_8.prefab_name].transform, "story_v_out_421101", "421101036", "story_v_out_421101.awb")

						arg_149_1:RecordAudio("421101036", var_152_13)
						arg_149_1:RecordAudio("421101036", var_152_13)
					else
						arg_149_1:AudioAction("play", "voice", "story_v_out_421101", "421101036", "story_v_out_421101.awb")
					end

					arg_149_1:RecordHistoryTalkVoice("story_v_out_421101", "421101036", "story_v_out_421101.awb")
				end

				arg_149_1:RecordContent(arg_149_1.text_.text)
			end

			local var_152_14 = math.max(var_152_7, arg_149_1.talkMaxDuration)

			if var_152_6 <= arg_149_1.time_ and arg_149_1.time_ < var_152_6 + var_152_14 then
				arg_149_1.typewritter.percent = (arg_149_1.time_ - var_152_6) / var_152_14

				arg_149_1.typewritter:SetDirty()
			end

			if arg_149_1.time_ >= var_152_6 + var_152_14 and arg_149_1.time_ < var_152_6 + var_152_14 + arg_152_0 then
				arg_149_1.typewritter.percent = 1

				arg_149_1.typewritter:SetDirty()
				arg_149_1:ShowNextGo(true)
			end
		end

		arg_149_1.nodeConfigList_ = {
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

		arg_149_1:InitPlayNodeList()
	end,
	Play421101037 = function(arg_153_0, arg_153_1)
		arg_153_1.time_ = 0
		arg_153_1.frameCnt_ = 0
		arg_153_1.state_ = "playing"
		arg_153_1.curTalkId_ = 421101037
		arg_153_1.duration_ = 12.93

		local var_153_0 = {
			zh = 10.566,
			ja = 12.933
		}
		local var_153_1 = manager.audio:GetLocalizationFlag()

		if var_153_0[var_153_1] ~= nil then
			arg_153_1.duration_ = var_153_0[var_153_1]
		end

		SetActive(arg_153_1.tipsGo_, false)

		function arg_153_1.onSingleLineFinish_()
			arg_153_1.onSingleLineUpdate_ = nil
			arg_153_1.onSingleLineFinish_ = nil
			arg_153_1.state_ = "waiting"
		end

		function arg_153_1.playNext_(arg_155_0)
			if arg_155_0 == 1 then
				arg_153_0:Play421101038(arg_153_1)
			end
		end

		function arg_153_1.onSingleLineUpdate_(arg_156_0)
			local var_156_0 = 1.25

			if 0 < arg_153_1.time_ and arg_153_1.time_ <= 0 + arg_156_0 then
				arg_153_1.talkMaxDuration = 0
				arg_153_1.dialogCg_.alpha = 1

				arg_153_1.dialog_:SetActive(true)
				SetActive(arg_153_1.leftNameGo_, true)

				arg_153_1.leftNameTxt_.text = arg_153_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_153_1.leftNameTxt_.transform)

				arg_153_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_153_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_153_1:RecordName(arg_153_1.leftNameTxt_.text)
				SetActive(arg_153_1.iconTrs_.gameObject, false)
				arg_153_1.callingController_:SetSelectedState("normal")

				local var_156_1 = arg_153_1:GetWordFromCfg(421101037)
				local var_156_2 = arg_153_1:FormatText(var_156_1.content)

				arg_153_1.text_.text = var_156_2

				LuaForUtil.ClearLinePrefixSymbol(arg_153_1.text_)

				local var_156_4 = 50 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 50)

				if (50 <= 0 and var_156_0 or var_156_0 * (utf8.len(var_156_2) / 50)) > 0 and var_156_0 < var_156_4 then
					arg_153_1.talkMaxDuration = var_156_4

					if var_156_4 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_4 + 0
					end
				end

				arg_153_1.text_.text = var_156_2
				arg_153_1.typewritter.percent = 0

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101037", "story_v_out_421101.awb") ~= 0 then
					local var_156_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101037", "story_v_out_421101.awb") / 1000

					if var_156_5 + 0 > arg_153_1.duration_ then
						arg_153_1.duration_ = var_156_5 + 0
					end

					if var_156_1.prefab_name ~= "" and arg_153_1.actors_[var_156_1.prefab_name] ~= nil then
						local var_156_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_153_1.actors_[var_156_1.prefab_name].transform, "story_v_out_421101", "421101037", "story_v_out_421101.awb")

						arg_153_1:RecordAudio("421101037", var_156_6)
						arg_153_1:RecordAudio("421101037", var_156_6)
					else
						arg_153_1:AudioAction("play", "voice", "story_v_out_421101", "421101037", "story_v_out_421101.awb")
					end

					arg_153_1:RecordHistoryTalkVoice("story_v_out_421101", "421101037", "story_v_out_421101.awb")
				end

				arg_153_1:RecordContent(arg_153_1.text_.text)
			end

			local var_156_7 = math.max(var_156_0, arg_153_1.talkMaxDuration)

			if 0 <= arg_153_1.time_ and arg_153_1.time_ < 0 + var_156_7 then
				arg_153_1.typewritter.percent = (arg_153_1.time_ - 0) / var_156_7

				arg_153_1.typewritter:SetDirty()
			end

			if arg_153_1.time_ >= 0 + var_156_7 and arg_153_1.time_ < 0 + var_156_7 + arg_156_0 then
				arg_153_1.typewritter.percent = 1

				arg_153_1.typewritter:SetDirty()
				arg_153_1:ShowNextGo(true)
			end
		end

		arg_153_1.nodeConfigList_ = {}

		arg_153_1:InitPlayNodeList()
	end,
	Play421101038 = function(arg_157_0, arg_157_1)
		arg_157_1.time_ = 0
		arg_157_1.frameCnt_ = 0
		arg_157_1.state_ = "playing"
		arg_157_1.curTalkId_ = 421101038
		arg_157_1.duration_ = 17.63

		local var_157_0 = {
			zh = 10.3,
			ja = 17.633
		}
		local var_157_1 = manager.audio:GetLocalizationFlag()

		if var_157_0[var_157_1] ~= nil then
			arg_157_1.duration_ = var_157_0[var_157_1]
		end

		SetActive(arg_157_1.tipsGo_, false)

		function arg_157_1.onSingleLineFinish_()
			arg_157_1.onSingleLineUpdate_ = nil
			arg_157_1.onSingleLineFinish_ = nil
			arg_157_1.state_ = "waiting"
		end

		function arg_157_1.playNext_(arg_159_0)
			if arg_159_0 == 1 then
				arg_157_0:Play421101039(arg_157_1)
			end
		end

		function arg_157_1.onSingleLineUpdate_(arg_160_0)
			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1.var_.moveOldPos1047ui_story = arg_157_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_160_0 = 0.001

			if 0 <= arg_157_1.time_ and arg_157_1.time_ < 0 + var_160_0 then
				arg_157_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_157_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_157_1.time_ - 0) / var_160_0)
				arg_157_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1047ui_story"].transform.position).z)
				arg_157_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1047ui_story"].transform.localEulerAngles = arg_157_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_157_1.time_ >= 0 + var_160_0 and arg_157_1.time_ < 0 + var_160_0 + arg_160_0 then
				arg_157_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_157_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_157_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_157_1.actors_["1047ui_story"].transform.position).z)
				arg_157_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_157_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_157_1.actors_["1047ui_story"].transform.localEulerAngles = arg_157_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= 0 + arg_160_0 then
				arg_157_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action3_2")
			end

			local var_160_1 = 0
			local var_160_2 = 1.1

			if 0 < arg_157_1.time_ and arg_157_1.time_ <= var_160_1 + arg_160_0 then
				arg_157_1.talkMaxDuration = 0
				arg_157_1.dialogCg_.alpha = 1

				arg_157_1.dialog_:SetActive(true)
				SetActive(arg_157_1.leftNameGo_, true)

				arg_157_1.leftNameTxt_.text = arg_157_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_157_1.leftNameTxt_.transform)

				arg_157_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_157_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_157_1:RecordName(arg_157_1.leftNameTxt_.text)
				SetActive(arg_157_1.iconTrs_.gameObject, false)
				arg_157_1.callingController_:SetSelectedState("normal")

				local var_160_3 = arg_157_1:GetWordFromCfg(421101038)
				local var_160_4 = arg_157_1:FormatText(var_160_3.content)

				arg_157_1.text_.text = var_160_4

				LuaForUtil.ClearLinePrefixSymbol(arg_157_1.text_)

				local var_160_6 = 44 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 44)

				if (44 <= 0 and var_160_2 or var_160_2 * (utf8.len(var_160_4) / 44)) > 0 and var_160_2 < var_160_6 then
					arg_157_1.talkMaxDuration = var_160_6

					if var_160_6 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_6 + var_160_1
					end
				end

				arg_157_1.text_.text = var_160_4
				arg_157_1.typewritter.percent = 0

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101038", "story_v_out_421101.awb") ~= 0 then
					local var_160_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101038", "story_v_out_421101.awb") / 1000

					if var_160_7 + var_160_1 > arg_157_1.duration_ then
						arg_157_1.duration_ = var_160_7 + var_160_1
					end

					if var_160_3.prefab_name ~= "" and arg_157_1.actors_[var_160_3.prefab_name] ~= nil then
						local var_160_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_157_1.actors_[var_160_3.prefab_name].transform, "story_v_out_421101", "421101038", "story_v_out_421101.awb")

						arg_157_1:RecordAudio("421101038", var_160_8)
						arg_157_1:RecordAudio("421101038", var_160_8)
					else
						arg_157_1:AudioAction("play", "voice", "story_v_out_421101", "421101038", "story_v_out_421101.awb")
					end

					arg_157_1:RecordHistoryTalkVoice("story_v_out_421101", "421101038", "story_v_out_421101.awb")
				end

				arg_157_1:RecordContent(arg_157_1.text_.text)
			end

			local var_160_9 = math.max(var_160_2, arg_157_1.talkMaxDuration)

			if var_160_1 <= arg_157_1.time_ and arg_157_1.time_ < var_160_1 + var_160_9 then
				arg_157_1.typewritter.percent = (arg_157_1.time_ - var_160_1) / var_160_9

				arg_157_1.typewritter:SetDirty()
			end

			if arg_157_1.time_ >= var_160_1 + var_160_9 and arg_157_1.time_ < var_160_1 + var_160_9 + arg_160_0 then
				arg_157_1.typewritter.percent = 1

				arg_157_1.typewritter:SetDirty()
				arg_157_1:ShowNextGo(true)
			end
		end

		arg_157_1.nodeConfigList_ = {
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

		arg_157_1:InitPlayNodeList()
	end,
	Play421101039 = function(arg_161_0, arg_161_1)
		arg_161_1.time_ = 0
		arg_161_1.frameCnt_ = 0
		arg_161_1.state_ = "playing"
		arg_161_1.curTalkId_ = 421101039
		arg_161_1.duration_ = 5

		SetActive(arg_161_1.tipsGo_, false)

		function arg_161_1.onSingleLineFinish_()
			arg_161_1.onSingleLineUpdate_ = nil
			arg_161_1.onSingleLineFinish_ = nil
			arg_161_1.state_ = "waiting"
		end

		function arg_161_1.playNext_(arg_163_0)
			if arg_163_0 == 1 then
				arg_161_0:Play421101040(arg_161_1)
			end
		end

		function arg_161_1.onSingleLineUpdate_(arg_164_0)
			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos1047ui_story = arg_161_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_164_0 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_0 then
				arg_161_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_0)
				arg_161_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).z)
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles = arg_161_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_0 and arg_161_1.time_ < 0 + var_164_0 + arg_164_0 then
				arg_161_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_161_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_161_1.actors_["1047ui_story"].transform.position).z)
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_161_1.actors_["1047ui_story"].transform.localEulerAngles = arg_161_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_164_1 = arg_161_1.actors_["10145ui_story"].transform

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= 0 + arg_164_0 then
				arg_161_1.var_.moveOldPos10145ui_story = var_164_1.localPosition
			end

			local var_164_2 = 0.001

			if 0 <= arg_161_1.time_ and arg_161_1.time_ < 0 + var_164_2 then
				var_164_1.localPosition = Vector3.Lerp(arg_161_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_161_1.time_ - 0) / var_164_2)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			if arg_161_1.time_ >= 0 + var_164_2 and arg_161_1.time_ < 0 + var_164_2 + arg_164_0 then
				var_164_1.localPosition = Vector3.New(0, 100, 0)
				var_164_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_164_1.position).x, (manager.ui.mainCamera.transform.position - var_164_1.position).y, (manager.ui.mainCamera.transform.position - var_164_1.position).z)
				var_164_1.localEulerAngles.z = 0
				var_164_1.localEulerAngles.x = 0
				var_164_1.localEulerAngles = var_164_1.localEulerAngles
			end

			local var_164_3 = 0
			local var_164_4 = 0.95

			if 0 < arg_161_1.time_ and arg_161_1.time_ <= var_164_3 + arg_164_0 then
				arg_161_1.talkMaxDuration = 0
				arg_161_1.dialogCg_.alpha = 1

				arg_161_1.dialog_:SetActive(true)
				SetActive(arg_161_1.leftNameGo_, false)

				arg_161_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_161_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_161_1:RecordName(arg_161_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_161_1.iconTrs_.gameObject, false)
				arg_161_1.callingController_:SetSelectedState("normal")

				local var_164_5 = arg_161_1:FormatText(arg_161_1:GetWordFromCfg(421101039).content)

				arg_161_1.text_.text = var_164_5

				LuaForUtil.ClearLinePrefixSymbol(arg_161_1.text_)

				local var_164_7 = 38 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 38)

				if (38 <= 0 and var_164_4 or var_164_4 * (utf8.len(var_164_5) / 38)) > 0 and var_164_4 < var_164_7 then
					arg_161_1.talkMaxDuration = var_164_7

					if var_164_7 + var_164_3 > arg_161_1.duration_ then
						arg_161_1.duration_ = var_164_7 + var_164_3
					end
				end

				arg_161_1.text_.text = var_164_5
				arg_161_1.typewritter.percent = 0

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(false)
				arg_161_1:RecordContent(arg_161_1.text_.text)
			end

			local var_164_8 = math.max(var_164_4, arg_161_1.talkMaxDuration)

			if var_164_3 <= arg_161_1.time_ and arg_161_1.time_ < var_164_3 + var_164_8 then
				arg_161_1.typewritter.percent = (arg_161_1.time_ - var_164_3) / var_164_8

				arg_161_1.typewritter:SetDirty()
			end

			if arg_161_1.time_ >= var_164_3 + var_164_8 and arg_161_1.time_ < var_164_3 + var_164_8 + arg_164_0 then
				arg_161_1.typewritter.percent = 1

				arg_161_1.typewritter:SetDirty()
				arg_161_1:ShowNextGo(true)
			end
		end

		arg_161_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_161_1:InitPlayNodeList()
	end,
	Play421101040 = function(arg_165_0, arg_165_1)
		arg_165_1.time_ = 0
		arg_165_1.frameCnt_ = 0
		arg_165_1.state_ = "playing"
		arg_165_1.curTalkId_ = 421101040
		arg_165_1.duration_ = 3.97

		local var_165_0 = {
			zh = 3.1,
			ja = 3.966
		}
		local var_165_1 = manager.audio:GetLocalizationFlag()

		if var_165_0[var_165_1] ~= nil then
			arg_165_1.duration_ = var_165_0[var_165_1]
		end

		SetActive(arg_165_1.tipsGo_, false)

		function arg_165_1.onSingleLineFinish_()
			arg_165_1.onSingleLineUpdate_ = nil
			arg_165_1.onSingleLineFinish_ = nil
			arg_165_1.state_ = "waiting"
		end

		function arg_165_1.playNext_(arg_167_0)
			if arg_167_0 == 1 then
				arg_165_0:Play421101041(arg_165_1)
			end
		end

		function arg_165_1.onSingleLineUpdate_(arg_168_0)
			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1.var_.moveOldPos10145ui_story = arg_165_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_168_0 = 0.001

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_0 then
				arg_165_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_165_1.var_.moveOldPos10145ui_story, Vector3.New(0, -1, -6.2), (arg_165_1.time_ - 0) / var_168_0)
				arg_165_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10145ui_story"].transform.position).z)
				arg_165_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10145ui_story"].transform.localEulerAngles = arg_165_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_165_1.time_ >= 0 + var_168_0 and arg_165_1.time_ < 0 + var_168_0 + arg_168_0 then
				arg_165_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, -1, -6.2)
				arg_165_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_165_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_165_1.actors_["10145ui_story"].transform.position).z)
				arg_165_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_165_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_165_1.actors_["10145ui_story"].transform.localEulerAngles = arg_165_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_168_1 = arg_165_1.actors_["10145ui_story"]

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10145ui_story == nil then
				arg_165_1.var_.characterEffect10145ui_story = var_168_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_168_2 = 0.200000002980232

			if 0 <= arg_165_1.time_ and arg_165_1.time_ < 0 + var_168_2 and not isNil(var_168_1) then
				if arg_165_1.var_.characterEffect10145ui_story and not isNil(var_168_1) then
					arg_165_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_165_1.time_ >= 0 + var_168_2 and arg_165_1.time_ < 0 + var_168_2 + arg_168_0 and not isNil(var_168_1) and arg_165_1.var_.characterEffect10145ui_story then
				arg_165_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action3_1")
			end

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= 0 + arg_168_0 then
				arg_165_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_168_4 = 0
			local var_168_5 = 0.2

			if 0 < arg_165_1.time_ and arg_165_1.time_ <= var_168_4 + arg_168_0 then
				arg_165_1.talkMaxDuration = 0
				arg_165_1.dialogCg_.alpha = 1

				arg_165_1.dialog_:SetActive(true)
				SetActive(arg_165_1.leftNameGo_, true)

				arg_165_1.leftNameTxt_.text = arg_165_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_165_1.leftNameTxt_.transform)

				arg_165_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_165_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_165_1:RecordName(arg_165_1.leftNameTxt_.text)
				SetActive(arg_165_1.iconTrs_.gameObject, false)
				arg_165_1.callingController_:SetSelectedState("normal")

				local var_168_6 = arg_165_1:GetWordFromCfg(421101040)
				local var_168_7 = arg_165_1:FormatText(var_168_6.content)

				arg_165_1.text_.text = var_168_7

				LuaForUtil.ClearLinePrefixSymbol(arg_165_1.text_)

				local var_168_9 = 8 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 8)

				if (8 <= 0 and var_168_5 or var_168_5 * (utf8.len(var_168_7) / 8)) > 0 and var_168_5 < var_168_9 then
					arg_165_1.talkMaxDuration = var_168_9

					if var_168_9 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_9 + var_168_4
					end
				end

				arg_165_1.text_.text = var_168_7
				arg_165_1.typewritter.percent = 0

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101040", "story_v_out_421101.awb") ~= 0 then
					local var_168_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101040", "story_v_out_421101.awb") / 1000

					if var_168_10 + var_168_4 > arg_165_1.duration_ then
						arg_165_1.duration_ = var_168_10 + var_168_4
					end

					if var_168_6.prefab_name ~= "" and arg_165_1.actors_[var_168_6.prefab_name] ~= nil then
						local var_168_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_165_1.actors_[var_168_6.prefab_name].transform, "story_v_out_421101", "421101040", "story_v_out_421101.awb")

						arg_165_1:RecordAudio("421101040", var_168_11)
						arg_165_1:RecordAudio("421101040", var_168_11)
					else
						arg_165_1:AudioAction("play", "voice", "story_v_out_421101", "421101040", "story_v_out_421101.awb")
					end

					arg_165_1:RecordHistoryTalkVoice("story_v_out_421101", "421101040", "story_v_out_421101.awb")
				end

				arg_165_1:RecordContent(arg_165_1.text_.text)
			end

			local var_168_12 = math.max(var_168_5, arg_165_1.talkMaxDuration)

			if var_168_4 <= arg_165_1.time_ and arg_165_1.time_ < var_168_4 + var_168_12 then
				arg_165_1.typewritter.percent = (arg_165_1.time_ - var_168_4) / var_168_12

				arg_165_1.typewritter:SetDirty()
			end

			if arg_165_1.time_ >= var_168_4 + var_168_12 and arg_165_1.time_ < var_168_4 + var_168_12 + arg_168_0 then
				arg_165_1.typewritter.percent = 1

				arg_165_1.typewritter:SetDirty()
				arg_165_1:ShowNextGo(true)
			end
		end

		arg_165_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_165_1:InitPlayNodeList()
	end,
	Play421101041 = function(arg_169_0, arg_169_1)
		arg_169_1.time_ = 0
		arg_169_1.frameCnt_ = 0
		arg_169_1.state_ = "playing"
		arg_169_1.curTalkId_ = 421101041
		arg_169_1.duration_ = 6.3

		SetActive(arg_169_1.tipsGo_, false)

		function arg_169_1.onSingleLineFinish_()
			arg_169_1.onSingleLineUpdate_ = nil
			arg_169_1.onSingleLineFinish_ = nil
			arg_169_1.state_ = "waiting"
		end

		function arg_169_1.playNext_(arg_171_0)
			if arg_171_0 == 1 then
				arg_169_0:Play421101042(arg_169_1)
			end
		end

		function arg_169_1.onSingleLineUpdate_(arg_172_0)
			local var_172_9000

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				arg_169_1.var_.moveOldPos10145ui_story = arg_169_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_172_0 = 0.001

			if 0 <= arg_169_1.time_ and arg_169_1.time_ < 0 + var_172_0 then
				arg_169_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_169_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_169_1.time_ - 0) / var_172_0)
				arg_169_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).z)
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles = arg_169_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_169_1.time_ >= 0 + var_172_0 and arg_169_1.time_ < 0 + var_172_0 + arg_172_0 then
				arg_169_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_169_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_169_1.actors_["10145ui_story"].transform.position).z)
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_169_1.actors_["10145ui_story"].transform.localEulerAngles = arg_169_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= 0 + arg_172_0 then
				local var_172_1 = arg_169_1.var_.effect1041

				if not arg_169_1.var_.effect1041 then
					var_172_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_boom"), manager.ui.mainCamera.transform)
					var_172_1.name = "1041"
					arg_169_1.var_.effect1041 = var_172_1
				else
					var_172_1.transform:SetParent(var_172_9000)
				end

				var_172_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_172_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 4 < arg_169_1.time_ and arg_169_1.time_ <= 4 + arg_172_0 then
				if arg_169_1.var_.effect1041 then
					Object.Destroy(arg_169_1.var_.effect1041)

					arg_169_1.var_.effect1041 = nil
				end
			end

			local var_172_4 = manager.ui.mainCamera.transform

			if 0.1 < arg_169_1.time_ and arg_169_1.time_ <= 0.1 + arg_172_0 then
				arg_169_1.var_.shakeOldPos = var_172_4.localPosition
			end

			local var_172_5 = 1.2

			if 0.1 <= arg_169_1.time_ and arg_169_1.time_ < 0.1 + var_172_5 then
				local var_172_6, var_172_7 = math.modf((arg_169_1.time_ - 0.1) / 0.066)

				var_172_4.localPosition = Vector3.New(var_172_7 * 0.13, var_172_7 * 0.13, var_172_7 * 0.13) + arg_169_1.var_.shakeOldPos
			end

			if arg_169_1.time_ >= 0.1 + var_172_5 and arg_169_1.time_ < 0.1 + var_172_5 + arg_172_0 then
				var_172_4.localPosition = arg_169_1.var_.shakeOldPos
			end

			if 0.1 < arg_169_1.time_ and arg_169_1.time_ <= 0.1 + arg_172_0 then
				arg_169_1:AudioAction("play", "effect", "se_story_140", "se_story_140_explosion04", "")
			end

			local var_172_9 = 0

			if 0 < arg_169_1.time_ and arg_169_1.time_ <= var_172_9 + arg_172_0 then
				arg_169_1.mask_.enabled = true
				arg_169_1.mask_.raycastTarget = false

				arg_169_1:SetGaussion(false)
			end

			local var_172_10 = 0.166666666666667

			if var_172_9 <= arg_169_1.time_ and arg_169_1.time_ < var_172_9 + var_172_10 then
				local var_172_11 = Color.New(1, 1, 1)

				var_172_11.a = Mathf.Lerp(1, 0, (arg_169_1.time_ - var_172_9) / var_172_10)
				arg_169_1.mask_.color = var_172_11
			end

			if arg_169_1.time_ >= var_172_9 + var_172_10 and arg_169_1.time_ < var_172_9 + var_172_10 + arg_172_0 then
				local var_172_12 = Color.New(1, 1, 1)

				arg_169_1.mask_.enabled = false
				var_172_12.a = 0
				arg_169_1.mask_.color = var_172_12
			end

			local var_172_13 = 1.3
			local var_172_14 = 1.6

			if 1.3 < arg_169_1.time_ and arg_169_1.time_ <= var_172_13 + arg_172_0 then
				arg_169_1.talkMaxDuration = 0
				arg_169_1.dialogCg_.alpha = 1

				arg_169_1.dialog_:SetActive(true)
				SetActive(arg_169_1.leftNameGo_, false)

				arg_169_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_169_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_169_1:RecordName(arg_169_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_169_1.iconTrs_.gameObject, false)
				arg_169_1.callingController_:SetSelectedState("normal")

				local var_172_15 = arg_169_1:FormatText(arg_169_1:GetWordFromCfg(421101041).content)

				arg_169_1.text_.text = var_172_15

				LuaForUtil.ClearLinePrefixSymbol(arg_169_1.text_)

				local var_172_17 = 64 <= 0 and var_172_14 or var_172_14 * (utf8.len(var_172_15) / 64)

				if (64 <= 0 and var_172_14 or var_172_14 * (utf8.len(var_172_15) / 64)) > 0 and var_172_14 < var_172_17 then
					arg_169_1.talkMaxDuration = var_172_17

					if var_172_17 + var_172_13 > arg_169_1.duration_ then
						arg_169_1.duration_ = var_172_17 + var_172_13
					end
				end

				arg_169_1.text_.text = var_172_15
				arg_169_1.typewritter.percent = 0

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(false)
				arg_169_1:RecordContent(arg_169_1.text_.text)
			end

			local var_172_18 = math.max(var_172_14, arg_169_1.talkMaxDuration)

			if var_172_13 <= arg_169_1.time_ and arg_169_1.time_ < var_172_13 + var_172_18 then
				arg_169_1.typewritter.percent = (arg_169_1.time_ - var_172_13) / var_172_18

				arg_169_1.typewritter:SetDirty()
			end

			if arg_169_1.time_ >= var_172_13 + var_172_18 and arg_169_1.time_ < var_172_13 + var_172_18 + arg_172_0 then
				arg_169_1.typewritter.percent = 1

				arg_169_1.typewritter:SetDirty()
				arg_169_1:ShowNextGo(true)
			end
		end

		arg_169_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_169_1:InitPlayNodeList()
	end,
	Play421101042 = function(arg_173_0, arg_173_1)
		arg_173_1.time_ = 0
		arg_173_1.frameCnt_ = 0
		arg_173_1.state_ = "playing"
		arg_173_1.curTalkId_ = 421101042
		arg_173_1.duration_ = 2

		SetActive(arg_173_1.tipsGo_, false)

		function arg_173_1.onSingleLineFinish_()
			arg_173_1.onSingleLineUpdate_ = nil
			arg_173_1.onSingleLineFinish_ = nil
			arg_173_1.state_ = "waiting"
		end

		function arg_173_1.playNext_(arg_175_0)
			if arg_175_0 == 1 then
				arg_173_0:Play421101043(arg_173_1)
			end
		end

		function arg_173_1.onSingleLineUpdate_(arg_176_0)
			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1.var_.moveOldPos1047ui_story = arg_173_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_176_0 = 0.001

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_173_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_173_1.time_ - 0) / var_176_0)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_173_1.time_ >= 0 + var_176_0 and arg_173_1.time_ < 0 + var_176_0 + arg_176_0 then
				arg_173_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_173_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_173_1.actors_["1047ui_story"].transform.position).z)
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_173_1.actors_["1047ui_story"].transform.localEulerAngles = arg_173_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_176_1 = arg_173_1.actors_["1047ui_story"]

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story == nil then
				arg_173_1.var_.characterEffect1047ui_story = var_176_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_176_2 = 0.200000002980232

			if 0 <= arg_173_1.time_ and arg_173_1.time_ < 0 + var_176_2 and not isNil(var_176_1) then
				if arg_173_1.var_.characterEffect1047ui_story and not isNil(var_176_1) then
					arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_173_1.time_ >= 0 + var_176_2 and arg_173_1.time_ < 0 + var_176_2 + arg_176_0 and not isNil(var_176_1) and arg_173_1.var_.characterEffect1047ui_story then
				arg_173_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_1")
			end

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= 0 + arg_176_0 then
				arg_173_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_176_4 = 0
			local var_176_5 = 0.15

			if 0 < arg_173_1.time_ and arg_173_1.time_ <= var_176_4 + arg_176_0 then
				arg_173_1.talkMaxDuration = 0
				arg_173_1.dialogCg_.alpha = 1

				arg_173_1.dialog_:SetActive(true)
				SetActive(arg_173_1.leftNameGo_, true)

				arg_173_1.leftNameTxt_.text = arg_173_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_173_1.leftNameTxt_.transform)

				arg_173_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_173_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_173_1:RecordName(arg_173_1.leftNameTxt_.text)
				SetActive(arg_173_1.iconTrs_.gameObject, false)
				arg_173_1.callingController_:SetSelectedState("normal")

				local var_176_6 = arg_173_1:GetWordFromCfg(421101042)
				local var_176_7 = arg_173_1:FormatText(var_176_6.content)

				arg_173_1.text_.text = var_176_7

				LuaForUtil.ClearLinePrefixSymbol(arg_173_1.text_)

				local var_176_9 = 6 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 6)

				if (6 <= 0 and var_176_5 or var_176_5 * (utf8.len(var_176_7) / 6)) > 0 and var_176_5 < var_176_9 then
					arg_173_1.talkMaxDuration = var_176_9

					if var_176_9 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_9 + var_176_4
					end
				end

				arg_173_1.text_.text = var_176_7
				arg_173_1.typewritter.percent = 0

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101042", "story_v_out_421101.awb") ~= 0 then
					local var_176_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101042", "story_v_out_421101.awb") / 1000

					if var_176_10 + var_176_4 > arg_173_1.duration_ then
						arg_173_1.duration_ = var_176_10 + var_176_4
					end

					if var_176_6.prefab_name ~= "" and arg_173_1.actors_[var_176_6.prefab_name] ~= nil then
						local var_176_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_173_1.actors_[var_176_6.prefab_name].transform, "story_v_out_421101", "421101042", "story_v_out_421101.awb")

						arg_173_1:RecordAudio("421101042", var_176_11)
						arg_173_1:RecordAudio("421101042", var_176_11)
					else
						arg_173_1:AudioAction("play", "voice", "story_v_out_421101", "421101042", "story_v_out_421101.awb")
					end

					arg_173_1:RecordHistoryTalkVoice("story_v_out_421101", "421101042", "story_v_out_421101.awb")
				end

				arg_173_1:RecordContent(arg_173_1.text_.text)
			end

			local var_176_12 = math.max(var_176_5, arg_173_1.talkMaxDuration)

			if var_176_4 <= arg_173_1.time_ and arg_173_1.time_ < var_176_4 + var_176_12 then
				arg_173_1.typewritter.percent = (arg_173_1.time_ - var_176_4) / var_176_12

				arg_173_1.typewritter:SetDirty()
			end

			if arg_173_1.time_ >= var_176_4 + var_176_12 and arg_173_1.time_ < var_176_4 + var_176_12 + arg_176_0 then
				arg_173_1.typewritter.percent = 1

				arg_173_1.typewritter:SetDirty()
				arg_173_1:ShowNextGo(true)
			end
		end

		arg_173_1.nodeConfigList_ = {
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

		arg_173_1:InitPlayNodeList()
	end,
	Play421101043 = function(arg_177_0, arg_177_1)
		arg_177_1.time_ = 0
		arg_177_1.frameCnt_ = 0
		arg_177_1.state_ = "playing"
		arg_177_1.curTalkId_ = 421101043
		arg_177_1.duration_ = 5

		SetActive(arg_177_1.tipsGo_, false)

		function arg_177_1.onSingleLineFinish_()
			arg_177_1.onSingleLineUpdate_ = nil
			arg_177_1.onSingleLineFinish_ = nil
			arg_177_1.state_ = "waiting"
		end

		function arg_177_1.playNext_(arg_179_0)
			if arg_179_0 == 1 then
				arg_177_0:Play421101044(arg_177_1)
			end
		end

		function arg_177_1.onSingleLineUpdate_(arg_180_0)
			if 0 < arg_177_1.time_ and arg_177_1.time_ <= 0 + arg_180_0 then
				arg_177_1.var_.moveOldPos1047ui_story = arg_177_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_180_0 = 0.001

			if 0 <= arg_177_1.time_ and arg_177_1.time_ < 0 + var_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_177_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_177_1.time_ - 0) / var_180_0)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_177_1.time_ >= 0 + var_180_0 and arg_177_1.time_ < 0 + var_180_0 + arg_180_0 then
				arg_177_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_177_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_177_1.actors_["1047ui_story"].transform.position).z)
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_177_1.actors_["1047ui_story"].transform.localEulerAngles = arg_177_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_177_1.time_ and arg_177_1.time_ <= 0.1 + arg_180_0 then
				arg_177_1:AudioAction("play", "effect", "se_story_140", "se_story_140_foley_fall", "")
			end

			local var_180_2 = 0
			local var_180_3 = 1.05

			if 0 < arg_177_1.time_ and arg_177_1.time_ <= var_180_2 + arg_180_0 then
				arg_177_1.talkMaxDuration = 0
				arg_177_1.dialogCg_.alpha = 1

				arg_177_1.dialog_:SetActive(true)
				SetActive(arg_177_1.leftNameGo_, false)

				arg_177_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_177_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_177_1:RecordName(arg_177_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_177_1.iconTrs_.gameObject, false)
				arg_177_1.callingController_:SetSelectedState("normal")

				local var_180_4 = arg_177_1:FormatText(arg_177_1:GetWordFromCfg(421101043).content)

				arg_177_1.text_.text = var_180_4

				LuaForUtil.ClearLinePrefixSymbol(arg_177_1.text_)

				local var_180_6 = 42 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 42)

				if (42 <= 0 and var_180_3 or var_180_3 * (utf8.len(var_180_4) / 42)) > 0 and var_180_3 < var_180_6 then
					arg_177_1.talkMaxDuration = var_180_6

					if var_180_6 + var_180_2 > arg_177_1.duration_ then
						arg_177_1.duration_ = var_180_6 + var_180_2
					end
				end

				arg_177_1.text_.text = var_180_4
				arg_177_1.typewritter.percent = 0

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(false)
				arg_177_1:RecordContent(arg_177_1.text_.text)
			end

			local var_180_7 = math.max(var_180_3, arg_177_1.talkMaxDuration)

			if var_180_2 <= arg_177_1.time_ and arg_177_1.time_ < var_180_2 + var_180_7 then
				arg_177_1.typewritter.percent = (arg_177_1.time_ - var_180_2) / var_180_7

				arg_177_1.typewritter:SetDirty()
			end

			if arg_177_1.time_ >= var_180_2 + var_180_7 and arg_177_1.time_ < var_180_2 + var_180_7 + arg_180_0 then
				arg_177_1.typewritter.percent = 1

				arg_177_1.typewritter:SetDirty()
				arg_177_1:ShowNextGo(true)
			end
		end

		arg_177_1.nodeConfigList_ = {
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

		arg_177_1:InitPlayNodeList()
	end,
	Play421101044 = function(arg_181_0, arg_181_1)
		arg_181_1.time_ = 0
		arg_181_1.frameCnt_ = 0
		arg_181_1.state_ = "playing"
		arg_181_1.curTalkId_ = 421101044
		arg_181_1.duration_ = 1.53

		local var_181_0 = {
			zh = 1.2,
			ja = 1.533
		}
		local var_181_1 = manager.audio:GetLocalizationFlag()

		if var_181_0[var_181_1] ~= nil then
			arg_181_1.duration_ = var_181_0[var_181_1]
		end

		SetActive(arg_181_1.tipsGo_, false)

		function arg_181_1.onSingleLineFinish_()
			arg_181_1.onSingleLineUpdate_ = nil
			arg_181_1.onSingleLineFinish_ = nil
			arg_181_1.state_ = "waiting"
		end

		function arg_181_1.playNext_(arg_183_0)
			if arg_183_0 == 1 then
				arg_181_0:Play421101045(arg_181_1)
			end
		end

		function arg_181_1.onSingleLineUpdate_(arg_184_0)
			local var_184_0 = 0.075

			if 0 < arg_181_1.time_ and arg_181_1.time_ <= 0 + arg_184_0 then
				arg_181_1.talkMaxDuration = 0
				arg_181_1.dialogCg_.alpha = 1

				arg_181_1.dialog_:SetActive(true)
				SetActive(arg_181_1.leftNameGo_, true)

				arg_181_1.leftNameTxt_.text = arg_181_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_181_1.leftNameTxt_.transform)

				arg_181_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_181_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_181_1:RecordName(arg_181_1.leftNameTxt_.text)
				SetActive(arg_181_1.iconTrs_.gameObject, true)
				arg_181_1.iconController_:SetSelectedState("hero")

				arg_181_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10145")

				arg_181_1.callingController_:SetSelectedState("normal")

				arg_181_1.keyicon_.color = Color.New(1, 1, 1)
				arg_181_1.icon_.color = Color.New(1, 1, 1)

				local var_184_1 = arg_181_1:GetWordFromCfg(421101044)
				local var_184_2 = arg_181_1:FormatText(var_184_1.content)

				arg_181_1.text_.text = var_184_2

				LuaForUtil.ClearLinePrefixSymbol(arg_181_1.text_)

				local var_184_4 = 3 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 3)

				if (3 <= 0 and var_184_0 or var_184_0 * (utf8.len(var_184_2) / 3)) > 0 and var_184_0 < var_184_4 then
					arg_181_1.talkMaxDuration = var_184_4

					if var_184_4 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_4 + 0
					end
				end

				arg_181_1.text_.text = var_184_2
				arg_181_1.typewritter.percent = 0

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101044", "story_v_out_421101.awb") ~= 0 then
					local var_184_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101044", "story_v_out_421101.awb") / 1000

					if var_184_5 + 0 > arg_181_1.duration_ then
						arg_181_1.duration_ = var_184_5 + 0
					end

					if var_184_1.prefab_name ~= "" and arg_181_1.actors_[var_184_1.prefab_name] ~= nil then
						local var_184_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_181_1.actors_[var_184_1.prefab_name].transform, "story_v_out_421101", "421101044", "story_v_out_421101.awb")

						arg_181_1:RecordAudio("421101044", var_184_6)
						arg_181_1:RecordAudio("421101044", var_184_6)
					else
						arg_181_1:AudioAction("play", "voice", "story_v_out_421101", "421101044", "story_v_out_421101.awb")
					end

					arg_181_1:RecordHistoryTalkVoice("story_v_out_421101", "421101044", "story_v_out_421101.awb")
				end

				arg_181_1:RecordContent(arg_181_1.text_.text)
			end

			local var_184_7 = math.max(var_184_0, arg_181_1.talkMaxDuration)

			if 0 <= arg_181_1.time_ and arg_181_1.time_ < 0 + var_184_7 then
				arg_181_1.typewritter.percent = (arg_181_1.time_ - 0) / var_184_7

				arg_181_1.typewritter:SetDirty()
			end

			if arg_181_1.time_ >= 0 + var_184_7 and arg_181_1.time_ < 0 + var_184_7 + arg_184_0 then
				arg_181_1.typewritter.percent = 1

				arg_181_1.typewritter:SetDirty()
				arg_181_1:ShowNextGo(true)
			end
		end

		arg_181_1.nodeConfigList_ = {}

		arg_181_1:InitPlayNodeList()
	end,
	Play421101045 = function(arg_185_0, arg_185_1)
		arg_185_1.time_ = 0
		arg_185_1.frameCnt_ = 0
		arg_185_1.state_ = "playing"
		arg_185_1.curTalkId_ = 421101045
		arg_185_1.duration_ = 4.53

		local var_185_0 = {
			zh = 4.533,
			ja = 4.166
		}
		local var_185_1 = manager.audio:GetLocalizationFlag()

		if var_185_0[var_185_1] ~= nil then
			arg_185_1.duration_ = var_185_0[var_185_1]
		end

		SetActive(arg_185_1.tipsGo_, false)

		function arg_185_1.onSingleLineFinish_()
			arg_185_1.onSingleLineUpdate_ = nil
			arg_185_1.onSingleLineFinish_ = nil
			arg_185_1.state_ = "waiting"
		end

		function arg_185_1.playNext_(arg_187_0)
			if arg_187_0 == 1 then
				arg_185_0:Play421101046(arg_185_1)
			end
		end

		function arg_185_1.onSingleLineUpdate_(arg_188_0)
			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1.var_.moveOldPos1047ui_story = arg_185_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_188_0 = 0.001

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_185_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_185_1.time_ - 0) / var_188_0)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_185_1.time_ >= 0 + var_188_0 and arg_185_1.time_ < 0 + var_188_0 + arg_188_0 then
				arg_185_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_185_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_185_1.actors_["1047ui_story"].transform.position).z)
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_185_1.actors_["1047ui_story"].transform.localEulerAngles = arg_185_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_188_1 = arg_185_1.actors_["1047ui_story"]

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1047ui_story == nil then
				arg_185_1.var_.characterEffect1047ui_story = var_188_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_188_2 = 0.200000002980232

			if 0 <= arg_185_1.time_ and arg_185_1.time_ < 0 + var_188_2 and not isNil(var_188_1) then
				if arg_185_1.var_.characterEffect1047ui_story and not isNil(var_188_1) then
					arg_185_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_185_1.time_ >= 0 + var_188_2 and arg_185_1.time_ < 0 + var_188_2 + arg_188_0 and not isNil(var_188_1) and arg_185_1.var_.characterEffect1047ui_story then
				arg_185_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= 0 + arg_188_0 then
				arg_185_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action7_2")
			end

			local var_188_4 = 0
			local var_188_5 = 0.45

			if 0 < arg_185_1.time_ and arg_185_1.time_ <= var_188_4 + arg_188_0 then
				arg_185_1.talkMaxDuration = 0
				arg_185_1.dialogCg_.alpha = 1

				arg_185_1.dialog_:SetActive(true)
				SetActive(arg_185_1.leftNameGo_, true)

				arg_185_1.leftNameTxt_.text = arg_185_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_185_1.leftNameTxt_.transform)

				arg_185_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_185_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_185_1:RecordName(arg_185_1.leftNameTxt_.text)
				SetActive(arg_185_1.iconTrs_.gameObject, false)
				arg_185_1.callingController_:SetSelectedState("normal")

				local var_188_6 = arg_185_1:GetWordFromCfg(421101045)
				local var_188_7 = arg_185_1:FormatText(var_188_6.content)

				arg_185_1.text_.text = var_188_7

				LuaForUtil.ClearLinePrefixSymbol(arg_185_1.text_)

				local var_188_9 = 18 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 18)

				if (18 <= 0 and var_188_5 or var_188_5 * (utf8.len(var_188_7) / 18)) > 0 and var_188_5 < var_188_9 then
					arg_185_1.talkMaxDuration = var_188_9

					if var_188_9 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_9 + var_188_4
					end
				end

				arg_185_1.text_.text = var_188_7
				arg_185_1.typewritter.percent = 0

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101045", "story_v_out_421101.awb") ~= 0 then
					local var_188_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101045", "story_v_out_421101.awb") / 1000

					if var_188_10 + var_188_4 > arg_185_1.duration_ then
						arg_185_1.duration_ = var_188_10 + var_188_4
					end

					if var_188_6.prefab_name ~= "" and arg_185_1.actors_[var_188_6.prefab_name] ~= nil then
						local var_188_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_185_1.actors_[var_188_6.prefab_name].transform, "story_v_out_421101", "421101045", "story_v_out_421101.awb")

						arg_185_1:RecordAudio("421101045", var_188_11)
						arg_185_1:RecordAudio("421101045", var_188_11)
					else
						arg_185_1:AudioAction("play", "voice", "story_v_out_421101", "421101045", "story_v_out_421101.awb")
					end

					arg_185_1:RecordHistoryTalkVoice("story_v_out_421101", "421101045", "story_v_out_421101.awb")
				end

				arg_185_1:RecordContent(arg_185_1.text_.text)
			end

			local var_188_12 = math.max(var_188_5, arg_185_1.talkMaxDuration)

			if var_188_4 <= arg_185_1.time_ and arg_185_1.time_ < var_188_4 + var_188_12 then
				arg_185_1.typewritter.percent = (arg_185_1.time_ - var_188_4) / var_188_12

				arg_185_1.typewritter:SetDirty()
			end

			if arg_185_1.time_ >= var_188_4 + var_188_12 and arg_185_1.time_ < var_188_4 + var_188_12 + arg_188_0 then
				arg_185_1.typewritter.percent = 1

				arg_185_1.typewritter:SetDirty()
				arg_185_1:ShowNextGo(true)
			end
		end

		arg_185_1.nodeConfigList_ = {
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

		arg_185_1:InitPlayNodeList()
	end,
	Play421101046 = function(arg_189_0, arg_189_1)
		arg_189_1.time_ = 0
		arg_189_1.frameCnt_ = 0
		arg_189_1.state_ = "playing"
		arg_189_1.curTalkId_ = 421101046
		arg_189_1.duration_ = 5

		SetActive(arg_189_1.tipsGo_, false)

		function arg_189_1.onSingleLineFinish_()
			arg_189_1.onSingleLineUpdate_ = nil
			arg_189_1.onSingleLineFinish_ = nil
			arg_189_1.state_ = "waiting"
		end

		function arg_189_1.playNext_(arg_191_0)
			if arg_191_0 == 1 then
				arg_189_0:Play421101047(arg_189_1)
			end
		end

		function arg_189_1.onSingleLineUpdate_(arg_192_0)
			if 0 < arg_189_1.time_ and arg_189_1.time_ <= 0 + arg_192_0 then
				arg_189_1.var_.moveOldPos1047ui_story = arg_189_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_192_0 = 0.001

			if 0 <= arg_189_1.time_ and arg_189_1.time_ < 0 + var_192_0 then
				arg_189_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_189_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_189_1.time_ - 0) / var_192_0)
				arg_189_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).z)
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles = arg_189_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_189_1.time_ >= 0 + var_192_0 and arg_189_1.time_ < 0 + var_192_0 + arg_192_0 then
				arg_189_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_189_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_189_1.actors_["1047ui_story"].transform.position).z)
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_189_1.actors_["1047ui_story"].transform.localEulerAngles = arg_189_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.666666666666667 < arg_189_1.time_ and arg_189_1.time_ <= 0.666666666666667 + arg_192_0 then
				arg_189_1:AudioAction("play", "effect", "se_story_140", "se_story_140_sand", "")
			end

			local var_192_2 = 0
			local var_192_3 = 1.225

			if 0 < arg_189_1.time_ and arg_189_1.time_ <= var_192_2 + arg_192_0 then
				arg_189_1.talkMaxDuration = 0
				arg_189_1.dialogCg_.alpha = 1

				arg_189_1.dialog_:SetActive(true)
				SetActive(arg_189_1.leftNameGo_, false)

				arg_189_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_189_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_189_1:RecordName(arg_189_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_189_1.iconTrs_.gameObject, false)
				arg_189_1.callingController_:SetSelectedState("normal")

				local var_192_4 = arg_189_1:FormatText(arg_189_1:GetWordFromCfg(421101046).content)

				arg_189_1.text_.text = var_192_4

				LuaForUtil.ClearLinePrefixSymbol(arg_189_1.text_)

				local var_192_6 = 49 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 49)

				if (49 <= 0 and var_192_3 or var_192_3 * (utf8.len(var_192_4) / 49)) > 0 and var_192_3 < var_192_6 then
					arg_189_1.talkMaxDuration = var_192_6

					if var_192_6 + var_192_2 > arg_189_1.duration_ then
						arg_189_1.duration_ = var_192_6 + var_192_2
					end
				end

				arg_189_1.text_.text = var_192_4
				arg_189_1.typewritter.percent = 0

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(false)
				arg_189_1:RecordContent(arg_189_1.text_.text)
			end

			local var_192_7 = math.max(var_192_3, arg_189_1.talkMaxDuration)

			if var_192_2 <= arg_189_1.time_ and arg_189_1.time_ < var_192_2 + var_192_7 then
				arg_189_1.typewritter.percent = (arg_189_1.time_ - var_192_2) / var_192_7

				arg_189_1.typewritter:SetDirty()
			end

			if arg_189_1.time_ >= var_192_2 + var_192_7 and arg_189_1.time_ < var_192_2 + var_192_7 + arg_192_0 then
				arg_189_1.typewritter.percent = 1

				arg_189_1.typewritter:SetDirty()
				arg_189_1:ShowNextGo(true)
			end
		end

		arg_189_1.nodeConfigList_ = {
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

		arg_189_1:InitPlayNodeList()
	end,
	Play421101047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 421101047
		arg_193_1.duration_ = 3.37

		local var_193_0 = {
			zh = 3.366,
			ja = 3
		}
		local var_193_1 = manager.audio:GetLocalizationFlag()

		if var_193_0[var_193_1] ~= nil then
			arg_193_1.duration_ = var_193_0[var_193_1]
		end

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play421101048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos1047ui_story = arg_193_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos1047ui_story, Vector3.New(-0.6, -1.13, -6.2), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).z)
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles = arg_193_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(-0.6, -1.13, -6.2)
				arg_193_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["1047ui_story"].transform.position).z)
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["1047ui_story"].transform.localEulerAngles = arg_193_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["1047ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1047ui_story == nil then
				arg_193_1.var_.characterEffect1047ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect1047ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect1047ui_story then
				arg_193_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_196_4 = 0
			local var_196_5 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_4 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_6 = arg_193_1:GetWordFromCfg(421101047)
				local var_196_7 = arg_193_1:FormatText(var_196_6.content)

				arg_193_1.text_.text = var_196_7

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_9 = 9 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 9)

				if (9 <= 0 and var_196_5 or var_196_5 * (utf8.len(var_196_7) / 9)) > 0 and var_196_5 < var_196_9 then
					arg_193_1.talkMaxDuration = var_196_9

					if var_196_9 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_9 + var_196_4
					end
				end

				arg_193_1.text_.text = var_196_7
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101047", "story_v_out_421101.awb") ~= 0 then
					local var_196_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101047", "story_v_out_421101.awb") / 1000

					if var_196_10 + var_196_4 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_4
					end

					if var_196_6.prefab_name ~= "" and arg_193_1.actors_[var_196_6.prefab_name] ~= nil then
						local var_196_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_193_1.actors_[var_196_6.prefab_name].transform, "story_v_out_421101", "421101047", "story_v_out_421101.awb")

						arg_193_1:RecordAudio("421101047", var_196_11)
						arg_193_1:RecordAudio("421101047", var_196_11)
					else
						arg_193_1:AudioAction("play", "voice", "story_v_out_421101", "421101047", "story_v_out_421101.awb")
					end

					arg_193_1:RecordHistoryTalkVoice("story_v_out_421101", "421101047", "story_v_out_421101.awb")
				end

				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_12 = math.max(var_196_5, arg_193_1.talkMaxDuration)

			if var_196_4 <= arg_193_1.time_ and arg_193_1.time_ < var_196_4 + var_196_12 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_4) / var_196_12

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_4 + var_196_12 and arg_193_1.time_ < var_196_4 + var_196_12 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
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

		arg_193_1:InitPlayNodeList()
	end,
	Play421101048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 421101048
		arg_197_1.duration_ = 4.7

		local var_197_0 = {
			zh = 3.466,
			ja = 4.7
		}
		local var_197_1 = manager.audio:GetLocalizationFlag()

		if var_197_0[var_197_1] ~= nil then
			arg_197_1.duration_ = var_197_0[var_197_1]
		end

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play421101049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1.var_.moveOldPos10145ui_story = arg_197_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_200_0 = 0.001

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 then
				arg_197_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_197_1.var_.moveOldPos10145ui_story, Vector3.New(0.78, -1, -6.2), (arg_197_1.time_ - 0) / var_200_0)
				arg_197_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10145ui_story"].transform.position).z)
				arg_197_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10145ui_story"].transform.localEulerAngles = arg_197_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 then
				arg_197_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(0.78, -1, -6.2)
				arg_197_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_197_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_197_1.actors_["10145ui_story"].transform.position).z)
				arg_197_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_197_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_197_1.actors_["10145ui_story"].transform.localEulerAngles = arg_197_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_200_1 = arg_197_1.actors_["10145ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10145ui_story == nil then
				arg_197_1.var_.characterEffect10145ui_story = var_200_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_2 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_2 and not isNil(var_200_1) then
				if arg_197_1.var_.characterEffect10145ui_story and not isNil(var_200_1) then
					arg_197_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_2 and arg_197_1.time_ < 0 + var_200_2 + arg_200_0 and not isNil(var_200_1) and arg_197_1.var_.characterEffect10145ui_story then
				arg_197_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			local var_200_4 = arg_197_1.actors_["1047ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1047ui_story == nil then
				arg_197_1.var_.characterEffect1047ui_story = var_200_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_5 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_5 and not isNil(var_200_4) then
				if arg_197_1.var_.characterEffect1047ui_story and not isNil(var_200_4) then
					arg_197_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_197_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_5)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_5 and arg_197_1.time_ < 0 + var_200_5 + arg_200_0 and not isNil(var_200_4) and arg_197_1.var_.characterEffect1047ui_story then
				arg_197_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_197_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action1_1")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_nanguoA", "EmotionTimelineAnimator")
			end

			local var_200_6 = 0
			local var_200_7 = 0.3

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_6 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_8 = arg_197_1:GetWordFromCfg(421101048)
				local var_200_9 = arg_197_1:FormatText(var_200_8.content)

				arg_197_1.text_.text = var_200_9

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_11 = 12 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 12)

				if (12 <= 0 and var_200_7 or var_200_7 * (utf8.len(var_200_9) / 12)) > 0 and var_200_7 < var_200_11 then
					arg_197_1.talkMaxDuration = var_200_11

					if var_200_11 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_11 + var_200_6
					end
				end

				arg_197_1.text_.text = var_200_9
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101048", "story_v_out_421101.awb") ~= 0 then
					local var_200_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101048", "story_v_out_421101.awb") / 1000

					if var_200_12 + var_200_6 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_12 + var_200_6
					end

					if var_200_8.prefab_name ~= "" and arg_197_1.actors_[var_200_8.prefab_name] ~= nil then
						local var_200_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_197_1.actors_[var_200_8.prefab_name].transform, "story_v_out_421101", "421101048", "story_v_out_421101.awb")

						arg_197_1:RecordAudio("421101048", var_200_13)
						arg_197_1:RecordAudio("421101048", var_200_13)
					else
						arg_197_1:AudioAction("play", "voice", "story_v_out_421101", "421101048", "story_v_out_421101.awb")
					end

					arg_197_1:RecordHistoryTalkVoice("story_v_out_421101", "421101048", "story_v_out_421101.awb")
				end

				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_14 = math.max(var_200_7, arg_197_1.talkMaxDuration)

			if var_200_6 <= arg_197_1.time_ and arg_197_1.time_ < var_200_6 + var_200_14 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_6) / var_200_14

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_6 + var_200_14 and arg_197_1.time_ < var_200_6 + var_200_14 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_197_1:InitPlayNodeList()
	end,
	Play421101049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 421101049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play421101050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos1047ui_story = arg_201_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_204_0 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 then
				arg_201_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_0)
				arg_201_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).z)
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles = arg_201_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 then
				arg_201_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_201_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_201_1.actors_["1047ui_story"].transform.position).z)
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_201_1.actors_["1047ui_story"].transform.localEulerAngles = arg_201_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_204_1 = arg_201_1.actors_["10145ui_story"].transform

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1.var_.moveOldPos10145ui_story = var_204_1.localPosition
			end

			local var_204_2 = 0.001

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_2 then
				var_204_1.localPosition = Vector3.Lerp(arg_201_1.var_.moveOldPos10145ui_story, Vector3.New(0, 100, 0), (arg_201_1.time_ - 0) / var_204_2)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if arg_201_1.time_ >= 0 + var_204_2 and arg_201_1.time_ < 0 + var_204_2 + arg_204_0 then
				var_204_1.localPosition = Vector3.New(0, 100, 0)
				var_204_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_204_1.position).x, (manager.ui.mainCamera.transform.position - var_204_1.position).y, (manager.ui.mainCamera.transform.position - var_204_1.position).z)
				var_204_1.localEulerAngles.z = 0
				var_204_1.localEulerAngles.x = 0
				var_204_1.localEulerAngles = var_204_1.localEulerAngles
			end

			if 0.583263799548149 < arg_201_1.time_ and arg_201_1.time_ <= 0.583263799548149 + arg_204_0 then
				arg_201_1:AudioAction("play", "effect", "se_story_140", "se_story_140_surround", "")
			end

			local var_204_4 = 0
			local var_204_5 = 1.125

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, false)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(421101049).content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_8 = 45 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 45)

				if (45 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 45)) > 0 and var_204_5 < var_204_8 then
					arg_201_1.talkMaxDuration = var_204_8

					if var_204_8 + var_204_4 > arg_201_1.duration_ then
						arg_201_1.duration_ = var_204_8 + var_204_4
					end
				end

				arg_201_1.text_.text = var_204_6
				arg_201_1.typewritter.percent = 0

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(false)
				arg_201_1:RecordContent(arg_201_1.text_.text)
			end

			local var_204_9 = math.max(var_204_5, arg_201_1.talkMaxDuration)

			if var_204_4 <= arg_201_1.time_ and arg_201_1.time_ < var_204_4 + var_204_9 then
				arg_201_1.typewritter.percent = (arg_201_1.time_ - var_204_4) / var_204_9

				arg_201_1.typewritter:SetDirty()
			end

			if arg_201_1.time_ >= var_204_4 + var_204_9 and arg_201_1.time_ < var_204_4 + var_204_9 + arg_204_0 then
				arg_201_1.typewritter.percent = 1

				arg_201_1.typewritter:SetDirty()
				arg_201_1:ShowNextGo(true)
			end
		end

		arg_201_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_201_1:InitPlayNodeList()
	end,
	Play421101050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 421101050
		arg_205_1.duration_ = 7.83

		local var_205_0 = {
			zh = 6.2,
			ja = 7.833
		}
		local var_205_1 = manager.audio:GetLocalizationFlag()

		if var_205_0[var_205_1] ~= nil then
			arg_205_1.duration_ = var_205_0[var_205_1]
		end

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play421101051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1.var_.moveOldPos1047ui_story = arg_205_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_208_0 = 0.001

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 then
				arg_205_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_205_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_205_1.time_ - 0) / var_208_0)
				arg_205_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).z)
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles = arg_205_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 then
				arg_205_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_205_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_205_1.actors_["1047ui_story"].transform.position).z)
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_205_1.actors_["1047ui_story"].transform.localEulerAngles = arg_205_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_208_1 = arg_205_1.actors_["1047ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1047ui_story == nil then
				arg_205_1.var_.characterEffect1047ui_story = var_208_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_2 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_2 and not isNil(var_208_1) then
				if arg_205_1.var_.characterEffect1047ui_story and not isNil(var_208_1) then
					arg_205_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_2 and arg_205_1.time_ < 0 + var_208_2 + arg_208_0 and not isNil(var_208_1) and arg_205_1.var_.characterEffect1047ui_story then
				arg_205_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_1")
			end

			local var_208_4 = 0
			local var_208_5 = 0.575

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:GetWordFromCfg(421101050)
				local var_208_7 = arg_205_1:FormatText(var_208_6.content)

				arg_205_1.text_.text = var_208_7

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_9 = 22 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 22)

				if (22 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_7) / 22)) > 0 and var_208_5 < var_208_9 then
					arg_205_1.talkMaxDuration = var_208_9

					if var_208_9 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_9 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_7
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101050", "story_v_out_421101.awb") ~= 0 then
					local var_208_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101050", "story_v_out_421101.awb") / 1000

					if var_208_10 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_10 + var_208_4
					end

					if var_208_6.prefab_name ~= "" and arg_205_1.actors_[var_208_6.prefab_name] ~= nil then
						local var_208_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_205_1.actors_[var_208_6.prefab_name].transform, "story_v_out_421101", "421101050", "story_v_out_421101.awb")

						arg_205_1:RecordAudio("421101050", var_208_11)
						arg_205_1:RecordAudio("421101050", var_208_11)
					else
						arg_205_1:AudioAction("play", "voice", "story_v_out_421101", "421101050", "story_v_out_421101.awb")
					end

					arg_205_1:RecordHistoryTalkVoice("story_v_out_421101", "421101050", "story_v_out_421101.awb")
				end

				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_12 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_12 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_12

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_12 and arg_205_1.time_ < var_208_4 + var_208_12 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {
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

		arg_205_1:InitPlayNodeList()
	end,
	Play421101051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 421101051
		arg_209_1.duration_ = 5.7

		local var_209_0 = {
			zh = 5.7,
			ja = 3.966
		}
		local var_209_1 = manager.audio:GetLocalizationFlag()

		if var_209_0[var_209_1] ~= nil then
			arg_209_1.duration_ = var_209_0[var_209_1]
		end

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play421101052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1047ui_story"]) and arg_209_1.var_.characterEffect1047ui_story == nil then
				arg_209_1.var_.characterEffect1047ui_story = arg_209_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1047ui_story"]) then
				if arg_209_1.var_.characterEffect1047ui_story and not isNil(arg_209_1.actors_["1047ui_story"]) then
					arg_209_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1047ui_story"]) and arg_209_1.var_.characterEffect1047ui_story then
				arg_209_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 0.45

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, true)

				arg_209_1.leftNameTxt_.text = arg_209_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_209_1.leftNameTxt_.transform)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1.leftNameTxt_.text)
				SetActive(arg_209_1.iconTrs_.gameObject, true)
				arg_209_1.iconController_:SetSelectedState("hero")

				arg_209_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_209_1.callingController_:SetSelectedState("normal")

				arg_209_1.keyicon_.color = Color.New(1, 1, 1)
				arg_209_1.icon_.color = Color.New(1, 1, 1)

				local var_212_3 = arg_209_1:GetWordFromCfg(421101051)
				local var_212_4 = arg_209_1:FormatText(var_212_3.content)

				arg_209_1.text_.text = var_212_4

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_6 = 18 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 18)

				if (18 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_4) / 18)) > 0 and var_212_2 < var_212_6 then
					arg_209_1.talkMaxDuration = var_212_6

					if var_212_6 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_6 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_4
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101051", "story_v_out_421101.awb") ~= 0 then
					local var_212_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101051", "story_v_out_421101.awb") / 1000

					if var_212_7 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_7 + var_212_1
					end

					if var_212_3.prefab_name ~= "" and arg_209_1.actors_[var_212_3.prefab_name] ~= nil then
						local var_212_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_209_1.actors_[var_212_3.prefab_name].transform, "story_v_out_421101", "421101051", "story_v_out_421101.awb")

						arg_209_1:RecordAudio("421101051", var_212_8)
						arg_209_1:RecordAudio("421101051", var_212_8)
					else
						arg_209_1:AudioAction("play", "voice", "story_v_out_421101", "421101051", "story_v_out_421101.awb")
					end

					arg_209_1:RecordHistoryTalkVoice("story_v_out_421101", "421101051", "story_v_out_421101.awb")
				end

				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_9 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_9 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_9

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_9 and arg_209_1.time_ < var_212_1 + var_212_9 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play421101052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 421101052
		arg_213_1.duration_ = 6.5

		local var_213_0 = {
			zh = 5.2,
			ja = 6.5
		}
		local var_213_1 = manager.audio:GetLocalizationFlag()

		if var_213_0[var_213_1] ~= nil then
			arg_213_1.duration_ = var_213_0[var_213_1]
		end

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play421101053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1.var_.moveOldPos1047ui_story = arg_213_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_216_0 = 0.001

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 then
				arg_213_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_213_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_213_1.time_ - 0) / var_216_0)
				arg_213_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).z)
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles = arg_213_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 then
				arg_213_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_213_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_213_1.actors_["1047ui_story"].transform.position).z)
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_213_1.actors_["1047ui_story"].transform.localEulerAngles = arg_213_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_216_1 = arg_213_1.actors_["1047ui_story"]

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1047ui_story == nil then
				arg_213_1.var_.characterEffect1047ui_story = var_216_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_2 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_2 and not isNil(var_216_1) then
				if arg_213_1.var_.characterEffect1047ui_story and not isNil(var_216_1) then
					arg_213_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_2 and arg_213_1.time_ < 0 + var_216_2 + arg_216_0 and not isNil(var_216_1) and arg_213_1.var_.characterEffect1047ui_story then
				arg_213_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 then
				arg_213_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action4_2")
			end

			local var_216_4 = 0
			local var_216_5 = 0.525

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_4 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_6 = arg_213_1:GetWordFromCfg(421101052)
				local var_216_7 = arg_213_1:FormatText(var_216_6.content)

				arg_213_1.text_.text = var_216_7

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_9 = 21 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 21)

				if (21 <= 0 and var_216_5 or var_216_5 * (utf8.len(var_216_7) / 21)) > 0 and var_216_5 < var_216_9 then
					arg_213_1.talkMaxDuration = var_216_9

					if var_216_9 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_9 + var_216_4
					end
				end

				arg_213_1.text_.text = var_216_7
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101052", "story_v_out_421101.awb") ~= 0 then
					local var_216_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101052", "story_v_out_421101.awb") / 1000

					if var_216_10 + var_216_4 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_10 + var_216_4
					end

					if var_216_6.prefab_name ~= "" and arg_213_1.actors_[var_216_6.prefab_name] ~= nil then
						local var_216_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_213_1.actors_[var_216_6.prefab_name].transform, "story_v_out_421101", "421101052", "story_v_out_421101.awb")

						arg_213_1:RecordAudio("421101052", var_216_11)
						arg_213_1:RecordAudio("421101052", var_216_11)
					else
						arg_213_1:AudioAction("play", "voice", "story_v_out_421101", "421101052", "story_v_out_421101.awb")
					end

					arg_213_1:RecordHistoryTalkVoice("story_v_out_421101", "421101052", "story_v_out_421101.awb")
				end

				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_12 = math.max(var_216_5, arg_213_1.talkMaxDuration)

			if var_216_4 <= arg_213_1.time_ and arg_213_1.time_ < var_216_4 + var_216_12 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_4) / var_216_12

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_4 + var_216_12 and arg_213_1.time_ < var_216_4 + var_216_12 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {
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

		arg_213_1:InitPlayNodeList()
	end,
	Play421101053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 421101053
		arg_217_1.duration_ = 8.7

		local var_217_0 = {
			zh = 6.566,
			ja = 8.7
		}
		local var_217_1 = manager.audio:GetLocalizationFlag()

		if var_217_0[var_217_1] ~= nil then
			arg_217_1.duration_ = var_217_0[var_217_1]
		end

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play421101054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 and not isNil(arg_217_1.actors_["1047ui_story"]) and arg_217_1.var_.characterEffect1047ui_story == nil then
				arg_217_1.var_.characterEffect1047ui_story = arg_217_1.actors_["1047ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_220_0 = 0.200000002980232

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_0 and not isNil(arg_217_1.actors_["1047ui_story"]) then
				if arg_217_1.var_.characterEffect1047ui_story and not isNil(arg_217_1.actors_["1047ui_story"]) then
					arg_217_1.var_.characterEffect1047ui_story.fillFlat = true
					arg_217_1.var_.characterEffect1047ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_217_1.time_ - 0) / var_220_0)
				end
			end

			if arg_217_1.time_ >= 0 + var_220_0 and arg_217_1.time_ < 0 + var_220_0 + arg_220_0 and not isNil(arg_217_1.actors_["1047ui_story"]) and arg_217_1.var_.characterEffect1047ui_story then
				arg_217_1.var_.characterEffect1047ui_story.fillFlat = true
				arg_217_1.var_.characterEffect1047ui_story.fillRatio = 0.5
			end

			local var_220_1 = 0
			local var_220_2 = 0.675

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= var_220_1 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, true)
				arg_217_1.iconController_:SetSelectedState("hero")

				arg_217_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_217_1.callingController_:SetSelectedState("normal")

				arg_217_1.keyicon_.color = Color.New(1, 1, 1)
				arg_217_1.icon_.color = Color.New(1, 1, 1)

				local var_220_3 = arg_217_1:GetWordFromCfg(421101053)
				local var_220_4 = arg_217_1:FormatText(var_220_3.content)

				arg_217_1.text_.text = var_220_4

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_6 = 27 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_4) / 27)

				if (27 <= 0 and var_220_2 or var_220_2 * (utf8.len(var_220_4) / 27)) > 0 and var_220_2 < var_220_6 then
					arg_217_1.talkMaxDuration = var_220_6

					if var_220_6 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_6 + var_220_1
					end
				end

				arg_217_1.text_.text = var_220_4
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101053", "story_v_out_421101.awb") ~= 0 then
					local var_220_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101053", "story_v_out_421101.awb") / 1000

					if var_220_7 + var_220_1 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_7 + var_220_1
					end

					if var_220_3.prefab_name ~= "" and arg_217_1.actors_[var_220_3.prefab_name] ~= nil then
						local var_220_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_217_1.actors_[var_220_3.prefab_name].transform, "story_v_out_421101", "421101053", "story_v_out_421101.awb")

						arg_217_1:RecordAudio("421101053", var_220_8)
						arg_217_1:RecordAudio("421101053", var_220_8)
					else
						arg_217_1:AudioAction("play", "voice", "story_v_out_421101", "421101053", "story_v_out_421101.awb")
					end

					arg_217_1:RecordHistoryTalkVoice("story_v_out_421101", "421101053", "story_v_out_421101.awb")
				end

				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_9 = math.max(var_220_2, arg_217_1.talkMaxDuration)

			if var_220_1 <= arg_217_1.time_ and arg_217_1.time_ < var_220_1 + var_220_9 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - var_220_1) / var_220_9

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= var_220_1 + var_220_9 and arg_217_1.time_ < var_220_1 + var_220_9 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play421101054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 421101054
		arg_221_1.duration_ = 5.4

		local var_221_0 = {
			zh = 3.733,
			ja = 5.4
		}
		local var_221_1 = manager.audio:GetLocalizationFlag()

		if var_221_0[var_221_1] ~= nil then
			arg_221_1.duration_ = var_221_0[var_221_1]
		end

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play421101055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			local var_224_0 = 0.325

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, true)

				arg_221_1.leftNameTxt_.text = arg_221_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_221_1.leftNameTxt_.transform)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1.leftNameTxt_.text)
				SetActive(arg_221_1.iconTrs_.gameObject, true)
				arg_221_1.iconController_:SetSelectedState("hero")

				arg_221_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_Aix")

				arg_221_1.callingController_:SetSelectedState("normal")

				arg_221_1.keyicon_.color = Color.New(1, 1, 1)
				arg_221_1.icon_.color = Color.New(1, 1, 1)

				local var_224_1 = arg_221_1:GetWordFromCfg(421101054)
				local var_224_2 = arg_221_1:FormatText(var_224_1.content)

				arg_221_1.text_.text = var_224_2

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_4 = 13 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 13)

				if (13 <= 0 and var_224_0 or var_224_0 * (utf8.len(var_224_2) / 13)) > 0 and var_224_0 < var_224_4 then
					arg_221_1.talkMaxDuration = var_224_4

					if var_224_4 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_4 + 0
					end
				end

				arg_221_1.text_.text = var_224_2
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101054", "story_v_out_421101.awb") ~= 0 then
					local var_224_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101054", "story_v_out_421101.awb") / 1000

					if var_224_5 + 0 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + 0
					end

					if var_224_1.prefab_name ~= "" and arg_221_1.actors_[var_224_1.prefab_name] ~= nil then
						local var_224_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_221_1.actors_[var_224_1.prefab_name].transform, "story_v_out_421101", "421101054", "story_v_out_421101.awb")

						arg_221_1:RecordAudio("421101054", var_224_6)
						arg_221_1:RecordAudio("421101054", var_224_6)
					else
						arg_221_1:AudioAction("play", "voice", "story_v_out_421101", "421101054", "story_v_out_421101.awb")
					end

					arg_221_1:RecordHistoryTalkVoice("story_v_out_421101", "421101054", "story_v_out_421101.awb")
				end

				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_7 = math.max(var_224_0, arg_221_1.talkMaxDuration)

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_7 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - 0) / var_224_7

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= 0 + var_224_7 and arg_221_1.time_ < 0 + var_224_7 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play421101055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 421101055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play421101056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1.var_.moveOldPos1047ui_story = arg_225_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_228_0 = 0.001

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_225_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_225_1.time_ - 0) / var_228_0)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 then
				arg_225_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_225_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_225_1.actors_["1047ui_story"].transform.position).z)
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_225_1.actors_["1047ui_story"].transform.localEulerAngles = arg_225_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_228_1 = 0
			local var_228_2 = 0.9

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_1 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, false)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_3 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(421101055).content)

				arg_225_1.text_.text = var_228_3

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_5 = 36 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 36)

				if (36 <= 0 and var_228_2 or var_228_2 * (utf8.len(var_228_3) / 36)) > 0 and var_228_2 < var_228_5 then
					arg_225_1.talkMaxDuration = var_228_5

					if var_228_5 + var_228_1 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_5 + var_228_1
					end
				end

				arg_225_1.text_.text = var_228_3
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_6 = math.max(var_228_2, arg_225_1.talkMaxDuration)

			if var_228_1 <= arg_225_1.time_ and arg_225_1.time_ < var_228_1 + var_228_6 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_1) / var_228_6

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_1 + var_228_6 and arg_225_1.time_ < var_228_1 + var_228_6 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {
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

		arg_225_1:InitPlayNodeList()
	end,
	Play421101056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 421101056
		arg_229_1.duration_ = 9.13

		local var_229_0 = {
			zh = 4.833,
			ja = 9.133
		}
		local var_229_1 = manager.audio:GetLocalizationFlag()

		if var_229_0[var_229_1] ~= nil then
			arg_229_1.duration_ = var_229_0[var_229_1]
		end

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play421101057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1.var_.moveOldPos1047ui_story = arg_229_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_232_0 = 0.001

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 then
				arg_229_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_229_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_229_1.time_ - 0) / var_232_0)
				arg_229_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).z)
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles = arg_229_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 then
				arg_229_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_229_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_229_1.actors_["1047ui_story"].transform.position).z)
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_229_1.actors_["1047ui_story"].transform.localEulerAngles = arg_229_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_232_1 = arg_229_1.actors_["1047ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1047ui_story == nil then
				arg_229_1.var_.characterEffect1047ui_story = var_232_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_2 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_2 and not isNil(var_232_1) then
				if arg_229_1.var_.characterEffect1047ui_story and not isNil(var_232_1) then
					arg_229_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_2 and arg_229_1.time_ < 0 + var_232_2 + arg_232_0 and not isNil(var_232_1) and arg_229_1.var_.characterEffect1047ui_story then
				arg_229_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 then
				arg_229_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			local var_232_4 = 0
			local var_232_5 = 0.725

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:GetWordFromCfg(421101056)
				local var_232_7 = arg_229_1:FormatText(var_232_6.content)

				arg_229_1.text_.text = var_232_7

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_9 = 29 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 29)

				if (29 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_7) / 29)) > 0 and var_232_5 < var_232_9 then
					arg_229_1.talkMaxDuration = var_232_9

					if var_232_9 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_9 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_7
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101056", "story_v_out_421101.awb") ~= 0 then
					local var_232_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101056", "story_v_out_421101.awb") / 1000

					if var_232_10 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_10 + var_232_4
					end

					if var_232_6.prefab_name ~= "" and arg_229_1.actors_[var_232_6.prefab_name] ~= nil then
						local var_232_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_229_1.actors_[var_232_6.prefab_name].transform, "story_v_out_421101", "421101056", "story_v_out_421101.awb")

						arg_229_1:RecordAudio("421101056", var_232_11)
						arg_229_1:RecordAudio("421101056", var_232_11)
					else
						arg_229_1:AudioAction("play", "voice", "story_v_out_421101", "421101056", "story_v_out_421101.awb")
					end

					arg_229_1:RecordHistoryTalkVoice("story_v_out_421101", "421101056", "story_v_out_421101.awb")
				end

				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_12 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_12 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_12

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_12 and arg_229_1.time_ < var_232_4 + var_232_12 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {
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

		arg_229_1:InitPlayNodeList()
	end,
	Play421101057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 421101057
		arg_233_1.duration_ = 9.8

		local var_233_0 = {
			zh = 8.833,
			ja = 9.8
		}
		local var_233_1 = manager.audio:GetLocalizationFlag()

		if var_233_0[var_233_1] ~= nil then
			arg_233_1.duration_ = var_233_0[var_233_1]
		end

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play421101058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			local var_236_9000

			if arg_233_1.bgs_.SS2103 == nil then
				local var_236_0 = Object.Instantiate(arg_233_1.paintGo_)

				var_236_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "SS2103")
				var_236_0.name = "SS2103"
				var_236_0.transform.parent = arg_233_1.stage_.transform
				var_236_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_233_1.bgs_.SS2103 = var_236_0
			end

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				local var_236_1 = arg_233_1.bgs_.SS2103

				arg_233_1.bgs_.SS2103.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_236_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_236_2 = var_236_1:GetComponent("SpriteRenderer")

				if var_236_2 and var_236_2.sprite then
					local var_236_3 = 2 * (var_236_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_236_1.transform.localScale = Vector3.New(var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, var_236_3 / var_236_2.sprite.bounds.size.y < var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x and var_236_3 * manager.ui.mainCameraCom_.aspect / var_236_2.sprite.bounds.size.x or var_236_3 / var_236_2.sprite.bounds.size.y, 0)
				end

				for iter_236_0, iter_236_1 in pairs(arg_233_1.bgs_) do
					if iter_236_0 ~= "SS2103" then
						iter_236_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_236_4 = 3

			if 3 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.allBtn_.enabled = false
			end

			if arg_233_1.time_ >= var_236_4 + 0.3 and arg_233_1.time_ < var_236_4 + 0.3 + arg_236_0 then
				arg_233_1.allBtn_.enabled = true
			end

			local var_236_5 = 0

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_5 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_6 = 1

			if var_236_5 <= arg_233_1.time_ and arg_233_1.time_ < var_236_5 + var_236_6 then
				local var_236_7 = Color.New(0, 0, 0)

				var_236_7.a = Mathf.Lerp(0, 1, (arg_233_1.time_ - var_236_5) / var_236_6)
				arg_233_1.mask_.color = var_236_7
			end

			if arg_233_1.time_ >= var_236_5 + var_236_6 and arg_233_1.time_ < var_236_5 + var_236_6 + arg_236_0 then
				local var_236_8 = Color.New(0, 0, 0)

				var_236_8.a = 1
				arg_233_1.mask_.color = var_236_8
			end

			local var_236_9 = 1

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= var_236_9 + arg_236_0 then
				arg_233_1.mask_.enabled = true
				arg_233_1.mask_.raycastTarget = true

				arg_233_1:SetGaussion(false)
			end

			local var_236_10 = 2

			if var_236_9 <= arg_233_1.time_ and arg_233_1.time_ < var_236_9 + var_236_10 then
				local var_236_11 = Color.New(0, 0, 0)

				var_236_11.a = Mathf.Lerp(1, 0, (arg_233_1.time_ - var_236_9) / var_236_10)
				arg_233_1.mask_.color = var_236_11
			end

			if arg_233_1.time_ >= var_236_9 + var_236_10 and arg_233_1.time_ < var_236_9 + var_236_10 + arg_236_0 then
				local var_236_12 = Color.New(0, 0, 0)

				arg_233_1.mask_.enabled = false
				var_236_12.a = 0
				arg_233_1.mask_.color = var_236_12
			end

			local var_236_13 = arg_233_1.actors_["1047ui_story"].transform

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				arg_233_1.var_.moveOldPos1047ui_story = var_236_13.localPosition
			end

			local var_236_14 = 0.001

			if 1 <= arg_233_1.time_ and arg_233_1.time_ < 1 + var_236_14 then
				var_236_13.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_233_1.time_ - 1) / var_236_14)
				var_236_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_13.position).x, (manager.ui.mainCamera.transform.position - var_236_13.position).y, (manager.ui.mainCamera.transform.position - var_236_13.position).z)
				var_236_13.localEulerAngles.z = 0
				var_236_13.localEulerAngles.x = 0
				var_236_13.localEulerAngles = var_236_13.localEulerAngles
			end

			if arg_233_1.time_ >= 1 + var_236_14 and arg_233_1.time_ < 1 + var_236_14 + arg_236_0 then
				var_236_13.localPosition = Vector3.New(0, 100, 0)
				var_236_13.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_236_13.position).x, (manager.ui.mainCamera.transform.position - var_236_13.position).y, (manager.ui.mainCamera.transform.position - var_236_13.position).z)
				var_236_13.localEulerAngles.z = 0
				var_236_13.localEulerAngles.x = 0
				var_236_13.localEulerAngles = var_236_13.localEulerAngles
			end

			local var_236_15 = arg_233_1.bgs_.SS2103.transform

			if 1 < arg_233_1.time_ and arg_233_1.time_ <= 1 + arg_236_0 then
				arg_233_1.var_.moveOldPosSS2103 = var_236_15.localPosition
			end

			local var_236_16 = 0.1

			if 1 <= arg_233_1.time_ and arg_233_1.time_ < 1 + var_236_16 then
				var_236_15.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPosSS2103, Vector3.New(0, 1, 10), (arg_233_1.time_ - 1) / var_236_16)
			end

			if arg_233_1.time_ >= 1 + var_236_16 and arg_233_1.time_ < 1 + var_236_16 + arg_236_0 then
				var_236_15.localPosition = Vector3.New(0, 1, 10)
			end

			local var_236_17 = arg_233_1.bgs_.SS2103.transform

			if 1.1 < arg_233_1.time_ and arg_233_1.time_ <= 1.1 + arg_236_0 then
				arg_233_1.var_.moveOldPosSS2103 = var_236_17.localPosition
			end

			local var_236_18 = 1.9

			if 1.1 <= arg_233_1.time_ and arg_233_1.time_ < 1.1 + var_236_18 then
				var_236_17.localPosition = Vector3.Lerp(arg_233_1.var_.moveOldPosSS2103, Vector3.New(0, 1, 9), (arg_233_1.time_ - 1.1) / var_236_18)
			end

			if arg_233_1.time_ >= 1.1 + var_236_18 and arg_233_1.time_ < 1.1 + var_236_18 + arg_236_0 then
				var_236_17.localPosition = Vector3.New(0, 1, 9)
			end

			if 1.03400000184774 < arg_233_1.time_ and arg_233_1.time_ <= 1.03400000184774 + arg_236_0 then
				local var_236_19 = arg_233_1.var_.effect105788

				if not arg_233_1.var_.effect105788 then
					var_236_19 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_fogbank_keep"), manager.ui.mainCamera.transform)
					var_236_19.name = "105788"
					arg_233_1.var_.effect105788 = var_236_19
				else
					var_236_19.transform:SetParent(var_236_9000)
				end

				var_236_19.transform.localPosition = Vector3.New(0, -1.33, 0)
				var_236_19.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if arg_233_1.frameCnt_ <= 1 then
				arg_233_1.dialog_:SetActive(false)
			end

			local var_236_21 = 3
			local var_236_22 = 0.4

			if 3 < arg_233_1.time_ and arg_233_1.time_ <= var_236_21 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0

				arg_233_1.dialog_:SetActive(true)

				arg_233_1.dialogCg_.alpha = 0

				local var_236_23 = LeanTween.value(arg_233_1.dialog_, 0, 1, 0.3)

				var_236_23:setOnUpdate(LuaHelper.FloatAction(function(arg_237_0)
					arg_233_1.dialogCg_.alpha = arg_237_0
				end))
				var_236_23:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_233_1.dialog_)
					var_236_23:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_233_1.duration_ = arg_233_1.duration_ + 0.3

				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_24 = arg_233_1:GetWordFromCfg(421101057)
				local var_236_25 = arg_233_1:FormatText(var_236_24.content)

				arg_233_1.text_.text = var_236_25

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_27 = 16 <= 0 and var_236_22 or var_236_22 * (utf8.len(var_236_25) / 16)

				if (16 <= 0 and var_236_22 or var_236_22 * (utf8.len(var_236_25) / 16)) > 0 and var_236_22 < var_236_27 then
					arg_233_1.talkMaxDuration = var_236_27
					var_236_21 = var_236_21 + 0.3

					if var_236_27 + var_236_21 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_27 + var_236_21
					end
				end

				arg_233_1.text_.text = var_236_25
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101057", "story_v_out_421101.awb") ~= 0 then
					local var_236_28 = manager.audio:GetVoiceLength("story_v_out_421101", "421101057", "story_v_out_421101.awb") / 1000

					if var_236_28 + var_236_21 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_28 + var_236_21
					end

					if var_236_24.prefab_name ~= "" and arg_233_1.actors_[var_236_24.prefab_name] ~= nil then
						local var_236_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_233_1.actors_[var_236_24.prefab_name].transform, "story_v_out_421101", "421101057", "story_v_out_421101.awb")

						arg_233_1:RecordAudio("421101057", var_236_29)
						arg_233_1:RecordAudio("421101057", var_236_29)
					else
						arg_233_1:AudioAction("play", "voice", "story_v_out_421101", "421101057", "story_v_out_421101.awb")
					end

					arg_233_1:RecordHistoryTalkVoice("story_v_out_421101", "421101057", "story_v_out_421101.awb")
				end

				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_30 = var_236_21 + 0.3
			local var_236_31 = math.max(var_236_22, arg_233_1.talkMaxDuration)

			if var_236_21 + 0.3 <= arg_233_1.time_ and arg_233_1.time_ < var_236_30 + var_236_31 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_30) / var_236_31

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_30 + var_236_31 and arg_233_1.time_ < var_236_30 + var_236_31 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1047ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "SS2103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.1,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2103",
				changeDisplayLayer = false,
				needEase = false,
				duration = 1.9,
				className = "StoryMoveNode",
				startTime = 1.1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_233_1:InitPlayNodeList()
	end,
	Play421101058 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 421101058
		arg_239_1.duration_ = 6

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play421101059(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_9000

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:AudioAction("play", "effect", "se_story_140", "se_story_140_metal", "")
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				local var_242_1 = arg_239_1.var_.effect10581

				if not arg_239_1.var_.effect10581 then
					var_242_1 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_Lightning_in"), manager.ui.mainCamera.transform)
					var_242_1.name = "10581"
					arg_239_1.var_.effect10581 = var_242_1
				else
					var_242_1.transform:SetParent(var_242_9000)
				end

				var_242_1.transform.localPosition = Vector3.New(0, 0, 0)
				var_242_1.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 0 < arg_239_1.time_ and arg_239_1.time_ <= 0 + arg_242_0 then
				arg_239_1:AudioAction("play", "effect", "se_story_138", "se_story_138_thunderhit", "")
			end

			if arg_239_1.frameCnt_ <= 1 then
				arg_239_1.dialog_:SetActive(false)
			end

			local var_242_4 = 1
			local var_242_5 = 1.25

			if 1 < arg_239_1.time_ and arg_239_1.time_ <= var_242_4 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0

				arg_239_1.dialog_:SetActive(true)

				arg_239_1.dialogCg_.alpha = 0

				local var_242_6 = LeanTween.value(arg_239_1.dialog_, 0, 1, 0.3)

				var_242_6:setOnUpdate(LuaHelper.FloatAction(function(arg_243_0)
					arg_239_1.dialogCg_.alpha = arg_243_0
				end))
				var_242_6:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_239_1.dialog_)
					var_242_6:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_239_1.duration_ = arg_239_1.duration_ + 0.3

				SetActive(arg_239_1.leftNameGo_, false)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_7 = arg_239_1:FormatText(arg_239_1:GetWordFromCfg(421101058).content)

				arg_239_1.text_.text = var_242_7

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_9 = 50 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 50)

				if (50 <= 0 and var_242_5 or var_242_5 * (utf8.len(var_242_7) / 50)) > 0 and var_242_5 < var_242_9 then
					arg_239_1.talkMaxDuration = var_242_9
					var_242_4 = var_242_4 + 0.3

					if var_242_9 + var_242_4 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_9 + var_242_4
					end
				end

				arg_239_1.text_.text = var_242_7
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)
				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = var_242_4 + 0.3
			local var_242_11 = math.max(var_242_5, arg_239_1.talkMaxDuration)

			if var_242_4 + 0.3 <= arg_239_1.time_ and arg_239_1.time_ < var_242_10 + var_242_11 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_10) / var_242_11

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_10 + var_242_11 and arg_239_1.time_ < var_242_10 + var_242_11 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end

		arg_239_1.nodeConfigList_ = {}

		arg_239_1:InitPlayNodeList()
	end,
	Play421101059 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 421101059
		arg_245_1.duration_ = 4.3

		local var_245_0 = {
			zh = 1.866,
			ja = 4.3
		}
		local var_245_1 = manager.audio:GetLocalizationFlag()

		if var_245_0[var_245_1] ~= nil then
			arg_245_1.duration_ = var_245_0[var_245_1]
		end

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play421101060(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 then
				if arg_245_1.var_.effect10581 then
					Object.Destroy(arg_245_1.var_.effect10581)

					arg_245_1.var_.effect10581 = nil
				end
			end

			local var_248_1 = 0
			local var_248_2 = 0.3

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, true)

				arg_245_1.leftNameTxt_.text = arg_245_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_245_1.leftNameTxt_.transform)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1.leftNameTxt_.text)
				SetActive(arg_245_1.iconTrs_.gameObject, true)
				arg_245_1.iconController_:SetSelectedState("hero")

				arg_245_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_6")

				arg_245_1.callingController_:SetSelectedState("normal")

				arg_245_1.keyicon_.color = Color.New(1, 1, 1)
				arg_245_1.icon_.color = Color.New(1, 1, 1)

				local var_248_3 = arg_245_1:GetWordFromCfg(421101059)
				local var_248_4 = arg_245_1:FormatText(var_248_3.content)

				arg_245_1.text_.text = var_248_4

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_6 = 12 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 12)

				if (12 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_4) / 12)) > 0 and var_248_2 < var_248_6 then
					arg_245_1.talkMaxDuration = var_248_6

					if var_248_6 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_6 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_4
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101059", "story_v_out_421101.awb") ~= 0 then
					local var_248_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101059", "story_v_out_421101.awb") / 1000

					if var_248_7 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_7 + var_248_1
					end

					if var_248_3.prefab_name ~= "" and arg_245_1.actors_[var_248_3.prefab_name] ~= nil then
						local var_248_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_245_1.actors_[var_248_3.prefab_name].transform, "story_v_out_421101", "421101059", "story_v_out_421101.awb")

						arg_245_1:RecordAudio("421101059", var_248_8)
						arg_245_1:RecordAudio("421101059", var_248_8)
					else
						arg_245_1:AudioAction("play", "voice", "story_v_out_421101", "421101059", "story_v_out_421101.awb")
					end

					arg_245_1:RecordHistoryTalkVoice("story_v_out_421101", "421101059", "story_v_out_421101.awb")
				end

				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_9 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_9 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_9

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_9 and arg_245_1.time_ < var_248_1 + var_248_9 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play421101060 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 421101060
		arg_249_1.duration_ = 13.27

		local var_249_0 = {
			zh = 10.3,
			ja = 13.266
		}
		local var_249_1 = manager.audio:GetLocalizationFlag()

		if var_249_0[var_249_1] ~= nil then
			arg_249_1.duration_ = var_249_0[var_249_1]
		end

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play421101061(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			local var_252_0 = 1.025

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_1 = arg_249_1:GetWordFromCfg(421101060)
				local var_252_2 = arg_249_1:FormatText(var_252_1.content)

				arg_249_1.text_.text = var_252_2

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_4 = 41 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 41)

				if (41 <= 0 and var_252_0 or var_252_0 * (utf8.len(var_252_2) / 41)) > 0 and var_252_0 < var_252_4 then
					arg_249_1.talkMaxDuration = var_252_4

					if var_252_4 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_4 + 0
					end
				end

				arg_249_1.text_.text = var_252_2
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101060", "story_v_out_421101.awb") ~= 0 then
					local var_252_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101060", "story_v_out_421101.awb") / 1000

					if var_252_5 + 0 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_5 + 0
					end

					if var_252_1.prefab_name ~= "" and arg_249_1.actors_[var_252_1.prefab_name] ~= nil then
						local var_252_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_249_1.actors_[var_252_1.prefab_name].transform, "story_v_out_421101", "421101060", "story_v_out_421101.awb")

						arg_249_1:RecordAudio("421101060", var_252_6)
						arg_249_1:RecordAudio("421101060", var_252_6)
					else
						arg_249_1:AudioAction("play", "voice", "story_v_out_421101", "421101060", "story_v_out_421101.awb")
					end

					arg_249_1:RecordHistoryTalkVoice("story_v_out_421101", "421101060", "story_v_out_421101.awb")
				end

				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_0, arg_249_1.talkMaxDuration)

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - 0) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= 0 + var_252_7 and arg_249_1.time_ < 0 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play421101061 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 421101061
		arg_253_1.duration_ = 9.97

		local var_253_0 = {
			zh = 9.033,
			ja = 9.966
		}
		local var_253_1 = manager.audio:GetLocalizationFlag()

		if var_253_0[var_253_1] ~= nil then
			arg_253_1.duration_ = var_253_0[var_253_1]
		end

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play421101062(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			local var_256_0 = 1.025

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_1 = arg_253_1:GetWordFromCfg(421101061)
				local var_256_2 = arg_253_1:FormatText(var_256_1.content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 41 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 41)

				if (41 <= 0 and var_256_0 or var_256_0 * (utf8.len(var_256_2) / 41)) > 0 and var_256_0 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + 0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101061", "story_v_out_421101.awb") ~= 0 then
					local var_256_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101061", "story_v_out_421101.awb") / 1000

					if var_256_5 + 0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_5 + 0
					end

					if var_256_1.prefab_name ~= "" and arg_253_1.actors_[var_256_1.prefab_name] ~= nil then
						local var_256_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_253_1.actors_[var_256_1.prefab_name].transform, "story_v_out_421101", "421101061", "story_v_out_421101.awb")

						arg_253_1:RecordAudio("421101061", var_256_6)
						arg_253_1:RecordAudio("421101061", var_256_6)
					else
						arg_253_1:AudioAction("play", "voice", "story_v_out_421101", "421101061", "story_v_out_421101.awb")
					end

					arg_253_1:RecordHistoryTalkVoice("story_v_out_421101", "421101061", "story_v_out_421101.awb")
				end

				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_7 = math.max(var_256_0, arg_253_1.talkMaxDuration)

			if 0 <= arg_253_1.time_ and arg_253_1.time_ < 0 + var_256_7 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - 0) / var_256_7

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= 0 + var_256_7 and arg_253_1.time_ < 0 + var_256_7 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play421101062 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 421101062
		arg_257_1.duration_ = 13.8

		local var_257_0 = {
			zh = 9.166,
			ja = 13.8
		}
		local var_257_1 = manager.audio:GetLocalizationFlag()

		if var_257_0[var_257_1] ~= nil then
			arg_257_1.duration_ = var_257_0[var_257_1]
		end

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play421101063(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			local var_260_0 = 1.225

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, true)
				arg_257_1.iconController_:SetSelectedState("hero")

				arg_257_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_3")

				arg_257_1.callingController_:SetSelectedState("normal")

				arg_257_1.keyicon_.color = Color.New(1, 1, 1)
				arg_257_1.icon_.color = Color.New(1, 1, 1)

				local var_260_1 = arg_257_1:GetWordFromCfg(421101062)
				local var_260_2 = arg_257_1:FormatText(var_260_1.content)

				arg_257_1.text_.text = var_260_2

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_4 = 49 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 49)

				if (49 <= 0 and var_260_0 or var_260_0 * (utf8.len(var_260_2) / 49)) > 0 and var_260_0 < var_260_4 then
					arg_257_1.talkMaxDuration = var_260_4

					if var_260_4 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_4 + 0
					end
				end

				arg_257_1.text_.text = var_260_2
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101062", "story_v_out_421101.awb") ~= 0 then
					local var_260_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101062", "story_v_out_421101.awb") / 1000

					if var_260_5 + 0 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_5 + 0
					end

					if var_260_1.prefab_name ~= "" and arg_257_1.actors_[var_260_1.prefab_name] ~= nil then
						local var_260_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_257_1.actors_[var_260_1.prefab_name].transform, "story_v_out_421101", "421101062", "story_v_out_421101.awb")

						arg_257_1:RecordAudio("421101062", var_260_6)
						arg_257_1:RecordAudio("421101062", var_260_6)
					else
						arg_257_1:AudioAction("play", "voice", "story_v_out_421101", "421101062", "story_v_out_421101.awb")
					end

					arg_257_1:RecordHistoryTalkVoice("story_v_out_421101", "421101062", "story_v_out_421101.awb")
				end

				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_7 = math.max(var_260_0, arg_257_1.talkMaxDuration)

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_7 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - 0) / var_260_7

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= 0 + var_260_7 and arg_257_1.time_ < 0 + var_260_7 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play421101063 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 421101063
		arg_261_1.duration_ = 23.73

		local var_261_0 = {
			zh = 17.4,
			ja = 23.733
		}
		local var_261_1 = manager.audio:GetLocalizationFlag()

		if var_261_0[var_261_1] ~= nil then
			arg_261_1.duration_ = var_261_0[var_261_1]
		end

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play421101064(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			local var_264_0 = 1.5

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, true)

				arg_261_1.leftNameTxt_.text = arg_261_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_261_1.leftNameTxt_.transform)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1.leftNameTxt_.text)
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_1 = arg_261_1:GetWordFromCfg(421101063)
				local var_264_2 = arg_261_1:FormatText(var_264_1.content)

				arg_261_1.text_.text = var_264_2

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_4 = 60 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 60)

				if (60 <= 0 and var_264_0 or var_264_0 * (utf8.len(var_264_2) / 60)) > 0 and var_264_0 < var_264_4 then
					arg_261_1.talkMaxDuration = var_264_4

					if var_264_4 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_4 + 0
					end
				end

				arg_261_1.text_.text = var_264_2
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101063", "story_v_out_421101.awb") ~= 0 then
					local var_264_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101063", "story_v_out_421101.awb") / 1000

					if var_264_5 + 0 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + 0
					end

					if var_264_1.prefab_name ~= "" and arg_261_1.actors_[var_264_1.prefab_name] ~= nil then
						local var_264_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_261_1.actors_[var_264_1.prefab_name].transform, "story_v_out_421101", "421101063", "story_v_out_421101.awb")

						arg_261_1:RecordAudio("421101063", var_264_6)
						arg_261_1:RecordAudio("421101063", var_264_6)
					else
						arg_261_1:AudioAction("play", "voice", "story_v_out_421101", "421101063", "story_v_out_421101.awb")
					end

					arg_261_1:RecordHistoryTalkVoice("story_v_out_421101", "421101063", "story_v_out_421101.awb")
				end

				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_7 = math.max(var_264_0, arg_261_1.talkMaxDuration)

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_7 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - 0) / var_264_7

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= 0 + var_264_7 and arg_261_1.time_ < 0 + var_264_7 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play421101064 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 421101064
		arg_265_1.duration_ = 6.6

		local var_265_0 = {
			zh = 2.7,
			ja = 6.6
		}
		local var_265_1 = manager.audio:GetLocalizationFlag()

		if var_265_0[var_265_1] ~= nil then
			arg_265_1.duration_ = var_265_0[var_265_1]
		end

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play421101065(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			local var_268_0 = 0.3

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, true)
				arg_265_1.iconController_:SetSelectedState("hero")

				arg_265_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_2")

				arg_265_1.callingController_:SetSelectedState("normal")

				arg_265_1.keyicon_.color = Color.New(1, 1, 1)
				arg_265_1.icon_.color = Color.New(1, 1, 1)

				local var_268_1 = arg_265_1:GetWordFromCfg(421101064)
				local var_268_2 = arg_265_1:FormatText(var_268_1.content)

				arg_265_1.text_.text = var_268_2

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_4 = 12 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 12)

				if (12 <= 0 and var_268_0 or var_268_0 * (utf8.len(var_268_2) / 12)) > 0 and var_268_0 < var_268_4 then
					arg_265_1.talkMaxDuration = var_268_4

					if var_268_4 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_4 + 0
					end
				end

				arg_265_1.text_.text = var_268_2
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101064", "story_v_out_421101.awb") ~= 0 then
					local var_268_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101064", "story_v_out_421101.awb") / 1000

					if var_268_5 + 0 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_5 + 0
					end

					if var_268_1.prefab_name ~= "" and arg_265_1.actors_[var_268_1.prefab_name] ~= nil then
						local var_268_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_265_1.actors_[var_268_1.prefab_name].transform, "story_v_out_421101", "421101064", "story_v_out_421101.awb")

						arg_265_1:RecordAudio("421101064", var_268_6)
						arg_265_1:RecordAudio("421101064", var_268_6)
					else
						arg_265_1:AudioAction("play", "voice", "story_v_out_421101", "421101064", "story_v_out_421101.awb")
					end

					arg_265_1:RecordHistoryTalkVoice("story_v_out_421101", "421101064", "story_v_out_421101.awb")
				end

				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_0, arg_265_1.talkMaxDuration)

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - 0) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= 0 + var_268_7 and arg_265_1.time_ < 0 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play421101065 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 421101065
		arg_269_1.duration_ = 18.9

		local var_269_0 = {
			zh = 18.633,
			ja = 18.9
		}
		local var_269_1 = manager.audio:GetLocalizationFlag()

		if var_269_0[var_269_1] ~= nil then
			arg_269_1.duration_ = var_269_0[var_269_1]
		end

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play421101066(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			local var_272_0 = 1.45

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_1 = arg_269_1:GetWordFromCfg(421101065)
				local var_272_2 = arg_269_1:FormatText(var_272_1.content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 57 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 57)

				if (57 <= 0 and var_272_0 or var_272_0 * (utf8.len(var_272_2) / 57)) > 0 and var_272_0 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + 0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101065", "story_v_out_421101.awb") ~= 0 then
					local var_272_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101065", "story_v_out_421101.awb") / 1000

					if var_272_5 + 0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_5 + 0
					end

					if var_272_1.prefab_name ~= "" and arg_269_1.actors_[var_272_1.prefab_name] ~= nil then
						local var_272_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_269_1.actors_[var_272_1.prefab_name].transform, "story_v_out_421101", "421101065", "story_v_out_421101.awb")

						arg_269_1:RecordAudio("421101065", var_272_6)
						arg_269_1:RecordAudio("421101065", var_272_6)
					else
						arg_269_1:AudioAction("play", "voice", "story_v_out_421101", "421101065", "story_v_out_421101.awb")
					end

					arg_269_1:RecordHistoryTalkVoice("story_v_out_421101", "421101065", "story_v_out_421101.awb")
				end

				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_7 = math.max(var_272_0, arg_269_1.talkMaxDuration)

			if 0 <= arg_269_1.time_ and arg_269_1.time_ < 0 + var_272_7 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - 0) / var_272_7

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= 0 + var_272_7 and arg_269_1.time_ < 0 + var_272_7 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play421101066 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 421101066
		arg_273_1.duration_ = 3.13

		local var_273_0 = {
			zh = 1.866,
			ja = 3.133
		}
		local var_273_1 = manager.audio:GetLocalizationFlag()

		if var_273_0[var_273_1] ~= nil then
			arg_273_1.duration_ = var_273_0[var_273_1]
		end

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play421101067(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			local var_276_0 = 0.175

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, true)
				arg_273_1.iconController_:SetSelectedState("hero")

				arg_273_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_3")

				arg_273_1.callingController_:SetSelectedState("normal")

				arg_273_1.keyicon_.color = Color.New(1, 1, 1)
				arg_273_1.icon_.color = Color.New(1, 1, 1)

				local var_276_1 = arg_273_1:GetWordFromCfg(421101066)
				local var_276_2 = arg_273_1:FormatText(var_276_1.content)

				arg_273_1.text_.text = var_276_2

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_4 = 7 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 7)

				if (7 <= 0 and var_276_0 or var_276_0 * (utf8.len(var_276_2) / 7)) > 0 and var_276_0 < var_276_4 then
					arg_273_1.talkMaxDuration = var_276_4

					if var_276_4 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_4 + 0
					end
				end

				arg_273_1.text_.text = var_276_2
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101066", "story_v_out_421101.awb") ~= 0 then
					local var_276_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101066", "story_v_out_421101.awb") / 1000

					if var_276_5 + 0 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_5 + 0
					end

					if var_276_1.prefab_name ~= "" and arg_273_1.actors_[var_276_1.prefab_name] ~= nil then
						local var_276_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_273_1.actors_[var_276_1.prefab_name].transform, "story_v_out_421101", "421101066", "story_v_out_421101.awb")

						arg_273_1:RecordAudio("421101066", var_276_6)
						arg_273_1:RecordAudio("421101066", var_276_6)
					else
						arg_273_1:AudioAction("play", "voice", "story_v_out_421101", "421101066", "story_v_out_421101.awb")
					end

					arg_273_1:RecordHistoryTalkVoice("story_v_out_421101", "421101066", "story_v_out_421101.awb")
				end

				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_7 = math.max(var_276_0, arg_273_1.talkMaxDuration)

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_7 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - 0) / var_276_7

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= 0 + var_276_7 and arg_273_1.time_ < 0 + var_276_7 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play421101067 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 421101067
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play421101068(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0.1 < arg_277_1.time_ and arg_277_1.time_ <= 0.1 + arg_280_0 then
				arg_277_1:AudioAction("play", "effect", "se_story_121_04", "se_story_121_04_gunreadygroup", "")
			end

			local var_280_1 = 0
			local var_280_2 = 1.7

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_1 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_3 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(421101067).content)

				arg_277_1.text_.text = var_280_3

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_5 = 68 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 68)

				if (68 <= 0 and var_280_2 or var_280_2 * (utf8.len(var_280_3) / 68)) > 0 and var_280_2 < var_280_5 then
					arg_277_1.talkMaxDuration = var_280_5

					if var_280_5 + var_280_1 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_5 + var_280_1
					end
				end

				arg_277_1.text_.text = var_280_3
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_6 = math.max(var_280_2, arg_277_1.talkMaxDuration)

			if var_280_1 <= arg_277_1.time_ and arg_277_1.time_ < var_280_1 + var_280_6 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_1) / var_280_6

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_1 + var_280_6 and arg_277_1.time_ < var_280_1 + var_280_6 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play421101068 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 421101068
		arg_281_1.duration_ = 8.5

		local var_281_0 = {
			zh = 7.166,
			ja = 8.5
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play421101069(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = 0.7

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, true)
				arg_281_1.iconController_:SetSelectedState("hero")

				arg_281_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_281_1.callingController_:SetSelectedState("normal")

				arg_281_1.keyicon_.color = Color.New(1, 1, 1)
				arg_281_1.icon_.color = Color.New(1, 1, 1)

				local var_284_1 = arg_281_1:GetWordFromCfg(421101068)
				local var_284_2 = arg_281_1:FormatText(var_284_1.content)

				arg_281_1.text_.text = var_284_2

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_4 = 28 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 28)

				if (28 <= 0 and var_284_0 or var_284_0 * (utf8.len(var_284_2) / 28)) > 0 and var_284_0 < var_284_4 then
					arg_281_1.talkMaxDuration = var_284_4

					if var_284_4 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_4 + 0
					end
				end

				arg_281_1.text_.text = var_284_2
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101068", "story_v_out_421101.awb") ~= 0 then
					local var_284_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101068", "story_v_out_421101.awb") / 1000

					if var_284_5 + 0 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_5 + 0
					end

					if var_284_1.prefab_name ~= "" and arg_281_1.actors_[var_284_1.prefab_name] ~= nil then
						local var_284_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_1.prefab_name].transform, "story_v_out_421101", "421101068", "story_v_out_421101.awb")

						arg_281_1:RecordAudio("421101068", var_284_6)
						arg_281_1:RecordAudio("421101068", var_284_6)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_421101", "421101068", "story_v_out_421101.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_421101", "421101068", "story_v_out_421101.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_7 = math.max(var_284_0, arg_281_1.talkMaxDuration)

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_7 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - 0) / var_284_7

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= 0 + var_284_7 and arg_281_1.time_ < 0 + var_284_7 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play421101069 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 421101069
		arg_285_1.duration_ = 1.2

		local var_285_0 = {
			zh = 1.166,
			ja = 1.2
		}
		local var_285_1 = manager.audio:GetLocalizationFlag()

		if var_285_0[var_285_1] ~= nil then
			arg_285_1.duration_ = var_285_0[var_285_1]
		end

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play421101070(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = 0.075

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, true)
				arg_285_1.iconController_:SetSelectedState("hero")

				arg_285_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1047_split_3")

				arg_285_1.callingController_:SetSelectedState("normal")

				arg_285_1.keyicon_.color = Color.New(1, 1, 1)
				arg_285_1.icon_.color = Color.New(1, 1, 1)

				local var_288_1 = arg_285_1:GetWordFromCfg(421101069)
				local var_288_2 = arg_285_1:FormatText(var_288_1.content)

				arg_285_1.text_.text = var_288_2

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_4 = 3 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 3)

				if (3 <= 0 and var_288_0 or var_288_0 * (utf8.len(var_288_2) / 3)) > 0 and var_288_0 < var_288_4 then
					arg_285_1.talkMaxDuration = var_288_4

					if var_288_4 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_4 + 0
					end
				end

				arg_285_1.text_.text = var_288_2
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101069", "story_v_out_421101.awb") ~= 0 then
					local var_288_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101069", "story_v_out_421101.awb") / 1000

					if var_288_5 + 0 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_5 + 0
					end

					if var_288_1.prefab_name ~= "" and arg_285_1.actors_[var_288_1.prefab_name] ~= nil then
						local var_288_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_285_1.actors_[var_288_1.prefab_name].transform, "story_v_out_421101", "421101069", "story_v_out_421101.awb")

						arg_285_1:RecordAudio("421101069", var_288_6)
						arg_285_1:RecordAudio("421101069", var_288_6)
					else
						arg_285_1:AudioAction("play", "voice", "story_v_out_421101", "421101069", "story_v_out_421101.awb")
					end

					arg_285_1:RecordHistoryTalkVoice("story_v_out_421101", "421101069", "story_v_out_421101.awb")
				end

				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_7 = math.max(var_288_0, arg_285_1.talkMaxDuration)

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_7 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - 0) / var_288_7

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= 0 + var_288_7 and arg_285_1.time_ < 0 + var_288_7 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play421101070 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 421101070
		arg_289_1.duration_ = 5.43

		local var_289_0 = {
			zh = 5.433,
			ja = 5.133
		}
		local var_289_1 = manager.audio:GetLocalizationFlag()

		if var_289_0[var_289_1] ~= nil then
			arg_289_1.duration_ = var_289_0[var_289_1]
		end

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play421101071(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = 0.425

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_1 = arg_289_1:GetWordFromCfg(421101070)
				local var_292_2 = arg_289_1:FormatText(var_292_1.content)

				arg_289_1.text_.text = var_292_2

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_4 = 17 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 17)

				if (17 <= 0 and var_292_0 or var_292_0 * (utf8.len(var_292_2) / 17)) > 0 and var_292_0 < var_292_4 then
					arg_289_1.talkMaxDuration = var_292_4

					if var_292_4 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_4 + 0
					end
				end

				arg_289_1.text_.text = var_292_2
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101070", "story_v_out_421101.awb") ~= 0 then
					local var_292_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101070", "story_v_out_421101.awb") / 1000

					if var_292_5 + 0 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_5 + 0
					end

					if var_292_1.prefab_name ~= "" and arg_289_1.actors_[var_292_1.prefab_name] ~= nil then
						local var_292_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_1.prefab_name].transform, "story_v_out_421101", "421101070", "story_v_out_421101.awb")

						arg_289_1:RecordAudio("421101070", var_292_6)
						arg_289_1:RecordAudio("421101070", var_292_6)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_421101", "421101070", "story_v_out_421101.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_421101", "421101070", "story_v_out_421101.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_7 = math.max(var_292_0, arg_289_1.talkMaxDuration)

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_7 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - 0) / var_292_7

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= 0 + var_292_7 and arg_289_1.time_ < 0 + var_292_7 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play421101071 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 421101071
		arg_293_1.duration_ = 4.17

		local var_293_0 = {
			zh = 2.466,
			ja = 4.166
		}
		local var_293_1 = manager.audio:GetLocalizationFlag()

		if var_293_0[var_293_1] ~= nil then
			arg_293_1.duration_ = var_293_0[var_293_1]
		end

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play421101072(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			local var_296_0 = 0.225

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, true)
				arg_293_1.iconController_:SetSelectedState("hero")

				arg_293_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_293_1.callingController_:SetSelectedState("normal")

				arg_293_1.keyicon_.color = Color.New(1, 1, 1)
				arg_293_1.icon_.color = Color.New(1, 1, 1)

				local var_296_1 = arg_293_1:GetWordFromCfg(421101071)
				local var_296_2 = arg_293_1:FormatText(var_296_1.content)

				arg_293_1.text_.text = var_296_2

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_4 = 9 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 9)

				if (9 <= 0 and var_296_0 or var_296_0 * (utf8.len(var_296_2) / 9)) > 0 and var_296_0 < var_296_4 then
					arg_293_1.talkMaxDuration = var_296_4

					if var_296_4 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_4 + 0
					end
				end

				arg_293_1.text_.text = var_296_2
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101071", "story_v_out_421101.awb") ~= 0 then
					local var_296_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101071", "story_v_out_421101.awb") / 1000

					if var_296_5 + 0 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_5 + 0
					end

					if var_296_1.prefab_name ~= "" and arg_293_1.actors_[var_296_1.prefab_name] ~= nil then
						local var_296_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_293_1.actors_[var_296_1.prefab_name].transform, "story_v_out_421101", "421101071", "story_v_out_421101.awb")

						arg_293_1:RecordAudio("421101071", var_296_6)
						arg_293_1:RecordAudio("421101071", var_296_6)
					else
						arg_293_1:AudioAction("play", "voice", "story_v_out_421101", "421101071", "story_v_out_421101.awb")
					end

					arg_293_1:RecordHistoryTalkVoice("story_v_out_421101", "421101071", "story_v_out_421101.awb")
				end

				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_7 = math.max(var_296_0, arg_293_1.talkMaxDuration)

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_7 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - 0) / var_296_7

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= 0 + var_296_7 and arg_293_1.time_ < 0 + var_296_7 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play421101072 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 421101072
		arg_297_1.duration_ = 5

		local var_297_0 = {
			zh = 4.466,
			ja = 5
		}
		local var_297_1 = manager.audio:GetLocalizationFlag()

		if var_297_0[var_297_1] ~= nil then
			arg_297_1.duration_ = var_297_0[var_297_1]
		end

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play421101073(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			local var_300_9000

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= 2 + arg_300_0 then
				arg_297_1.allBtn_.enabled = false
			end

			if arg_297_1.time_ >= 2 + 0.0999999999999996 and arg_297_1.time_ < 2 + 0.0999999999999996 + arg_300_0 then
				arg_297_1.allBtn_.enabled = true
			end

			local var_300_0 = "SS2103a"

			if arg_297_1.bgs_.SS2103a == nil then
				local var_300_1 = Object.Instantiate(arg_297_1.paintGo_)

				var_300_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_300_0)
				var_300_1.name = var_300_0
				var_300_1.transform.parent = arg_297_1.stage_.transform
				var_300_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_297_1.bgs_[var_300_0] = var_300_1
			end

			local var_300_2 = arg_297_1.bgs_.SS2103a.transform

			if 1 < arg_297_1.time_ and arg_297_1.time_ <= 1 + arg_300_0 then
				arg_297_1.var_.moveOldPosSS2103a = var_300_2.localPosition
			end

			local var_300_3 = 0.001

			if 1 <= arg_297_1.time_ and arg_297_1.time_ < 1 + var_300_3 then
				var_300_2.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPosSS2103a, Vector3.New(0, 0.3, 3.5), (arg_297_1.time_ - 1) / var_300_3)
			end

			if arg_297_1.time_ >= 1 + var_300_3 and arg_297_1.time_ < 1 + var_300_3 + arg_300_0 then
				var_300_2.localPosition = Vector3.New(0, 0.3, 3.5)
			end

			local var_300_4 = arg_297_1.bgs_.SS2103a.transform

			if 1.06666666666667 < arg_297_1.time_ and arg_297_1.time_ <= 1.06666666666667 + arg_300_0 then
				arg_297_1.var_.moveOldPosSS2103a = var_300_4.localPosition
			end

			local var_300_5 = 0.933333333333333

			if 1.06666666666667 <= arg_297_1.time_ and arg_297_1.time_ < 1.06666666666667 + var_300_5 then
				var_300_4.localPosition = Vector3.Lerp(arg_297_1.var_.moveOldPosSS2103a, Vector3.New(0, 0.2, 3.5), (arg_297_1.time_ - 1.06666666666667) / var_300_5)
			end

			if arg_297_1.time_ >= 1.06666666666667 + var_300_5 and arg_297_1.time_ < 1.06666666666667 + var_300_5 + arg_300_0 then
				var_300_4.localPosition = Vector3.New(0, 0.2, 3.5)
			end

			local var_300_6 = 0

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_6 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_7 = 1

			if var_300_6 <= arg_297_1.time_ and arg_297_1.time_ < var_300_6 + var_300_7 then
				local var_300_8 = Color.New(0, 0, 0)

				var_300_8.a = Mathf.Lerp(0, 1, (arg_297_1.time_ - var_300_6) / var_300_7)
				arg_297_1.mask_.color = var_300_8
			end

			if arg_297_1.time_ >= var_300_6 + var_300_7 and arg_297_1.time_ < var_300_6 + var_300_7 + arg_300_0 then
				local var_300_9 = Color.New(0, 0, 0)

				var_300_9.a = 1
				arg_297_1.mask_.color = var_300_9
			end

			local var_300_10 = 1

			if 1 < arg_297_1.time_ and arg_297_1.time_ <= var_300_10 + arg_300_0 then
				arg_297_1.mask_.enabled = true
				arg_297_1.mask_.raycastTarget = true

				arg_297_1:SetGaussion(false)
			end

			local var_300_11 = 0.666666666666666

			if var_300_10 <= arg_297_1.time_ and arg_297_1.time_ < var_300_10 + var_300_11 then
				local var_300_12 = Color.New(0, 0, 0)

				var_300_12.a = Mathf.Lerp(1, 0, (arg_297_1.time_ - var_300_10) / var_300_11)
				arg_297_1.mask_.color = var_300_12
			end

			if arg_297_1.time_ >= var_300_10 + var_300_11 and arg_297_1.time_ < var_300_10 + var_300_11 + arg_300_0 then
				local var_300_13 = Color.New(0, 0, 0)

				arg_297_1.mask_.enabled = false
				var_300_13.a = 0
				arg_297_1.mask_.color = var_300_13
			end

			if 1 < arg_297_1.time_ and arg_297_1.time_ <= 1 + arg_300_0 then
				local var_300_14 = arg_297_1.var_.effect1072

				if not arg_297_1.var_.effect1072 then
					var_300_14 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"), manager.ui.mainCamera.transform)
					var_300_14.name = "1072"
					arg_297_1.var_.effect1072 = var_300_14
				else
					var_300_14.transform:SetParent(var_300_9000)
				end

				var_300_14.transform.localPosition = Vector3.New(0, 0, 0)
				var_300_14.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 2.06666666666667 < arg_297_1.time_ and arg_297_1.time_ <= 2.06666666666667 + arg_300_0 then
				if arg_297_1.var_.effect1072 then
					Object.Destroy(arg_297_1.var_.effect1072)

					arg_297_1.var_.effect1072 = nil
				end
			end

			if 0.983333333333333 < arg_297_1.time_ and arg_297_1.time_ <= 0.983333333333333 + arg_300_0 then
				if arg_297_1.var_.effect105788 then
					Object.Destroy(arg_297_1.var_.effect105788)

					arg_297_1.var_.effect105788 = nil
				end
			end

			if arg_297_1.frameCnt_ <= 1 then
				arg_297_1.dialog_:SetActive(false)
			end

			local var_300_18 = 2
			local var_300_19 = 0.15

			if 2 < arg_297_1.time_ and arg_297_1.time_ <= var_300_18 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0

				arg_297_1.dialog_:SetActive(true)

				arg_297_1.dialogCg_.alpha = 0

				local var_300_20 = LeanTween.value(arg_297_1.dialog_, 0, 1, 0.3)

				var_300_20:setOnUpdate(LuaHelper.FloatAction(function(arg_301_0)
					arg_297_1.dialogCg_.alpha = arg_301_0
				end))
				var_300_20:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_297_1.dialog_)
					var_300_20:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_297_1.duration_ = arg_297_1.duration_ + 0.3

				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_21 = arg_297_1:GetWordFromCfg(421101072)
				local var_300_22 = arg_297_1:FormatText(var_300_21.content)

				arg_297_1.text_.text = var_300_22

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_24 = 6 <= 0 and var_300_19 or var_300_19 * (utf8.len(var_300_22) / 6)

				if (6 <= 0 and var_300_19 or var_300_19 * (utf8.len(var_300_22) / 6)) > 0 and var_300_19 < var_300_24 then
					arg_297_1.talkMaxDuration = var_300_24
					var_300_18 = var_300_18 + 0.3

					if var_300_24 + var_300_18 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_24 + var_300_18
					end
				end

				arg_297_1.text_.text = var_300_22
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101072", "story_v_out_421101.awb") ~= 0 then
					local var_300_25 = manager.audio:GetVoiceLength("story_v_out_421101", "421101072", "story_v_out_421101.awb") / 1000

					if var_300_25 + var_300_18 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_25 + var_300_18
					end

					if var_300_21.prefab_name ~= "" and arg_297_1.actors_[var_300_21.prefab_name] ~= nil then
						local var_300_26 = LuaForUtil.PlayVoiceWithCriLipsync(arg_297_1.actors_[var_300_21.prefab_name].transform, "story_v_out_421101", "421101072", "story_v_out_421101.awb")

						arg_297_1:RecordAudio("421101072", var_300_26)
						arg_297_1:RecordAudio("421101072", var_300_26)
					else
						arg_297_1:AudioAction("play", "voice", "story_v_out_421101", "421101072", "story_v_out_421101.awb")
					end

					arg_297_1:RecordHistoryTalkVoice("story_v_out_421101", "421101072", "story_v_out_421101.awb")
				end

				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_27 = var_300_18 + 0.3
			local var_300_28 = math.max(var_300_19, arg_297_1.talkMaxDuration)

			if var_300_18 + 0.3 <= arg_297_1.time_ and arg_297_1.time_ < var_300_27 + var_300_28 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_27) / var_300_28

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_27 + var_300_28 and arg_297_1.time_ < var_300_27 + var_300_28 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "SS2103a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			},
			{
				assetPath = "",
				actorName = "SS2103a",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.933333333333333,
				className = "StoryMoveNode",
				startTime = 1.06666666666667,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background
			}
		}

		arg_297_1:InitPlayNodeList()
	end,
	Play421101073 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 421101073
		arg_303_1.duration_ = 5

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play421101074(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			if 0.8 < arg_303_1.time_ and arg_303_1.time_ <= 0.8 + arg_306_0 then
				arg_303_1:AudioAction("play", "effect", "se_story_143", "se_story_143_organic01", "")
			end

			local var_306_1 = 0
			local var_306_2 = 1.525

			if 0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_1 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, false)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_303_1.iconTrs_.gameObject, false)
				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:FormatText(arg_303_1:GetWordFromCfg(421101073).content)

				arg_303_1.text_.text = var_306_3

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 61 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 61)

				if (61 <= 0 and var_306_2 or var_306_2 * (utf8.len(var_306_3) / 61)) > 0 and var_306_2 < var_306_5 then
					arg_303_1.talkMaxDuration = var_306_5

					if var_306_5 + var_306_1 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_5 + var_306_1
					end
				end

				arg_303_1.text_.text = var_306_3
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)
				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_6 = math.max(var_306_2, arg_303_1.talkMaxDuration)

			if var_306_1 <= arg_303_1.time_ and arg_303_1.time_ < var_306_1 + var_306_6 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_1) / var_306_6

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_1 + var_306_6 and arg_303_1.time_ < var_306_1 + var_306_6 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end

		arg_303_1.nodeConfigList_ = {}

		arg_303_1:InitPlayNodeList()
	end,
	Play421101074 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 421101074
		arg_307_1.duration_ = 4.57

		local var_307_0 = {
			zh = 4.266,
			ja = 4.566
		}
		local var_307_1 = manager.audio:GetLocalizationFlag()

		if var_307_0[var_307_1] ~= nil then
			arg_307_1.duration_ = var_307_0[var_307_1]
		end

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play421101075(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			if 0.166666666666667 < arg_307_1.time_ and arg_307_1.time_ <= 0.166666666666667 + arg_310_0 then
				arg_307_1.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			local var_310_0 = 0.533333333333333

			if 0.166666666666667 <= arg_307_1.time_ and arg_307_1.time_ < 0.166666666666667 + var_310_0 then
				local var_310_1, var_310_2 = math.modf((arg_307_1.time_ - 0.166666666666667) / 0.066)

				manager.ui.mainCamera.transform.localPosition = Vector3.New(var_310_2 * 0.13, var_310_2 * 0.13, var_310_2 * 0.13) + arg_307_1.var_.shakeOldPos
			end

			if arg_307_1.time_ >= 0.166666666666667 + var_310_0 and arg_307_1.time_ < 0.166666666666667 + var_310_0 + arg_310_0 then
				manager.ui.mainCamera.transform.localPosition = arg_307_1.var_.shakeOldPos
			end

			local var_310_3 = 0
			local var_310_4 = 0.425

			if 0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_3 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, true)

				arg_307_1.leftNameTxt_.text = arg_307_1:FormatText(StoryNameCfg[1318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_307_1.leftNameTxt_.transform)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1.leftNameTxt_.text)
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_5 = arg_307_1:GetWordFromCfg(421101074)
				local var_310_6 = arg_307_1:FormatText(var_310_5.content)

				arg_307_1.text_.text = var_310_6

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_8 = 17 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_6) / 17)

				if (17 <= 0 and var_310_4 or var_310_4 * (utf8.len(var_310_6) / 17)) > 0 and var_310_4 < var_310_8 then
					arg_307_1.talkMaxDuration = var_310_8

					if var_310_8 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_8 + var_310_3
					end
				end

				arg_307_1.text_.text = var_310_6
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101074", "story_v_out_421101.awb") ~= 0 then
					local var_310_9 = manager.audio:GetVoiceLength("story_v_out_421101", "421101074", "story_v_out_421101.awb") / 1000

					if var_310_9 + var_310_3 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_9 + var_310_3
					end

					if var_310_5.prefab_name ~= "" and arg_307_1.actors_[var_310_5.prefab_name] ~= nil then
						local var_310_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_307_1.actors_[var_310_5.prefab_name].transform, "story_v_out_421101", "421101074", "story_v_out_421101.awb")

						arg_307_1:RecordAudio("421101074", var_310_10)
						arg_307_1:RecordAudio("421101074", var_310_10)
					else
						arg_307_1:AudioAction("play", "voice", "story_v_out_421101", "421101074", "story_v_out_421101.awb")
					end

					arg_307_1:RecordHistoryTalkVoice("story_v_out_421101", "421101074", "story_v_out_421101.awb")
				end

				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_11 = math.max(var_310_4, arg_307_1.talkMaxDuration)

			if var_310_3 <= arg_307_1.time_ and arg_307_1.time_ < var_310_3 + var_310_11 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_3) / var_310_11

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_3 + var_310_11 and arg_307_1.time_ < var_310_3 + var_310_11 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end

		arg_307_1.nodeConfigList_ = {}

		arg_307_1:InitPlayNodeList()
	end,
	Play421101075 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 421101075
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play421101076(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			if 0.4 < arg_311_1.time_ and arg_311_1.time_ <= 0.4 + arg_314_0 then
				arg_311_1:AudioAction("play", "effect", "se_story_143", "se_story_143_organic02", "")
			end

			local var_314_1 = 0
			local var_314_2 = 1.15

			if 0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_1 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_3 = arg_311_1:FormatText(arg_311_1:GetWordFromCfg(421101075).content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_5 = 46 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 46)

				if (46 <= 0 and var_314_2 or var_314_2 * (utf8.len(var_314_3) / 46)) > 0 and var_314_2 < var_314_5 then
					arg_311_1.talkMaxDuration = var_314_5

					if var_314_5 + var_314_1 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_5 + var_314_1
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_6 = math.max(var_314_2, arg_311_1.talkMaxDuration)

			if var_314_1 <= arg_311_1.time_ and arg_311_1.time_ < var_314_1 + var_314_6 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_1) / var_314_6

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_1 + var_314_6 and arg_311_1.time_ < var_314_1 + var_314_6 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end

		arg_311_1.nodeConfigList_ = {}

		arg_311_1:InitPlayNodeList()
	end,
	Play421101076 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 421101076
		arg_315_1.duration_ = 7.2

		local var_315_0 = {
			zh = 5.56633333333333,
			ja = 7.19933333333333
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play421101077(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_9000

			if 1.33333333333333 < arg_315_1.time_ and arg_315_1.time_ <= 1.33333333333333 + arg_318_0 then
				local var_318_0 = arg_315_1.bgs_.I23f

				arg_315_1.bgs_.I23f.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_318_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_318_1 = var_318_0:GetComponent("SpriteRenderer")

				if var_318_1 and var_318_1.sprite then
					local var_318_2 = 2 * (var_318_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_318_0.transform.localScale = Vector3.New(var_318_2 / var_318_1.sprite.bounds.size.y < var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x and var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x or var_318_2 / var_318_1.sprite.bounds.size.y, var_318_2 / var_318_1.sprite.bounds.size.y < var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x and var_318_2 * manager.ui.mainCameraCom_.aspect / var_318_1.sprite.bounds.size.x or var_318_2 / var_318_1.sprite.bounds.size.y, 0)
				end

				for iter_318_0, iter_318_1 in pairs(arg_315_1.bgs_) do
					if iter_318_0 ~= "I23f" then
						iter_318_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_318_3 = 3.33333333333333

			if 3.33333333333333 < arg_315_1.time_ and arg_315_1.time_ <= var_318_3 + arg_318_0 then
				arg_315_1.allBtn_.enabled = false
			end

			if arg_315_1.time_ >= var_318_3 + 0.133333333333334 and arg_315_1.time_ < var_318_3 + 0.133333333333334 + arg_318_0 then
				arg_315_1.allBtn_.enabled = true
			end

			local var_318_4 = 0

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_4 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_5 = 1.33333333333333

			if var_318_4 <= arg_315_1.time_ and arg_315_1.time_ < var_318_4 + var_318_5 then
				local var_318_6 = Color.New(0, 0, 0)

				var_318_6.a = Mathf.Lerp(0, 1, (arg_315_1.time_ - var_318_4) / var_318_5)
				arg_315_1.mask_.color = var_318_6
			end

			if arg_315_1.time_ >= var_318_4 + var_318_5 and arg_315_1.time_ < var_318_4 + var_318_5 + arg_318_0 then
				local var_318_7 = Color.New(0, 0, 0)

				var_318_7.a = 1
				arg_315_1.mask_.color = var_318_7
			end

			local var_318_8 = 1.33333333333333

			if 1.33333333333333 < arg_315_1.time_ and arg_315_1.time_ <= var_318_8 + arg_318_0 then
				arg_315_1.mask_.enabled = true
				arg_315_1.mask_.raycastTarget = true

				arg_315_1:SetGaussion(false)
			end

			local var_318_9 = 2

			if var_318_8 <= arg_315_1.time_ and arg_315_1.time_ < var_318_8 + var_318_9 then
				local var_318_10 = Color.New(0, 0, 0)

				var_318_10.a = Mathf.Lerp(1, 0, (arg_315_1.time_ - var_318_8) / var_318_9)
				arg_315_1.mask_.color = var_318_10
			end

			if arg_315_1.time_ >= var_318_8 + var_318_9 and arg_315_1.time_ < var_318_8 + var_318_9 + arg_318_0 then
				local var_318_11 = Color.New(0, 0, 0)

				arg_315_1.mask_.enabled = false
				var_318_11.a = 0
				arg_315_1.mask_.color = var_318_11
			end

			if 0 < arg_315_1.time_ and arg_315_1.time_ <= 0 + arg_318_0 then
				local var_318_12 = arg_315_1.var_.effect1072

				if not arg_315_1.var_.effect1072 then
					var_318_12 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_heiwu"), manager.ui.mainCamera.transform)
					var_318_12.name = "1072"
					arg_315_1.var_.effect1072 = var_318_12
				else
					var_318_12.transform:SetParent(var_318_9000)
				end

				var_318_12.transform.localPosition = Vector3.New(0, 0, 0)
				var_318_12.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			if 3.60833333333333 < arg_315_1.time_ and arg_315_1.time_ <= 3.60833333333333 + arg_318_0 then
				if arg_315_1.var_.effect1072 then
					Object.Destroy(arg_315_1.var_.effect1072)

					arg_315_1.var_.effect1072 = nil
				end
			end

			if arg_315_1.frameCnt_ <= 1 then
				arg_315_1.dialog_:SetActive(false)
			end

			local var_318_15 = 3.33333333333333
			local var_318_16 = 0.275

			if 3.33333333333333 < arg_315_1.time_ and arg_315_1.time_ <= var_318_15 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0

				arg_315_1.dialog_:SetActive(true)

				arg_315_1.dialogCg_.alpha = 0

				local var_318_17 = LeanTween.value(arg_315_1.dialog_, 0, 1, 0.3)

				var_318_17:setOnUpdate(LuaHelper.FloatAction(function(arg_319_0)
					arg_315_1.dialogCg_.alpha = arg_319_0
				end))
				var_318_17:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_315_1.dialog_)
					var_318_17:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_315_1.duration_ = arg_315_1.duration_ + 0.3

				SetActive(arg_315_1.leftNameGo_, true)

				arg_315_1.leftNameTxt_.text = arg_315_1:FormatText(StoryNameCfg[1323].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_tb_shadowcitizenma")

				arg_315_1.callingController_:SetSelectedState("normal")

				arg_315_1.keyicon_.color = Color.New(1, 1, 1)
				arg_315_1.icon_.color = Color.New(1, 1, 1)

				local var_318_18 = arg_315_1:GetWordFromCfg(421101076)
				local var_318_19 = arg_315_1:FormatText(var_318_18.content)

				arg_315_1.text_.text = var_318_19

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_21 = 11 <= 0 and var_318_16 or var_318_16 * (utf8.len(var_318_19) / 11)

				if (11 <= 0 and var_318_16 or var_318_16 * (utf8.len(var_318_19) / 11)) > 0 and var_318_16 < var_318_21 then
					arg_315_1.talkMaxDuration = var_318_21
					var_318_15 = var_318_15 + 0.3

					if var_318_21 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_21 + var_318_15
					end
				end

				arg_315_1.text_.text = var_318_19
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101076", "story_v_out_421101.awb") ~= 0 then
					local var_318_22 = manager.audio:GetVoiceLength("story_v_out_421101", "421101076", "story_v_out_421101.awb") / 1000

					if var_318_22 + var_318_15 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_22 + var_318_15
					end

					if var_318_18.prefab_name ~= "" and arg_315_1.actors_[var_318_18.prefab_name] ~= nil then
						local var_318_23 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_18.prefab_name].transform, "story_v_out_421101", "421101076", "story_v_out_421101.awb")

						arg_315_1:RecordAudio("421101076", var_318_23)
						arg_315_1:RecordAudio("421101076", var_318_23)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_421101", "421101076", "story_v_out_421101.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_421101", "421101076", "story_v_out_421101.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_24 = var_318_15 + 0.3
			local var_318_25 = math.max(var_318_16, arg_315_1.talkMaxDuration)

			if var_318_15 + 0.3 <= arg_315_1.time_ and arg_315_1.time_ < var_318_24 + var_318_25 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_24) / var_318_25

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_24 + var_318_25 and arg_315_1.time_ < var_318_24 + var_318_25 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end

		arg_315_1.nodeConfigList_ = {}

		arg_315_1:InitPlayNodeList()
	end,
	Play421101077 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 421101077
		arg_321_1.duration_ = 3

		local var_321_0 = {
			zh = 2.033,
			ja = 3
		}
		local var_321_1 = manager.audio:GetLocalizationFlag()

		if var_321_0[var_321_1] ~= nil then
			arg_321_1.duration_ = var_321_0[var_321_1]
		end

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play421101078(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			local var_324_0 = 0.225

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, true)
				arg_321_1.iconController_:SetSelectedState("hero")

				arg_321_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_321_1.callingController_:SetSelectedState("normal")

				arg_321_1.keyicon_.color = Color.New(1, 1, 1)
				arg_321_1.icon_.color = Color.New(1, 1, 1)

				local var_324_1 = arg_321_1:GetWordFromCfg(421101077)
				local var_324_2 = arg_321_1:FormatText(var_324_1.content)

				arg_321_1.text_.text = var_324_2

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_4 = 9 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 9)

				if (9 <= 0 and var_324_0 or var_324_0 * (utf8.len(var_324_2) / 9)) > 0 and var_324_0 < var_324_4 then
					arg_321_1.talkMaxDuration = var_324_4

					if var_324_4 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_4 + 0
					end
				end

				arg_321_1.text_.text = var_324_2
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101077", "story_v_out_421101.awb") ~= 0 then
					local var_324_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101077", "story_v_out_421101.awb") / 1000

					if var_324_5 + 0 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_5 + 0
					end

					if var_324_1.prefab_name ~= "" and arg_321_1.actors_[var_324_1.prefab_name] ~= nil then
						local var_324_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_321_1.actors_[var_324_1.prefab_name].transform, "story_v_out_421101", "421101077", "story_v_out_421101.awb")

						arg_321_1:RecordAudio("421101077", var_324_6)
						arg_321_1:RecordAudio("421101077", var_324_6)
					else
						arg_321_1:AudioAction("play", "voice", "story_v_out_421101", "421101077", "story_v_out_421101.awb")
					end

					arg_321_1:RecordHistoryTalkVoice("story_v_out_421101", "421101077", "story_v_out_421101.awb")
				end

				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_7 = math.max(var_324_0, arg_321_1.talkMaxDuration)

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_7 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - 0) / var_324_7

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= 0 + var_324_7 and arg_321_1.time_ < 0 + var_324_7 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play421101078 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 421101078
		arg_325_1.duration_ = 3.7

		local var_325_0 = {
			zh = 3.1,
			ja = 3.7
		}
		local var_325_1 = manager.audio:GetLocalizationFlag()

		if var_325_0[var_325_1] ~= nil then
			arg_325_1.duration_ = var_325_0[var_325_1]
		end

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play421101079(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			local var_328_0 = 0.35

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[1313].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, true)
				arg_325_1.iconController_:SetSelectedState("hero")

				arg_325_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadow2020")

				arg_325_1.callingController_:SetSelectedState("normal")

				arg_325_1.keyicon_.color = Color.New(1, 1, 1)
				arg_325_1.icon_.color = Color.New(1, 1, 1)

				local var_328_1 = arg_325_1:GetWordFromCfg(421101078)
				local var_328_2 = arg_325_1:FormatText(var_328_1.content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 14 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 14)

				if (14 <= 0 and var_328_0 or var_328_0 * (utf8.len(var_328_2) / 14)) > 0 and var_328_0 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + 0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101078", "story_v_out_421101.awb") ~= 0 then
					local var_328_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101078", "story_v_out_421101.awb") / 1000

					if var_328_5 + 0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_5 + 0
					end

					if var_328_1.prefab_name ~= "" and arg_325_1.actors_[var_328_1.prefab_name] ~= nil then
						local var_328_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_325_1.actors_[var_328_1.prefab_name].transform, "story_v_out_421101", "421101078", "story_v_out_421101.awb")

						arg_325_1:RecordAudio("421101078", var_328_6)
						arg_325_1:RecordAudio("421101078", var_328_6)
					else
						arg_325_1:AudioAction("play", "voice", "story_v_out_421101", "421101078", "story_v_out_421101.awb")
					end

					arg_325_1:RecordHistoryTalkVoice("story_v_out_421101", "421101078", "story_v_out_421101.awb")
				end

				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_7 = math.max(var_328_0, arg_325_1.talkMaxDuration)

			if 0 <= arg_325_1.time_ and arg_325_1.time_ < 0 + var_328_7 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - 0) / var_328_7

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= 0 + var_328_7 and arg_325_1.time_ < 0 + var_328_7 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play421101079 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 421101079
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play421101080(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0.1 < arg_329_1.time_ and arg_329_1.time_ <= 0.1 + arg_332_0 then
				arg_329_1:AudioAction("play", "effect", "se_story_1310", "se_story_1310_surround", "")
			end

			local var_332_1 = 0
			local var_332_2 = 1.525

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_1 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, false)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_3 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(421101079).content)

				arg_329_1.text_.text = var_332_3

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_5 = 61 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 61)

				if (61 <= 0 and var_332_2 or var_332_2 * (utf8.len(var_332_3) / 61)) > 0 and var_332_2 < var_332_5 then
					arg_329_1.talkMaxDuration = var_332_5

					if var_332_5 + var_332_1 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_5 + var_332_1
					end
				end

				arg_329_1.text_.text = var_332_3
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_6 = math.max(var_332_2, arg_329_1.talkMaxDuration)

			if var_332_1 <= arg_329_1.time_ and arg_329_1.time_ < var_332_1 + var_332_6 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_1) / var_332_6

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_1 + var_332_6 and arg_329_1.time_ < var_332_1 + var_332_6 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play421101080 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 421101080
		arg_333_1.duration_ = 1.47

		local var_333_0 = {
			zh = 1.466,
			ja = 1.133
		}
		local var_333_1 = manager.audio:GetLocalizationFlag()

		if var_333_0[var_333_1] ~= nil then
			arg_333_1.duration_ = var_333_0[var_333_1]
		end

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play421101081(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			local var_336_0 = 0.075

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, true)

				arg_333_1.leftNameTxt_.text = arg_333_1:FormatText(StoryNameCfg[1311].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_333_1.leftNameTxt_.transform)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1.leftNameTxt_.text)
				SetActive(arg_333_1.iconTrs_.gameObject, true)
				arg_333_1.iconController_:SetSelectedState("hero")

				arg_333_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_xh_citizenma")

				arg_333_1.callingController_:SetSelectedState("normal")

				arg_333_1.keyicon_.color = Color.New(1, 1, 1)
				arg_333_1.icon_.color = Color.New(1, 1, 1)

				local var_336_1 = arg_333_1:GetWordFromCfg(421101080)
				local var_336_2 = arg_333_1:FormatText(var_336_1.content)

				arg_333_1.text_.text = var_336_2

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_4 = 3 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 3)

				if (3 <= 0 and var_336_0 or var_336_0 * (utf8.len(var_336_2) / 3)) > 0 and var_336_0 < var_336_4 then
					arg_333_1.talkMaxDuration = var_336_4

					if var_336_4 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_4 + 0
					end
				end

				arg_333_1.text_.text = var_336_2
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101080", "story_v_out_421101.awb") ~= 0 then
					local var_336_5 = manager.audio:GetVoiceLength("story_v_out_421101", "421101080", "story_v_out_421101.awb") / 1000

					if var_336_5 + 0 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + 0
					end

					if var_336_1.prefab_name ~= "" and arg_333_1.actors_[var_336_1.prefab_name] ~= nil then
						local var_336_6 = LuaForUtil.PlayVoiceWithCriLipsync(arg_333_1.actors_[var_336_1.prefab_name].transform, "story_v_out_421101", "421101080", "story_v_out_421101.awb")

						arg_333_1:RecordAudio("421101080", var_336_6)
						arg_333_1:RecordAudio("421101080", var_336_6)
					else
						arg_333_1:AudioAction("play", "voice", "story_v_out_421101", "421101080", "story_v_out_421101.awb")
					end

					arg_333_1:RecordHistoryTalkVoice("story_v_out_421101", "421101080", "story_v_out_421101.awb")
				end

				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_7 = math.max(var_336_0, arg_333_1.talkMaxDuration)

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_7 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - 0) / var_336_7

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= 0 + var_336_7 and arg_333_1.time_ < 0 + var_336_7 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play421101081 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 421101081
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play421101082(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			local var_340_0 = 0.55

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, false)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_1 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(421101081).content)

				arg_337_1.text_.text = var_340_1

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_3 = 22 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 22)

				if (22 <= 0 and var_340_0 or var_340_0 * (utf8.len(var_340_1) / 22)) > 0 and var_340_0 < var_340_3 then
					arg_337_1.talkMaxDuration = var_340_3

					if var_340_3 + 0 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_3 + 0
					end
				end

				arg_337_1.text_.text = var_340_1
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_4 = math.max(var_340_0, arg_337_1.talkMaxDuration)

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_4 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - 0) / var_340_4

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= 0 + var_340_4 and arg_337_1.time_ < 0 + var_340_4 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play421101082 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 421101082
		arg_341_1.duration_ = 6.7

		local var_341_0 = {
			zh = 4.8,
			ja = 6.7
		}
		local var_341_1 = manager.audio:GetLocalizationFlag()

		if var_341_0[var_341_1] ~= nil then
			arg_341_1.duration_ = var_341_0[var_341_1]
		end

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play421101083(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1.var_.moveOldPos1047ui_story = arg_341_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_344_0 = 0.001

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 then
				arg_341_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_341_1.var_.moveOldPos1047ui_story, Vector3.New(0, -1.13, -6.2), (arg_341_1.time_ - 0) / var_344_0)
				arg_341_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).z)
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles = arg_341_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 then
				arg_341_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, -1.13, -6.2)
				arg_341_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_341_1.actors_["1047ui_story"].transform.position).z)
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_341_1.actors_["1047ui_story"].transform.localEulerAngles = arg_341_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_344_1 = arg_341_1.actors_["1047ui_story"]

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1047ui_story == nil then
				arg_341_1.var_.characterEffect1047ui_story = var_344_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_2 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_2 and not isNil(var_344_1) then
				if arg_341_1.var_.characterEffect1047ui_story and not isNil(var_344_1) then
					arg_341_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_341_1.time_ >= 0 + var_344_2 and arg_341_1.time_ < 0 + var_344_2 + arg_344_0 and not isNil(var_344_1) and arg_341_1.var_.characterEffect1047ui_story then
				arg_341_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action6_1")
			end

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 then
				arg_341_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_shengqiB", "EmotionTimelineAnimator")
			end

			local var_344_4 = 0
			local var_344_5 = 0.45

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_4 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, true)

				arg_341_1.leftNameTxt_.text = arg_341_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_341_1.leftNameTxt_.transform)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1.leftNameTxt_.text)
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_6 = arg_341_1:GetWordFromCfg(421101082)
				local var_344_7 = arg_341_1:FormatText(var_344_6.content)

				arg_341_1.text_.text = var_344_7

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_9 = 18 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 18)

				if (18 <= 0 and var_344_5 or var_344_5 * (utf8.len(var_344_7) / 18)) > 0 and var_344_5 < var_344_9 then
					arg_341_1.talkMaxDuration = var_344_9

					if var_344_9 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_9 + var_344_4
					end
				end

				arg_341_1.text_.text = var_344_7
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101082", "story_v_out_421101.awb") ~= 0 then
					local var_344_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101082", "story_v_out_421101.awb") / 1000

					if var_344_10 + var_344_4 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_10 + var_344_4
					end

					if var_344_6.prefab_name ~= "" and arg_341_1.actors_[var_344_6.prefab_name] ~= nil then
						local var_344_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_341_1.actors_[var_344_6.prefab_name].transform, "story_v_out_421101", "421101082", "story_v_out_421101.awb")

						arg_341_1:RecordAudio("421101082", var_344_11)
						arg_341_1:RecordAudio("421101082", var_344_11)
					else
						arg_341_1:AudioAction("play", "voice", "story_v_out_421101", "421101082", "story_v_out_421101.awb")
					end

					arg_341_1:RecordHistoryTalkVoice("story_v_out_421101", "421101082", "story_v_out_421101.awb")
				end

				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_12 = math.max(var_344_5, arg_341_1.talkMaxDuration)

			if var_344_4 <= arg_341_1.time_ and arg_341_1.time_ < var_344_4 + var_344_12 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_4) / var_344_12

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_4 + var_344_12 and arg_341_1.time_ < var_344_4 + var_344_12 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {
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

		arg_341_1:InitPlayNodeList()
	end,
	Play421101083 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 421101083
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play421101084(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1.var_.moveOldPos1047ui_story = arg_345_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_348_0 = 0.001

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_345_1.var_.moveOldPos1047ui_story, Vector3.New(0, 100, 0), (arg_345_1.time_ - 0) / var_348_0)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 then
				arg_345_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_345_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_345_1.actors_["1047ui_story"].transform.position).z)
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_345_1.actors_["1047ui_story"].transform.localEulerAngles = arg_345_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0.1 < arg_345_1.time_ and arg_345_1.time_ <= 0.1 + arg_348_0 then
				arg_345_1:AudioAction("play", "effect", "se_story_143", "se_story_143_monster", "")
			end

			local var_348_2 = 0
			local var_348_3 = 1.7

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, false)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(421101083).content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_6 = 68 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 68)

				if (68 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 68)) > 0 and var_348_3 < var_348_6 then
					arg_345_1.talkMaxDuration = var_348_6

					if var_348_6 + var_348_2 > arg_345_1.duration_ then
						arg_345_1.duration_ = var_348_6 + var_348_2
					end
				end

				arg_345_1.text_.text = var_348_4
				arg_345_1.typewritter.percent = 0

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(false)
				arg_345_1:RecordContent(arg_345_1.text_.text)
			end

			local var_348_7 = math.max(var_348_3, arg_345_1.talkMaxDuration)

			if var_348_2 <= arg_345_1.time_ and arg_345_1.time_ < var_348_2 + var_348_7 then
				arg_345_1.typewritter.percent = (arg_345_1.time_ - var_348_2) / var_348_7

				arg_345_1.typewritter:SetDirty()
			end

			if arg_345_1.time_ >= var_348_2 + var_348_7 and arg_345_1.time_ < var_348_2 + var_348_7 + arg_348_0 then
				arg_345_1.typewritter.percent = 1

				arg_345_1.typewritter:SetDirty()
				arg_345_1:ShowNextGo(true)
			end
		end

		arg_345_1.nodeConfigList_ = {
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

		arg_345_1:InitPlayNodeList()
	end,
	Play421101084 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 421101084
		arg_349_1.duration_ = 2.8

		local var_349_0 = {
			zh = 2.8,
			ja = 2.433
		}
		local var_349_1 = manager.audio:GetLocalizationFlag()

		if var_349_0[var_349_1] ~= nil then
			arg_349_1.duration_ = var_349_0[var_349_1]
		end

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play421101085(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1.var_.moveOldPos10145ui_story = arg_349_1.actors_["10145ui_story"].transform.localPosition
			end

			local var_352_0 = 0.001

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_0 then
				arg_349_1.actors_["10145ui_story"].transform.localPosition = Vector3.Lerp(arg_349_1.var_.moveOldPos10145ui_story, Vector3.New(-0.65, -1, -6.2), (arg_349_1.time_ - 0) / var_352_0)
				arg_349_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10145ui_story"].transform.position).z)
				arg_349_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10145ui_story"].transform.localEulerAngles = arg_349_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			if arg_349_1.time_ >= 0 + var_352_0 and arg_349_1.time_ < 0 + var_352_0 + arg_352_0 then
				arg_349_1.actors_["10145ui_story"].transform.localPosition = Vector3.New(-0.65, -1, -6.2)
				arg_349_1.actors_["10145ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_349_1.actors_["10145ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10145ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_349_1.actors_["10145ui_story"].transform.position).z)
				arg_349_1.actors_["10145ui_story"].transform.localEulerAngles.z = 0
				arg_349_1.actors_["10145ui_story"].transform.localEulerAngles.x = 0
				arg_349_1.actors_["10145ui_story"].transform.localEulerAngles = arg_349_1.actors_["10145ui_story"].transform.localEulerAngles
			end

			local var_352_1 = arg_349_1.actors_["10145ui_story"]

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect10145ui_story == nil then
				arg_349_1.var_.characterEffect10145ui_story = var_352_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_352_2 = 0.200000002980232

			if 0 <= arg_349_1.time_ and arg_349_1.time_ < 0 + var_352_2 and not isNil(var_352_1) then
				if arg_349_1.var_.characterEffect10145ui_story and not isNil(var_352_1) then
					arg_349_1.var_.characterEffect10145ui_story.fillFlat = false
				end
			end

			if arg_349_1.time_ >= 0 + var_352_2 and arg_349_1.time_ < 0 + var_352_2 + arg_352_0 and not isNil(var_352_1) and arg_349_1.var_.characterEffect10145ui_story then
				arg_349_1.var_.characterEffect10145ui_story.fillFlat = false
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/story10145/story10145action/10145action9_1")
			end

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10145ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_352_4 = 0
			local var_352_5 = 0.275

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_4 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[1308].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_6 = arg_349_1:GetWordFromCfg(421101084)
				local var_352_7 = arg_349_1:FormatText(var_352_6.content)

				arg_349_1.text_.text = var_352_7

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_9 = 11 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 11)

				if (11 <= 0 and var_352_5 or var_352_5 * (utf8.len(var_352_7) / 11)) > 0 and var_352_5 < var_352_9 then
					arg_349_1.talkMaxDuration = var_352_9

					if var_352_9 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_9 + var_352_4
					end
				end

				arg_349_1.text_.text = var_352_7
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101084", "story_v_out_421101.awb") ~= 0 then
					local var_352_10 = manager.audio:GetVoiceLength("story_v_out_421101", "421101084", "story_v_out_421101.awb") / 1000

					if var_352_10 + var_352_4 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_10 + var_352_4
					end

					if var_352_6.prefab_name ~= "" and arg_349_1.actors_[var_352_6.prefab_name] ~= nil then
						local var_352_11 = LuaForUtil.PlayVoiceWithCriLipsync(arg_349_1.actors_[var_352_6.prefab_name].transform, "story_v_out_421101", "421101084", "story_v_out_421101.awb")

						arg_349_1:RecordAudio("421101084", var_352_11)
						arg_349_1:RecordAudio("421101084", var_352_11)
					else
						arg_349_1:AudioAction("play", "voice", "story_v_out_421101", "421101084", "story_v_out_421101.awb")
					end

					arg_349_1:RecordHistoryTalkVoice("story_v_out_421101", "421101084", "story_v_out_421101.awb")
				end

				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_12 = math.max(var_352_5, arg_349_1.talkMaxDuration)

			if var_352_4 <= arg_349_1.time_ and arg_349_1.time_ < var_352_4 + var_352_12 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_4) / var_352_12

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_4 + var_352_12 and arg_349_1.time_ < var_352_4 + var_352_12 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10145ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_349_1:InitPlayNodeList()
	end,
	Play421101085 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 421101085
		arg_353_1.duration_ = 5.9

		local var_353_0 = {
			zh = 2.633,
			ja = 5.9
		}
		local var_353_1 = manager.audio:GetLocalizationFlag()

		if var_353_0[var_353_1] ~= nil then
			arg_353_1.duration_ = var_353_0[var_353_1]
		end

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play421101086(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1.var_.moveOldPos1047ui_story = arg_353_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_356_0 = 0.001

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_0 then
				arg_353_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_353_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_353_1.time_ - 0) / var_356_0)
				arg_353_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).z)
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles = arg_353_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_353_1.time_ >= 0 + var_356_0 and arg_353_1.time_ < 0 + var_356_0 + arg_356_0 then
				arg_353_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_353_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_353_1.actors_["1047ui_story"].transform.position).z)
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_353_1.actors_["1047ui_story"].transform.localEulerAngles = arg_353_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			local var_356_1 = arg_353_1.actors_["1047ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1047ui_story == nil then
				arg_353_1.var_.characterEffect1047ui_story = var_356_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_2 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_2 and not isNil(var_356_1) then
				if arg_353_1.var_.characterEffect1047ui_story and not isNil(var_356_1) then
					arg_353_1.var_.characterEffect1047ui_story.fillFlat = false
				end
			end

			if arg_353_1.time_ >= 0 + var_356_2 and arg_353_1.time_ < 0 + var_356_2 + arg_356_0 and not isNil(var_356_1) and arg_353_1.var_.characterEffect1047ui_story then
				arg_353_1.var_.characterEffect1047ui_story.fillFlat = false
			end

			local var_356_4 = arg_353_1.actors_["10145ui_story"]

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect10145ui_story == nil then
				arg_353_1.var_.characterEffect10145ui_story = var_356_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_356_5 = 0.200000002980232

			if 0 <= arg_353_1.time_ and arg_353_1.time_ < 0 + var_356_5 and not isNil(var_356_4) then
				if arg_353_1.var_.characterEffect10145ui_story and not isNil(var_356_4) then
					arg_353_1.var_.characterEffect10145ui_story.fillFlat = true
					arg_353_1.var_.characterEffect10145ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_353_1.time_ - 0) / var_356_5)
				end
			end

			if arg_353_1.time_ >= 0 + var_356_5 and arg_353_1.time_ < 0 + var_356_5 + arg_356_0 and not isNil(var_356_4) and arg_353_1.var_.characterEffect10145ui_story then
				arg_353_1.var_.characterEffect10145ui_story.fillFlat = true
				arg_353_1.var_.characterEffect10145ui_story.fillRatio = 0.5
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_renzhen", "EmotionTimelineAnimator")
			end

			local var_356_6 = 0
			local var_356_7 = 0.4

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_6 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_8 = arg_353_1:GetWordFromCfg(421101085)
				local var_356_9 = arg_353_1:FormatText(var_356_8.content)

				arg_353_1.text_.text = var_356_9

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_11 = 16 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_9) / 16)

				if (16 <= 0 and var_356_7 or var_356_7 * (utf8.len(var_356_9) / 16)) > 0 and var_356_7 < var_356_11 then
					arg_353_1.talkMaxDuration = var_356_11

					if var_356_11 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_11 + var_356_6
					end
				end

				arg_353_1.text_.text = var_356_9
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101085", "story_v_out_421101.awb") ~= 0 then
					local var_356_12 = manager.audio:GetVoiceLength("story_v_out_421101", "421101085", "story_v_out_421101.awb") / 1000

					if var_356_12 + var_356_6 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_12 + var_356_6
					end

					if var_356_8.prefab_name ~= "" and arg_353_1.actors_[var_356_8.prefab_name] ~= nil then
						local var_356_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_353_1.actors_[var_356_8.prefab_name].transform, "story_v_out_421101", "421101085", "story_v_out_421101.awb")

						arg_353_1:RecordAudio("421101085", var_356_13)
						arg_353_1:RecordAudio("421101085", var_356_13)
					else
						arg_353_1:AudioAction("play", "voice", "story_v_out_421101", "421101085", "story_v_out_421101.awb")
					end

					arg_353_1:RecordHistoryTalkVoice("story_v_out_421101", "421101085", "story_v_out_421101.awb")
				end

				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_14 = math.max(var_356_7, arg_353_1.talkMaxDuration)

			if var_356_6 <= arg_353_1.time_ and arg_353_1.time_ < var_356_6 + var_356_14 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_6) / var_356_14

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_6 + var_356_14 and arg_353_1.time_ < var_356_6 + var_356_14 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {
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

		arg_353_1:InitPlayNodeList()
	end,
	Play421101086 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 421101086
		arg_357_1.duration_ = 6.47

		local var_357_0 = {
			zh = 4.233,
			ja = 6.466
		}
		local var_357_1 = manager.audio:GetLocalizationFlag()

		if var_357_0[var_357_1] ~= nil then
			arg_357_1.duration_ = var_357_0[var_357_1]
		end

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
			arg_357_1.auto_ = false
		end

		function arg_357_1.playNext_(arg_359_0)
			arg_357_1.onStoryFinished_()
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1.var_.moveOldPos1047ui_story = arg_357_1.actors_["1047ui_story"].transform.localPosition
			end

			local var_360_0 = 0.001

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 then
				arg_357_1.actors_["1047ui_story"].transform.localPosition = Vector3.Lerp(arg_357_1.var_.moveOldPos1047ui_story, Vector3.New(0.74, -1.13, -6.2), (arg_357_1.time_ - 0) / var_360_0)
				arg_357_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).z)
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles = arg_357_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 then
				arg_357_1.actors_["1047ui_story"].transform.localPosition = Vector3.New(0.74, -1.13, -6.2)
				arg_357_1.actors_["1047ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_357_1.actors_["1047ui_story"].transform.position).z)
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.z = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles.x = 0
				arg_357_1.actors_["1047ui_story"].transform.localEulerAngles = arg_357_1.actors_["1047ui_story"].transform.localEulerAngles
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/story1047/story1047action/1047action1_1")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1047ui_story", "StoryTimeline/CharAction/public_expression/expr_kuaileA_weixiao", "EmotionTimelineAnimator")
			end

			local var_360_1 = 0
			local var_360_2 = 0.55

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_1 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[1296].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_3 = arg_357_1:GetWordFromCfg(421101086)
				local var_360_4 = arg_357_1:FormatText(var_360_3.content)

				arg_357_1.text_.text = var_360_4

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_6 = 22 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_4) / 22)

				if (22 <= 0 and var_360_2 or var_360_2 * (utf8.len(var_360_4) / 22)) > 0 and var_360_2 < var_360_6 then
					arg_357_1.talkMaxDuration = var_360_6

					if var_360_6 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_6 + var_360_1
					end
				end

				arg_357_1.text_.text = var_360_4
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_421101", "421101086", "story_v_out_421101.awb") ~= 0 then
					local var_360_7 = manager.audio:GetVoiceLength("story_v_out_421101", "421101086", "story_v_out_421101.awb") / 1000

					if var_360_7 + var_360_1 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_7 + var_360_1
					end

					if var_360_3.prefab_name ~= "" and arg_357_1.actors_[var_360_3.prefab_name] ~= nil then
						local var_360_8 = LuaForUtil.PlayVoiceWithCriLipsync(arg_357_1.actors_[var_360_3.prefab_name].transform, "story_v_out_421101", "421101086", "story_v_out_421101.awb")

						arg_357_1:RecordAudio("421101086", var_360_8)
						arg_357_1:RecordAudio("421101086", var_360_8)
					else
						arg_357_1:AudioAction("play", "voice", "story_v_out_421101", "421101086", "story_v_out_421101.awb")
					end

					arg_357_1:RecordHistoryTalkVoice("story_v_out_421101", "421101086", "story_v_out_421101.awb")
				end

				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_9 = math.max(var_360_2, arg_357_1.talkMaxDuration)

			if var_360_1 <= arg_357_1.time_ and arg_357_1.time_ < var_360_1 + var_360_9 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_1) / var_360_9

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_1 + var_360_9 and arg_357_1.time_ < var_360_1 + var_360_9 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {
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

		arg_357_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/I23f",
		"TextureConfig/Background/B13a",
		"TextureConfig/Background/SS2103"
	},
	voices = {
		"story_v_out_421101.awb"
	}
}
