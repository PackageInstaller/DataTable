return {
	Play935011001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 935011001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play935011002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			if arg_1_1.bgs_.ST2003a == nil then
				local var_4_0 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2003a")
				var_4_0.name = "ST2003a"
				var_4_0.transform.parent = arg_1_1.stage_.transform
				var_4_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_.ST2003a = var_4_0
			end

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= 0 + arg_4_0 then
				local var_4_1 = arg_1_1.bgs_.ST2003a

				arg_1_1.bgs_.ST2003a.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_4_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_2 = var_4_1:GetComponent("SpriteRenderer")

				if var_4_2 and var_4_2.sprite then
					local var_4_3 = 2 * (var_4_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_4_1.transform.localScale = Vector3.New(var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, var_4_3 / var_4_2.sprite.bounds.size.y < var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x and var_4_3 * manager.ui.mainCameraCom_.aspect / var_4_2.sprite.bounds.size.x or var_4_3 / var_4_2.sprite.bounds.size.y, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST2003a" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_4 = 0

			if 0 < arg_1_1.time_ and arg_1_1.time_ <= var_4_4 + arg_4_0 then
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
				arg_1_1:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")

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

			if 0.3 < arg_1_1.time_ and arg_1_1.time_ <= 0.3 + arg_4_0 then
				arg_1_1:AudioAction("play", "music", "bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily.awb")

				local var_4_14 = manager.audio:GetAudioName("bgm_activity_4_8_story_xuheng_daily", "bgm_activity_4_8_story_xuheng_daily")

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
			local var_4_16 = 0.975

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

				local var_4_18 = arg_1_1:FormatText(arg_1_1:GetWordFromCfg(935011001).content)

				arg_1_1.text_.text = var_4_18

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_20 = 39 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 39)

				if (39 <= 0 and var_4_16 or var_4_16 * (utf8.len(var_4_18) / 39)) > 0 and var_4_16 < var_4_20 then
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
	Play935011002 = function(arg_9_0, arg_9_1)
		arg_9_1.time_ = 0
		arg_9_1.frameCnt_ = 0
		arg_9_1.state_ = "playing"
		arg_9_1.curTalkId_ = 935011002
		arg_9_1.duration_ = 5

		SetActive(arg_9_1.tipsGo_, false)

		function arg_9_1.onSingleLineFinish_()
			arg_9_1.onSingleLineUpdate_ = nil
			arg_9_1.onSingleLineFinish_ = nil
			arg_9_1.state_ = "waiting"
		end

		function arg_9_1.playNext_(arg_11_0)
			if arg_11_0 == 1 then
				arg_9_0:Play935011003(arg_9_1)
			end
		end

		function arg_9_1.onSingleLineUpdate_(arg_12_0)
			local var_12_0 = 0.95

			if 0 < arg_9_1.time_ and arg_9_1.time_ <= 0 + arg_12_0 then
				arg_9_1.talkMaxDuration = 0
				arg_9_1.dialogCg_.alpha = 1

				arg_9_1.dialog_:SetActive(true)
				SetActive(arg_9_1.leftNameGo_, false)

				arg_9_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_9_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_9_1:RecordName(arg_9_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_9_1.iconTrs_.gameObject, false)
				arg_9_1.callingController_:SetSelectedState("normal")

				local var_12_1 = arg_9_1:FormatText(arg_9_1:GetWordFromCfg(935011002).content)

				arg_9_1.text_.text = var_12_1

				LuaForUtil.ClearLinePrefixSymbol(arg_9_1.text_)

				local var_12_3 = 38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)

				if (38 <= 0 and var_12_0 or var_12_0 * (utf8.len(var_12_1) / 38)) > 0 and var_12_0 < var_12_3 then
					arg_9_1.talkMaxDuration = var_12_3

					if var_12_3 + 0 > arg_9_1.duration_ then
						arg_9_1.duration_ = var_12_3 + 0
					end
				end

				arg_9_1.text_.text = var_12_1
				arg_9_1.typewritter.percent = 0

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(false)
				arg_9_1:RecordContent(arg_9_1.text_.text)
			end

			local var_12_4 = math.max(var_12_0, arg_9_1.talkMaxDuration)

			if 0 <= arg_9_1.time_ and arg_9_1.time_ < 0 + var_12_4 then
				arg_9_1.typewritter.percent = (arg_9_1.time_ - 0) / var_12_4

				arg_9_1.typewritter:SetDirty()
			end

			if arg_9_1.time_ >= 0 + var_12_4 and arg_9_1.time_ < 0 + var_12_4 + arg_12_0 then
				arg_9_1.typewritter.percent = 1

				arg_9_1.typewritter:SetDirty()
				arg_9_1:ShowNextGo(true)
			end
		end

		arg_9_1.nodeConfigList_ = {}

		arg_9_1:InitPlayNodeList()
	end,
	Play935011003 = function(arg_13_0, arg_13_1)
		arg_13_1.time_ = 0
		arg_13_1.frameCnt_ = 0
		arg_13_1.state_ = "playing"
		arg_13_1.curTalkId_ = 935011003
		arg_13_1.duration_ = 5

		SetActive(arg_13_1.tipsGo_, false)

		function arg_13_1.onSingleLineFinish_()
			arg_13_1.onSingleLineUpdate_ = nil
			arg_13_1.onSingleLineFinish_ = nil
			arg_13_1.state_ = "waiting"
		end

		function arg_13_1.playNext_(arg_15_0)
			if arg_15_0 == 1 then
				arg_13_0:Play935011004(arg_13_1)
			end
		end

		function arg_13_1.onSingleLineUpdate_(arg_16_0)
			if arg_13_1.actors_["1070ui_story"] == nil and not isNil((Asset.Load("Char/" .. "1070ui_story"))) then
				local var_16_0 = Object.Instantiate(Asset.Load("Char/" .. "1070ui_story"), arg_13_1.stage_.transform)

				var_16_0.name = "1070ui_story"
				var_16_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_13_1.actors_["1070ui_story"] = var_16_0

				local var_16_1 = var_16_0:GetComponentInChildren(typeof(CharacterEffect))

				var_16_1.enabled = true

				local var_16_2 = GameObjectTools.GetOrAddComponent(var_16_0, typeof(DynamicBoneHelper))

				if var_16_2 then
					var_16_2:EnableDynamicBone(false)
				end

				arg_13_1:ShowWeapon(var_16_1.transform, false)

				arg_13_1.var_["1070ui_story" .. "Animator"] = var_16_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_13_1.var_["1070ui_story" .. "Animator"].applyRootMotion = true
				arg_13_1.var_["1070ui_story" .. "LipSync"] = var_16_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_16_3 = arg_13_1.actors_["1070ui_story"].transform

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1.var_.moveOldPos1070ui_story = var_16_3.localPosition
			end

			local var_16_4 = 0.001

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_4 then
				var_16_3.localPosition = Vector3.Lerp(arg_13_1.var_.moveOldPos1070ui_story, Vector3.New(0, -0.95, -6.05), (arg_13_1.time_ - 0) / var_16_4)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			if arg_13_1.time_ >= 0 + var_16_4 and arg_13_1.time_ < 0 + var_16_4 + arg_16_0 then
				var_16_3.localPosition = Vector3.New(0, -0.95, -6.05)
				var_16_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_16_3.position).x, (manager.ui.mainCamera.transform.position - var_16_3.position).y, (manager.ui.mainCamera.transform.position - var_16_3.position).z)
				var_16_3.localEulerAngles.z = 0
				var_16_3.localEulerAngles.x = 0
				var_16_3.localEulerAngles = var_16_3.localEulerAngles
			end

			local var_16_5 = arg_13_1.actors_["1070ui_story"]

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1070ui_story == nil then
				arg_13_1.var_.characterEffect1070ui_story = var_16_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_16_6 = 0.200000002980232

			if 0 <= arg_13_1.time_ and arg_13_1.time_ < 0 + var_16_6 and not isNil(var_16_5) then
				if arg_13_1.var_.characterEffect1070ui_story and not isNil(var_16_5) then
					arg_13_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_13_1.time_ >= 0 + var_16_6 and arg_13_1.time_ < 0 + var_16_6 + arg_16_0 and not isNil(var_16_5) and arg_13_1.var_.characterEffect1070ui_story then
				arg_13_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= 0 + arg_16_0 then
				arg_13_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_16_8 = 0
			local var_16_9 = 0.3

			if 0 < arg_13_1.time_ and arg_13_1.time_ <= var_16_8 + arg_16_0 then
				arg_13_1.talkMaxDuration = 0
				arg_13_1.dialogCg_.alpha = 1

				arg_13_1.dialog_:SetActive(true)
				SetActive(arg_13_1.leftNameGo_, true)

				arg_13_1.leftNameTxt_.text = arg_13_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_13_1.leftNameTxt_.transform)

				arg_13_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_13_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_13_1:RecordName(arg_13_1.leftNameTxt_.text)
				SetActive(arg_13_1.iconTrs_.gameObject, false)
				arg_13_1.callingController_:SetSelectedState("normal")

				local var_16_10 = arg_13_1:FormatText(arg_13_1:GetWordFromCfg(935011003).content)

				arg_13_1.text_.text = var_16_10

				LuaForUtil.ClearLinePrefixSymbol(arg_13_1.text_)

				local var_16_12 = 12 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 12)

				if (12 <= 0 and var_16_9 or var_16_9 * (utf8.len(var_16_10) / 12)) > 0 and var_16_9 < var_16_12 then
					arg_13_1.talkMaxDuration = var_16_12

					if var_16_12 + var_16_8 > arg_13_1.duration_ then
						arg_13_1.duration_ = var_16_12 + var_16_8
					end
				end

				arg_13_1.text_.text = var_16_10
				arg_13_1.typewritter.percent = 0

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(false)
				arg_13_1:RecordContent(arg_13_1.text_.text)
			end

			local var_16_13 = math.max(var_16_9, arg_13_1.talkMaxDuration)

			if var_16_8 <= arg_13_1.time_ and arg_13_1.time_ < var_16_8 + var_16_13 then
				arg_13_1.typewritter.percent = (arg_13_1.time_ - var_16_8) / var_16_13

				arg_13_1.typewritter:SetDirty()
			end

			if arg_13_1.time_ >= var_16_8 + var_16_13 and arg_13_1.time_ < var_16_8 + var_16_13 + arg_16_0 then
				arg_13_1.typewritter.percent = 1

				arg_13_1.typewritter:SetDirty()
				arg_13_1:ShowNextGo(true)
			end
		end

		arg_13_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
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
	Play935011004 = function(arg_17_0, arg_17_1)
		arg_17_1.time_ = 0
		arg_17_1.frameCnt_ = 0
		arg_17_1.state_ = "playing"
		arg_17_1.curTalkId_ = 935011004
		arg_17_1.duration_ = 5

		SetActive(arg_17_1.tipsGo_, false)

		function arg_17_1.onSingleLineFinish_()
			arg_17_1.onSingleLineUpdate_ = nil
			arg_17_1.onSingleLineFinish_ = nil
			arg_17_1.state_ = "waiting"
		end

		function arg_17_1.playNext_(arg_19_0)
			if arg_19_0 == 1 then
				arg_17_0:Play935011005(arg_17_1)
			end
		end

		function arg_17_1.onSingleLineUpdate_(arg_20_0)
			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 then
				arg_17_1.var_.moveOldPos1070ui_story = arg_17_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_20_0 = 0.001

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_0 then
				arg_17_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_17_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_17_1.time_ - 0) / var_20_0)
				arg_17_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1070ui_story"].transform.position).z)
				arg_17_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1070ui_story"].transform.localEulerAngles = arg_17_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_17_1.time_ >= 0 + var_20_0 and arg_17_1.time_ < 0 + var_20_0 + arg_20_0 then
				arg_17_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_17_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_17_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_17_1.actors_["1070ui_story"].transform.position).z)
				arg_17_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_17_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_17_1.actors_["1070ui_story"].transform.localEulerAngles = arg_17_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_20_1 = arg_17_1.actors_["1070ui_story"]

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= 0 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1070ui_story == nil then
				arg_17_1.var_.characterEffect1070ui_story = var_20_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_20_2 = 0.200000002980232

			if 0 <= arg_17_1.time_ and arg_17_1.time_ < 0 + var_20_2 and not isNil(var_20_1) then
				if arg_17_1.var_.characterEffect1070ui_story and not isNil(var_20_1) then
					arg_17_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_17_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_17_1.time_ - 0) / var_20_2)
				end
			end

			if arg_17_1.time_ >= 0 + var_20_2 and arg_17_1.time_ < 0 + var_20_2 + arg_20_0 and not isNil(var_20_1) and arg_17_1.var_.characterEffect1070ui_story then
				arg_17_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_17_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_20_3 = 0
			local var_20_4 = 0.575

			if 0 < arg_17_1.time_ and arg_17_1.time_ <= var_20_3 + arg_20_0 then
				arg_17_1.talkMaxDuration = 0
				arg_17_1.dialogCg_.alpha = 1

				arg_17_1.dialog_:SetActive(true)
				SetActive(arg_17_1.leftNameGo_, false)

				arg_17_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_17_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_17_1:RecordName(arg_17_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_17_1.iconTrs_.gameObject, false)
				arg_17_1.callingController_:SetSelectedState("normal")

				local var_20_5 = arg_17_1:FormatText(arg_17_1:GetWordFromCfg(935011004).content)

				arg_17_1.text_.text = var_20_5

				LuaForUtil.ClearLinePrefixSymbol(arg_17_1.text_)

				local var_20_7 = 23 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 23)

				if (23 <= 0 and var_20_4 or var_20_4 * (utf8.len(var_20_5) / 23)) > 0 and var_20_4 < var_20_7 then
					arg_17_1.talkMaxDuration = var_20_7

					if var_20_7 + var_20_3 > arg_17_1.duration_ then
						arg_17_1.duration_ = var_20_7 + var_20_3
					end
				end

				arg_17_1.text_.text = var_20_5
				arg_17_1.typewritter.percent = 0

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(false)
				arg_17_1:RecordContent(arg_17_1.text_.text)
			end

			local var_20_8 = math.max(var_20_4, arg_17_1.talkMaxDuration)

			if var_20_3 <= arg_17_1.time_ and arg_17_1.time_ < var_20_3 + var_20_8 then
				arg_17_1.typewritter.percent = (arg_17_1.time_ - var_20_3) / var_20_8

				arg_17_1.typewritter:SetDirty()
			end

			if arg_17_1.time_ >= var_20_3 + var_20_8 and arg_17_1.time_ < var_20_3 + var_20_8 + arg_20_0 then
				arg_17_1.typewritter.percent = 1

				arg_17_1.typewritter:SetDirty()
				arg_17_1:ShowNextGo(true)
			end
		end

		arg_17_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "ST2003a",
				frequency = 100,
				className = "StoryShakeNode",
				duration = 0.0666666666666667,
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Background,
				shakeTarget = StoryPlayerConst.SHAKE_TARGET.BACKGROUND,
				offset = Vector3.New(0.1, 0.1, 0.1)
			}
		}

		arg_17_1:InitPlayNodeList()
	end,
	Play935011005 = function(arg_21_0, arg_21_1)
		arg_21_1.time_ = 0
		arg_21_1.frameCnt_ = 0
		arg_21_1.state_ = "playing"
		arg_21_1.curTalkId_ = 935011005
		arg_21_1.duration_ = 5

		SetActive(arg_21_1.tipsGo_, false)

		function arg_21_1.onSingleLineFinish_()
			arg_21_1.onSingleLineUpdate_ = nil
			arg_21_1.onSingleLineFinish_ = nil
			arg_21_1.state_ = "waiting"
		end

		function arg_21_1.playNext_(arg_23_0)
			if arg_23_0 == 1 then
				arg_21_0:Play935011006(arg_21_1)
			end
		end

		function arg_21_1.onSingleLineUpdate_(arg_24_0)
			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1.var_.moveOldPos1070ui_story = arg_21_1.actors_["1070ui_story"].transform.localPosition
			end

			local var_24_0 = 0.001

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_0 then
				arg_21_1.actors_["1070ui_story"].transform.localPosition = Vector3.Lerp(arg_21_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_21_1.time_ - 0) / var_24_0)
				arg_21_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1070ui_story"].transform.position).z)
				arg_21_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1070ui_story"].transform.localEulerAngles = arg_21_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			if arg_21_1.time_ >= 0 + var_24_0 and arg_21_1.time_ < 0 + var_24_0 + arg_24_0 then
				arg_21_1.actors_["1070ui_story"].transform.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				arg_21_1.actors_["1070ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_21_1.actors_["1070ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1070ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_21_1.actors_["1070ui_story"].transform.position).z)
				arg_21_1.actors_["1070ui_story"].transform.localEulerAngles.z = 0
				arg_21_1.actors_["1070ui_story"].transform.localEulerAngles.x = 0
				arg_21_1.actors_["1070ui_story"].transform.localEulerAngles = arg_21_1.actors_["1070ui_story"].transform.localEulerAngles
			end

			local var_24_1 = arg_21_1.actors_["1070ui_story"]

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1070ui_story == nil then
				arg_21_1.var_.characterEffect1070ui_story = var_24_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_24_2 = 0.200000002980232

			if 0 <= arg_21_1.time_ and arg_21_1.time_ < 0 + var_24_2 and not isNil(var_24_1) then
				if arg_21_1.var_.characterEffect1070ui_story and not isNil(var_24_1) then
					arg_21_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_21_1.time_ >= 0 + var_24_2 and arg_21_1.time_ < 0 + var_24_2 + arg_24_0 and not isNil(var_24_1) and arg_21_1.var_.characterEffect1070ui_story then
				arg_21_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= 0 + arg_24_0 then
				arg_21_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva", "EmotionTimelineAnimator")
			end

			local var_24_4 = 0
			local var_24_5 = 0.15

			if 0 < arg_21_1.time_ and arg_21_1.time_ <= var_24_4 + arg_24_0 then
				arg_21_1.talkMaxDuration = 0
				arg_21_1.dialogCg_.alpha = 1

				arg_21_1.dialog_:SetActive(true)
				SetActive(arg_21_1.leftNameGo_, true)

				arg_21_1.leftNameTxt_.text = arg_21_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_21_1.leftNameTxt_.transform)

				arg_21_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_21_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_21_1:RecordName(arg_21_1.leftNameTxt_.text)
				SetActive(arg_21_1.iconTrs_.gameObject, false)
				arg_21_1.callingController_:SetSelectedState("normal")

				local var_24_6 = arg_21_1:FormatText(arg_21_1:GetWordFromCfg(935011005).content)

				arg_21_1.text_.text = var_24_6

				LuaForUtil.ClearLinePrefixSymbol(arg_21_1.text_)

				local var_24_8 = 6 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 6)

				if (6 <= 0 and var_24_5 or var_24_5 * (utf8.len(var_24_6) / 6)) > 0 and var_24_5 < var_24_8 then
					arg_21_1.talkMaxDuration = var_24_8

					if var_24_8 + var_24_4 > arg_21_1.duration_ then
						arg_21_1.duration_ = var_24_8 + var_24_4
					end
				end

				arg_21_1.text_.text = var_24_6
				arg_21_1.typewritter.percent = 0

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(false)
				arg_21_1:RecordContent(arg_21_1.text_.text)
			end

			local var_24_9 = math.max(var_24_5, arg_21_1.talkMaxDuration)

			if var_24_4 <= arg_21_1.time_ and arg_21_1.time_ < var_24_4 + var_24_9 then
				arg_21_1.typewritter.percent = (arg_21_1.time_ - var_24_4) / var_24_9

				arg_21_1.typewritter:SetDirty()
			end

			if arg_21_1.time_ >= var_24_4 + var_24_9 and arg_21_1.time_ < var_24_4 + var_24_9 + arg_24_0 then
				arg_21_1.typewritter.percent = 1

				arg_21_1.typewritter:SetDirty()
				arg_21_1:ShowNextGo(true)
			end
		end

		arg_21_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_21_1:InitPlayNodeList()
	end,
	Play935011006 = function(arg_25_0, arg_25_1)
		arg_25_1.time_ = 0
		arg_25_1.frameCnt_ = 0
		arg_25_1.state_ = "playing"
		arg_25_1.curTalkId_ = 935011006
		arg_25_1.duration_ = 5

		SetActive(arg_25_1.tipsGo_, false)

		function arg_25_1.onSingleLineFinish_()
			arg_25_1.onSingleLineUpdate_ = nil
			arg_25_1.onSingleLineFinish_ = nil
			arg_25_1.state_ = "waiting"
		end

		function arg_25_1.playNext_(arg_27_0)
			if arg_27_0 == 1 then
				arg_25_0:Play935011007(arg_25_1)
			end
		end

		function arg_25_1.onSingleLineUpdate_(arg_28_0)
			if arg_25_1.actors_["10039ui_story"] == nil and not isNil((Asset.Load("Char/" .. "10039ui_story"))) then
				local var_28_0 = Object.Instantiate(Asset.Load("Char/" .. "10039ui_story"), arg_25_1.stage_.transform)

				var_28_0.name = "10039ui_story"
				var_28_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_25_1.actors_["10039ui_story"] = var_28_0

				local var_28_1 = var_28_0:GetComponentInChildren(typeof(CharacterEffect))

				var_28_1.enabled = true

				local var_28_2 = GameObjectTools.GetOrAddComponent(var_28_0, typeof(DynamicBoneHelper))

				if var_28_2 then
					var_28_2:EnableDynamicBone(false)
				end

				arg_25_1:ShowWeapon(var_28_1.transform, false)

				arg_25_1.var_["10039ui_story" .. "Animator"] = var_28_1.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_25_1.var_["10039ui_story" .. "Animator"].applyRootMotion = true
				arg_25_1.var_["10039ui_story" .. "LipSync"] = var_28_1.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_28_3 = arg_25_1.actors_["10039ui_story"].transform

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1.var_.moveOldPos10039ui_story = var_28_3.localPosition
			end

			local var_28_4 = 0.001

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_4 then
				var_28_3.localPosition = Vector3.Lerp(arg_25_1.var_.moveOldPos10039ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_25_1.time_ - 0) / var_28_4)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			if arg_25_1.time_ >= 0 + var_28_4 and arg_25_1.time_ < 0 + var_28_4 + arg_28_0 then
				var_28_3.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_28_3.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_28_3.position).x, (manager.ui.mainCamera.transform.position - var_28_3.position).y, (manager.ui.mainCamera.transform.position - var_28_3.position).z)
				var_28_3.localEulerAngles.z = 0
				var_28_3.localEulerAngles.x = 0
				var_28_3.localEulerAngles = var_28_3.localEulerAngles
			end

			local var_28_5 = arg_25_1.actors_["10039ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10039ui_story == nil then
				arg_25_1.var_.characterEffect10039ui_story = var_28_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_6 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_6 and not isNil(var_28_5) then
				if arg_25_1.var_.characterEffect10039ui_story and not isNil(var_28_5) then
					arg_25_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_25_1.time_ >= 0 + var_28_6 and arg_25_1.time_ < 0 + var_28_6 + arg_28_0 and not isNil(var_28_5) and arg_25_1.var_.characterEffect10039ui_story then
				arg_25_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_28_8 = arg_25_1.actors_["1070ui_story"]

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.characterEffect1070ui_story == nil then
				arg_25_1.var_.characterEffect1070ui_story = var_28_8:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_28_9 = 0.200000002980232

			if 0 <= arg_25_1.time_ and arg_25_1.time_ < 0 + var_28_9 and not isNil(var_28_8) then
				if arg_25_1.var_.characterEffect1070ui_story and not isNil(var_28_8) then
					arg_25_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_25_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_25_1.time_ - 0) / var_28_9)
				end
			end

			if arg_25_1.time_ >= 0 + var_28_9 and arg_25_1.time_ < 0 + var_28_9 + arg_28_0 and not isNil(var_28_8) and arg_25_1.var_.characterEffect1070ui_story then
				arg_25_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_25_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= 0 + arg_28_0 then
				arg_25_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva", "EmotionTimelineAnimator")
			end

			local var_28_10 = 0
			local var_28_11 = 0.5

			if 0 < arg_25_1.time_ and arg_25_1.time_ <= var_28_10 + arg_28_0 then
				arg_25_1.talkMaxDuration = 0
				arg_25_1.dialogCg_.alpha = 1

				arg_25_1.dialog_:SetActive(true)
				SetActive(arg_25_1.leftNameGo_, true)

				arg_25_1.leftNameTxt_.text = arg_25_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_25_1.leftNameTxt_.transform)

				arg_25_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_25_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_25_1:RecordName(arg_25_1.leftNameTxt_.text)
				SetActive(arg_25_1.iconTrs_.gameObject, false)
				arg_25_1.callingController_:SetSelectedState("normal")

				local var_28_12 = arg_25_1:FormatText(arg_25_1:GetWordFromCfg(935011006).content)

				arg_25_1.text_.text = var_28_12

				LuaForUtil.ClearLinePrefixSymbol(arg_25_1.text_)

				local var_28_14 = 20 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_12) / 20)

				if (20 <= 0 and var_28_11 or var_28_11 * (utf8.len(var_28_12) / 20)) > 0 and var_28_11 < var_28_14 then
					arg_25_1.talkMaxDuration = var_28_14

					if var_28_14 + var_28_10 > arg_25_1.duration_ then
						arg_25_1.duration_ = var_28_14 + var_28_10
					end
				end

				arg_25_1.text_.text = var_28_12
				arg_25_1.typewritter.percent = 0

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(false)
				arg_25_1:RecordContent(arg_25_1.text_.text)
			end

			local var_28_15 = math.max(var_28_11, arg_25_1.talkMaxDuration)

			if var_28_10 <= arg_25_1.time_ and arg_25_1.time_ < var_28_10 + var_28_15 then
				arg_25_1.typewritter.percent = (arg_25_1.time_ - var_28_10) / var_28_15

				arg_25_1.typewritter:SetDirty()
			end

			if arg_25_1.time_ >= var_28_10 + var_28_15 and arg_25_1.time_ < var_28_10 + var_28_15 + arg_28_0 then
				arg_25_1.typewritter.percent = 1

				arg_25_1.typewritter:SetDirty()
				arg_25_1:ShowNextGo(true)
			end
		end

		arg_25_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play935011007 = function(arg_29_0, arg_29_1)
		arg_29_1.time_ = 0
		arg_29_1.frameCnt_ = 0
		arg_29_1.state_ = "playing"
		arg_29_1.curTalkId_ = 935011007
		arg_29_1.duration_ = 5

		SetActive(arg_29_1.tipsGo_, false)

		function arg_29_1.onSingleLineFinish_()
			arg_29_1.onSingleLineUpdate_ = nil
			arg_29_1.onSingleLineFinish_ = nil
			arg_29_1.state_ = "waiting"
		end

		function arg_29_1.playNext_(arg_31_0)
			if arg_31_0 == 1 then
				arg_29_0:Play935011008(arg_29_1)
			end
		end

		function arg_29_1.onSingleLineUpdate_(arg_32_0)
			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(arg_29_1.actors_["1070ui_story"]) and arg_29_1.var_.characterEffect1070ui_story == nil then
				arg_29_1.var_.characterEffect1070ui_story = arg_29_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_0 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_0 and not isNil(arg_29_1.actors_["1070ui_story"]) then
				if arg_29_1.var_.characterEffect1070ui_story and not isNil(arg_29_1.actors_["1070ui_story"]) then
					arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_29_1.time_ >= 0 + var_32_0 and arg_29_1.time_ < 0 + var_32_0 + arg_32_0 and not isNil(arg_29_1.actors_["1070ui_story"]) and arg_29_1.var_.characterEffect1070ui_story then
				arg_29_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_32_2 = arg_29_1.actors_["10039ui_story"]

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect10039ui_story == nil then
				arg_29_1.var_.characterEffect10039ui_story = var_32_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_32_3 = 0.200000002980232

			if 0 <= arg_29_1.time_ and arg_29_1.time_ < 0 + var_32_3 and not isNil(var_32_2) then
				if arg_29_1.var_.characterEffect10039ui_story and not isNil(var_32_2) then
					arg_29_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_29_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_29_1.time_ - 0) / var_32_3)
				end
			end

			if arg_29_1.time_ >= 0 + var_32_3 and arg_29_1.time_ < 0 + var_32_3 + arg_32_0 and not isNil(var_32_2) and arg_29_1.var_.characterEffect10039ui_story then
				arg_29_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_29_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= 0 + arg_32_0 then
				arg_29_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_32_4 = 0
			local var_32_5 = 0.925

			if 0 < arg_29_1.time_ and arg_29_1.time_ <= var_32_4 + arg_32_0 then
				arg_29_1.talkMaxDuration = 0
				arg_29_1.dialogCg_.alpha = 1

				arg_29_1.dialog_:SetActive(true)
				SetActive(arg_29_1.leftNameGo_, true)

				arg_29_1.leftNameTxt_.text = arg_29_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_29_1.leftNameTxt_.transform)

				arg_29_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_29_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_29_1:RecordName(arg_29_1.leftNameTxt_.text)
				SetActive(arg_29_1.iconTrs_.gameObject, false)
				arg_29_1.callingController_:SetSelectedState("normal")

				local var_32_6 = arg_29_1:FormatText(arg_29_1:GetWordFromCfg(935011007).content)

				arg_29_1.text_.text = var_32_6

				LuaForUtil.ClearLinePrefixSymbol(arg_29_1.text_)

				local var_32_8 = 37 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 37)

				if (37 <= 0 and var_32_5 or var_32_5 * (utf8.len(var_32_6) / 37)) > 0 and var_32_5 < var_32_8 then
					arg_29_1.talkMaxDuration = var_32_8

					if var_32_8 + var_32_4 > arg_29_1.duration_ then
						arg_29_1.duration_ = var_32_8 + var_32_4
					end
				end

				arg_29_1.text_.text = var_32_6
				arg_29_1.typewritter.percent = 0

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(false)
				arg_29_1:RecordContent(arg_29_1.text_.text)
			end

			local var_32_9 = math.max(var_32_5, arg_29_1.talkMaxDuration)

			if var_32_4 <= arg_29_1.time_ and arg_29_1.time_ < var_32_4 + var_32_9 then
				arg_29_1.typewritter.percent = (arg_29_1.time_ - var_32_4) / var_32_9

				arg_29_1.typewritter:SetDirty()
			end

			if arg_29_1.time_ >= var_32_4 + var_32_9 and arg_29_1.time_ < var_32_4 + var_32_9 + arg_32_0 then
				arg_29_1.typewritter.percent = 1

				arg_29_1.typewritter:SetDirty()
				arg_29_1:ShowNextGo(true)
			end
		end

		arg_29_1.nodeConfigList_ = {}

		arg_29_1:InitPlayNodeList()
	end,
	Play935011008 = function(arg_33_0, arg_33_1)
		arg_33_1.time_ = 0
		arg_33_1.frameCnt_ = 0
		arg_33_1.state_ = "playing"
		arg_33_1.curTalkId_ = 935011008
		arg_33_1.duration_ = 5

		SetActive(arg_33_1.tipsGo_, false)

		function arg_33_1.onSingleLineFinish_()
			arg_33_1.onSingleLineUpdate_ = nil
			arg_33_1.onSingleLineFinish_ = nil
			arg_33_1.state_ = "waiting"
		end

		function arg_33_1.playNext_(arg_35_0)
			if arg_35_0 == 1 then
				arg_33_0:Play935011009(arg_33_1)
			end
		end

		function arg_33_1.onSingleLineUpdate_(arg_36_0)
			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(arg_33_1.actors_["10039ui_story"]) and arg_33_1.var_.characterEffect10039ui_story == nil then
				arg_33_1.var_.characterEffect10039ui_story = arg_33_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_0 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_0 and not isNil(arg_33_1.actors_["10039ui_story"]) then
				if arg_33_1.var_.characterEffect10039ui_story and not isNil(arg_33_1.actors_["10039ui_story"]) then
					arg_33_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_33_1.time_ >= 0 + var_36_0 and arg_33_1.time_ < 0 + var_36_0 + arg_36_0 and not isNil(arg_33_1.actors_["10039ui_story"]) and arg_33_1.var_.characterEffect10039ui_story then
				arg_33_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_36_2 = arg_33_1.actors_["1070ui_story"]

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1070ui_story == nil then
				arg_33_1.var_.characterEffect1070ui_story = var_36_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_36_3 = 0.200000002980232

			if 0 <= arg_33_1.time_ and arg_33_1.time_ < 0 + var_36_3 and not isNil(var_36_2) then
				if arg_33_1.var_.characterEffect1070ui_story and not isNil(var_36_2) then
					arg_33_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_33_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_33_1.time_ - 0) / var_36_3)
				end
			end

			if arg_33_1.time_ >= 0 + var_36_3 and arg_33_1.time_ < 0 + var_36_3 + arg_36_0 and not isNil(var_36_2) and arg_33_1.var_.characterEffect1070ui_story then
				arg_33_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_33_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= 0 + arg_36_0 then
				arg_33_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_36_4 = 0
			local var_36_5 = 0.125

			if 0 < arg_33_1.time_ and arg_33_1.time_ <= var_36_4 + arg_36_0 then
				arg_33_1.talkMaxDuration = 0
				arg_33_1.dialogCg_.alpha = 1

				arg_33_1.dialog_:SetActive(true)
				SetActive(arg_33_1.leftNameGo_, true)

				arg_33_1.leftNameTxt_.text = arg_33_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_33_1.leftNameTxt_.transform)

				arg_33_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_33_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_33_1:RecordName(arg_33_1.leftNameTxt_.text)
				SetActive(arg_33_1.iconTrs_.gameObject, false)
				arg_33_1.callingController_:SetSelectedState("normal")

				local var_36_6 = arg_33_1:FormatText(arg_33_1:GetWordFromCfg(935011008).content)

				arg_33_1.text_.text = var_36_6

				LuaForUtil.ClearLinePrefixSymbol(arg_33_1.text_)

				local var_36_8 = 5 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 5)

				if (5 <= 0 and var_36_5 or var_36_5 * (utf8.len(var_36_6) / 5)) > 0 and var_36_5 < var_36_8 then
					arg_33_1.talkMaxDuration = var_36_8

					if var_36_8 + var_36_4 > arg_33_1.duration_ then
						arg_33_1.duration_ = var_36_8 + var_36_4
					end
				end

				arg_33_1.text_.text = var_36_6
				arg_33_1.typewritter.percent = 0

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(false)
				arg_33_1:RecordContent(arg_33_1.text_.text)
			end

			local var_36_9 = math.max(var_36_5, arg_33_1.talkMaxDuration)

			if var_36_4 <= arg_33_1.time_ and arg_33_1.time_ < var_36_4 + var_36_9 then
				arg_33_1.typewritter.percent = (arg_33_1.time_ - var_36_4) / var_36_9

				arg_33_1.typewritter:SetDirty()
			end

			if arg_33_1.time_ >= var_36_4 + var_36_9 and arg_33_1.time_ < var_36_4 + var_36_9 + arg_36_0 then
				arg_33_1.typewritter.percent = 1

				arg_33_1.typewritter:SetDirty()
				arg_33_1:ShowNextGo(true)
			end
		end

		arg_33_1.nodeConfigList_ = {}

		arg_33_1:InitPlayNodeList()
	end,
	Play935011009 = function(arg_37_0, arg_37_1)
		arg_37_1.time_ = 0
		arg_37_1.frameCnt_ = 0
		arg_37_1.state_ = "playing"
		arg_37_1.curTalkId_ = 935011009
		arg_37_1.duration_ = 5

		SetActive(arg_37_1.tipsGo_, false)

		function arg_37_1.onSingleLineFinish_()
			arg_37_1.onSingleLineUpdate_ = nil
			arg_37_1.onSingleLineFinish_ = nil
			arg_37_1.state_ = "waiting"
		end

		function arg_37_1.playNext_(arg_39_0)
			if arg_39_0 == 1 then
				arg_37_0:Play935011010(arg_37_1)
			end
		end

		function arg_37_1.onSingleLineUpdate_(arg_40_0)
			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(arg_37_1.actors_["1070ui_story"]) and arg_37_1.var_.characterEffect1070ui_story == nil then
				arg_37_1.var_.characterEffect1070ui_story = arg_37_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_0 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_0 and not isNil(arg_37_1.actors_["1070ui_story"]) then
				if arg_37_1.var_.characterEffect1070ui_story and not isNil(arg_37_1.actors_["1070ui_story"]) then
					arg_37_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_37_1.time_ >= 0 + var_40_0 and arg_37_1.time_ < 0 + var_40_0 + arg_40_0 and not isNil(arg_37_1.actors_["1070ui_story"]) and arg_37_1.var_.characterEffect1070ui_story then
				arg_37_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_40_2 = arg_37_1.actors_["10039ui_story"]

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect10039ui_story == nil then
				arg_37_1.var_.characterEffect10039ui_story = var_40_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_40_3 = 0.200000002980232

			if 0 <= arg_37_1.time_ and arg_37_1.time_ < 0 + var_40_3 and not isNil(var_40_2) then
				if arg_37_1.var_.characterEffect10039ui_story and not isNil(var_40_2) then
					arg_37_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_37_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_37_1.time_ - 0) / var_40_3)
				end
			end

			if arg_37_1.time_ >= 0 + var_40_3 and arg_37_1.time_ < 0 + var_40_3 + arg_40_0 and not isNil(var_40_2) and arg_37_1.var_.characterEffect10039ui_story then
				arg_37_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_37_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= 0 + arg_40_0 then
				arg_37_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_40_4 = 0
			local var_40_5 = 0.125

			if 0 < arg_37_1.time_ and arg_37_1.time_ <= var_40_4 + arg_40_0 then
				arg_37_1.talkMaxDuration = 0
				arg_37_1.dialogCg_.alpha = 1

				arg_37_1.dialog_:SetActive(true)
				SetActive(arg_37_1.leftNameGo_, true)

				arg_37_1.leftNameTxt_.text = arg_37_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_37_1.leftNameTxt_.transform)

				arg_37_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_37_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_37_1:RecordName(arg_37_1.leftNameTxt_.text)
				SetActive(arg_37_1.iconTrs_.gameObject, false)
				arg_37_1.callingController_:SetSelectedState("normal")

				local var_40_6 = arg_37_1:FormatText(arg_37_1:GetWordFromCfg(935011009).content)

				arg_37_1.text_.text = var_40_6

				LuaForUtil.ClearLinePrefixSymbol(arg_37_1.text_)

				local var_40_8 = 5 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 5)

				if (5 <= 0 and var_40_5 or var_40_5 * (utf8.len(var_40_6) / 5)) > 0 and var_40_5 < var_40_8 then
					arg_37_1.talkMaxDuration = var_40_8

					if var_40_8 + var_40_4 > arg_37_1.duration_ then
						arg_37_1.duration_ = var_40_8 + var_40_4
					end
				end

				arg_37_1.text_.text = var_40_6
				arg_37_1.typewritter.percent = 0

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(false)
				arg_37_1:RecordContent(arg_37_1.text_.text)
			end

			local var_40_9 = math.max(var_40_5, arg_37_1.talkMaxDuration)

			if var_40_4 <= arg_37_1.time_ and arg_37_1.time_ < var_40_4 + var_40_9 then
				arg_37_1.typewritter.percent = (arg_37_1.time_ - var_40_4) / var_40_9

				arg_37_1.typewritter:SetDirty()
			end

			if arg_37_1.time_ >= var_40_4 + var_40_9 and arg_37_1.time_ < var_40_4 + var_40_9 + arg_40_0 then
				arg_37_1.typewritter.percent = 1

				arg_37_1.typewritter:SetDirty()
				arg_37_1:ShowNextGo(true)
			end
		end

		arg_37_1.nodeConfigList_ = {}

		arg_37_1:InitPlayNodeList()
	end,
	Play935011010 = function(arg_41_0, arg_41_1)
		arg_41_1.time_ = 0
		arg_41_1.frameCnt_ = 0
		arg_41_1.state_ = "playing"
		arg_41_1.curTalkId_ = 935011010
		arg_41_1.duration_ = 5

		SetActive(arg_41_1.tipsGo_, false)

		function arg_41_1.onSingleLineFinish_()
			arg_41_1.onSingleLineUpdate_ = nil
			arg_41_1.onSingleLineFinish_ = nil
			arg_41_1.state_ = "waiting"
		end

		function arg_41_1.playNext_(arg_43_0)
			if arg_43_0 == 1 then
				arg_41_0:Play935011011(arg_41_1)
			end
		end

		function arg_41_1.onSingleLineUpdate_(arg_44_0)
			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 and not isNil(arg_41_1.actors_["1070ui_story"]) and arg_41_1.var_.characterEffect1070ui_story == nil then
				arg_41_1.var_.characterEffect1070ui_story = arg_41_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_44_0 = 0.200000002980232

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_0 and not isNil(arg_41_1.actors_["1070ui_story"]) then
				if arg_41_1.var_.characterEffect1070ui_story and not isNil(arg_41_1.actors_["1070ui_story"]) then
					arg_41_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_41_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_41_1.time_ - 0) / var_44_0)
				end
			end

			if arg_41_1.time_ >= 0 + var_44_0 and arg_41_1.time_ < 0 + var_44_0 + arg_44_0 and not isNil(arg_41_1.actors_["1070ui_story"]) and arg_41_1.var_.characterEffect1070ui_story then
				arg_41_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_41_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_44_1 = arg_41_1.actors_["1070ui_story"].transform

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= 0 + arg_44_0 then
				arg_41_1.var_.moveOldPos1070ui_story = var_44_1.localPosition
			end

			local var_44_2 = 0.001

			if 0 <= arg_41_1.time_ and arg_41_1.time_ < 0 + var_44_2 then
				var_44_1.localPosition = Vector3.Lerp(arg_41_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_41_1.time_ - 0) / var_44_2)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			if arg_41_1.time_ >= 0 + var_44_2 and arg_41_1.time_ < 0 + var_44_2 + arg_44_0 then
				var_44_1.localPosition = Vector3.New(0, 100, 0)
				var_44_1.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_44_1.position).x, (manager.ui.mainCamera.transform.position - var_44_1.position).y, (manager.ui.mainCamera.transform.position - var_44_1.position).z)
				var_44_1.localEulerAngles.z = 0
				var_44_1.localEulerAngles.x = 0
				var_44_1.localEulerAngles = var_44_1.localEulerAngles
			end

			local var_44_3 = 0
			local var_44_4 = 1.125

			if 0 < arg_41_1.time_ and arg_41_1.time_ <= var_44_3 + arg_44_0 then
				arg_41_1.talkMaxDuration = 0
				arg_41_1.dialogCg_.alpha = 1

				arg_41_1.dialog_:SetActive(true)
				SetActive(arg_41_1.leftNameGo_, false)

				arg_41_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_41_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_41_1:RecordName(arg_41_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_41_1.iconTrs_.gameObject, false)
				arg_41_1.callingController_:SetSelectedState("normal")

				local var_44_5 = arg_41_1:FormatText(arg_41_1:GetWordFromCfg(935011010).content)

				arg_41_1.text_.text = var_44_5

				LuaForUtil.ClearLinePrefixSymbol(arg_41_1.text_)

				local var_44_7 = 45 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 45)

				if (45 <= 0 and var_44_4 or var_44_4 * (utf8.len(var_44_5) / 45)) > 0 and var_44_4 < var_44_7 then
					arg_41_1.talkMaxDuration = var_44_7

					if var_44_7 + var_44_3 > arg_41_1.duration_ then
						arg_41_1.duration_ = var_44_7 + var_44_3
					end
				end

				arg_41_1.text_.text = var_44_5
				arg_41_1.typewritter.percent = 0

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(false)
				arg_41_1:RecordContent(arg_41_1.text_.text)
			end

			local var_44_8 = math.max(var_44_4, arg_41_1.talkMaxDuration)

			if var_44_3 <= arg_41_1.time_ and arg_41_1.time_ < var_44_3 + var_44_8 then
				arg_41_1.typewritter.percent = (arg_41_1.time_ - var_44_3) / var_44_8

				arg_41_1.typewritter:SetDirty()
			end

			if arg_41_1.time_ >= var_44_3 + var_44_8 and arg_41_1.time_ < var_44_3 + var_44_8 + arg_44_0 then
				arg_41_1.typewritter.percent = 1

				arg_41_1.typewritter:SetDirty()
				arg_41_1:ShowNextGo(true)
			end
		end

		arg_41_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_41_1:InitPlayNodeList()
	end,
	Play935011011 = function(arg_45_0, arg_45_1)
		arg_45_1.time_ = 0
		arg_45_1.frameCnt_ = 0
		arg_45_1.state_ = "playing"
		arg_45_1.curTalkId_ = 935011011
		arg_45_1.duration_ = 5

		SetActive(arg_45_1.tipsGo_, false)

		function arg_45_1.onSingleLineFinish_()
			arg_45_1.onSingleLineUpdate_ = nil
			arg_45_1.onSingleLineFinish_ = nil
			arg_45_1.state_ = "waiting"
		end

		function arg_45_1.playNext_(arg_47_0)
			if arg_47_0 == 1 then
				arg_45_0:Play935011012(arg_45_1)
			end
		end

		function arg_45_1.onSingleLineUpdate_(arg_48_0)
			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 and not isNil(arg_45_1.actors_["1070ui_story"]) and arg_45_1.var_.characterEffect1070ui_story == nil then
				arg_45_1.var_.characterEffect1070ui_story = arg_45_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_48_0 = 0.200000002980232

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_0 and not isNil(arg_45_1.actors_["1070ui_story"]) then
				if arg_45_1.var_.characterEffect1070ui_story and not isNil(arg_45_1.actors_["1070ui_story"]) then
					arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_45_1.time_ >= 0 + var_48_0 and arg_45_1.time_ < 0 + var_48_0 + arg_48_0 and not isNil(arg_45_1.actors_["1070ui_story"]) and arg_45_1.var_.characterEffect1070ui_story then
				arg_45_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_48_2 = arg_45_1.actors_["1070ui_story"].transform

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1.var_.moveOldPos1070ui_story = var_48_2.localPosition
			end

			local var_48_3 = 0.001

			if 0 <= arg_45_1.time_ and arg_45_1.time_ < 0 + var_48_3 then
				var_48_2.localPosition = Vector3.Lerp(arg_45_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_45_1.time_ - 0) / var_48_3)
				var_48_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_2.position).x, (manager.ui.mainCamera.transform.position - var_48_2.position).y, (manager.ui.mainCamera.transform.position - var_48_2.position).z)
				var_48_2.localEulerAngles.z = 0
				var_48_2.localEulerAngles.x = 0
				var_48_2.localEulerAngles = var_48_2.localEulerAngles
			end

			if arg_45_1.time_ >= 0 + var_48_3 and arg_45_1.time_ < 0 + var_48_3 + arg_48_0 then
				var_48_2.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_48_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_48_2.position).x, (manager.ui.mainCamera.transform.position - var_48_2.position).y, (manager.ui.mainCamera.transform.position - var_48_2.position).z)
				var_48_2.localEulerAngles.z = 0
				var_48_2.localEulerAngles.x = 0
				var_48_2.localEulerAngles = var_48_2.localEulerAngles
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action476")
			end

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= 0 + arg_48_0 then
				arg_45_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva", "EmotionTimelineAnimator")
			end

			local var_48_4 = 0
			local var_48_5 = 1

			if 0 < arg_45_1.time_ and arg_45_1.time_ <= var_48_4 + arg_48_0 then
				arg_45_1.talkMaxDuration = 0
				arg_45_1.dialogCg_.alpha = 1

				arg_45_1.dialog_:SetActive(true)
				SetActive(arg_45_1.leftNameGo_, true)

				arg_45_1.leftNameTxt_.text = arg_45_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_45_1.leftNameTxt_.transform)

				arg_45_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_45_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_45_1:RecordName(arg_45_1.leftNameTxt_.text)
				SetActive(arg_45_1.iconTrs_.gameObject, false)
				arg_45_1.callingController_:SetSelectedState("normal")

				local var_48_6 = arg_45_1:FormatText(arg_45_1:GetWordFromCfg(935011011).content)

				arg_45_1.text_.text = var_48_6

				LuaForUtil.ClearLinePrefixSymbol(arg_45_1.text_)

				local var_48_8 = 40 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_6) / 40)

				if (40 <= 0 and var_48_5 or var_48_5 * (utf8.len(var_48_6) / 40)) > 0 and var_48_5 < var_48_8 then
					arg_45_1.talkMaxDuration = var_48_8

					if var_48_8 + var_48_4 > arg_45_1.duration_ then
						arg_45_1.duration_ = var_48_8 + var_48_4
					end
				end

				arg_45_1.text_.text = var_48_6
				arg_45_1.typewritter.percent = 0

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(false)
				arg_45_1:RecordContent(arg_45_1.text_.text)
			end

			local var_48_9 = math.max(var_48_5, arg_45_1.talkMaxDuration)

			if var_48_4 <= arg_45_1.time_ and arg_45_1.time_ < var_48_4 + var_48_9 then
				arg_45_1.typewritter.percent = (arg_45_1.time_ - var_48_4) / var_48_9

				arg_45_1.typewritter:SetDirty()
			end

			if arg_45_1.time_ >= var_48_4 + var_48_9 and arg_45_1.time_ < var_48_4 + var_48_9 + arg_48_0 then
				arg_45_1.typewritter.percent = 1

				arg_45_1.typewritter:SetDirty()
				arg_45_1:ShowNextGo(true)
			end
		end

		arg_45_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_45_1:InitPlayNodeList()
	end,
	Play935011012 = function(arg_49_0, arg_49_1)
		arg_49_1.time_ = 0
		arg_49_1.frameCnt_ = 0
		arg_49_1.state_ = "playing"
		arg_49_1.curTalkId_ = 935011012
		arg_49_1.duration_ = 5

		SetActive(arg_49_1.tipsGo_, false)

		function arg_49_1.onSingleLineFinish_()
			arg_49_1.onSingleLineUpdate_ = nil
			arg_49_1.onSingleLineFinish_ = nil
			arg_49_1.state_ = "waiting"
		end

		function arg_49_1.playNext_(arg_51_0)
			if arg_51_0 == 1 then
				arg_49_0:Play935011013(arg_49_1)
			end
		end

		function arg_49_1.onSingleLineUpdate_(arg_52_0)
			local var_52_0 = 0.5

			if 0 < arg_49_1.time_ and arg_49_1.time_ <= 0 + arg_52_0 then
				arg_49_1.talkMaxDuration = 0
				arg_49_1.dialogCg_.alpha = 1

				arg_49_1.dialog_:SetActive(true)
				SetActive(arg_49_1.leftNameGo_, true)

				arg_49_1.leftNameTxt_.text = arg_49_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_49_1.leftNameTxt_.transform)

				arg_49_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_49_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_49_1:RecordName(arg_49_1.leftNameTxt_.text)
				SetActive(arg_49_1.iconTrs_.gameObject, false)
				arg_49_1.callingController_:SetSelectedState("normal")

				local var_52_1 = arg_49_1:FormatText(arg_49_1:GetWordFromCfg(935011012).content)

				arg_49_1.text_.text = var_52_1

				LuaForUtil.ClearLinePrefixSymbol(arg_49_1.text_)

				local var_52_3 = 20 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 20)

				if (20 <= 0 and var_52_0 or var_52_0 * (utf8.len(var_52_1) / 20)) > 0 and var_52_0 < var_52_3 then
					arg_49_1.talkMaxDuration = var_52_3

					if var_52_3 + 0 > arg_49_1.duration_ then
						arg_49_1.duration_ = var_52_3 + 0
					end
				end

				arg_49_1.text_.text = var_52_1
				arg_49_1.typewritter.percent = 0

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(false)
				arg_49_1:RecordContent(arg_49_1.text_.text)
			end

			local var_52_4 = math.max(var_52_0, arg_49_1.talkMaxDuration)

			if 0 <= arg_49_1.time_ and arg_49_1.time_ < 0 + var_52_4 then
				arg_49_1.typewritter.percent = (arg_49_1.time_ - 0) / var_52_4

				arg_49_1.typewritter:SetDirty()
			end

			if arg_49_1.time_ >= 0 + var_52_4 and arg_49_1.time_ < 0 + var_52_4 + arg_52_0 then
				arg_49_1.typewritter.percent = 1

				arg_49_1.typewritter:SetDirty()
				arg_49_1:ShowNextGo(true)
			end
		end

		arg_49_1.nodeConfigList_ = {}

		arg_49_1:InitPlayNodeList()
	end,
	Play935011013 = function(arg_53_0, arg_53_1)
		arg_53_1.time_ = 0
		arg_53_1.frameCnt_ = 0
		arg_53_1.state_ = "playing"
		arg_53_1.curTalkId_ = 935011013
		arg_53_1.duration_ = 5

		SetActive(arg_53_1.tipsGo_, false)

		function arg_53_1.onSingleLineFinish_()
			arg_53_1.onSingleLineUpdate_ = nil
			arg_53_1.onSingleLineFinish_ = nil
			arg_53_1.state_ = "waiting"
		end

		function arg_53_1.playNext_(arg_55_0)
			if arg_55_0 == 1 then
				arg_53_0:Play935011014(arg_53_1)
			end
		end

		function arg_53_1.onSingleLineUpdate_(arg_56_0)
			if 0 < arg_53_1.time_ and arg_53_1.time_ <= 0 + arg_56_0 then
				arg_53_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_56_0 = 0
			local var_56_1 = 1.275

			if 0 < arg_53_1.time_ and arg_53_1.time_ <= var_56_0 + arg_56_0 then
				arg_53_1.talkMaxDuration = 0
				arg_53_1.dialogCg_.alpha = 1

				arg_53_1.dialog_:SetActive(true)
				SetActive(arg_53_1.leftNameGo_, true)

				arg_53_1.leftNameTxt_.text = arg_53_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_53_1.leftNameTxt_.transform)

				arg_53_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_53_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_53_1:RecordName(arg_53_1.leftNameTxt_.text)
				SetActive(arg_53_1.iconTrs_.gameObject, false)
				arg_53_1.callingController_:SetSelectedState("normal")

				local var_56_2 = arg_53_1:FormatText(arg_53_1:GetWordFromCfg(935011013).content)

				arg_53_1.text_.text = var_56_2

				LuaForUtil.ClearLinePrefixSymbol(arg_53_1.text_)

				local var_56_4 = 51 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_2) / 51)

				if (51 <= 0 and var_56_1 or var_56_1 * (utf8.len(var_56_2) / 51)) > 0 and var_56_1 < var_56_4 then
					arg_53_1.talkMaxDuration = var_56_4

					if var_56_4 + var_56_0 > arg_53_1.duration_ then
						arg_53_1.duration_ = var_56_4 + var_56_0
					end
				end

				arg_53_1.text_.text = var_56_2
				arg_53_1.typewritter.percent = 0

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(false)
				arg_53_1:RecordContent(arg_53_1.text_.text)
			end

			local var_56_5 = math.max(var_56_1, arg_53_1.talkMaxDuration)

			if var_56_0 <= arg_53_1.time_ and arg_53_1.time_ < var_56_0 + var_56_5 then
				arg_53_1.typewritter.percent = (arg_53_1.time_ - var_56_0) / var_56_5

				arg_53_1.typewritter:SetDirty()
			end

			if arg_53_1.time_ >= var_56_0 + var_56_5 and arg_53_1.time_ < var_56_0 + var_56_5 + arg_56_0 then
				arg_53_1.typewritter.percent = 1

				arg_53_1.typewritter:SetDirty()
				arg_53_1:ShowNextGo(true)
			end
		end

		arg_53_1.nodeConfigList_ = {}

		arg_53_1:InitPlayNodeList()
	end,
	Play935011014 = function(arg_57_0, arg_57_1)
		arg_57_1.time_ = 0
		arg_57_1.frameCnt_ = 0
		arg_57_1.state_ = "playing"
		arg_57_1.curTalkId_ = 935011014
		arg_57_1.duration_ = 5

		SetActive(arg_57_1.tipsGo_, false)

		function arg_57_1.onSingleLineFinish_()
			arg_57_1.onSingleLineUpdate_ = nil
			arg_57_1.onSingleLineFinish_ = nil
			arg_57_1.state_ = "waiting"
		end

		function arg_57_1.playNext_(arg_59_0)
			if arg_59_0 == 1 then
				arg_57_0:Play935011015(arg_57_1)
			end
		end

		function arg_57_1.onSingleLineUpdate_(arg_60_0)
			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(arg_57_1.actors_["10039ui_story"]) and arg_57_1.var_.characterEffect10039ui_story == nil then
				arg_57_1.var_.characterEffect10039ui_story = arg_57_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_0 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_0 and not isNil(arg_57_1.actors_["10039ui_story"]) then
				if arg_57_1.var_.characterEffect10039ui_story and not isNil(arg_57_1.actors_["10039ui_story"]) then
					arg_57_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_57_1.time_ >= 0 + var_60_0 and arg_57_1.time_ < 0 + var_60_0 + arg_60_0 and not isNil(arg_57_1.actors_["10039ui_story"]) and arg_57_1.var_.characterEffect10039ui_story then
				arg_57_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_60_2 = arg_57_1.actors_["1070ui_story"]

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1070ui_story == nil then
				arg_57_1.var_.characterEffect1070ui_story = var_60_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_60_3 = 0.200000002980232

			if 0 <= arg_57_1.time_ and arg_57_1.time_ < 0 + var_60_3 and not isNil(var_60_2) then
				if arg_57_1.var_.characterEffect1070ui_story and not isNil(var_60_2) then
					arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_57_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_57_1.time_ - 0) / var_60_3)
				end
			end

			if arg_57_1.time_ >= 0 + var_60_3 and arg_57_1.time_ < 0 + var_60_3 + arg_60_0 and not isNil(var_60_2) and arg_57_1.var_.characterEffect1070ui_story then
				arg_57_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_57_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action456")
			end

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= 0 + arg_60_0 then
				arg_57_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_60_4 = 0
			local var_60_5 = 0.075

			if 0 < arg_57_1.time_ and arg_57_1.time_ <= var_60_4 + arg_60_0 then
				arg_57_1.talkMaxDuration = 0
				arg_57_1.dialogCg_.alpha = 1

				arg_57_1.dialog_:SetActive(true)
				SetActive(arg_57_1.leftNameGo_, true)

				arg_57_1.leftNameTxt_.text = arg_57_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_57_1.leftNameTxt_.transform)

				arg_57_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_57_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_57_1:RecordName(arg_57_1.leftNameTxt_.text)
				SetActive(arg_57_1.iconTrs_.gameObject, false)
				arg_57_1.callingController_:SetSelectedState("normal")

				local var_60_6 = arg_57_1:FormatText(arg_57_1:GetWordFromCfg(935011014).content)

				arg_57_1.text_.text = var_60_6

				LuaForUtil.ClearLinePrefixSymbol(arg_57_1.text_)

				local var_60_8 = 3 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_6) / 3)

				if (3 <= 0 and var_60_5 or var_60_5 * (utf8.len(var_60_6) / 3)) > 0 and var_60_5 < var_60_8 then
					arg_57_1.talkMaxDuration = var_60_8

					if var_60_8 + var_60_4 > arg_57_1.duration_ then
						arg_57_1.duration_ = var_60_8 + var_60_4
					end
				end

				arg_57_1.text_.text = var_60_6
				arg_57_1.typewritter.percent = 0

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(false)
				arg_57_1:RecordContent(arg_57_1.text_.text)
			end

			local var_60_9 = math.max(var_60_5, arg_57_1.talkMaxDuration)

			if var_60_4 <= arg_57_1.time_ and arg_57_1.time_ < var_60_4 + var_60_9 then
				arg_57_1.typewritter.percent = (arg_57_1.time_ - var_60_4) / var_60_9

				arg_57_1.typewritter:SetDirty()
			end

			if arg_57_1.time_ >= var_60_4 + var_60_9 and arg_57_1.time_ < var_60_4 + var_60_9 + arg_60_0 then
				arg_57_1.typewritter.percent = 1

				arg_57_1.typewritter:SetDirty()
				arg_57_1:ShowNextGo(true)
			end
		end

		arg_57_1.nodeConfigList_ = {}

		arg_57_1:InitPlayNodeList()
	end,
	Play935011015 = function(arg_61_0, arg_61_1)
		arg_61_1.time_ = 0
		arg_61_1.frameCnt_ = 0
		arg_61_1.state_ = "playing"
		arg_61_1.curTalkId_ = 935011015
		arg_61_1.duration_ = 5

		SetActive(arg_61_1.tipsGo_, false)

		function arg_61_1.onSingleLineFinish_()
			arg_61_1.onSingleLineUpdate_ = nil
			arg_61_1.onSingleLineFinish_ = nil
			arg_61_1.state_ = "waiting"
		end

		function arg_61_1.playNext_(arg_63_0)
			if arg_63_0 == 1 then
				arg_61_0:Play935011016(arg_61_1)
			end
		end

		function arg_61_1.onSingleLineUpdate_(arg_64_0)
			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(arg_61_1.actors_["1070ui_story"]) and arg_61_1.var_.characterEffect1070ui_story == nil then
				arg_61_1.var_.characterEffect1070ui_story = arg_61_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_0 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_0 and not isNil(arg_61_1.actors_["1070ui_story"]) then
				if arg_61_1.var_.characterEffect1070ui_story and not isNil(arg_61_1.actors_["1070ui_story"]) then
					arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_61_1.time_ >= 0 + var_64_0 and arg_61_1.time_ < 0 + var_64_0 + arg_64_0 and not isNil(arg_61_1.actors_["1070ui_story"]) and arg_61_1.var_.characterEffect1070ui_story then
				arg_61_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_64_2 = arg_61_1.actors_["10039ui_story"]

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect10039ui_story == nil then
				arg_61_1.var_.characterEffect10039ui_story = var_64_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_64_3 = 0.200000002980232

			if 0 <= arg_61_1.time_ and arg_61_1.time_ < 0 + var_64_3 and not isNil(var_64_2) then
				if arg_61_1.var_.characterEffect10039ui_story and not isNil(var_64_2) then
					arg_61_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_61_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_61_1.time_ - 0) / var_64_3)
				end
			end

			if arg_61_1.time_ >= 0 + var_64_3 and arg_61_1.time_ < 0 + var_64_3 + arg_64_0 and not isNil(var_64_2) and arg_61_1.var_.characterEffect10039ui_story then
				arg_61_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_61_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= 0 + arg_64_0 then
				arg_61_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_64_4 = 0
			local var_64_5 = 0.125

			if 0 < arg_61_1.time_ and arg_61_1.time_ <= var_64_4 + arg_64_0 then
				arg_61_1.talkMaxDuration = 0
				arg_61_1.dialogCg_.alpha = 1

				arg_61_1.dialog_:SetActive(true)
				SetActive(arg_61_1.leftNameGo_, true)

				arg_61_1.leftNameTxt_.text = arg_61_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_61_1.leftNameTxt_.transform)

				arg_61_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_61_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_61_1:RecordName(arg_61_1.leftNameTxt_.text)
				SetActive(arg_61_1.iconTrs_.gameObject, false)
				arg_61_1.callingController_:SetSelectedState("normal")

				local var_64_6 = arg_61_1:FormatText(arg_61_1:GetWordFromCfg(935011015).content)

				arg_61_1.text_.text = var_64_6

				LuaForUtil.ClearLinePrefixSymbol(arg_61_1.text_)

				local var_64_8 = 5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_6) / 5)

				if (5 <= 0 and var_64_5 or var_64_5 * (utf8.len(var_64_6) / 5)) > 0 and var_64_5 < var_64_8 then
					arg_61_1.talkMaxDuration = var_64_8

					if var_64_8 + var_64_4 > arg_61_1.duration_ then
						arg_61_1.duration_ = var_64_8 + var_64_4
					end
				end

				arg_61_1.text_.text = var_64_6
				arg_61_1.typewritter.percent = 0

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(false)
				arg_61_1:RecordContent(arg_61_1.text_.text)
			end

			local var_64_9 = math.max(var_64_5, arg_61_1.talkMaxDuration)

			if var_64_4 <= arg_61_1.time_ and arg_61_1.time_ < var_64_4 + var_64_9 then
				arg_61_1.typewritter.percent = (arg_61_1.time_ - var_64_4) / var_64_9

				arg_61_1.typewritter:SetDirty()
			end

			if arg_61_1.time_ >= var_64_4 + var_64_9 and arg_61_1.time_ < var_64_4 + var_64_9 + arg_64_0 then
				arg_61_1.typewritter.percent = 1

				arg_61_1.typewritter:SetDirty()
				arg_61_1:ShowNextGo(true)
			end
		end

		arg_61_1.nodeConfigList_ = {}

		arg_61_1:InitPlayNodeList()
	end,
	Play935011016 = function(arg_65_0, arg_65_1)
		arg_65_1.time_ = 0
		arg_65_1.frameCnt_ = 0
		arg_65_1.state_ = "playing"
		arg_65_1.curTalkId_ = 935011016
		arg_65_1.duration_ = 5

		SetActive(arg_65_1.tipsGo_, false)

		function arg_65_1.onSingleLineFinish_()
			arg_65_1.onSingleLineUpdate_ = nil
			arg_65_1.onSingleLineFinish_ = nil
			arg_65_1.state_ = "waiting"
		end

		function arg_65_1.playNext_(arg_67_0)
			if arg_67_0 == 1 then
				arg_65_0:Play935011017(arg_65_1)
			end
		end

		function arg_65_1.onSingleLineUpdate_(arg_68_0)
			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(arg_65_1.actors_["10039ui_story"]) and arg_65_1.var_.characterEffect10039ui_story == nil then
				arg_65_1.var_.characterEffect10039ui_story = arg_65_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_0 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_0 and not isNil(arg_65_1.actors_["10039ui_story"]) then
				if arg_65_1.var_.characterEffect10039ui_story and not isNil(arg_65_1.actors_["10039ui_story"]) then
					arg_65_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_65_1.time_ >= 0 + var_68_0 and arg_65_1.time_ < 0 + var_68_0 + arg_68_0 and not isNil(arg_65_1.actors_["10039ui_story"]) and arg_65_1.var_.characterEffect10039ui_story then
				arg_65_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_68_2 = arg_65_1.actors_["1070ui_story"]

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1070ui_story == nil then
				arg_65_1.var_.characterEffect1070ui_story = var_68_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_68_3 = 0.200000002980232

			if 0 <= arg_65_1.time_ and arg_65_1.time_ < 0 + var_68_3 and not isNil(var_68_2) then
				if arg_65_1.var_.characterEffect1070ui_story and not isNil(var_68_2) then
					arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_65_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_65_1.time_ - 0) / var_68_3)
				end
			end

			if arg_65_1.time_ >= 0 + var_68_3 and arg_65_1.time_ < 0 + var_68_3 + arg_68_0 and not isNil(var_68_2) and arg_65_1.var_.characterEffect1070ui_story then
				arg_65_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_65_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= 0 + arg_68_0 then
				arg_65_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_68_4 = 0
			local var_68_5 = 0.625

			if 0 < arg_65_1.time_ and arg_65_1.time_ <= var_68_4 + arg_68_0 then
				arg_65_1.talkMaxDuration = 0
				arg_65_1.dialogCg_.alpha = 1

				arg_65_1.dialog_:SetActive(true)
				SetActive(arg_65_1.leftNameGo_, true)

				arg_65_1.leftNameTxt_.text = arg_65_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_65_1.leftNameTxt_.transform)

				arg_65_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_65_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_65_1:RecordName(arg_65_1.leftNameTxt_.text)
				SetActive(arg_65_1.iconTrs_.gameObject, false)
				arg_65_1.callingController_:SetSelectedState("normal")

				local var_68_6 = arg_65_1:FormatText(arg_65_1:GetWordFromCfg(935011016).content)

				arg_65_1.text_.text = var_68_6

				LuaForUtil.ClearLinePrefixSymbol(arg_65_1.text_)

				local var_68_8 = 25 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 25)

				if (25 <= 0 and var_68_5 or var_68_5 * (utf8.len(var_68_6) / 25)) > 0 and var_68_5 < var_68_8 then
					arg_65_1.talkMaxDuration = var_68_8

					if var_68_8 + var_68_4 > arg_65_1.duration_ then
						arg_65_1.duration_ = var_68_8 + var_68_4
					end
				end

				arg_65_1.text_.text = var_68_6
				arg_65_1.typewritter.percent = 0

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(false)
				arg_65_1:RecordContent(arg_65_1.text_.text)
			end

			local var_68_9 = math.max(var_68_5, arg_65_1.talkMaxDuration)

			if var_68_4 <= arg_65_1.time_ and arg_65_1.time_ < var_68_4 + var_68_9 then
				arg_65_1.typewritter.percent = (arg_65_1.time_ - var_68_4) / var_68_9

				arg_65_1.typewritter:SetDirty()
			end

			if arg_65_1.time_ >= var_68_4 + var_68_9 and arg_65_1.time_ < var_68_4 + var_68_9 + arg_68_0 then
				arg_65_1.typewritter.percent = 1

				arg_65_1.typewritter:SetDirty()
				arg_65_1:ShowNextGo(true)
			end
		end

		arg_65_1.nodeConfigList_ = {}

		arg_65_1:InitPlayNodeList()
	end,
	Play935011017 = function(arg_69_0, arg_69_1)
		arg_69_1.time_ = 0
		arg_69_1.frameCnt_ = 0
		arg_69_1.state_ = "playing"
		arg_69_1.curTalkId_ = 935011017
		arg_69_1.duration_ = 5

		SetActive(arg_69_1.tipsGo_, false)

		function arg_69_1.onSingleLineFinish_()
			arg_69_1.onSingleLineUpdate_ = nil
			arg_69_1.onSingleLineFinish_ = nil
			arg_69_1.state_ = "waiting"
		end

		function arg_69_1.playNext_(arg_71_0)
			if arg_71_0 == 1 then
				arg_69_0:Play935011018(arg_69_1)
			end
		end

		function arg_69_1.onSingleLineUpdate_(arg_72_0)
			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(arg_69_1.actors_["1070ui_story"]) and arg_69_1.var_.characterEffect1070ui_story == nil then
				arg_69_1.var_.characterEffect1070ui_story = arg_69_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_0 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_0 and not isNil(arg_69_1.actors_["1070ui_story"]) then
				if arg_69_1.var_.characterEffect1070ui_story and not isNil(arg_69_1.actors_["1070ui_story"]) then
					arg_69_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_69_1.time_ >= 0 + var_72_0 and arg_69_1.time_ < 0 + var_72_0 + arg_72_0 and not isNil(arg_69_1.actors_["1070ui_story"]) and arg_69_1.var_.characterEffect1070ui_story then
				arg_69_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_72_2 = arg_69_1.actors_["10039ui_story"]

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect10039ui_story == nil then
				arg_69_1.var_.characterEffect10039ui_story = var_72_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_72_3 = 0.200000002980232

			if 0 <= arg_69_1.time_ and arg_69_1.time_ < 0 + var_72_3 and not isNil(var_72_2) then
				if arg_69_1.var_.characterEffect10039ui_story and not isNil(var_72_2) then
					arg_69_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_69_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_69_1.time_ - 0) / var_72_3)
				end
			end

			if arg_69_1.time_ >= 0 + var_72_3 and arg_69_1.time_ < 0 + var_72_3 + arg_72_0 and not isNil(var_72_2) and arg_69_1.var_.characterEffect10039ui_story then
				arg_69_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_69_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= 0 + arg_72_0 then
				arg_69_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva", "EmotionTimelineAnimator")
			end

			local var_72_4 = 0
			local var_72_5 = 0.25

			if 0 < arg_69_1.time_ and arg_69_1.time_ <= var_72_4 + arg_72_0 then
				arg_69_1.talkMaxDuration = 0
				arg_69_1.dialogCg_.alpha = 1

				arg_69_1.dialog_:SetActive(true)
				SetActive(arg_69_1.leftNameGo_, true)

				arg_69_1.leftNameTxt_.text = arg_69_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_69_1.leftNameTxt_.transform)

				arg_69_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_69_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_69_1:RecordName(arg_69_1.leftNameTxt_.text)
				SetActive(arg_69_1.iconTrs_.gameObject, false)
				arg_69_1.callingController_:SetSelectedState("normal")

				local var_72_6 = arg_69_1:FormatText(arg_69_1:GetWordFromCfg(935011017).content)

				arg_69_1.text_.text = var_72_6

				LuaForUtil.ClearLinePrefixSymbol(arg_69_1.text_)

				local var_72_8 = 10 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_6) / 10)

				if (10 <= 0 and var_72_5 or var_72_5 * (utf8.len(var_72_6) / 10)) > 0 and var_72_5 < var_72_8 then
					arg_69_1.talkMaxDuration = var_72_8

					if var_72_8 + var_72_4 > arg_69_1.duration_ then
						arg_69_1.duration_ = var_72_8 + var_72_4
					end
				end

				arg_69_1.text_.text = var_72_6
				arg_69_1.typewritter.percent = 0

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(false)
				arg_69_1:RecordContent(arg_69_1.text_.text)
			end

			local var_72_9 = math.max(var_72_5, arg_69_1.talkMaxDuration)

			if var_72_4 <= arg_69_1.time_ and arg_69_1.time_ < var_72_4 + var_72_9 then
				arg_69_1.typewritter.percent = (arg_69_1.time_ - var_72_4) / var_72_9

				arg_69_1.typewritter:SetDirty()
			end

			if arg_69_1.time_ >= var_72_4 + var_72_9 and arg_69_1.time_ < var_72_4 + var_72_9 + arg_72_0 then
				arg_69_1.typewritter.percent = 1

				arg_69_1.typewritter:SetDirty()
				arg_69_1:ShowNextGo(true)
			end
		end

		arg_69_1.nodeConfigList_ = {}

		arg_69_1:InitPlayNodeList()
	end,
	Play935011018 = function(arg_73_0, arg_73_1)
		arg_73_1.time_ = 0
		arg_73_1.frameCnt_ = 0
		arg_73_1.state_ = "playing"
		arg_73_1.curTalkId_ = 935011018
		arg_73_1.duration_ = 5

		SetActive(arg_73_1.tipsGo_, false)

		function arg_73_1.onSingleLineFinish_()
			arg_73_1.onSingleLineUpdate_ = nil
			arg_73_1.onSingleLineFinish_ = nil
			arg_73_1.state_ = "waiting"
		end

		function arg_73_1.playNext_(arg_75_0)
			if arg_75_0 == 1 then
				arg_73_0:Play935011019(arg_73_1)
			end
		end

		function arg_73_1.onSingleLineUpdate_(arg_76_0)
			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 and not isNil(arg_73_1.actors_["1070ui_story"]) and arg_73_1.var_.characterEffect1070ui_story == nil then
				arg_73_1.var_.characterEffect1070ui_story = arg_73_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_76_0 = 0.200000002980232

			if 0 <= arg_73_1.time_ and arg_73_1.time_ < 0 + var_76_0 and not isNil(arg_73_1.actors_["1070ui_story"]) then
				if arg_73_1.var_.characterEffect1070ui_story and not isNil(arg_73_1.actors_["1070ui_story"]) then
					arg_73_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_73_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_73_1.time_ - 0) / var_76_0)
				end
			end

			if arg_73_1.time_ >= 0 + var_76_0 and arg_73_1.time_ < 0 + var_76_0 + arg_76_0 and not isNil(arg_73_1.actors_["1070ui_story"]) and arg_73_1.var_.characterEffect1070ui_story then
				arg_73_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_73_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= 0 + arg_76_0 then
				arg_73_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			local var_76_1 = 0
			local var_76_2 = 0.8

			if 0 < arg_73_1.time_ and arg_73_1.time_ <= var_76_1 + arg_76_0 then
				arg_73_1.talkMaxDuration = 0
				arg_73_1.dialogCg_.alpha = 1

				arg_73_1.dialog_:SetActive(true)
				SetActive(arg_73_1.leftNameGo_, false)

				arg_73_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_73_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_73_1:RecordName(arg_73_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_73_1.iconTrs_.gameObject, false)
				arg_73_1.callingController_:SetSelectedState("normal")

				local var_76_3 = arg_73_1:FormatText(arg_73_1:GetWordFromCfg(935011018).content)

				arg_73_1.text_.text = var_76_3

				LuaForUtil.ClearLinePrefixSymbol(arg_73_1.text_)

				local var_76_5 = 32 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 32)

				if (32 <= 0 and var_76_2 or var_76_2 * (utf8.len(var_76_3) / 32)) > 0 and var_76_2 < var_76_5 then
					arg_73_1.talkMaxDuration = var_76_5

					if var_76_5 + var_76_1 > arg_73_1.duration_ then
						arg_73_1.duration_ = var_76_5 + var_76_1
					end
				end

				arg_73_1.text_.text = var_76_3
				arg_73_1.typewritter.percent = 0

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(false)
				arg_73_1:RecordContent(arg_73_1.text_.text)
			end

			local var_76_6 = math.max(var_76_2, arg_73_1.talkMaxDuration)

			if var_76_1 <= arg_73_1.time_ and arg_73_1.time_ < var_76_1 + var_76_6 then
				arg_73_1.typewritter.percent = (arg_73_1.time_ - var_76_1) / var_76_6

				arg_73_1.typewritter:SetDirty()
			end

			if arg_73_1.time_ >= var_76_1 + var_76_6 and arg_73_1.time_ < var_76_1 + var_76_6 + arg_76_0 then
				arg_73_1.typewritter.percent = 1

				arg_73_1.typewritter:SetDirty()
				arg_73_1:ShowNextGo(true)
			end
		end

		arg_73_1.nodeConfigList_ = {}

		arg_73_1:InitPlayNodeList()
	end,
	Play935011019 = function(arg_77_0, arg_77_1)
		arg_77_1.time_ = 0
		arg_77_1.frameCnt_ = 0
		arg_77_1.state_ = "playing"
		arg_77_1.curTalkId_ = 935011019
		arg_77_1.duration_ = 5

		SetActive(arg_77_1.tipsGo_, false)

		function arg_77_1.onSingleLineFinish_()
			arg_77_1.onSingleLineUpdate_ = nil
			arg_77_1.onSingleLineFinish_ = nil
			arg_77_1.state_ = "waiting"
		end

		function arg_77_1.playNext_(arg_79_0)
			if arg_79_0 == 1 then
				arg_77_0:Play935011020(arg_77_1)
			end
		end

		function arg_77_1.onSingleLineUpdate_(arg_80_0)
			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 and not isNil(arg_77_1.actors_["1070ui_story"]) and arg_77_1.var_.characterEffect1070ui_story == nil then
				arg_77_1.var_.characterEffect1070ui_story = arg_77_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_80_0 = 0.200000002980232

			if 0 <= arg_77_1.time_ and arg_77_1.time_ < 0 + var_80_0 and not isNil(arg_77_1.actors_["1070ui_story"]) then
				if arg_77_1.var_.characterEffect1070ui_story and not isNil(arg_77_1.actors_["1070ui_story"]) then
					arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_77_1.time_ >= 0 + var_80_0 and arg_77_1.time_ < 0 + var_80_0 + arg_80_0 and not isNil(arg_77_1.actors_["1070ui_story"]) and arg_77_1.var_.characterEffect1070ui_story then
				arg_77_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= 0 + arg_80_0 then
				arg_77_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_80_2 = 0
			local var_80_3 = 1.475

			if 0 < arg_77_1.time_ and arg_77_1.time_ <= var_80_2 + arg_80_0 then
				arg_77_1.talkMaxDuration = 0
				arg_77_1.dialogCg_.alpha = 1

				arg_77_1.dialog_:SetActive(true)
				SetActive(arg_77_1.leftNameGo_, true)

				arg_77_1.leftNameTxt_.text = arg_77_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_77_1.leftNameTxt_.transform)

				arg_77_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_77_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_77_1:RecordName(arg_77_1.leftNameTxt_.text)
				SetActive(arg_77_1.iconTrs_.gameObject, false)
				arg_77_1.callingController_:SetSelectedState("normal")

				local var_80_4 = arg_77_1:FormatText(arg_77_1:GetWordFromCfg(935011019).content)

				arg_77_1.text_.text = var_80_4

				LuaForUtil.ClearLinePrefixSymbol(arg_77_1.text_)

				local var_80_6 = 59 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 59)

				if (59 <= 0 and var_80_3 or var_80_3 * (utf8.len(var_80_4) / 59)) > 0 and var_80_3 < var_80_6 then
					arg_77_1.talkMaxDuration = var_80_6

					if var_80_6 + var_80_2 > arg_77_1.duration_ then
						arg_77_1.duration_ = var_80_6 + var_80_2
					end
				end

				arg_77_1.text_.text = var_80_4
				arg_77_1.typewritter.percent = 0

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(false)
				arg_77_1:RecordContent(arg_77_1.text_.text)
			end

			local var_80_7 = math.max(var_80_3, arg_77_1.talkMaxDuration)

			if var_80_2 <= arg_77_1.time_ and arg_77_1.time_ < var_80_2 + var_80_7 then
				arg_77_1.typewritter.percent = (arg_77_1.time_ - var_80_2) / var_80_7

				arg_77_1.typewritter:SetDirty()
			end

			if arg_77_1.time_ >= var_80_2 + var_80_7 and arg_77_1.time_ < var_80_2 + var_80_7 + arg_80_0 then
				arg_77_1.typewritter.percent = 1

				arg_77_1.typewritter:SetDirty()
				arg_77_1:ShowNextGo(true)
			end
		end

		arg_77_1.nodeConfigList_ = {}

		arg_77_1:InitPlayNodeList()
	end,
	Play935011020 = function(arg_81_0, arg_81_1)
		arg_81_1.time_ = 0
		arg_81_1.frameCnt_ = 0
		arg_81_1.state_ = "playing"
		arg_81_1.curTalkId_ = 935011020
		arg_81_1.duration_ = 5

		SetActive(arg_81_1.tipsGo_, false)

		function arg_81_1.onSingleLineFinish_()
			arg_81_1.onSingleLineUpdate_ = nil
			arg_81_1.onSingleLineFinish_ = nil
			arg_81_1.state_ = "waiting"
		end

		function arg_81_1.playNext_(arg_83_0)
			if arg_83_0 == 1 then
				arg_81_0:Play935011021(arg_81_1)
			end
		end

		function arg_81_1.onSingleLineUpdate_(arg_84_0)
			if 0 < arg_81_1.time_ and arg_81_1.time_ <= 0 + arg_84_0 then
				arg_81_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			local var_84_0 = 0
			local var_84_1 = 0.625

			if 0 < arg_81_1.time_ and arg_81_1.time_ <= var_84_0 + arg_84_0 then
				arg_81_1.talkMaxDuration = 0
				arg_81_1.dialogCg_.alpha = 1

				arg_81_1.dialog_:SetActive(true)
				SetActive(arg_81_1.leftNameGo_, true)

				arg_81_1.leftNameTxt_.text = arg_81_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_81_1.leftNameTxt_.transform)

				arg_81_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_81_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_81_1:RecordName(arg_81_1.leftNameTxt_.text)
				SetActive(arg_81_1.iconTrs_.gameObject, false)
				arg_81_1.callingController_:SetSelectedState("normal")

				local var_84_2 = arg_81_1:FormatText(arg_81_1:GetWordFromCfg(935011020).content)

				arg_81_1.text_.text = var_84_2

				LuaForUtil.ClearLinePrefixSymbol(arg_81_1.text_)

				local var_84_4 = 25 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_2) / 25)

				if (25 <= 0 and var_84_1 or var_84_1 * (utf8.len(var_84_2) / 25)) > 0 and var_84_1 < var_84_4 then
					arg_81_1.talkMaxDuration = var_84_4

					if var_84_4 + var_84_0 > arg_81_1.duration_ then
						arg_81_1.duration_ = var_84_4 + var_84_0
					end
				end

				arg_81_1.text_.text = var_84_2
				arg_81_1.typewritter.percent = 0

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(false)
				arg_81_1:RecordContent(arg_81_1.text_.text)
			end

			local var_84_5 = math.max(var_84_1, arg_81_1.talkMaxDuration)

			if var_84_0 <= arg_81_1.time_ and arg_81_1.time_ < var_84_0 + var_84_5 then
				arg_81_1.typewritter.percent = (arg_81_1.time_ - var_84_0) / var_84_5

				arg_81_1.typewritter:SetDirty()
			end

			if arg_81_1.time_ >= var_84_0 + var_84_5 and arg_81_1.time_ < var_84_0 + var_84_5 + arg_84_0 then
				arg_81_1.typewritter.percent = 1

				arg_81_1.typewritter:SetDirty()
				arg_81_1:ShowNextGo(true)
			end
		end

		arg_81_1.nodeConfigList_ = {}

		arg_81_1:InitPlayNodeList()
	end,
	Play935011021 = function(arg_85_0, arg_85_1)
		arg_85_1.time_ = 0
		arg_85_1.frameCnt_ = 0
		arg_85_1.state_ = "playing"
		arg_85_1.curTalkId_ = 935011021
		arg_85_1.duration_ = 5

		SetActive(arg_85_1.tipsGo_, false)

		function arg_85_1.onSingleLineFinish_()
			arg_85_1.onSingleLineUpdate_ = nil
			arg_85_1.onSingleLineFinish_ = nil
			arg_85_1.state_ = "waiting"
		end

		function arg_85_1.playNext_(arg_87_0)
			if arg_87_0 == 1 then
				arg_85_0:Play935011022(arg_85_1)
			end
		end

		function arg_85_1.onSingleLineUpdate_(arg_88_0)
			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= 0 + arg_88_0 then
				arg_85_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva", "EmotionTimelineAnimator")
			end

			local var_88_0 = 0
			local var_88_1 = 1.425

			if 0 < arg_85_1.time_ and arg_85_1.time_ <= var_88_0 + arg_88_0 then
				arg_85_1.talkMaxDuration = 0
				arg_85_1.dialogCg_.alpha = 1

				arg_85_1.dialog_:SetActive(true)
				SetActive(arg_85_1.leftNameGo_, true)

				arg_85_1.leftNameTxt_.text = arg_85_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_85_1.leftNameTxt_.transform)

				arg_85_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_85_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_85_1:RecordName(arg_85_1.leftNameTxt_.text)
				SetActive(arg_85_1.iconTrs_.gameObject, false)
				arg_85_1.callingController_:SetSelectedState("normal")

				local var_88_2 = arg_85_1:FormatText(arg_85_1:GetWordFromCfg(935011021).content)

				arg_85_1.text_.text = var_88_2

				LuaForUtil.ClearLinePrefixSymbol(arg_85_1.text_)

				local var_88_4 = 57 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_2) / 57)

				if (57 <= 0 and var_88_1 or var_88_1 * (utf8.len(var_88_2) / 57)) > 0 and var_88_1 < var_88_4 then
					arg_85_1.talkMaxDuration = var_88_4

					if var_88_4 + var_88_0 > arg_85_1.duration_ then
						arg_85_1.duration_ = var_88_4 + var_88_0
					end
				end

				arg_85_1.text_.text = var_88_2
				arg_85_1.typewritter.percent = 0

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(false)
				arg_85_1:RecordContent(arg_85_1.text_.text)
			end

			local var_88_5 = math.max(var_88_1, arg_85_1.talkMaxDuration)

			if var_88_0 <= arg_85_1.time_ and arg_85_1.time_ < var_88_0 + var_88_5 then
				arg_85_1.typewritter.percent = (arg_85_1.time_ - var_88_0) / var_88_5

				arg_85_1.typewritter:SetDirty()
			end

			if arg_85_1.time_ >= var_88_0 + var_88_5 and arg_85_1.time_ < var_88_0 + var_88_5 + arg_88_0 then
				arg_85_1.typewritter.percent = 1

				arg_85_1.typewritter:SetDirty()
				arg_85_1:ShowNextGo(true)
			end
		end

		arg_85_1.nodeConfigList_ = {}

		arg_85_1:InitPlayNodeList()
	end,
	Play935011022 = function(arg_89_0, arg_89_1)
		arg_89_1.time_ = 0
		arg_89_1.frameCnt_ = 0
		arg_89_1.state_ = "playing"
		arg_89_1.curTalkId_ = 935011022
		arg_89_1.duration_ = 5

		SetActive(arg_89_1.tipsGo_, false)

		function arg_89_1.onSingleLineFinish_()
			arg_89_1.onSingleLineUpdate_ = nil
			arg_89_1.onSingleLineFinish_ = nil
			arg_89_1.state_ = "waiting"
		end

		function arg_89_1.playNext_(arg_91_0)
			if arg_91_0 == 1 then
				arg_89_0:Play935011023(arg_89_1)
			end
		end

		function arg_89_1.onSingleLineUpdate_(arg_92_0)
			if 0 < arg_89_1.time_ and arg_89_1.time_ <= 0 + arg_92_0 and not isNil(arg_89_1.actors_["1070ui_story"]) and arg_89_1.var_.characterEffect1070ui_story == nil then
				arg_89_1.var_.characterEffect1070ui_story = arg_89_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_92_0 = 0.200000002980232

			if 0 <= arg_89_1.time_ and arg_89_1.time_ < 0 + var_92_0 and not isNil(arg_89_1.actors_["1070ui_story"]) then
				if arg_89_1.var_.characterEffect1070ui_story and not isNil(arg_89_1.actors_["1070ui_story"]) then
					arg_89_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_89_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_89_1.time_ - 0) / var_92_0)
				end
			end

			if arg_89_1.time_ >= 0 + var_92_0 and arg_89_1.time_ < 0 + var_92_0 + arg_92_0 and not isNil(arg_89_1.actors_["1070ui_story"]) and arg_89_1.var_.characterEffect1070ui_story then
				arg_89_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_89_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_92_1 = 0
			local var_92_2 = 1.15

			if 0 < arg_89_1.time_ and arg_89_1.time_ <= var_92_1 + arg_92_0 then
				arg_89_1.talkMaxDuration = 0
				arg_89_1.dialogCg_.alpha = 1

				arg_89_1.dialog_:SetActive(true)
				SetActive(arg_89_1.leftNameGo_, false)

				arg_89_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_89_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_89_1:RecordName(arg_89_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_89_1.iconTrs_.gameObject, false)
				arg_89_1.callingController_:SetSelectedState("normal")

				local var_92_3 = arg_89_1:FormatText(arg_89_1:GetWordFromCfg(935011022).content)

				arg_89_1.text_.text = var_92_3

				LuaForUtil.ClearLinePrefixSymbol(arg_89_1.text_)

				local var_92_5 = 46 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 46)

				if (46 <= 0 and var_92_2 or var_92_2 * (utf8.len(var_92_3) / 46)) > 0 and var_92_2 < var_92_5 then
					arg_89_1.talkMaxDuration = var_92_5

					if var_92_5 + var_92_1 > arg_89_1.duration_ then
						arg_89_1.duration_ = var_92_5 + var_92_1
					end
				end

				arg_89_1.text_.text = var_92_3
				arg_89_1.typewritter.percent = 0

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(false)
				arg_89_1:RecordContent(arg_89_1.text_.text)
			end

			local var_92_6 = math.max(var_92_2, arg_89_1.talkMaxDuration)

			if var_92_1 <= arg_89_1.time_ and arg_89_1.time_ < var_92_1 + var_92_6 then
				arg_89_1.typewritter.percent = (arg_89_1.time_ - var_92_1) / var_92_6

				arg_89_1.typewritter:SetDirty()
			end

			if arg_89_1.time_ >= var_92_1 + var_92_6 and arg_89_1.time_ < var_92_1 + var_92_6 + arg_92_0 then
				arg_89_1.typewritter.percent = 1

				arg_89_1.typewritter:SetDirty()
				arg_89_1:ShowNextGo(true)
			end
		end

		arg_89_1.nodeConfigList_ = {}

		arg_89_1:InitPlayNodeList()
	end,
	Play935011023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 935011023
		arg_93_1.duration_ = 5

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play935011024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = 1.4

			if 0 < arg_93_1.time_ and arg_93_1.time_ <= 0 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, false)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_93_1.iconTrs_.gameObject, false)
				arg_93_1.callingController_:SetSelectedState("normal")

				local var_96_1 = arg_93_1:FormatText(arg_93_1:GetWordFromCfg(935011023).content)

				arg_93_1.text_.text = var_96_1

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_3 = 56 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 56)

				if (56 <= 0 and var_96_0 or var_96_0 * (utf8.len(var_96_1) / 56)) > 0 and var_96_0 < var_96_3 then
					arg_93_1.talkMaxDuration = var_96_3

					if var_96_3 + 0 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_3 + 0
					end
				end

				arg_93_1.text_.text = var_96_1
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)
				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_4 = math.max(var_96_0, arg_93_1.talkMaxDuration)

			if 0 <= arg_93_1.time_ and arg_93_1.time_ < 0 + var_96_4 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - 0) / var_96_4

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= 0 + var_96_4 and arg_93_1.time_ < 0 + var_96_4 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end

		arg_93_1.nodeConfigList_ = {}

		arg_93_1:InitPlayNodeList()
	end,
	Play935011024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 935011024
		arg_97_1.duration_ = 5

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play935011025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 and not isNil(arg_97_1.actors_["10039ui_story"]) and arg_97_1.var_.characterEffect10039ui_story == nil then
				arg_97_1.var_.characterEffect10039ui_story = arg_97_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_0 = 0.200000002980232

			if 0 <= arg_97_1.time_ and arg_97_1.time_ < 0 + var_100_0 and not isNil(arg_97_1.actors_["10039ui_story"]) then
				if arg_97_1.var_.characterEffect10039ui_story and not isNil(arg_97_1.actors_["10039ui_story"]) then
					arg_97_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= 0 + var_100_0 and arg_97_1.time_ < 0 + var_100_0 + arg_100_0 and not isNil(arg_97_1.actors_["10039ui_story"]) and arg_97_1.var_.characterEffect10039ui_story then
				arg_97_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= 0 + arg_100_0 then
				arg_97_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_100_2 = 0
			local var_100_3 = 0.625

			if 0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				arg_97_1.leftNameTxt_.text = arg_97_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_4 = arg_97_1:FormatText(arg_97_1:GetWordFromCfg(935011024).content)

				arg_97_1.text_.text = var_100_4

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_6 = 25 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_4) / 25)

				if (25 <= 0 and var_100_3 or var_100_3 * (utf8.len(var_100_4) / 25)) > 0 and var_100_3 < var_100_6 then
					arg_97_1.talkMaxDuration = var_100_6

					if var_100_6 + var_100_2 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_6 + var_100_2
					end
				end

				arg_97_1.text_.text = var_100_4
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)
				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_7 = math.max(var_100_3, arg_97_1.talkMaxDuration)

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_7 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_2) / var_100_7

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_2 + var_100_7 and arg_97_1.time_ < var_100_2 + var_100_7 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end

		arg_97_1.nodeConfigList_ = {}

		arg_97_1:InitPlayNodeList()
	end,
	Play935011025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 935011025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play935011026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(arg_101_1.actors_["1070ui_story"]) and arg_101_1.var_.characterEffect1070ui_story == nil then
				arg_101_1.var_.characterEffect1070ui_story = arg_101_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_0 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_0 and not isNil(arg_101_1.actors_["1070ui_story"]) then
				if arg_101_1.var_.characterEffect1070ui_story and not isNil(arg_101_1.actors_["1070ui_story"]) then
					arg_101_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_101_1.time_ >= 0 + var_104_0 and arg_101_1.time_ < 0 + var_104_0 + arg_104_0 and not isNil(arg_101_1.actors_["1070ui_story"]) and arg_101_1.var_.characterEffect1070ui_story then
				arg_101_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_104_2 = arg_101_1.actors_["10039ui_story"]

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect10039ui_story == nil then
				arg_101_1.var_.characterEffect10039ui_story = var_104_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_3 = 0.200000002980232

			if 0 <= arg_101_1.time_ and arg_101_1.time_ < 0 + var_104_3 and not isNil(var_104_2) then
				if arg_101_1.var_.characterEffect10039ui_story and not isNil(var_104_2) then
					arg_101_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_101_1.time_ - 0) / var_104_3)
				end
			end

			if arg_101_1.time_ >= 0 + var_104_3 and arg_101_1.time_ < 0 + var_104_3 + arg_104_0 and not isNil(var_104_2) and arg_101_1.var_.characterEffect10039ui_story then
				arg_101_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= 0 + arg_104_0 then
				arg_101_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_104_4 = 0
			local var_104_5 = 0.05

			if 0 < arg_101_1.time_ and arg_101_1.time_ <= var_104_4 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, true)

				arg_101_1.leftNameTxt_.text = arg_101_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_101_1.leftNameTxt_.transform)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1.leftNameTxt_.text)
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_6 = arg_101_1:FormatText(arg_101_1:GetWordFromCfg(935011025).content)

				arg_101_1.text_.text = var_104_6

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_8 = 2 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_6) / 2)

				if (2 <= 0 and var_104_5 or var_104_5 * (utf8.len(var_104_6) / 2)) > 0 and var_104_5 < var_104_8 then
					arg_101_1.talkMaxDuration = var_104_8

					if var_104_8 + var_104_4 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_8 + var_104_4
					end
				end

				arg_101_1.text_.text = var_104_6
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_9 = math.max(var_104_5, arg_101_1.talkMaxDuration)

			if var_104_4 <= arg_101_1.time_ and arg_101_1.time_ < var_104_4 + var_104_9 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_4) / var_104_9

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_4 + var_104_9 and arg_101_1.time_ < var_104_4 + var_104_9 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end

		arg_101_1.nodeConfigList_ = {}

		arg_101_1:InitPlayNodeList()
	end,
	Play935011026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 935011026
		arg_105_1.duration_ = 5

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play935011027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			if 0 < arg_105_1.time_ and arg_105_1.time_ <= 0 + arg_108_0 and not isNil(arg_105_1.actors_["1070ui_story"]) and arg_105_1.var_.characterEffect1070ui_story == nil then
				arg_105_1.var_.characterEffect1070ui_story = arg_105_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_108_0 = 0.200000002980232

			if 0 <= arg_105_1.time_ and arg_105_1.time_ < 0 + var_108_0 and not isNil(arg_105_1.actors_["1070ui_story"]) then
				if arg_105_1.var_.characterEffect1070ui_story and not isNil(arg_105_1.actors_["1070ui_story"]) then
					arg_105_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_105_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_105_1.time_ - 0) / var_108_0)
				end
			end

			if arg_105_1.time_ >= 0 + var_108_0 and arg_105_1.time_ < 0 + var_108_0 + arg_108_0 and not isNil(arg_105_1.actors_["1070ui_story"]) and arg_105_1.var_.characterEffect1070ui_story then
				arg_105_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_105_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_108_1 = 0
			local var_108_2 = 0.8

			if 0 < arg_105_1.time_ and arg_105_1.time_ <= var_108_1 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0
				arg_105_1.dialogCg_.alpha = 1

				arg_105_1.dialog_:SetActive(true)
				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_3 = arg_105_1:FormatText(arg_105_1:GetWordFromCfg(935011026).content)

				arg_105_1.text_.text = var_108_3

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_5 = 32 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 32)

				if (32 <= 0 and var_108_2 or var_108_2 * (utf8.len(var_108_3) / 32)) > 0 and var_108_2 < var_108_5 then
					arg_105_1.talkMaxDuration = var_108_5

					if var_108_5 + var_108_1 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_5 + var_108_1
					end
				end

				arg_105_1.text_.text = var_108_3
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_6 = math.max(var_108_2, arg_105_1.talkMaxDuration)

			if var_108_1 <= arg_105_1.time_ and arg_105_1.time_ < var_108_1 + var_108_6 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_1) / var_108_6

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_1 + var_108_6 and arg_105_1.time_ < var_108_1 + var_108_6 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end

		arg_105_1.nodeConfigList_ = {}

		arg_105_1:InitPlayNodeList()
	end,
	Play935011027 = function(arg_109_0, arg_109_1)
		arg_109_1.time_ = 0
		arg_109_1.frameCnt_ = 0
		arg_109_1.state_ = "playing"
		arg_109_1.curTalkId_ = 935011027
		arg_109_1.duration_ = 5

		SetActive(arg_109_1.tipsGo_, false)

		function arg_109_1.onSingleLineFinish_()
			arg_109_1.onSingleLineUpdate_ = nil
			arg_109_1.onSingleLineFinish_ = nil
			arg_109_1.state_ = "waiting"
		end

		function arg_109_1.playNext_(arg_111_0)
			if arg_111_0 == 1 then
				arg_109_0:Play935011028(arg_109_1)
			end
		end

		function arg_109_1.onSingleLineUpdate_(arg_112_0)
			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 and not isNil(arg_109_1.actors_["10039ui_story"]) and arg_109_1.var_.characterEffect10039ui_story == nil then
				arg_109_1.var_.characterEffect10039ui_story = arg_109_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_112_0 = 0.200000002980232

			if 0 <= arg_109_1.time_ and arg_109_1.time_ < 0 + var_112_0 and not isNil(arg_109_1.actors_["10039ui_story"]) then
				if arg_109_1.var_.characterEffect10039ui_story and not isNil(arg_109_1.actors_["10039ui_story"]) then
					arg_109_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_109_1.time_ >= 0 + var_112_0 and arg_109_1.time_ < 0 + var_112_0 + arg_112_0 and not isNil(arg_109_1.actors_["10039ui_story"]) and arg_109_1.var_.characterEffect10039ui_story then
				arg_109_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_1")
			end

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= 0 + arg_112_0 then
				arg_109_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_112_2 = 0
			local var_112_3 = 0.55

			if 0 < arg_109_1.time_ and arg_109_1.time_ <= var_112_2 + arg_112_0 then
				arg_109_1.talkMaxDuration = 0
				arg_109_1.dialogCg_.alpha = 1

				arg_109_1.dialog_:SetActive(true)
				SetActive(arg_109_1.leftNameGo_, true)

				arg_109_1.leftNameTxt_.text = arg_109_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_109_1.leftNameTxt_.transform)

				arg_109_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_109_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_109_1:RecordName(arg_109_1.leftNameTxt_.text)
				SetActive(arg_109_1.iconTrs_.gameObject, false)
				arg_109_1.callingController_:SetSelectedState("normal")

				local var_112_4 = arg_109_1:FormatText(arg_109_1:GetWordFromCfg(935011027).content)

				arg_109_1.text_.text = var_112_4

				LuaForUtil.ClearLinePrefixSymbol(arg_109_1.text_)

				local var_112_6 = 22 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 22)

				if (22 <= 0 and var_112_3 or var_112_3 * (utf8.len(var_112_4) / 22)) > 0 and var_112_3 < var_112_6 then
					arg_109_1.talkMaxDuration = var_112_6

					if var_112_6 + var_112_2 > arg_109_1.duration_ then
						arg_109_1.duration_ = var_112_6 + var_112_2
					end
				end

				arg_109_1.text_.text = var_112_4
				arg_109_1.typewritter.percent = 0

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(false)
				arg_109_1:RecordContent(arg_109_1.text_.text)
			end

			local var_112_7 = math.max(var_112_3, arg_109_1.talkMaxDuration)

			if var_112_2 <= arg_109_1.time_ and arg_109_1.time_ < var_112_2 + var_112_7 then
				arg_109_1.typewritter.percent = (arg_109_1.time_ - var_112_2) / var_112_7

				arg_109_1.typewritter:SetDirty()
			end

			if arg_109_1.time_ >= var_112_2 + var_112_7 and arg_109_1.time_ < var_112_2 + var_112_7 + arg_112_0 then
				arg_109_1.typewritter.percent = 1

				arg_109_1.typewritter:SetDirty()
				arg_109_1:ShowNextGo(true)
			end
		end

		arg_109_1.nodeConfigList_ = {}

		arg_109_1:InitPlayNodeList()
	end,
	Play935011028 = function(arg_113_0, arg_113_1)
		arg_113_1.time_ = 0
		arg_113_1.frameCnt_ = 0
		arg_113_1.state_ = "playing"
		arg_113_1.curTalkId_ = 935011028
		arg_113_1.duration_ = 5

		SetActive(arg_113_1.tipsGo_, false)

		function arg_113_1.onSingleLineFinish_()
			arg_113_1.onSingleLineUpdate_ = nil
			arg_113_1.onSingleLineFinish_ = nil
			arg_113_1.state_ = "waiting"
		end

		function arg_113_1.playNext_(arg_115_0)
			if arg_115_0 == 1 then
				arg_113_0:Play935011029(arg_113_1)
			end
		end

		function arg_113_1.onSingleLineUpdate_(arg_116_0)
			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(arg_113_1.actors_["1070ui_story"]) and arg_113_1.var_.characterEffect1070ui_story == nil then
				arg_113_1.var_.characterEffect1070ui_story = arg_113_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_0 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_0 and not isNil(arg_113_1.actors_["1070ui_story"]) then
				if arg_113_1.var_.characterEffect1070ui_story and not isNil(arg_113_1.actors_["1070ui_story"]) then
					arg_113_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_113_1.time_ >= 0 + var_116_0 and arg_113_1.time_ < 0 + var_116_0 + arg_116_0 and not isNil(arg_113_1.actors_["1070ui_story"]) and arg_113_1.var_.characterEffect1070ui_story then
				arg_113_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_116_2 = arg_113_1.actors_["10039ui_story"]

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect10039ui_story == nil then
				arg_113_1.var_.characterEffect10039ui_story = var_116_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_116_3 = 0.200000002980232

			if 0 <= arg_113_1.time_ and arg_113_1.time_ < 0 + var_116_3 and not isNil(var_116_2) then
				if arg_113_1.var_.characterEffect10039ui_story and not isNil(var_116_2) then
					arg_113_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_113_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_113_1.time_ - 0) / var_116_3)
				end
			end

			if arg_113_1.time_ >= 0 + var_116_3 and arg_113_1.time_ < 0 + var_116_3 + arg_116_0 and not isNil(var_116_2) and arg_113_1.var_.characterEffect10039ui_story then
				arg_113_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_113_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= 0 + arg_116_0 then
				arg_113_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_116_4 = 0
			local var_116_5 = 0.1

			if 0 < arg_113_1.time_ and arg_113_1.time_ <= var_116_4 + arg_116_0 then
				arg_113_1.talkMaxDuration = 0
				arg_113_1.dialogCg_.alpha = 1

				arg_113_1.dialog_:SetActive(true)
				SetActive(arg_113_1.leftNameGo_, true)

				arg_113_1.leftNameTxt_.text = arg_113_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_113_1.leftNameTxt_.transform)

				arg_113_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_113_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_113_1:RecordName(arg_113_1.leftNameTxt_.text)
				SetActive(arg_113_1.iconTrs_.gameObject, false)
				arg_113_1.callingController_:SetSelectedState("normal")

				local var_116_6 = arg_113_1:FormatText(arg_113_1:GetWordFromCfg(935011028).content)

				arg_113_1.text_.text = var_116_6

				LuaForUtil.ClearLinePrefixSymbol(arg_113_1.text_)

				local var_116_8 = 4 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_6) / 4)

				if (4 <= 0 and var_116_5 or var_116_5 * (utf8.len(var_116_6) / 4)) > 0 and var_116_5 < var_116_8 then
					arg_113_1.talkMaxDuration = var_116_8

					if var_116_8 + var_116_4 > arg_113_1.duration_ then
						arg_113_1.duration_ = var_116_8 + var_116_4
					end
				end

				arg_113_1.text_.text = var_116_6
				arg_113_1.typewritter.percent = 0

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(false)
				arg_113_1:RecordContent(arg_113_1.text_.text)
			end

			local var_116_9 = math.max(var_116_5, arg_113_1.talkMaxDuration)

			if var_116_4 <= arg_113_1.time_ and arg_113_1.time_ < var_116_4 + var_116_9 then
				arg_113_1.typewritter.percent = (arg_113_1.time_ - var_116_4) / var_116_9

				arg_113_1.typewritter:SetDirty()
			end

			if arg_113_1.time_ >= var_116_4 + var_116_9 and arg_113_1.time_ < var_116_4 + var_116_9 + arg_116_0 then
				arg_113_1.typewritter.percent = 1

				arg_113_1.typewritter:SetDirty()
				arg_113_1:ShowNextGo(true)
			end
		end

		arg_113_1.nodeConfigList_ = {}

		arg_113_1:InitPlayNodeList()
	end,
	Play935011029 = function(arg_117_0, arg_117_1)
		arg_117_1.time_ = 0
		arg_117_1.frameCnt_ = 0
		arg_117_1.state_ = "playing"
		arg_117_1.curTalkId_ = 935011029
		arg_117_1.duration_ = 5

		SetActive(arg_117_1.tipsGo_, false)

		function arg_117_1.onSingleLineFinish_()
			arg_117_1.onSingleLineUpdate_ = nil
			arg_117_1.onSingleLineFinish_ = nil
			arg_117_1.state_ = "waiting"
		end

		function arg_117_1.playNext_(arg_119_0)
			if arg_119_0 == 1 then
				arg_117_0:Play935011030(arg_117_1)
			end
		end

		function arg_117_1.onSingleLineUpdate_(arg_120_0)
			if 0 < arg_117_1.time_ and arg_117_1.time_ <= 0 + arg_120_0 and not isNil(arg_117_1.actors_["1070ui_story"]) and arg_117_1.var_.characterEffect1070ui_story == nil then
				arg_117_1.var_.characterEffect1070ui_story = arg_117_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_120_0 = 0.200000002980232

			if 0 <= arg_117_1.time_ and arg_117_1.time_ < 0 + var_120_0 and not isNil(arg_117_1.actors_["1070ui_story"]) then
				if arg_117_1.var_.characterEffect1070ui_story and not isNil(arg_117_1.actors_["1070ui_story"]) then
					arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_117_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_117_1.time_ - 0) / var_120_0)
				end
			end

			if arg_117_1.time_ >= 0 + var_120_0 and arg_117_1.time_ < 0 + var_120_0 + arg_120_0 and not isNil(arg_117_1.actors_["1070ui_story"]) and arg_117_1.var_.characterEffect1070ui_story then
				arg_117_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_117_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_120_1 = 0
			local var_120_2 = 0.575

			if 0 < arg_117_1.time_ and arg_117_1.time_ <= var_120_1 + arg_120_0 then
				arg_117_1.talkMaxDuration = 0
				arg_117_1.dialogCg_.alpha = 1

				arg_117_1.dialog_:SetActive(true)
				SetActive(arg_117_1.leftNameGo_, false)

				arg_117_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_117_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_117_1:RecordName(arg_117_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_117_1.iconTrs_.gameObject, false)
				arg_117_1.callingController_:SetSelectedState("normal")

				local var_120_3 = arg_117_1:FormatText(arg_117_1:GetWordFromCfg(935011029).content)

				arg_117_1.text_.text = var_120_3

				LuaForUtil.ClearLinePrefixSymbol(arg_117_1.text_)

				local var_120_5 = 23 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 23)

				if (23 <= 0 and var_120_2 or var_120_2 * (utf8.len(var_120_3) / 23)) > 0 and var_120_2 < var_120_5 then
					arg_117_1.talkMaxDuration = var_120_5

					if var_120_5 + var_120_1 > arg_117_1.duration_ then
						arg_117_1.duration_ = var_120_5 + var_120_1
					end
				end

				arg_117_1.text_.text = var_120_3
				arg_117_1.typewritter.percent = 0

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(false)
				arg_117_1:RecordContent(arg_117_1.text_.text)
			end

			local var_120_6 = math.max(var_120_2, arg_117_1.talkMaxDuration)

			if var_120_1 <= arg_117_1.time_ and arg_117_1.time_ < var_120_1 + var_120_6 then
				arg_117_1.typewritter.percent = (arg_117_1.time_ - var_120_1) / var_120_6

				arg_117_1.typewritter:SetDirty()
			end

			if arg_117_1.time_ >= var_120_1 + var_120_6 and arg_117_1.time_ < var_120_1 + var_120_6 + arg_120_0 then
				arg_117_1.typewritter.percent = 1

				arg_117_1.typewritter:SetDirty()
				arg_117_1:ShowNextGo(true)
			end
		end

		arg_117_1.nodeConfigList_ = {}

		arg_117_1:InitPlayNodeList()
	end,
	Play935011030 = function(arg_121_0, arg_121_1)
		arg_121_1.time_ = 0
		arg_121_1.frameCnt_ = 0
		arg_121_1.state_ = "playing"
		arg_121_1.curTalkId_ = 935011030
		arg_121_1.duration_ = 5

		SetActive(arg_121_1.tipsGo_, false)

		function arg_121_1.onSingleLineFinish_()
			arg_121_1.onSingleLineUpdate_ = nil
			arg_121_1.onSingleLineFinish_ = nil
			arg_121_1.state_ = "waiting"
		end

		function arg_121_1.playNext_(arg_123_0)
			if arg_123_0 == 1 then
				arg_121_0:Play935011031(arg_121_1)
			end
		end

		function arg_121_1.onSingleLineUpdate_(arg_124_0)
			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 and not isNil(arg_121_1.actors_["1070ui_story"]) and arg_121_1.var_.characterEffect1070ui_story == nil then
				arg_121_1.var_.characterEffect1070ui_story = arg_121_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_124_0 = 0.200000002980232

			if 0 <= arg_121_1.time_ and arg_121_1.time_ < 0 + var_124_0 and not isNil(arg_121_1.actors_["1070ui_story"]) then
				if arg_121_1.var_.characterEffect1070ui_story and not isNil(arg_121_1.actors_["1070ui_story"]) then
					arg_121_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_121_1.time_ >= 0 + var_124_0 and arg_121_1.time_ < 0 + var_124_0 + arg_124_0 and not isNil(arg_121_1.actors_["1070ui_story"]) and arg_121_1.var_.characterEffect1070ui_story then
				arg_121_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= 0 + arg_124_0 then
				arg_121_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_124_2 = 0
			local var_124_3 = 0.125

			if 0 < arg_121_1.time_ and arg_121_1.time_ <= var_124_2 + arg_124_0 then
				arg_121_1.talkMaxDuration = 0
				arg_121_1.dialogCg_.alpha = 1

				arg_121_1.dialog_:SetActive(true)
				SetActive(arg_121_1.leftNameGo_, true)

				arg_121_1.leftNameTxt_.text = arg_121_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_121_1.leftNameTxt_.transform)

				arg_121_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_121_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_121_1:RecordName(arg_121_1.leftNameTxt_.text)
				SetActive(arg_121_1.iconTrs_.gameObject, false)
				arg_121_1.callingController_:SetSelectedState("normal")

				local var_124_4 = arg_121_1:FormatText(arg_121_1:GetWordFromCfg(935011030).content)

				arg_121_1.text_.text = var_124_4

				LuaForUtil.ClearLinePrefixSymbol(arg_121_1.text_)

				local var_124_6 = 5 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 5)

				if (5 <= 0 and var_124_3 or var_124_3 * (utf8.len(var_124_4) / 5)) > 0 and var_124_3 < var_124_6 then
					arg_121_1.talkMaxDuration = var_124_6

					if var_124_6 + var_124_2 > arg_121_1.duration_ then
						arg_121_1.duration_ = var_124_6 + var_124_2
					end
				end

				arg_121_1.text_.text = var_124_4
				arg_121_1.typewritter.percent = 0

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(false)
				arg_121_1:RecordContent(arg_121_1.text_.text)
			end

			local var_124_7 = math.max(var_124_3, arg_121_1.talkMaxDuration)

			if var_124_2 <= arg_121_1.time_ and arg_121_1.time_ < var_124_2 + var_124_7 then
				arg_121_1.typewritter.percent = (arg_121_1.time_ - var_124_2) / var_124_7

				arg_121_1.typewritter:SetDirty()
			end

			if arg_121_1.time_ >= var_124_2 + var_124_7 and arg_121_1.time_ < var_124_2 + var_124_7 + arg_124_0 then
				arg_121_1.typewritter.percent = 1

				arg_121_1.typewritter:SetDirty()
				arg_121_1:ShowNextGo(true)
			end
		end

		arg_121_1.nodeConfigList_ = {}

		arg_121_1:InitPlayNodeList()
	end,
	Play935011031 = function(arg_125_0, arg_125_1)
		arg_125_1.time_ = 0
		arg_125_1.frameCnt_ = 0
		arg_125_1.state_ = "playing"
		arg_125_1.curTalkId_ = 935011031
		arg_125_1.duration_ = 9

		SetActive(arg_125_1.tipsGo_, false)

		function arg_125_1.onSingleLineFinish_()
			arg_125_1.onSingleLineUpdate_ = nil
			arg_125_1.onSingleLineFinish_ = nil
			arg_125_1.state_ = "waiting"
		end

		function arg_125_1.playNext_(arg_127_0)
			if arg_127_0 == 1 then
				arg_125_0:Play935011032(arg_125_1)
			end
		end

		function arg_125_1.onSingleLineUpdate_(arg_128_0)
			if arg_125_1.bgs_.ST2003 == nil then
				local var_128_0 = Object.Instantiate(arg_125_1.paintGo_)

				var_128_0:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. "ST2003")
				var_128_0.name = "ST2003"
				var_128_0.transform.parent = arg_125_1.stage_.transform
				var_128_0.transform.localPosition = Vector3.New(0, 100, 0)
				arg_125_1.bgs_.ST2003 = var_128_0
			end

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				local var_128_1 = arg_125_1.bgs_.ST2003

				arg_125_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_128_1.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_128_2 = var_128_1:GetComponent("SpriteRenderer")

				if var_128_2 and var_128_2.sprite then
					local var_128_3 = 2 * (var_128_1.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_128_1.transform.localScale = Vector3.New(var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, var_128_3 / var_128_2.sprite.bounds.size.y < var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x and var_128_3 * manager.ui.mainCameraCom_.aspect / var_128_2.sprite.bounds.size.x or var_128_3 / var_128_2.sprite.bounds.size.y, 0)
				end

				for iter_128_0, iter_128_1 in pairs(arg_125_1.bgs_) do
					if iter_128_0 ~= "ST2003" then
						iter_128_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_128_4 = 4

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_4 + arg_128_0 then
				arg_125_1.allBtn_.enabled = false
			end

			if arg_125_1.time_ >= var_128_4 + 0.3 and arg_125_1.time_ < var_128_4 + 0.3 + arg_128_0 then
				arg_125_1.allBtn_.enabled = true
			end

			local var_128_5 = 0

			if 0 < arg_125_1.time_ and arg_125_1.time_ <= var_128_5 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_6 = 2

			if var_128_5 <= arg_125_1.time_ and arg_125_1.time_ < var_128_5 + var_128_6 then
				local var_128_7 = Color.New(0, 0, 0)

				var_128_7.a = Mathf.Lerp(0, 1, (arg_125_1.time_ - var_128_5) / var_128_6)
				arg_125_1.mask_.color = var_128_7
			end

			if arg_125_1.time_ >= var_128_5 + var_128_6 and arg_125_1.time_ < var_128_5 + var_128_6 + arg_128_0 then
				local var_128_8 = Color.New(0, 0, 0)

				var_128_8.a = 1
				arg_125_1.mask_.color = var_128_8
			end

			local var_128_9 = 2

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= var_128_9 + arg_128_0 then
				arg_125_1.mask_.enabled = true
				arg_125_1.mask_.raycastTarget = true

				arg_125_1:SetGaussion(false)
			end

			local var_128_10 = 2

			if var_128_9 <= arg_125_1.time_ and arg_125_1.time_ < var_128_9 + var_128_10 then
				local var_128_11 = Color.New(0, 0, 0)

				var_128_11.a = Mathf.Lerp(1, 0, (arg_125_1.time_ - var_128_9) / var_128_10)
				arg_125_1.mask_.color = var_128_11
			end

			if arg_125_1.time_ >= var_128_9 + var_128_10 and arg_125_1.time_ < var_128_9 + var_128_10 + arg_128_0 then
				local var_128_12 = Color.New(0, 0, 0)

				arg_125_1.mask_.enabled = false
				var_128_12.a = 0
				arg_125_1.mask_.color = var_128_12
			end

			local var_128_13 = arg_125_1.actors_["1070ui_story"]

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= 4 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect1070ui_story == nil then
				arg_125_1.var_.characterEffect1070ui_story = var_128_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_128_14 = 0.200000002980232

			if 4 <= arg_125_1.time_ and arg_125_1.time_ < 4 + var_128_14 and not isNil(var_128_13) then
				if arg_125_1.var_.characterEffect1070ui_story and not isNil(var_128_13) then
					arg_125_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_125_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_125_1.time_ - 4) / var_128_14)
				end
			end

			if arg_125_1.time_ >= 4 + var_128_14 and arg_125_1.time_ < 4 + var_128_14 + arg_128_0 and not isNil(var_128_13) and arg_125_1.var_.characterEffect1070ui_story then
				arg_125_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_125_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_128_15 = arg_125_1.actors_["1070ui_story"].transform

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				arg_125_1.var_.moveOldPos1070ui_story = var_128_15.localPosition
			end

			local var_128_16 = 0.001

			if 2 <= arg_125_1.time_ and arg_125_1.time_ < 2 + var_128_16 then
				var_128_15.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 2) / var_128_16)
				var_128_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_15.position).x, (manager.ui.mainCamera.transform.position - var_128_15.position).y, (manager.ui.mainCamera.transform.position - var_128_15.position).z)
				var_128_15.localEulerAngles.z = 0
				var_128_15.localEulerAngles.x = 0
				var_128_15.localEulerAngles = var_128_15.localEulerAngles
			end

			if arg_125_1.time_ >= 2 + var_128_16 and arg_125_1.time_ < 2 + var_128_16 + arg_128_0 then
				var_128_15.localPosition = Vector3.New(0, 100, 0)
				var_128_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_15.position).x, (manager.ui.mainCamera.transform.position - var_128_15.position).y, (manager.ui.mainCamera.transform.position - var_128_15.position).z)
				var_128_15.localEulerAngles.z = 0
				var_128_15.localEulerAngles.x = 0
				var_128_15.localEulerAngles = var_128_15.localEulerAngles
			end

			local var_128_17 = arg_125_1.actors_["10039ui_story"].transform

			if 2 < arg_125_1.time_ and arg_125_1.time_ <= 2 + arg_128_0 then
				arg_125_1.var_.moveOldPos10039ui_story = var_128_17.localPosition
			end

			local var_128_18 = 0.001

			if 2 <= arg_125_1.time_ and arg_125_1.time_ < 2 + var_128_18 then
				var_128_17.localPosition = Vector3.Lerp(arg_125_1.var_.moveOldPos10039ui_story, Vector3.New(0, 100, 0), (arg_125_1.time_ - 2) / var_128_18)
				var_128_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_17.position).x, (manager.ui.mainCamera.transform.position - var_128_17.position).y, (manager.ui.mainCamera.transform.position - var_128_17.position).z)
				var_128_17.localEulerAngles.z = 0
				var_128_17.localEulerAngles.x = 0
				var_128_17.localEulerAngles = var_128_17.localEulerAngles
			end

			if arg_125_1.time_ >= 2 + var_128_18 and arg_125_1.time_ < 2 + var_128_18 + arg_128_0 then
				var_128_17.localPosition = Vector3.New(0, 100, 0)
				var_128_17.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_128_17.position).x, (manager.ui.mainCamera.transform.position - var_128_17.position).y, (manager.ui.mainCamera.transform.position - var_128_17.position).z)
				var_128_17.localEulerAngles.z = 0
				var_128_17.localEulerAngles.x = 0
				var_128_17.localEulerAngles = var_128_17.localEulerAngles
			end

			if arg_125_1.frameCnt_ <= 1 then
				arg_125_1.dialog_:SetActive(false)
			end

			local var_128_19 = 4
			local var_128_20 = 1.16666666666667

			if 4 < arg_125_1.time_ and arg_125_1.time_ <= var_128_19 + arg_128_0 then
				arg_125_1.talkMaxDuration = 0

				arg_125_1.dialog_:SetActive(true)

				arg_125_1.dialogCg_.alpha = 0

				local var_128_21 = LeanTween.value(arg_125_1.dialog_, 0, 1, 0.3)

				var_128_21:setOnUpdate(LuaHelper.FloatAction(function(arg_129_0)
					arg_125_1.dialogCg_.alpha = arg_129_0
				end))
				var_128_21:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_125_1.dialog_)
					var_128_21:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_125_1.duration_ = arg_125_1.duration_ + 0.3

				SetActive(arg_125_1.leftNameGo_, false)

				arg_125_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_125_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_125_1:RecordName(arg_125_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_125_1.iconTrs_.gameObject, false)
				arg_125_1.callingController_:SetSelectedState("normal")

				local var_128_22 = arg_125_1:FormatText(arg_125_1:GetWordFromCfg(935011031).content)

				arg_125_1.text_.text = var_128_22

				LuaForUtil.ClearLinePrefixSymbol(arg_125_1.text_)

				local var_128_24 = 51 <= 0 and var_128_20 or var_128_20 * (utf8.len(var_128_22) / 51)

				if (51 <= 0 and var_128_20 or var_128_20 * (utf8.len(var_128_22) / 51)) > 0 and var_128_20 < var_128_24 then
					arg_125_1.talkMaxDuration = var_128_24
					var_128_19 = var_128_19 + 0.3

					if var_128_24 + var_128_19 > arg_125_1.duration_ then
						arg_125_1.duration_ = var_128_24 + var_128_19
					end
				end

				arg_125_1.text_.text = var_128_22
				arg_125_1.typewritter.percent = 0

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(false)
				arg_125_1:RecordContent(arg_125_1.text_.text)
			end

			local var_128_25 = var_128_19 + 0.3
			local var_128_26 = math.max(var_128_20, arg_125_1.talkMaxDuration)

			if var_128_19 + 0.3 <= arg_125_1.time_ and arg_125_1.time_ < var_128_25 + var_128_26 then
				arg_125_1.typewritter.percent = (arg_125_1.time_ - var_128_25) / var_128_26

				arg_125_1.typewritter:SetDirty()
			end

			if arg_125_1.time_ >= var_128_25 + var_128_26 and arg_125_1.time_ < var_128_25 + var_128_26 + arg_128_0 then
				arg_125_1.typewritter.percent = 1

				arg_125_1.typewritter:SetDirty()
				arg_125_1:ShowNextGo(true)
			end
		end

		arg_125_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 2,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_125_1:InitPlayNodeList()
	end,
	Play935011032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 935011032
		arg_131_1.duration_ = 5

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play935011033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = 0.9

			if 0 < arg_131_1.time_ and arg_131_1.time_ <= 0 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, false)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_1 = arg_131_1:FormatText(arg_131_1:GetWordFromCfg(935011032).content)

				arg_131_1.text_.text = var_134_1

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_3 = 36 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 36)

				if (36 <= 0 and var_134_0 or var_134_0 * (utf8.len(var_134_1) / 36)) > 0 and var_134_0 < var_134_3 then
					arg_131_1.talkMaxDuration = var_134_3

					if var_134_3 + 0 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_3 + 0
					end
				end

				arg_131_1.text_.text = var_134_1
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)
				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_4 = math.max(var_134_0, arg_131_1.talkMaxDuration)

			if 0 <= arg_131_1.time_ and arg_131_1.time_ < 0 + var_134_4 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - 0) / var_134_4

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= 0 + var_134_4 and arg_131_1.time_ < 0 + var_134_4 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end

		arg_131_1.nodeConfigList_ = {}

		arg_131_1:InitPlayNodeList()
	end,
	Play935011033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 935011033
		arg_135_1.duration_ = 5

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play935011034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = 0.625

			if 0 < arg_135_1.time_ and arg_135_1.time_ <= 0 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, false)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_1 = arg_135_1:FormatText(arg_135_1:GetWordFromCfg(935011033).content)

				arg_135_1.text_.text = var_138_1

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_3 = 25 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 25)

				if (25 <= 0 and var_138_0 or var_138_0 * (utf8.len(var_138_1) / 25)) > 0 and var_138_0 < var_138_3 then
					arg_135_1.talkMaxDuration = var_138_3

					if var_138_3 + 0 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_3 + 0
					end
				end

				arg_135_1.text_.text = var_138_1
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)
				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_4 = math.max(var_138_0, arg_135_1.talkMaxDuration)

			if 0 <= arg_135_1.time_ and arg_135_1.time_ < 0 + var_138_4 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - 0) / var_138_4

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= 0 + var_138_4 and arg_135_1.time_ < 0 + var_138_4 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end

		arg_135_1.nodeConfigList_ = {}

		arg_135_1:InitPlayNodeList()
	end,
	Play935011034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 935011034
		arg_139_1.duration_ = 5

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play935011035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 and not isNil(arg_139_1.actors_["10039ui_story"]) and arg_139_1.var_.characterEffect10039ui_story == nil then
				arg_139_1.var_.characterEffect10039ui_story = arg_139_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_0 = 0.200000002980232

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_0 and not isNil(arg_139_1.actors_["10039ui_story"]) then
				if arg_139_1.var_.characterEffect10039ui_story and not isNil(arg_139_1.actors_["10039ui_story"]) then
					arg_139_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= 0 + var_142_0 and arg_139_1.time_ < 0 + var_142_0 + arg_142_0 and not isNil(arg_139_1.actors_["10039ui_story"]) and arg_139_1.var_.characterEffect10039ui_story then
				arg_139_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_142_2 = arg_139_1.actors_["10039ui_story"].transform

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1.var_.moveOldPos10039ui_story = var_142_2.localPosition
			end

			local var_142_3 = 0.001

			if 0 <= arg_139_1.time_ and arg_139_1.time_ < 0 + var_142_3 then
				var_142_2.localPosition = Vector3.Lerp(arg_139_1.var_.moveOldPos10039ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_139_1.time_ - 0) / var_142_3)
				var_142_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_2.position).x, (manager.ui.mainCamera.transform.position - var_142_2.position).y, (manager.ui.mainCamera.transform.position - var_142_2.position).z)
				var_142_2.localEulerAngles.z = 0
				var_142_2.localEulerAngles.x = 0
				var_142_2.localEulerAngles = var_142_2.localEulerAngles
			end

			if arg_139_1.time_ >= 0 + var_142_3 and arg_139_1.time_ < 0 + var_142_3 + arg_142_0 then
				var_142_2.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_142_2.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_142_2.position).x, (manager.ui.mainCamera.transform.position - var_142_2.position).y, (manager.ui.mainCamera.transform.position - var_142_2.position).z)
				var_142_2.localEulerAngles.z = 0
				var_142_2.localEulerAngles.x = 0
				var_142_2.localEulerAngles = var_142_2.localEulerAngles
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_1")
			end

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= 0 + arg_142_0 then
				arg_139_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_142_4 = 0
			local var_142_5 = 0.125

			if 0 < arg_139_1.time_ and arg_139_1.time_ <= var_142_4 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				arg_139_1.leftNameTxt_.text = arg_139_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_6 = arg_139_1:FormatText(arg_139_1:GetWordFromCfg(935011034).content)

				arg_139_1.text_.text = var_142_6

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_8 = 5 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_6) / 5)

				if (5 <= 0 and var_142_5 or var_142_5 * (utf8.len(var_142_6) / 5)) > 0 and var_142_5 < var_142_8 then
					arg_139_1.talkMaxDuration = var_142_8

					if var_142_8 + var_142_4 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_8 + var_142_4
					end
				end

				arg_139_1.text_.text = var_142_6
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)
				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_9 = math.max(var_142_5, arg_139_1.talkMaxDuration)

			if var_142_4 <= arg_139_1.time_ and arg_139_1.time_ < var_142_4 + var_142_9 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_4) / var_142_9

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_4 + var_142_9 and arg_139_1.time_ < var_142_4 + var_142_9 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end

		arg_139_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_139_1:InitPlayNodeList()
	end,
	Play935011035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 935011035
		arg_143_1.duration_ = 5

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play935011036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(arg_143_1.actors_["1070ui_story"]) and arg_143_1.var_.characterEffect1070ui_story == nil then
				arg_143_1.var_.characterEffect1070ui_story = arg_143_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_0 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_0 and not isNil(arg_143_1.actors_["1070ui_story"]) then
				if arg_143_1.var_.characterEffect1070ui_story and not isNil(arg_143_1.actors_["1070ui_story"]) then
					arg_143_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_143_1.time_ >= 0 + var_146_0 and arg_143_1.time_ < 0 + var_146_0 + arg_146_0 and not isNil(arg_143_1.actors_["1070ui_story"]) and arg_143_1.var_.characterEffect1070ui_story then
				arg_143_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_146_2 = arg_143_1.actors_["10039ui_story"]

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect10039ui_story == nil then
				arg_143_1.var_.characterEffect10039ui_story = var_146_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_146_3 = 0.200000002980232

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_3 and not isNil(var_146_2) then
				if arg_143_1.var_.characterEffect10039ui_story and not isNil(var_146_2) then
					arg_143_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_143_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_143_1.time_ - 0) / var_146_3)
				end
			end

			if arg_143_1.time_ >= 0 + var_146_3 and arg_143_1.time_ < 0 + var_146_3 + arg_146_0 and not isNil(var_146_2) and arg_143_1.var_.characterEffect10039ui_story then
				arg_143_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_143_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			local var_146_4 = arg_143_1.actors_["1070ui_story"].transform

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1.var_.moveOldPos1070ui_story = var_146_4.localPosition
			end

			local var_146_5 = 0.001

			if 0 <= arg_143_1.time_ and arg_143_1.time_ < 0 + var_146_5 then
				var_146_4.localPosition = Vector3.Lerp(arg_143_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_143_1.time_ - 0) / var_146_5)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if arg_143_1.time_ >= 0 + var_146_5 and arg_143_1.time_ < 0 + var_146_5 + arg_146_0 then
				var_146_4.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_146_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_146_4.position).x, (manager.ui.mainCamera.transform.position - var_146_4.position).y, (manager.ui.mainCamera.transform.position - var_146_4.position).z)
				var_146_4.localEulerAngles.z = 0
				var_146_4.localEulerAngles.x = 0
				var_146_4.localEulerAngles = var_146_4.localEulerAngles
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= 0 + arg_146_0 then
				arg_143_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva", "EmotionTimelineAnimator")
			end

			local var_146_6 = 0
			local var_146_7 = 0.05

			if 0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_6 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				arg_143_1.leftNameTxt_.text = arg_143_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_8 = arg_143_1:FormatText(arg_143_1:GetWordFromCfg(935011035).content)

				arg_143_1.text_.text = var_146_8

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_10 = 2 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_8) / 2)

				if (2 <= 0 and var_146_7 or var_146_7 * (utf8.len(var_146_8) / 2)) > 0 and var_146_7 < var_146_10 then
					arg_143_1.talkMaxDuration = var_146_10

					if var_146_10 + var_146_6 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_10 + var_146_6
					end
				end

				arg_143_1.text_.text = var_146_8
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)
				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_7, arg_143_1.talkMaxDuration)

			if var_146_6 <= arg_143_1.time_ and arg_143_1.time_ < var_146_6 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_6) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_6 + var_146_11 and arg_143_1.time_ < var_146_6 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end

		arg_143_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_143_1:InitPlayNodeList()
	end,
	Play935011036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 935011036
		arg_147_1.duration_ = 5

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play935011037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			if 0 < arg_147_1.time_ and arg_147_1.time_ <= 0 + arg_150_0 and not isNil(arg_147_1.actors_["1070ui_story"]) and arg_147_1.var_.characterEffect1070ui_story == nil then
				arg_147_1.var_.characterEffect1070ui_story = arg_147_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_0 = 0.200000002980232

			if 0 <= arg_147_1.time_ and arg_147_1.time_ < 0 + var_150_0 and not isNil(arg_147_1.actors_["1070ui_story"]) then
				if arg_147_1.var_.characterEffect1070ui_story and not isNil(arg_147_1.actors_["1070ui_story"]) then
					arg_147_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_147_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_147_1.time_ - 0) / var_150_0)
				end
			end

			if arg_147_1.time_ >= 0 + var_150_0 and arg_147_1.time_ < 0 + var_150_0 + arg_150_0 and not isNil(arg_147_1.actors_["1070ui_story"]) and arg_147_1.var_.characterEffect1070ui_story then
				arg_147_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_147_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_150_1 = 0
			local var_150_2 = 0.85

			if 0 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, false)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_3 = arg_147_1:FormatText(arg_147_1:GetWordFromCfg(935011036).content)

				arg_147_1.text_.text = var_150_3

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_5 = 34 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 34)

				if (34 <= 0 and var_150_2 or var_150_2 * (utf8.len(var_150_3) / 34)) > 0 and var_150_2 < var_150_5 then
					arg_147_1.talkMaxDuration = var_150_5

					if var_150_5 + var_150_1 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_5 + var_150_1
					end
				end

				arg_147_1.text_.text = var_150_3
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)
				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_6 = math.max(var_150_2, arg_147_1.talkMaxDuration)

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_6 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_1) / var_150_6

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_1 + var_150_6 and arg_147_1.time_ < var_150_1 + var_150_6 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end

		arg_147_1.nodeConfigList_ = {}

		arg_147_1:InitPlayNodeList()
	end,
	Play935011037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 935011037
		arg_151_1.duration_ = 5

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play935011038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			if 0 < arg_151_1.time_ and arg_151_1.time_ <= 0 + arg_154_0 and not isNil(arg_151_1.actors_["10039ui_story"]) and arg_151_1.var_.characterEffect10039ui_story == nil then
				arg_151_1.var_.characterEffect10039ui_story = arg_151_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_0 = 0.200000002980232

			if 0 <= arg_151_1.time_ and arg_151_1.time_ < 0 + var_154_0 and not isNil(arg_151_1.actors_["10039ui_story"]) then
				if arg_151_1.var_.characterEffect10039ui_story and not isNil(arg_151_1.actors_["10039ui_story"]) then
					arg_151_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= 0 + var_154_0 and arg_151_1.time_ < 0 + var_154_0 + arg_154_0 and not isNil(arg_151_1.actors_["10039ui_story"]) and arg_151_1.var_.characterEffect10039ui_story then
				arg_151_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_154_2 = 0
			local var_154_3 = 0.6

			if 0 < arg_151_1.time_ and arg_151_1.time_ <= var_154_2 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				arg_151_1.leftNameTxt_.text = arg_151_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_4 = arg_151_1:FormatText(arg_151_1:GetWordFromCfg(935011037).content)

				arg_151_1.text_.text = var_154_4

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_6 = 24 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 24)

				if (24 <= 0 and var_154_3 or var_154_3 * (utf8.len(var_154_4) / 24)) > 0 and var_154_3 < var_154_6 then
					arg_151_1.talkMaxDuration = var_154_6

					if var_154_6 + var_154_2 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_6 + var_154_2
					end
				end

				arg_151_1.text_.text = var_154_4
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)
				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_7 = math.max(var_154_3, arg_151_1.talkMaxDuration)

			if var_154_2 <= arg_151_1.time_ and arg_151_1.time_ < var_154_2 + var_154_7 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_2) / var_154_7

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_2 + var_154_7 and arg_151_1.time_ < var_154_2 + var_154_7 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end

		arg_151_1.nodeConfigList_ = {}

		arg_151_1:InitPlayNodeList()
	end,
	Play935011038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 935011038
		arg_155_1.duration_ = 5

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play935011039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			if 0 < arg_155_1.time_ and arg_155_1.time_ <= 0 + arg_158_0 then
				arg_155_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva", "EmotionTimelineAnimator")
			end

			local var_158_0 = 0
			local var_158_1 = 0.475

			if 0 < arg_155_1.time_ and arg_155_1.time_ <= var_158_0 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				arg_155_1.leftNameTxt_.text = arg_155_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_2 = arg_155_1:FormatText(arg_155_1:GetWordFromCfg(935011038).content)

				arg_155_1.text_.text = var_158_2

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_4 = 19 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_2) / 19)

				if (19 <= 0 and var_158_1 or var_158_1 * (utf8.len(var_158_2) / 19)) > 0 and var_158_1 < var_158_4 then
					arg_155_1.talkMaxDuration = var_158_4

					if var_158_4 + var_158_0 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_4 + var_158_0
					end
				end

				arg_155_1.text_.text = var_158_2
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)
				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_5 = math.max(var_158_1, arg_155_1.talkMaxDuration)

			if var_158_0 <= arg_155_1.time_ and arg_155_1.time_ < var_158_0 + var_158_5 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_0) / var_158_5

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_0 + var_158_5 and arg_155_1.time_ < var_158_0 + var_158_5 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end

		arg_155_1.nodeConfigList_ = {}

		arg_155_1:InitPlayNodeList()
	end,
	Play935011039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 935011039
		arg_159_1.duration_ = 5

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play935011040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(arg_159_1.actors_["1070ui_story"]) and arg_159_1.var_.characterEffect1070ui_story == nil then
				arg_159_1.var_.characterEffect1070ui_story = arg_159_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_0 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_0 and not isNil(arg_159_1.actors_["1070ui_story"]) then
				if arg_159_1.var_.characterEffect1070ui_story and not isNil(arg_159_1.actors_["1070ui_story"]) then
					arg_159_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_159_1.time_ >= 0 + var_162_0 and arg_159_1.time_ < 0 + var_162_0 + arg_162_0 and not isNil(arg_159_1.actors_["1070ui_story"]) and arg_159_1.var_.characterEffect1070ui_story then
				arg_159_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_162_2 = arg_159_1.actors_["10039ui_story"]

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect10039ui_story == nil then
				arg_159_1.var_.characterEffect10039ui_story = var_162_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_162_3 = 0.200000002980232

			if 0 <= arg_159_1.time_ and arg_159_1.time_ < 0 + var_162_3 and not isNil(var_162_2) then
				if arg_159_1.var_.characterEffect10039ui_story and not isNil(var_162_2) then
					arg_159_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_159_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_159_1.time_ - 0) / var_162_3)
				end
			end

			if arg_159_1.time_ >= 0 + var_162_3 and arg_159_1.time_ < 0 + var_162_3 + arg_162_0 and not isNil(var_162_2) and arg_159_1.var_.characterEffect10039ui_story then
				arg_159_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_159_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= 0 + arg_162_0 then
				arg_159_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_162_4 = 0
			local var_162_5 = 0.125

			if 0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_4 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				arg_159_1.leftNameTxt_.text = arg_159_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_6 = arg_159_1:FormatText(arg_159_1:GetWordFromCfg(935011039).content)

				arg_159_1.text_.text = var_162_6

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_8 = 5 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_6) / 5)

				if (5 <= 0 and var_162_5 or var_162_5 * (utf8.len(var_162_6) / 5)) > 0 and var_162_5 < var_162_8 then
					arg_159_1.talkMaxDuration = var_162_8

					if var_162_8 + var_162_4 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_4
					end
				end

				arg_159_1.text_.text = var_162_6
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)
				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_9 = math.max(var_162_5, arg_159_1.talkMaxDuration)

			if var_162_4 <= arg_159_1.time_ and arg_159_1.time_ < var_162_4 + var_162_9 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_4) / var_162_9

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_4 + var_162_9 and arg_159_1.time_ < var_162_4 + var_162_9 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end

		arg_159_1.nodeConfigList_ = {}

		arg_159_1:InitPlayNodeList()
	end,
	Play935011040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 935011040
		arg_163_1.duration_ = 5

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play935011041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(arg_163_1.actors_["10039ui_story"]) and arg_163_1.var_.characterEffect10039ui_story == nil then
				arg_163_1.var_.characterEffect10039ui_story = arg_163_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_0 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_0 and not isNil(arg_163_1.actors_["10039ui_story"]) then
				if arg_163_1.var_.characterEffect10039ui_story and not isNil(arg_163_1.actors_["10039ui_story"]) then
					arg_163_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= 0 + var_166_0 and arg_163_1.time_ < 0 + var_166_0 + arg_166_0 and not isNil(arg_163_1.actors_["10039ui_story"]) and arg_163_1.var_.characterEffect10039ui_story then
				arg_163_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_166_2 = arg_163_1.actors_["1070ui_story"]

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1070ui_story == nil then
				arg_163_1.var_.characterEffect1070ui_story = var_166_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_3 = 0.200000002980232

			if 0 <= arg_163_1.time_ and arg_163_1.time_ < 0 + var_166_3 and not isNil(var_166_2) then
				if arg_163_1.var_.characterEffect1070ui_story and not isNil(var_166_2) then
					arg_163_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_163_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_163_1.time_ - 0) / var_166_3)
				end
			end

			if arg_163_1.time_ >= 0 + var_166_3 and arg_163_1.time_ < 0 + var_166_3 + arg_166_0 and not isNil(var_166_2) and arg_163_1.var_.characterEffect1070ui_story then
				arg_163_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_163_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= 0 + arg_166_0 then
				arg_163_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action463")
			end

			local var_166_4 = 0
			local var_166_5 = 0.225

			if 0 < arg_163_1.time_ and arg_163_1.time_ <= var_166_4 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				arg_163_1.leftNameTxt_.text = arg_163_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_6 = arg_163_1:FormatText(arg_163_1:GetWordFromCfg(935011040).content)

				arg_163_1.text_.text = var_166_6

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_8 = 9 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_6) / 9)

				if (9 <= 0 and var_166_5 or var_166_5 * (utf8.len(var_166_6) / 9)) > 0 and var_166_5 < var_166_8 then
					arg_163_1.talkMaxDuration = var_166_8

					if var_166_8 + var_166_4 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_8 + var_166_4
					end
				end

				arg_163_1.text_.text = var_166_6
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)
				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_9 = math.max(var_166_5, arg_163_1.talkMaxDuration)

			if var_166_4 <= arg_163_1.time_ and arg_163_1.time_ < var_166_4 + var_166_9 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_4) / var_166_9

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_4 + var_166_9 and arg_163_1.time_ < var_166_4 + var_166_9 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end

		arg_163_1.nodeConfigList_ = {}

		arg_163_1:InitPlayNodeList()
	end,
	Play935011041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 935011041
		arg_167_1.duration_ = 5

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play935011042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(arg_167_1.actors_["1070ui_story"]) and arg_167_1.var_.characterEffect1070ui_story == nil then
				arg_167_1.var_.characterEffect1070ui_story = arg_167_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_0 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_0 and not isNil(arg_167_1.actors_["1070ui_story"]) then
				if arg_167_1.var_.characterEffect1070ui_story and not isNil(arg_167_1.actors_["1070ui_story"]) then
					arg_167_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= 0 + var_170_0 and arg_167_1.time_ < 0 + var_170_0 + arg_170_0 and not isNil(arg_167_1.actors_["1070ui_story"]) and arg_167_1.var_.characterEffect1070ui_story then
				arg_167_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_170_2 = arg_167_1.actors_["10039ui_story"]

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect10039ui_story == nil then
				arg_167_1.var_.characterEffect10039ui_story = var_170_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_3 = 0.200000002980232

			if 0 <= arg_167_1.time_ and arg_167_1.time_ < 0 + var_170_3 and not isNil(var_170_2) then
				if arg_167_1.var_.characterEffect10039ui_story and not isNil(var_170_2) then
					arg_167_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_167_1.time_ - 0) / var_170_3)
				end
			end

			if arg_167_1.time_ >= 0 + var_170_3 and arg_167_1.time_ < 0 + var_170_3 + arg_170_0 and not isNil(var_170_2) and arg_167_1.var_.characterEffect10039ui_story then
				arg_167_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= 0 + arg_170_0 then
				arg_167_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_170_4 = 0
			local var_170_5 = 0.1

			if 0 < arg_167_1.time_ and arg_167_1.time_ <= var_170_4 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				arg_167_1.leftNameTxt_.text = arg_167_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_6 = arg_167_1:FormatText(arg_167_1:GetWordFromCfg(935011041).content)

				arg_167_1.text_.text = var_170_6

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_8 = 4 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 4)

				if (4 <= 0 and var_170_5 or var_170_5 * (utf8.len(var_170_6) / 4)) > 0 and var_170_5 < var_170_8 then
					arg_167_1.talkMaxDuration = var_170_8

					if var_170_8 + var_170_4 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_8 + var_170_4
					end
				end

				arg_167_1.text_.text = var_170_6
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)
				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_9 = math.max(var_170_5, arg_167_1.talkMaxDuration)

			if var_170_4 <= arg_167_1.time_ and arg_167_1.time_ < var_170_4 + var_170_9 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_4) / var_170_9

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_4 + var_170_9 and arg_167_1.time_ < var_170_4 + var_170_9 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end

		arg_167_1.nodeConfigList_ = {}

		arg_167_1:InitPlayNodeList()
	end,
	Play935011042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 935011042
		arg_171_1.duration_ = 5

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play935011043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(arg_171_1.actors_["10039ui_story"]) and arg_171_1.var_.characterEffect10039ui_story == nil then
				arg_171_1.var_.characterEffect10039ui_story = arg_171_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_0 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_0 and not isNil(arg_171_1.actors_["10039ui_story"]) then
				if arg_171_1.var_.characterEffect10039ui_story and not isNil(arg_171_1.actors_["10039ui_story"]) then
					arg_171_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_171_1.time_ >= 0 + var_174_0 and arg_171_1.time_ < 0 + var_174_0 + arg_174_0 and not isNil(arg_171_1.actors_["10039ui_story"]) and arg_171_1.var_.characterEffect10039ui_story then
				arg_171_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_174_2 = arg_171_1.actors_["1070ui_story"]

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1070ui_story == nil then
				arg_171_1.var_.characterEffect1070ui_story = var_174_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_174_3 = 0.200000002980232

			if 0 <= arg_171_1.time_ and arg_171_1.time_ < 0 + var_174_3 and not isNil(var_174_2) then
				if arg_171_1.var_.characterEffect1070ui_story and not isNil(var_174_2) then
					arg_171_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_171_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_171_1.time_ - 0) / var_174_3)
				end
			end

			if arg_171_1.time_ >= 0 + var_174_3 and arg_171_1.time_ < 0 + var_174_3 + arg_174_0 and not isNil(var_174_2) and arg_171_1.var_.characterEffect1070ui_story then
				arg_171_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_171_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= 0 + arg_174_0 then
				arg_171_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action3_2")
			end

			local var_174_4 = 0
			local var_174_5 = 0.25

			if 0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_4 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				arg_171_1.leftNameTxt_.text = arg_171_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_6 = arg_171_1:FormatText(arg_171_1:GetWordFromCfg(935011042).content)

				arg_171_1.text_.text = var_174_6

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_8 = 10 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_6) / 10)

				if (10 <= 0 and var_174_5 or var_174_5 * (utf8.len(var_174_6) / 10)) > 0 and var_174_5 < var_174_8 then
					arg_171_1.talkMaxDuration = var_174_8

					if var_174_8 + var_174_4 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_4
					end
				end

				arg_171_1.text_.text = var_174_6
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)
				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_9 = math.max(var_174_5, arg_171_1.talkMaxDuration)

			if var_174_4 <= arg_171_1.time_ and arg_171_1.time_ < var_174_4 + var_174_9 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_4) / var_174_9

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_4 + var_174_9 and arg_171_1.time_ < var_174_4 + var_174_9 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end

		arg_171_1.nodeConfigList_ = {}

		arg_171_1:InitPlayNodeList()
	end,
	Play935011043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 935011043
		arg_175_1.duration_ = 5

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play935011044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0.4

			if 0 < arg_175_1.time_ and arg_175_1.time_ <= 0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				arg_175_1.leftNameTxt_.text = arg_175_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_1 = arg_175_1:FormatText(arg_175_1:GetWordFromCfg(935011043).content)

				arg_175_1.text_.text = var_178_1

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_3 = 16 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 16)

				if (16 <= 0 and var_178_0 or var_178_0 * (utf8.len(var_178_1) / 16)) > 0 and var_178_0 < var_178_3 then
					arg_175_1.talkMaxDuration = var_178_3

					if var_178_3 + 0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_3 + 0
					end
				end

				arg_175_1.text_.text = var_178_1
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)
				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_4 = math.max(var_178_0, arg_175_1.talkMaxDuration)

			if 0 <= arg_175_1.time_ and arg_175_1.time_ < 0 + var_178_4 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - 0) / var_178_4

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= 0 + var_178_4 and arg_175_1.time_ < 0 + var_178_4 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end

		arg_175_1.nodeConfigList_ = {}

		arg_175_1:InitPlayNodeList()
	end,
	Play935011044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 935011044
		arg_179_1.duration_ = 5

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play935011045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(arg_179_1.actors_["1070ui_story"]) and arg_179_1.var_.characterEffect1070ui_story == nil then
				arg_179_1.var_.characterEffect1070ui_story = arg_179_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_0 = 0.166666666666667

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_0 and not isNil(arg_179_1.actors_["1070ui_story"]) then
				if arg_179_1.var_.characterEffect1070ui_story and not isNil(arg_179_1.actors_["1070ui_story"]) then
					arg_179_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= 0 + var_182_0 and arg_179_1.time_ < 0 + var_182_0 + arg_182_0 and not isNil(arg_179_1.actors_["1070ui_story"]) and arg_179_1.var_.characterEffect1070ui_story then
				arg_179_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_182_2 = arg_179_1.actors_["10039ui_story"]

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect10039ui_story == nil then
				arg_179_1.var_.characterEffect10039ui_story = var_182_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_3 = 0.166666666666667

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_3 and not isNil(var_182_2) then
				if arg_179_1.var_.characterEffect10039ui_story and not isNil(var_182_2) then
					arg_179_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_179_1.time_ - 0) / var_182_3)
				end
			end

			if arg_179_1.time_ >= 0 + var_182_3 and arg_179_1.time_ < 0 + var_182_3 + arg_182_0 and not isNil(var_182_2) and arg_179_1.var_.characterEffect10039ui_story then
				arg_179_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_182_4 = arg_179_1.actors_["10039ui_story"].transform

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1.var_.moveOldPos10039ui_story = var_182_4.localPosition
			end

			local var_182_5 = 0.001

			if 0 <= arg_179_1.time_ and arg_179_1.time_ < 0 + var_182_5 then
				var_182_4.localPosition = Vector3.Lerp(arg_179_1.var_.moveOldPos10039ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_179_1.time_ - 0) / var_182_5)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			if arg_179_1.time_ >= 0 + var_182_5 and arg_179_1.time_ < 0 + var_182_5 + arg_182_0 then
				var_182_4.localPosition = Vector3.New(0.7, -0.8, -6.2)
				var_182_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_182_4.position).x, (manager.ui.mainCamera.transform.position - var_182_4.position).y, (manager.ui.mainCamera.transform.position - var_182_4.position).z)
				var_182_4.localEulerAngles.z = 0
				var_182_4.localEulerAngles.x = 0
				var_182_4.localEulerAngles = var_182_4.localEulerAngles
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= 0 + arg_182_0 then
				arg_179_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva", "EmotionTimelineAnimator")
			end

			local var_182_6 = 0
			local var_182_7 = 0.675

			if 0 < arg_179_1.time_ and arg_179_1.time_ <= var_182_6 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				arg_179_1.leftNameTxt_.text = arg_179_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_8 = arg_179_1:FormatText(arg_179_1:GetWordFromCfg(935011044).content)

				arg_179_1.text_.text = var_182_8

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_10 = 27 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_8) / 27)

				if (27 <= 0 and var_182_7 or var_182_7 * (utf8.len(var_182_8) / 27)) > 0 and var_182_7 < var_182_10 then
					arg_179_1.talkMaxDuration = var_182_10

					if var_182_10 + var_182_6 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_10 + var_182_6
					end
				end

				arg_179_1.text_.text = var_182_8
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)
				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_11 = math.max(var_182_7, arg_179_1.talkMaxDuration)

			if var_182_6 <= arg_179_1.time_ and arg_179_1.time_ < var_182_6 + var_182_11 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_6) / var_182_11

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_6 + var_182_11 and arg_179_1.time_ < var_182_6 + var_182_11 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end

		arg_179_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_179_1:InitPlayNodeList()
	end,
	Play935011045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 935011045
		arg_183_1.duration_ = 5

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play935011046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 and not isNil(arg_183_1.actors_["1070ui_story"]) and arg_183_1.var_.characterEffect1070ui_story == nil then
				arg_183_1.var_.characterEffect1070ui_story = arg_183_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_0 = 0.200000002980232

			if 0 <= arg_183_1.time_ and arg_183_1.time_ < 0 + var_186_0 and not isNil(arg_183_1.actors_["1070ui_story"]) then
				if arg_183_1.var_.characterEffect1070ui_story and not isNil(arg_183_1.actors_["1070ui_story"]) then
					arg_183_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_183_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_183_1.time_ - 0) / var_186_0)
				end
			end

			if arg_183_1.time_ >= 0 + var_186_0 and arg_183_1.time_ < 0 + var_186_0 + arg_186_0 and not isNil(arg_183_1.actors_["1070ui_story"]) and arg_183_1.var_.characterEffect1070ui_story then
				arg_183_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_183_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= 0 + arg_186_0 then
				arg_183_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_186_1 = 0
			local var_186_2 = 0.725

			if 0 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, false)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_3 = arg_183_1:FormatText(arg_183_1:GetWordFromCfg(935011045).content)

				arg_183_1.text_.text = var_186_3

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_5 = 29 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 29)

				if (29 <= 0 and var_186_2 or var_186_2 * (utf8.len(var_186_3) / 29)) > 0 and var_186_2 < var_186_5 then
					arg_183_1.talkMaxDuration = var_186_5

					if var_186_5 + var_186_1 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_5 + var_186_1
					end
				end

				arg_183_1.text_.text = var_186_3
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)
				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_6 = math.max(var_186_2, arg_183_1.talkMaxDuration)

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_6 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_1) / var_186_6

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_1 + var_186_6 and arg_183_1.time_ < var_186_1 + var_186_6 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end

		arg_183_1.nodeConfigList_ = {}

		arg_183_1:InitPlayNodeList()
	end,
	Play935011046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 935011046
		arg_187_1.duration_ = 9

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play935011047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			if 0 < arg_187_1.time_ and arg_187_1.time_ <= 0 + arg_190_0 then
				local var_190_0 = arg_187_1.bgs_.ST2003

				arg_187_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_190_0.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_1 = var_190_0:GetComponent("SpriteRenderer")

				if var_190_1 and var_190_1.sprite then
					local var_190_2 = 2 * (var_190_0.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_190_0.transform.localScale = Vector3.New(var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, var_190_2 / var_190_1.sprite.bounds.size.y < var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x and var_190_2 * manager.ui.mainCameraCom_.aspect / var_190_1.sprite.bounds.size.x or var_190_2 / var_190_1.sprite.bounds.size.y, 0)
				end

				for iter_190_0, iter_190_1 in pairs(arg_187_1.bgs_) do
					if iter_190_0 ~= "ST2003" then
						iter_190_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < arg_187_1.time_ and arg_187_1.time_ <= 2 + arg_190_0 then
				local var_190_3 = arg_187_1.bgs_.ST2003

				arg_187_1.bgs_.ST2003.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(manager.ui.mainCamera.transform.localPosition.x, manager.ui.mainCamera.transform.localPosition.y, 0)
				var_190_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_190_4 = var_190_3:GetComponent("SpriteRenderer")

				if var_190_4 and var_190_4.sprite then
					local var_190_5 = 2 * (var_190_3.transform.localPosition - manager.ui.mainCamera.transform.localPosition).z * Mathf.Tan(manager.ui.mainCameraCom_.fieldOfView * 0.5 * Mathf.Deg2Rad)

					var_190_3.transform.localScale = Vector3.New(var_190_5 / var_190_4.sprite.bounds.size.y < var_190_5 * manager.ui.mainCameraCom_.aspect / var_190_4.sprite.bounds.size.x and var_190_5 * manager.ui.mainCameraCom_.aspect / var_190_4.sprite.bounds.size.x or var_190_5 / var_190_4.sprite.bounds.size.y, var_190_5 / var_190_4.sprite.bounds.size.y < var_190_5 * manager.ui.mainCameraCom_.aspect / var_190_4.sprite.bounds.size.x and var_190_5 * manager.ui.mainCameraCom_.aspect / var_190_4.sprite.bounds.size.x or var_190_5 / var_190_4.sprite.bounds.size.y, 0)
				end

				for iter_190_2, iter_190_3 in pairs(arg_187_1.bgs_) do
					if iter_190_2 ~= "ST2003" then
						iter_190_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_190_6 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_6 + arg_190_0 then
				arg_187_1.allBtn_.enabled = false
			end

			if arg_187_1.time_ >= var_190_6 + 0.3 and arg_187_1.time_ < var_190_6 + 0.3 + arg_190_0 then
				arg_187_1.allBtn_.enabled = true
			end

			local var_190_7 = 0

			if 0 < arg_187_1.time_ and arg_187_1.time_ <= var_190_7 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_8 = 2

			if var_190_7 <= arg_187_1.time_ and arg_187_1.time_ < var_190_7 + var_190_8 then
				local var_190_9 = Color.New(0, 0, 0)

				var_190_9.a = Mathf.Lerp(0, 1, (arg_187_1.time_ - var_190_7) / var_190_8)
				arg_187_1.mask_.color = var_190_9
			end

			if arg_187_1.time_ >= var_190_7 + var_190_8 and arg_187_1.time_ < var_190_7 + var_190_8 + arg_190_0 then
				local var_190_10 = Color.New(0, 0, 0)

				var_190_10.a = 1
				arg_187_1.mask_.color = var_190_10
			end

			local var_190_11 = 2

			if 2 < arg_187_1.time_ and arg_187_1.time_ <= var_190_11 + arg_190_0 then
				arg_187_1.mask_.enabled = true
				arg_187_1.mask_.raycastTarget = true

				arg_187_1:SetGaussion(false)
			end

			local var_190_12 = 2

			if var_190_11 <= arg_187_1.time_ and arg_187_1.time_ < var_190_11 + var_190_12 then
				local var_190_13 = Color.New(0, 0, 0)

				var_190_13.a = Mathf.Lerp(1, 0, (arg_187_1.time_ - var_190_11) / var_190_12)
				arg_187_1.mask_.color = var_190_13
			end

			if arg_187_1.time_ >= var_190_11 + var_190_12 and arg_187_1.time_ < var_190_11 + var_190_12 + arg_190_0 then
				local var_190_14 = Color.New(0, 0, 0)

				arg_187_1.mask_.enabled = false
				var_190_14.a = 0
				arg_187_1.mask_.color = var_190_14
			end

			local var_190_15 = arg_187_1.actors_["1070ui_story"].transform

			if 4 < arg_187_1.time_ and arg_187_1.time_ <= 4 + arg_190_0 then
				arg_187_1.var_.moveOldPos1070ui_story = var_190_15.localPosition
			end

			local var_190_16 = 0.001

			if 4 <= arg_187_1.time_ and arg_187_1.time_ < 4 + var_190_16 then
				var_190_15.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1070ui_story, Vector3.New(-0.7, -0.95, -6.05), (arg_187_1.time_ - 4) / var_190_16)
				var_190_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_15.position).x, (manager.ui.mainCamera.transform.position - var_190_15.position).y, (manager.ui.mainCamera.transform.position - var_190_15.position).z)
				var_190_15.localEulerAngles.z = 0
				var_190_15.localEulerAngles.x = 0
				var_190_15.localEulerAngles = var_190_15.localEulerAngles
			end

			if arg_187_1.time_ >= 4 + var_190_16 and arg_187_1.time_ < 4 + var_190_16 + arg_190_0 then
				var_190_15.localPosition = Vector3.New(-0.7, -0.95, -6.05)
				var_190_15.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_15.position).x, (manager.ui.mainCamera.transform.position - var_190_15.position).y, (manager.ui.mainCamera.transform.position - var_190_15.position).z)
				var_190_15.localEulerAngles.z = 0
				var_190_15.localEulerAngles.x = 0
				var_190_15.localEulerAngles = var_190_15.localEulerAngles
			end

			local var_190_17 = arg_187_1.actors_["1070ui_story"]

			if 4 < arg_187_1.time_ and arg_187_1.time_ <= 4 + arg_190_0 and not isNil(var_190_17) and arg_187_1.var_.characterEffect1070ui_story == nil then
				arg_187_1.var_.characterEffect1070ui_story = var_190_17:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_18 = 0.200000002980232

			if 4 <= arg_187_1.time_ and arg_187_1.time_ < 4 + var_190_18 and not isNil(var_190_17) then
				if arg_187_1.var_.characterEffect1070ui_story and not isNil(var_190_17) then
					arg_187_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= 4 + var_190_18 and arg_187_1.time_ < 4 + var_190_18 + arg_190_0 and not isNil(var_190_17) and arg_187_1.var_.characterEffect1070ui_story then
				arg_187_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_190_20 = arg_187_1.actors_["1070ui_story"].transform

			if 1.98333333333333 < arg_187_1.time_ and arg_187_1.time_ <= 1.98333333333333 + arg_190_0 then
				arg_187_1.var_.moveOldPos1070ui_story = var_190_20.localPosition
			end

			local var_190_21 = 0.001

			if 1.98333333333333 <= arg_187_1.time_ and arg_187_1.time_ < 1.98333333333333 + var_190_21 then
				var_190_20.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 1.98333333333333) / var_190_21)
				var_190_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_20.position).x, (manager.ui.mainCamera.transform.position - var_190_20.position).y, (manager.ui.mainCamera.transform.position - var_190_20.position).z)
				var_190_20.localEulerAngles.z = 0
				var_190_20.localEulerAngles.x = 0
				var_190_20.localEulerAngles = var_190_20.localEulerAngles
			end

			if arg_187_1.time_ >= 1.98333333333333 + var_190_21 and arg_187_1.time_ < 1.98333333333333 + var_190_21 + arg_190_0 then
				var_190_20.localPosition = Vector3.New(0, 100, 0)
				var_190_20.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_20.position).x, (manager.ui.mainCamera.transform.position - var_190_20.position).y, (manager.ui.mainCamera.transform.position - var_190_20.position).z)
				var_190_20.localEulerAngles.z = 0
				var_190_20.localEulerAngles.x = 0
				var_190_20.localEulerAngles = var_190_20.localEulerAngles
			end

			local var_190_22 = arg_187_1.actors_["10039ui_story"].transform

			if 1.98333333333333 < arg_187_1.time_ and arg_187_1.time_ <= 1.98333333333333 + arg_190_0 then
				arg_187_1.var_.moveOldPos10039ui_story = var_190_22.localPosition
			end

			local var_190_23 = 0.001

			if 1.98333333333333 <= arg_187_1.time_ and arg_187_1.time_ < 1.98333333333333 + var_190_23 then
				var_190_22.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10039ui_story, Vector3.New(0, 100, 0), (arg_187_1.time_ - 1.98333333333333) / var_190_23)
				var_190_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_22.position).x, (manager.ui.mainCamera.transform.position - var_190_22.position).y, (manager.ui.mainCamera.transform.position - var_190_22.position).z)
				var_190_22.localEulerAngles.z = 0
				var_190_22.localEulerAngles.x = 0
				var_190_22.localEulerAngles = var_190_22.localEulerAngles
			end

			if arg_187_1.time_ >= 1.98333333333333 + var_190_23 and arg_187_1.time_ < 1.98333333333333 + var_190_23 + arg_190_0 then
				var_190_22.localPosition = Vector3.New(0, 100, 0)
				var_190_22.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_190_22.position).x, (manager.ui.mainCamera.transform.position - var_190_22.position).y, (manager.ui.mainCamera.transform.position - var_190_22.position).z)
				var_190_22.localEulerAngles.z = 0
				var_190_22.localEulerAngles.x = 0
				var_190_22.localEulerAngles = var_190_22.localEulerAngles
			end

			if 4 < arg_187_1.time_ and arg_187_1.time_ <= 4 + arg_190_0 then
				arg_187_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 4 < arg_187_1.time_ and arg_187_1.time_ <= 4 + arg_190_0 then
				arg_187_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva", "EmotionTimelineAnimator")
			end

			if arg_187_1.frameCnt_ <= 1 then
				arg_187_1.dialog_:SetActive(false)
			end

			local var_190_24 = 4
			local var_190_25 = 0.175

			if 4 < arg_187_1.time_ and arg_187_1.time_ <= var_190_24 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0

				arg_187_1.dialog_:SetActive(true)

				arg_187_1.dialogCg_.alpha = 0

				local var_190_26 = LeanTween.value(arg_187_1.dialog_, 0, 1, 0.3)

				var_190_26:setOnUpdate(LuaHelper.FloatAction(function(arg_191_0)
					arg_187_1.dialogCg_.alpha = arg_191_0
				end))
				var_190_26:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_187_1.dialog_)
					var_190_26:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_187_1.duration_ = arg_187_1.duration_ + 0.3

				SetActive(arg_187_1.leftNameGo_, true)

				arg_187_1.leftNameTxt_.text = arg_187_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_27 = arg_187_1:FormatText(arg_187_1:GetWordFromCfg(935011046).content)

				arg_187_1.text_.text = var_190_27

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_29 = 7 <= 0 and var_190_25 or var_190_25 * (utf8.len(var_190_27) / 7)

				if (7 <= 0 and var_190_25 or var_190_25 * (utf8.len(var_190_27) / 7)) > 0 and var_190_25 < var_190_29 then
					arg_187_1.talkMaxDuration = var_190_29
					var_190_24 = var_190_24 + 0.3

					if var_190_29 + var_190_24 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_29 + var_190_24
					end
				end

				arg_187_1.text_.text = var_190_27
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)
				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_30 = var_190_24 + 0.3
			local var_190_31 = math.max(var_190_25, arg_187_1.talkMaxDuration)

			if var_190_24 + 0.3 <= arg_187_1.time_ and arg_187_1.time_ < var_190_30 + var_190_31 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_30) / var_190_31

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_30 + var_190_31 and arg_187_1.time_ < var_190_30 + var_190_31 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end

		arg_187_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 4,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			},
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.0166666666666667,
				className = "StoryMoveNode",
				startTime = 1.98333333333333,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_187_1:InitPlayNodeList()
	end,
	Play935011047 = function(arg_193_0, arg_193_1)
		arg_193_1.time_ = 0
		arg_193_1.frameCnt_ = 0
		arg_193_1.state_ = "playing"
		arg_193_1.curTalkId_ = 935011047
		arg_193_1.duration_ = 5

		SetActive(arg_193_1.tipsGo_, false)

		function arg_193_1.onSingleLineFinish_()
			arg_193_1.onSingleLineUpdate_ = nil
			arg_193_1.onSingleLineFinish_ = nil
			arg_193_1.state_ = "waiting"
		end

		function arg_193_1.playNext_(arg_195_0)
			if arg_195_0 == 1 then
				arg_193_0:Play935011048(arg_193_1)
			end
		end

		function arg_193_1.onSingleLineUpdate_(arg_196_0)
			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1.var_.moveOldPos10039ui_story = arg_193_1.actors_["10039ui_story"].transform.localPosition
			end

			local var_196_0 = 0.001

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_0 then
				arg_193_1.actors_["10039ui_story"].transform.localPosition = Vector3.Lerp(arg_193_1.var_.moveOldPos10039ui_story, Vector3.New(0.7, -0.8, -6.2), (arg_193_1.time_ - 0) / var_196_0)
				arg_193_1.actors_["10039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10039ui_story"].transform.position).z)
				arg_193_1.actors_["10039ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10039ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10039ui_story"].transform.localEulerAngles = arg_193_1.actors_["10039ui_story"].transform.localEulerAngles
			end

			if arg_193_1.time_ >= 0 + var_196_0 and arg_193_1.time_ < 0 + var_196_0 + arg_196_0 then
				arg_193_1.actors_["10039ui_story"].transform.localPosition = Vector3.New(0.7, -0.8, -6.2)
				arg_193_1.actors_["10039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_193_1.actors_["10039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_193_1.actors_["10039ui_story"].transform.position).z)
				arg_193_1.actors_["10039ui_story"].transform.localEulerAngles.z = 0
				arg_193_1.actors_["10039ui_story"].transform.localEulerAngles.x = 0
				arg_193_1.actors_["10039ui_story"].transform.localEulerAngles = arg_193_1.actors_["10039ui_story"].transform.localEulerAngles
			end

			local var_196_1 = arg_193_1.actors_["10039ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10039ui_story == nil then
				arg_193_1.var_.characterEffect10039ui_story = var_196_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_2 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_2 and not isNil(var_196_1) then
				if arg_193_1.var_.characterEffect10039ui_story and not isNil(var_196_1) then
					arg_193_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_193_1.time_ >= 0 + var_196_2 and arg_193_1.time_ < 0 + var_196_2 + arg_196_0 and not isNil(var_196_1) and arg_193_1.var_.characterEffect10039ui_story then
				arg_193_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_196_4 = arg_193_1.actors_["1070ui_story"]

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1070ui_story == nil then
				arg_193_1.var_.characterEffect1070ui_story = var_196_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_196_5 = 0.200000002980232

			if 0 <= arg_193_1.time_ and arg_193_1.time_ < 0 + var_196_5 and not isNil(var_196_4) then
				if arg_193_1.var_.characterEffect1070ui_story and not isNil(var_196_4) then
					arg_193_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_193_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_193_1.time_ - 0) / var_196_5)
				end
			end

			if arg_193_1.time_ >= 0 + var_196_5 and arg_193_1.time_ < 0 + var_196_5 + arg_196_0 and not isNil(var_196_4) and arg_193_1.var_.characterEffect1070ui_story then
				arg_193_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_193_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action2_1")
			end

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= 0 + arg_196_0 then
				arg_193_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_196_6 = 0
			local var_196_7 = 0.225

			if 0 < arg_193_1.time_ and arg_193_1.time_ <= var_196_6 + arg_196_0 then
				arg_193_1.talkMaxDuration = 0
				arg_193_1.dialogCg_.alpha = 1

				arg_193_1.dialog_:SetActive(true)
				SetActive(arg_193_1.leftNameGo_, true)

				arg_193_1.leftNameTxt_.text = arg_193_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_193_1.leftNameTxt_.transform)

				arg_193_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_193_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_193_1:RecordName(arg_193_1.leftNameTxt_.text)
				SetActive(arg_193_1.iconTrs_.gameObject, false)
				arg_193_1.callingController_:SetSelectedState("normal")

				local var_196_8 = arg_193_1:FormatText(arg_193_1:GetWordFromCfg(935011047).content)

				arg_193_1.text_.text = var_196_8

				LuaForUtil.ClearLinePrefixSymbol(arg_193_1.text_)

				local var_196_10 = 9 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_8) / 9)

				if (9 <= 0 and var_196_7 or var_196_7 * (utf8.len(var_196_8) / 9)) > 0 and var_196_7 < var_196_10 then
					arg_193_1.talkMaxDuration = var_196_10

					if var_196_10 + var_196_6 > arg_193_1.duration_ then
						arg_193_1.duration_ = var_196_10 + var_196_6
					end
				end

				arg_193_1.text_.text = var_196_8
				arg_193_1.typewritter.percent = 0

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(false)
				arg_193_1:RecordContent(arg_193_1.text_.text)
			end

			local var_196_11 = math.max(var_196_7, arg_193_1.talkMaxDuration)

			if var_196_6 <= arg_193_1.time_ and arg_193_1.time_ < var_196_6 + var_196_11 then
				arg_193_1.typewritter.percent = (arg_193_1.time_ - var_196_6) / var_196_11

				arg_193_1.typewritter:SetDirty()
			end

			if arg_193_1.time_ >= var_196_6 + var_196_11 and arg_193_1.time_ < var_196_6 + var_196_11 + arg_196_0 then
				arg_193_1.typewritter.percent = 1

				arg_193_1.typewritter:SetDirty()
				arg_193_1:ShowNextGo(true)
			end
		end

		arg_193_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
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
	Play935011048 = function(arg_197_0, arg_197_1)
		arg_197_1.time_ = 0
		arg_197_1.frameCnt_ = 0
		arg_197_1.state_ = "playing"
		arg_197_1.curTalkId_ = 935011048
		arg_197_1.duration_ = 5

		SetActive(arg_197_1.tipsGo_, false)

		function arg_197_1.onSingleLineFinish_()
			arg_197_1.onSingleLineUpdate_ = nil
			arg_197_1.onSingleLineFinish_ = nil
			arg_197_1.state_ = "waiting"
		end

		function arg_197_1.playNext_(arg_199_0)
			if arg_199_0 == 1 then
				arg_197_0:Play935011049(arg_197_1)
			end
		end

		function arg_197_1.onSingleLineUpdate_(arg_200_0)
			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(arg_197_1.actors_["1070ui_story"]) and arg_197_1.var_.characterEffect1070ui_story == nil then
				arg_197_1.var_.characterEffect1070ui_story = arg_197_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_0 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_0 and not isNil(arg_197_1.actors_["1070ui_story"]) then
				if arg_197_1.var_.characterEffect1070ui_story and not isNil(arg_197_1.actors_["1070ui_story"]) then
					arg_197_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_197_1.time_ >= 0 + var_200_0 and arg_197_1.time_ < 0 + var_200_0 + arg_200_0 and not isNil(arg_197_1.actors_["1070ui_story"]) and arg_197_1.var_.characterEffect1070ui_story then
				arg_197_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_200_2 = arg_197_1.actors_["10039ui_story"]

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect10039ui_story == nil then
				arg_197_1.var_.characterEffect10039ui_story = var_200_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_200_3 = 0.200000002980232

			if 0 <= arg_197_1.time_ and arg_197_1.time_ < 0 + var_200_3 and not isNil(var_200_2) then
				if arg_197_1.var_.characterEffect10039ui_story and not isNil(var_200_2) then
					arg_197_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_197_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_197_1.time_ - 0) / var_200_3)
				end
			end

			if arg_197_1.time_ >= 0 + var_200_3 and arg_197_1.time_ < 0 + var_200_3 + arg_200_0 and not isNil(var_200_2) and arg_197_1.var_.characterEffect10039ui_story then
				arg_197_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_197_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= 0 + arg_200_0 then
				arg_197_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_200_4 = 0
			local var_200_5 = 0.275

			if 0 < arg_197_1.time_ and arg_197_1.time_ <= var_200_4 + arg_200_0 then
				arg_197_1.talkMaxDuration = 0
				arg_197_1.dialogCg_.alpha = 1

				arg_197_1.dialog_:SetActive(true)
				SetActive(arg_197_1.leftNameGo_, true)

				arg_197_1.leftNameTxt_.text = arg_197_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_197_1.leftNameTxt_.transform)

				arg_197_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_197_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_197_1:RecordName(arg_197_1.leftNameTxt_.text)
				SetActive(arg_197_1.iconTrs_.gameObject, false)
				arg_197_1.callingController_:SetSelectedState("normal")

				local var_200_6 = arg_197_1:FormatText(arg_197_1:GetWordFromCfg(935011048).content)

				arg_197_1.text_.text = var_200_6

				LuaForUtil.ClearLinePrefixSymbol(arg_197_1.text_)

				local var_200_8 = 11 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_6) / 11)

				if (11 <= 0 and var_200_5 or var_200_5 * (utf8.len(var_200_6) / 11)) > 0 and var_200_5 < var_200_8 then
					arg_197_1.talkMaxDuration = var_200_8

					if var_200_8 + var_200_4 > arg_197_1.duration_ then
						arg_197_1.duration_ = var_200_8 + var_200_4
					end
				end

				arg_197_1.text_.text = var_200_6
				arg_197_1.typewritter.percent = 0

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(false)
				arg_197_1:RecordContent(arg_197_1.text_.text)
			end

			local var_200_9 = math.max(var_200_5, arg_197_1.talkMaxDuration)

			if var_200_4 <= arg_197_1.time_ and arg_197_1.time_ < var_200_4 + var_200_9 then
				arg_197_1.typewritter.percent = (arg_197_1.time_ - var_200_4) / var_200_9

				arg_197_1.typewritter:SetDirty()
			end

			if arg_197_1.time_ >= var_200_4 + var_200_9 and arg_197_1.time_ < var_200_4 + var_200_9 + arg_200_0 then
				arg_197_1.typewritter.percent = 1

				arg_197_1.typewritter:SetDirty()
				arg_197_1:ShowNextGo(true)
			end
		end

		arg_197_1.nodeConfigList_ = {}

		arg_197_1:InitPlayNodeList()
	end,
	Play935011049 = function(arg_201_0, arg_201_1)
		arg_201_1.time_ = 0
		arg_201_1.frameCnt_ = 0
		arg_201_1.state_ = "playing"
		arg_201_1.curTalkId_ = 935011049
		arg_201_1.duration_ = 5

		SetActive(arg_201_1.tipsGo_, false)

		function arg_201_1.onSingleLineFinish_()
			arg_201_1.onSingleLineUpdate_ = nil
			arg_201_1.onSingleLineFinish_ = nil
			arg_201_1.state_ = "waiting"
		end

		function arg_201_1.playNext_(arg_203_0)
			if arg_203_0 == 1 then
				arg_201_0:Play935011050(arg_201_1)
			end
		end

		function arg_201_1.onSingleLineUpdate_(arg_204_0)
			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(arg_201_1.actors_["10039ui_story"]) and arg_201_1.var_.characterEffect10039ui_story == nil then
				arg_201_1.var_.characterEffect10039ui_story = arg_201_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_0 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_0 and not isNil(arg_201_1.actors_["10039ui_story"]) then
				if arg_201_1.var_.characterEffect10039ui_story and not isNil(arg_201_1.actors_["10039ui_story"]) then
					arg_201_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_201_1.time_ >= 0 + var_204_0 and arg_201_1.time_ < 0 + var_204_0 + arg_204_0 and not isNil(arg_201_1.actors_["10039ui_story"]) and arg_201_1.var_.characterEffect10039ui_story then
				arg_201_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_204_2 = arg_201_1.actors_["1070ui_story"]

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1070ui_story == nil then
				arg_201_1.var_.characterEffect1070ui_story = var_204_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_204_3 = 0.200000002980232

			if 0 <= arg_201_1.time_ and arg_201_1.time_ < 0 + var_204_3 and not isNil(var_204_2) then
				if arg_201_1.var_.characterEffect1070ui_story and not isNil(var_204_2) then
					arg_201_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_201_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_201_1.time_ - 0) / var_204_3)
				end
			end

			if arg_201_1.time_ >= 0 + var_204_3 and arg_201_1.time_ < 0 + var_204_3 + arg_204_0 and not isNil(var_204_2) and arg_201_1.var_.characterEffect1070ui_story then
				arg_201_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_201_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action423")
			end

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= 0 + arg_204_0 then
				arg_201_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva", "EmotionTimelineAnimator")
			end

			local var_204_4 = 0
			local var_204_5 = 0.15

			if 0 < arg_201_1.time_ and arg_201_1.time_ <= var_204_4 + arg_204_0 then
				arg_201_1.talkMaxDuration = 0
				arg_201_1.dialogCg_.alpha = 1

				arg_201_1.dialog_:SetActive(true)
				SetActive(arg_201_1.leftNameGo_, true)

				arg_201_1.leftNameTxt_.text = arg_201_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_201_1.leftNameTxt_.transform)

				arg_201_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_201_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_201_1:RecordName(arg_201_1.leftNameTxt_.text)
				SetActive(arg_201_1.iconTrs_.gameObject, false)
				arg_201_1.callingController_:SetSelectedState("normal")

				local var_204_6 = arg_201_1:FormatText(arg_201_1:GetWordFromCfg(935011049).content)

				arg_201_1.text_.text = var_204_6

				LuaForUtil.ClearLinePrefixSymbol(arg_201_1.text_)

				local var_204_8 = 6 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 6)

				if (6 <= 0 and var_204_5 or var_204_5 * (utf8.len(var_204_6) / 6)) > 0 and var_204_5 < var_204_8 then
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

		arg_201_1.nodeConfigList_ = {}

		arg_201_1:InitPlayNodeList()
	end,
	Play935011050 = function(arg_205_0, arg_205_1)
		arg_205_1.time_ = 0
		arg_205_1.frameCnt_ = 0
		arg_205_1.state_ = "playing"
		arg_205_1.curTalkId_ = 935011050
		arg_205_1.duration_ = 5

		SetActive(arg_205_1.tipsGo_, false)

		function arg_205_1.onSingleLineFinish_()
			arg_205_1.onSingleLineUpdate_ = nil
			arg_205_1.onSingleLineFinish_ = nil
			arg_205_1.state_ = "waiting"
		end

		function arg_205_1.playNext_(arg_207_0)
			if arg_207_0 == 1 then
				arg_205_0:Play935011051(arg_205_1)
			end
		end

		function arg_205_1.onSingleLineUpdate_(arg_208_0)
			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(arg_205_1.actors_["1070ui_story"]) and arg_205_1.var_.characterEffect1070ui_story == nil then
				arg_205_1.var_.characterEffect1070ui_story = arg_205_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_0 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_0 and not isNil(arg_205_1.actors_["1070ui_story"]) then
				if arg_205_1.var_.characterEffect1070ui_story and not isNil(arg_205_1.actors_["1070ui_story"]) then
					arg_205_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_205_1.time_ >= 0 + var_208_0 and arg_205_1.time_ < 0 + var_208_0 + arg_208_0 and not isNil(arg_205_1.actors_["1070ui_story"]) and arg_205_1.var_.characterEffect1070ui_story then
				arg_205_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_208_2 = arg_205_1.actors_["10039ui_story"]

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10039ui_story == nil then
				arg_205_1.var_.characterEffect10039ui_story = var_208_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_208_3 = 0.200000002980232

			if 0 <= arg_205_1.time_ and arg_205_1.time_ < 0 + var_208_3 and not isNil(var_208_2) then
				if arg_205_1.var_.characterEffect10039ui_story and not isNil(var_208_2) then
					arg_205_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_205_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_205_1.time_ - 0) / var_208_3)
				end
			end

			if arg_205_1.time_ >= 0 + var_208_3 and arg_205_1.time_ < 0 + var_208_3 + arg_208_0 and not isNil(var_208_2) and arg_205_1.var_.characterEffect10039ui_story then
				arg_205_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_205_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= 0 + arg_208_0 then
				arg_205_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2203cva", "EmotionTimelineAnimator")
			end

			local var_208_4 = 0
			local var_208_5 = 0.075

			if 0 < arg_205_1.time_ and arg_205_1.time_ <= var_208_4 + arg_208_0 then
				arg_205_1.talkMaxDuration = 0
				arg_205_1.dialogCg_.alpha = 1

				arg_205_1.dialog_:SetActive(true)
				SetActive(arg_205_1.leftNameGo_, true)

				arg_205_1.leftNameTxt_.text = arg_205_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_205_1.leftNameTxt_.transform)

				arg_205_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_205_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_205_1:RecordName(arg_205_1.leftNameTxt_.text)
				SetActive(arg_205_1.iconTrs_.gameObject, false)
				arg_205_1.callingController_:SetSelectedState("normal")

				local var_208_6 = arg_205_1:FormatText(arg_205_1:GetWordFromCfg(935011050).content)

				arg_205_1.text_.text = var_208_6

				LuaForUtil.ClearLinePrefixSymbol(arg_205_1.text_)

				local var_208_8 = 3 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 3)

				if (3 <= 0 and var_208_5 or var_208_5 * (utf8.len(var_208_6) / 3)) > 0 and var_208_5 < var_208_8 then
					arg_205_1.talkMaxDuration = var_208_8

					if var_208_8 + var_208_4 > arg_205_1.duration_ then
						arg_205_1.duration_ = var_208_8 + var_208_4
					end
				end

				arg_205_1.text_.text = var_208_6
				arg_205_1.typewritter.percent = 0

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(false)
				arg_205_1:RecordContent(arg_205_1.text_.text)
			end

			local var_208_9 = math.max(var_208_5, arg_205_1.talkMaxDuration)

			if var_208_4 <= arg_205_1.time_ and arg_205_1.time_ < var_208_4 + var_208_9 then
				arg_205_1.typewritter.percent = (arg_205_1.time_ - var_208_4) / var_208_9

				arg_205_1.typewritter:SetDirty()
			end

			if arg_205_1.time_ >= var_208_4 + var_208_9 and arg_205_1.time_ < var_208_4 + var_208_9 + arg_208_0 then
				arg_205_1.typewritter.percent = 1

				arg_205_1.typewritter:SetDirty()
				arg_205_1:ShowNextGo(true)
			end
		end

		arg_205_1.nodeConfigList_ = {}

		arg_205_1:InitPlayNodeList()
	end,
	Play935011051 = function(arg_209_0, arg_209_1)
		arg_209_1.time_ = 0
		arg_209_1.frameCnt_ = 0
		arg_209_1.state_ = "playing"
		arg_209_1.curTalkId_ = 935011051
		arg_209_1.duration_ = 5

		SetActive(arg_209_1.tipsGo_, false)

		function arg_209_1.onSingleLineFinish_()
			arg_209_1.onSingleLineUpdate_ = nil
			arg_209_1.onSingleLineFinish_ = nil
			arg_209_1.state_ = "waiting"
		end

		function arg_209_1.playNext_(arg_211_0)
			if arg_211_0 == 1 then
				arg_209_0:Play935011052(arg_209_1)
			end
		end

		function arg_209_1.onSingleLineUpdate_(arg_212_0)
			if 0 < arg_209_1.time_ and arg_209_1.time_ <= 0 + arg_212_0 and not isNil(arg_209_1.actors_["1070ui_story"]) and arg_209_1.var_.characterEffect1070ui_story == nil then
				arg_209_1.var_.characterEffect1070ui_story = arg_209_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_212_0 = 0.200000002980232

			if 0 <= arg_209_1.time_ and arg_209_1.time_ < 0 + var_212_0 and not isNil(arg_209_1.actors_["1070ui_story"]) then
				if arg_209_1.var_.characterEffect1070ui_story and not isNil(arg_209_1.actors_["1070ui_story"]) then
					arg_209_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_209_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_209_1.time_ - 0) / var_212_0)
				end
			end

			if arg_209_1.time_ >= 0 + var_212_0 and arg_209_1.time_ < 0 + var_212_0 + arg_212_0 and not isNil(arg_209_1.actors_["1070ui_story"]) and arg_209_1.var_.characterEffect1070ui_story then
				arg_209_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_209_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_212_1 = 0
			local var_212_2 = 1.125

			if 0 < arg_209_1.time_ and arg_209_1.time_ <= var_212_1 + arg_212_0 then
				arg_209_1.talkMaxDuration = 0
				arg_209_1.dialogCg_.alpha = 1

				arg_209_1.dialog_:SetActive(true)
				SetActive(arg_209_1.leftNameGo_, false)

				arg_209_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_209_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_209_1:RecordName(arg_209_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_209_1.iconTrs_.gameObject, false)
				arg_209_1.callingController_:SetSelectedState("normal")

				local var_212_3 = arg_209_1:FormatText(arg_209_1:GetWordFromCfg(935011051).content)

				arg_209_1.text_.text = var_212_3

				LuaForUtil.ClearLinePrefixSymbol(arg_209_1.text_)

				local var_212_5 = 45 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 45)

				if (45 <= 0 and var_212_2 or var_212_2 * (utf8.len(var_212_3) / 45)) > 0 and var_212_2 < var_212_5 then
					arg_209_1.talkMaxDuration = var_212_5

					if var_212_5 + var_212_1 > arg_209_1.duration_ then
						arg_209_1.duration_ = var_212_5 + var_212_1
					end
				end

				arg_209_1.text_.text = var_212_3
				arg_209_1.typewritter.percent = 0

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(false)
				arg_209_1:RecordContent(arg_209_1.text_.text)
			end

			local var_212_6 = math.max(var_212_2, arg_209_1.talkMaxDuration)

			if var_212_1 <= arg_209_1.time_ and arg_209_1.time_ < var_212_1 + var_212_6 then
				arg_209_1.typewritter.percent = (arg_209_1.time_ - var_212_1) / var_212_6

				arg_209_1.typewritter:SetDirty()
			end

			if arg_209_1.time_ >= var_212_1 + var_212_6 and arg_209_1.time_ < var_212_1 + var_212_6 + arg_212_0 then
				arg_209_1.typewritter.percent = 1

				arg_209_1.typewritter:SetDirty()
				arg_209_1:ShowNextGo(true)
			end
		end

		arg_209_1.nodeConfigList_ = {}

		arg_209_1:InitPlayNodeList()
	end,
	Play935011052 = function(arg_213_0, arg_213_1)
		arg_213_1.time_ = 0
		arg_213_1.frameCnt_ = 0
		arg_213_1.state_ = "playing"
		arg_213_1.curTalkId_ = 935011052
		arg_213_1.duration_ = 5

		SetActive(arg_213_1.tipsGo_, false)

		function arg_213_1.onSingleLineFinish_()
			arg_213_1.onSingleLineUpdate_ = nil
			arg_213_1.onSingleLineFinish_ = nil
			arg_213_1.state_ = "waiting"
		end

		function arg_213_1.playNext_(arg_215_0)
			if arg_215_0 == 1 then
				arg_213_0:Play935011053(arg_213_1)
			end
		end

		function arg_213_1.onSingleLineUpdate_(arg_216_0)
			if 0 < arg_213_1.time_ and arg_213_1.time_ <= 0 + arg_216_0 and not isNil(arg_213_1.actors_["1070ui_story"]) and arg_213_1.var_.characterEffect1070ui_story == nil then
				arg_213_1.var_.characterEffect1070ui_story = arg_213_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_216_0 = 0.200000002980232

			if 0 <= arg_213_1.time_ and arg_213_1.time_ < 0 + var_216_0 and not isNil(arg_213_1.actors_["1070ui_story"]) then
				if arg_213_1.var_.characterEffect1070ui_story and not isNil(arg_213_1.actors_["1070ui_story"]) then
					arg_213_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_213_1.time_ >= 0 + var_216_0 and arg_213_1.time_ < 0 + var_216_0 + arg_216_0 and not isNil(arg_213_1.actors_["1070ui_story"]) and arg_213_1.var_.characterEffect1070ui_story then
				arg_213_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_216_2 = 0
			local var_216_3 = 0.55

			if 0 < arg_213_1.time_ and arg_213_1.time_ <= var_216_2 + arg_216_0 then
				arg_213_1.talkMaxDuration = 0
				arg_213_1.dialogCg_.alpha = 1

				arg_213_1.dialog_:SetActive(true)
				SetActive(arg_213_1.leftNameGo_, true)

				arg_213_1.leftNameTxt_.text = arg_213_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_213_1.leftNameTxt_.transform)

				arg_213_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_213_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_213_1:RecordName(arg_213_1.leftNameTxt_.text)
				SetActive(arg_213_1.iconTrs_.gameObject, false)
				arg_213_1.callingController_:SetSelectedState("normal")

				local var_216_4 = arg_213_1:FormatText(arg_213_1:GetWordFromCfg(935011052).content)

				arg_213_1.text_.text = var_216_4

				LuaForUtil.ClearLinePrefixSymbol(arg_213_1.text_)

				local var_216_6 = 22 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_4) / 22)

				if (22 <= 0 and var_216_3 or var_216_3 * (utf8.len(var_216_4) / 22)) > 0 and var_216_3 < var_216_6 then
					arg_213_1.talkMaxDuration = var_216_6

					if var_216_6 + var_216_2 > arg_213_1.duration_ then
						arg_213_1.duration_ = var_216_6 + var_216_2
					end
				end

				arg_213_1.text_.text = var_216_4
				arg_213_1.typewritter.percent = 0

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(false)
				arg_213_1:RecordContent(arg_213_1.text_.text)
			end

			local var_216_7 = math.max(var_216_3, arg_213_1.talkMaxDuration)

			if var_216_2 <= arg_213_1.time_ and arg_213_1.time_ < var_216_2 + var_216_7 then
				arg_213_1.typewritter.percent = (arg_213_1.time_ - var_216_2) / var_216_7

				arg_213_1.typewritter:SetDirty()
			end

			if arg_213_1.time_ >= var_216_2 + var_216_7 and arg_213_1.time_ < var_216_2 + var_216_7 + arg_216_0 then
				arg_213_1.typewritter.percent = 1

				arg_213_1.typewritter:SetDirty()
				arg_213_1:ShowNextGo(true)
			end
		end

		arg_213_1.nodeConfigList_ = {}

		arg_213_1:InitPlayNodeList()
	end,
	Play935011053 = function(arg_217_0, arg_217_1)
		arg_217_1.time_ = 0
		arg_217_1.frameCnt_ = 0
		arg_217_1.state_ = "playing"
		arg_217_1.curTalkId_ = 935011053
		arg_217_1.duration_ = 5

		SetActive(arg_217_1.tipsGo_, false)

		function arg_217_1.onSingleLineFinish_()
			arg_217_1.onSingleLineUpdate_ = nil
			arg_217_1.onSingleLineFinish_ = nil
			arg_217_1.state_ = "waiting"
		end

		function arg_217_1.playNext_(arg_219_0)
			if arg_219_0 == 1 then
				arg_217_0:Play935011054(arg_217_1)
			end
		end

		function arg_217_1.onSingleLineUpdate_(arg_220_0)
			local var_220_0 = 0.775

			if 0 < arg_217_1.time_ and arg_217_1.time_ <= 0 + arg_220_0 then
				arg_217_1.talkMaxDuration = 0
				arg_217_1.dialogCg_.alpha = 1

				arg_217_1.dialog_:SetActive(true)
				SetActive(arg_217_1.leftNameGo_, true)

				arg_217_1.leftNameTxt_.text = arg_217_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_217_1.leftNameTxt_.transform)

				arg_217_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_217_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_217_1:RecordName(arg_217_1.leftNameTxt_.text)
				SetActive(arg_217_1.iconTrs_.gameObject, false)
				arg_217_1.callingController_:SetSelectedState("normal")

				local var_220_1 = arg_217_1:FormatText(arg_217_1:GetWordFromCfg(935011053).content)

				arg_217_1.text_.text = var_220_1

				LuaForUtil.ClearLinePrefixSymbol(arg_217_1.text_)

				local var_220_3 = 31 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 31)

				if (31 <= 0 and var_220_0 or var_220_0 * (utf8.len(var_220_1) / 31)) > 0 and var_220_0 < var_220_3 then
					arg_217_1.talkMaxDuration = var_220_3

					if var_220_3 + 0 > arg_217_1.duration_ then
						arg_217_1.duration_ = var_220_3 + 0
					end
				end

				arg_217_1.text_.text = var_220_1
				arg_217_1.typewritter.percent = 0

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(false)
				arg_217_1:RecordContent(arg_217_1.text_.text)
			end

			local var_220_4 = math.max(var_220_0, arg_217_1.talkMaxDuration)

			if 0 <= arg_217_1.time_ and arg_217_1.time_ < 0 + var_220_4 then
				arg_217_1.typewritter.percent = (arg_217_1.time_ - 0) / var_220_4

				arg_217_1.typewritter:SetDirty()
			end

			if arg_217_1.time_ >= 0 + var_220_4 and arg_217_1.time_ < 0 + var_220_4 + arg_220_0 then
				arg_217_1.typewritter.percent = 1

				arg_217_1.typewritter:SetDirty()
				arg_217_1:ShowNextGo(true)
			end
		end

		arg_217_1.nodeConfigList_ = {}

		arg_217_1:InitPlayNodeList()
	end,
	Play935011054 = function(arg_221_0, arg_221_1)
		arg_221_1.time_ = 0
		arg_221_1.frameCnt_ = 0
		arg_221_1.state_ = "playing"
		arg_221_1.curTalkId_ = 935011054
		arg_221_1.duration_ = 5

		SetActive(arg_221_1.tipsGo_, false)

		function arg_221_1.onSingleLineFinish_()
			arg_221_1.onSingleLineUpdate_ = nil
			arg_221_1.onSingleLineFinish_ = nil
			arg_221_1.state_ = "waiting"
		end

		function arg_221_1.playNext_(arg_223_0)
			if arg_223_0 == 1 then
				arg_221_0:Play935011055(arg_221_1)
			end
		end

		function arg_221_1.onSingleLineUpdate_(arg_224_0)
			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 and not isNil(arg_221_1.actors_["1070ui_story"]) and arg_221_1.var_.characterEffect1070ui_story == nil then
				arg_221_1.var_.characterEffect1070ui_story = arg_221_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_224_0 = 0.200000002980232

			if 0 <= arg_221_1.time_ and arg_221_1.time_ < 0 + var_224_0 and not isNil(arg_221_1.actors_["1070ui_story"]) then
				if arg_221_1.var_.characterEffect1070ui_story and not isNil(arg_221_1.actors_["1070ui_story"]) then
					arg_221_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_221_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_221_1.time_ - 0) / var_224_0)
				end
			end

			if arg_221_1.time_ >= 0 + var_224_0 and arg_221_1.time_ < 0 + var_224_0 + arg_224_0 and not isNil(arg_221_1.actors_["1070ui_story"]) and arg_221_1.var_.characterEffect1070ui_story then
				arg_221_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_221_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= 0 + arg_224_0 then
				arg_221_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action436")
			end

			local var_224_1 = 0
			local var_224_2 = 0.9

			if 0 < arg_221_1.time_ and arg_221_1.time_ <= var_224_1 + arg_224_0 then
				arg_221_1.talkMaxDuration = 0
				arg_221_1.dialogCg_.alpha = 1

				arg_221_1.dialog_:SetActive(true)
				SetActive(arg_221_1.leftNameGo_, false)

				arg_221_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_221_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_221_1:RecordName(arg_221_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_221_1.iconTrs_.gameObject, false)
				arg_221_1.callingController_:SetSelectedState("normal")

				local var_224_3 = arg_221_1:FormatText(arg_221_1:GetWordFromCfg(935011054).content)

				arg_221_1.text_.text = var_224_3

				LuaForUtil.ClearLinePrefixSymbol(arg_221_1.text_)

				local var_224_5 = 36 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 36)

				if (36 <= 0 and var_224_2 or var_224_2 * (utf8.len(var_224_3) / 36)) > 0 and var_224_2 < var_224_5 then
					arg_221_1.talkMaxDuration = var_224_5

					if var_224_5 + var_224_1 > arg_221_1.duration_ then
						arg_221_1.duration_ = var_224_5 + var_224_1
					end
				end

				arg_221_1.text_.text = var_224_3
				arg_221_1.typewritter.percent = 0

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(false)
				arg_221_1:RecordContent(arg_221_1.text_.text)
			end

			local var_224_6 = math.max(var_224_2, arg_221_1.talkMaxDuration)

			if var_224_1 <= arg_221_1.time_ and arg_221_1.time_ < var_224_1 + var_224_6 then
				arg_221_1.typewritter.percent = (arg_221_1.time_ - var_224_1) / var_224_6

				arg_221_1.typewritter:SetDirty()
			end

			if arg_221_1.time_ >= var_224_1 + var_224_6 and arg_221_1.time_ < var_224_1 + var_224_6 + arg_224_0 then
				arg_221_1.typewritter.percent = 1

				arg_221_1.typewritter:SetDirty()
				arg_221_1:ShowNextGo(true)
			end
		end

		arg_221_1.nodeConfigList_ = {}

		arg_221_1:InitPlayNodeList()
	end,
	Play935011055 = function(arg_225_0, arg_225_1)
		arg_225_1.time_ = 0
		arg_225_1.frameCnt_ = 0
		arg_225_1.state_ = "playing"
		arg_225_1.curTalkId_ = 935011055
		arg_225_1.duration_ = 5

		SetActive(arg_225_1.tipsGo_, false)

		function arg_225_1.onSingleLineFinish_()
			arg_225_1.onSingleLineUpdate_ = nil
			arg_225_1.onSingleLineFinish_ = nil
			arg_225_1.state_ = "waiting"
		end

		function arg_225_1.playNext_(arg_227_0)
			if arg_227_0 == 1 then
				arg_225_0:Play935011056(arg_225_1)
			end
		end

		function arg_225_1.onSingleLineUpdate_(arg_228_0)
			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 and not isNil(arg_225_1.actors_["1070ui_story"]) and arg_225_1.var_.characterEffect1070ui_story == nil then
				arg_225_1.var_.characterEffect1070ui_story = arg_225_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_228_0 = 0.200000002980232

			if 0 <= arg_225_1.time_ and arg_225_1.time_ < 0 + var_228_0 and not isNil(arg_225_1.actors_["1070ui_story"]) then
				if arg_225_1.var_.characterEffect1070ui_story and not isNil(arg_225_1.actors_["1070ui_story"]) then
					arg_225_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_225_1.time_ >= 0 + var_228_0 and arg_225_1.time_ < 0 + var_228_0 + arg_228_0 and not isNil(arg_225_1.actors_["1070ui_story"]) and arg_225_1.var_.characterEffect1070ui_story then
				arg_225_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= 0 + arg_228_0 then
				arg_225_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_2")
			end

			local var_228_2 = 0
			local var_228_3 = 0.225

			if 0 < arg_225_1.time_ and arg_225_1.time_ <= var_228_2 + arg_228_0 then
				arg_225_1.talkMaxDuration = 0
				arg_225_1.dialogCg_.alpha = 1

				arg_225_1.dialog_:SetActive(true)
				SetActive(arg_225_1.leftNameGo_, true)

				arg_225_1.leftNameTxt_.text = arg_225_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_225_1.leftNameTxt_.transform)

				arg_225_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_225_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_225_1:RecordName(arg_225_1.leftNameTxt_.text)
				SetActive(arg_225_1.iconTrs_.gameObject, false)
				arg_225_1.callingController_:SetSelectedState("normal")

				local var_228_4 = arg_225_1:FormatText(arg_225_1:GetWordFromCfg(935011055).content)

				arg_225_1.text_.text = var_228_4

				LuaForUtil.ClearLinePrefixSymbol(arg_225_1.text_)

				local var_228_6 = 9 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_4) / 9)

				if (9 <= 0 and var_228_3 or var_228_3 * (utf8.len(var_228_4) / 9)) > 0 and var_228_3 < var_228_6 then
					arg_225_1.talkMaxDuration = var_228_6

					if var_228_6 + var_228_2 > arg_225_1.duration_ then
						arg_225_1.duration_ = var_228_6 + var_228_2
					end
				end

				arg_225_1.text_.text = var_228_4
				arg_225_1.typewritter.percent = 0

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(false)
				arg_225_1:RecordContent(arg_225_1.text_.text)
			end

			local var_228_7 = math.max(var_228_3, arg_225_1.talkMaxDuration)

			if var_228_2 <= arg_225_1.time_ and arg_225_1.time_ < var_228_2 + var_228_7 then
				arg_225_1.typewritter.percent = (arg_225_1.time_ - var_228_2) / var_228_7

				arg_225_1.typewritter:SetDirty()
			end

			if arg_225_1.time_ >= var_228_2 + var_228_7 and arg_225_1.time_ < var_228_2 + var_228_7 + arg_228_0 then
				arg_225_1.typewritter.percent = 1

				arg_225_1.typewritter:SetDirty()
				arg_225_1:ShowNextGo(true)
			end
		end

		arg_225_1.nodeConfigList_ = {}

		arg_225_1:InitPlayNodeList()
	end,
	Play935011056 = function(arg_229_0, arg_229_1)
		arg_229_1.time_ = 0
		arg_229_1.frameCnt_ = 0
		arg_229_1.state_ = "playing"
		arg_229_1.curTalkId_ = 935011056
		arg_229_1.duration_ = 5

		SetActive(arg_229_1.tipsGo_, false)

		function arg_229_1.onSingleLineFinish_()
			arg_229_1.onSingleLineUpdate_ = nil
			arg_229_1.onSingleLineFinish_ = nil
			arg_229_1.state_ = "waiting"
		end

		function arg_229_1.playNext_(arg_231_0)
			if arg_231_0 == 1 then
				arg_229_0:Play935011057(arg_229_1)
			end
		end

		function arg_229_1.onSingleLineUpdate_(arg_232_0)
			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(arg_229_1.actors_["10039ui_story"]) and arg_229_1.var_.characterEffect10039ui_story == nil then
				arg_229_1.var_.characterEffect10039ui_story = arg_229_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_0 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_0 and not isNil(arg_229_1.actors_["10039ui_story"]) then
				if arg_229_1.var_.characterEffect10039ui_story and not isNil(arg_229_1.actors_["10039ui_story"]) then
					arg_229_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_229_1.time_ >= 0 + var_232_0 and arg_229_1.time_ < 0 + var_232_0 + arg_232_0 and not isNil(arg_229_1.actors_["10039ui_story"]) and arg_229_1.var_.characterEffect10039ui_story then
				arg_229_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_232_2 = arg_229_1.actors_["1070ui_story"]

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= 0 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1070ui_story == nil then
				arg_229_1.var_.characterEffect1070ui_story = var_232_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_232_3 = 0.200000002980232

			if 0 <= arg_229_1.time_ and arg_229_1.time_ < 0 + var_232_3 and not isNil(var_232_2) then
				if arg_229_1.var_.characterEffect1070ui_story and not isNil(var_232_2) then
					arg_229_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_229_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_229_1.time_ - 0) / var_232_3)
				end
			end

			if arg_229_1.time_ >= 0 + var_232_3 and arg_229_1.time_ < 0 + var_232_3 + arg_232_0 and not isNil(var_232_2) and arg_229_1.var_.characterEffect1070ui_story then
				arg_229_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_229_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_232_4 = 0
			local var_232_5 = 0.6

			if 0 < arg_229_1.time_ and arg_229_1.time_ <= var_232_4 + arg_232_0 then
				arg_229_1.talkMaxDuration = 0
				arg_229_1.dialogCg_.alpha = 1

				arg_229_1.dialog_:SetActive(true)
				SetActive(arg_229_1.leftNameGo_, true)

				arg_229_1.leftNameTxt_.text = arg_229_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_229_1.leftNameTxt_.transform)

				arg_229_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_229_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_229_1:RecordName(arg_229_1.leftNameTxt_.text)
				SetActive(arg_229_1.iconTrs_.gameObject, false)
				arg_229_1.callingController_:SetSelectedState("normal")

				local var_232_6 = arg_229_1:FormatText(arg_229_1:GetWordFromCfg(935011056).content)

				arg_229_1.text_.text = var_232_6

				LuaForUtil.ClearLinePrefixSymbol(arg_229_1.text_)

				local var_232_8 = 24 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_6) / 24)

				if (24 <= 0 and var_232_5 or var_232_5 * (utf8.len(var_232_6) / 24)) > 0 and var_232_5 < var_232_8 then
					arg_229_1.talkMaxDuration = var_232_8

					if var_232_8 + var_232_4 > arg_229_1.duration_ then
						arg_229_1.duration_ = var_232_8 + var_232_4
					end
				end

				arg_229_1.text_.text = var_232_6
				arg_229_1.typewritter.percent = 0

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(false)
				arg_229_1:RecordContent(arg_229_1.text_.text)
			end

			local var_232_9 = math.max(var_232_5, arg_229_1.talkMaxDuration)

			if var_232_4 <= arg_229_1.time_ and arg_229_1.time_ < var_232_4 + var_232_9 then
				arg_229_1.typewritter.percent = (arg_229_1.time_ - var_232_4) / var_232_9

				arg_229_1.typewritter:SetDirty()
			end

			if arg_229_1.time_ >= var_232_4 + var_232_9 and arg_229_1.time_ < var_232_4 + var_232_9 + arg_232_0 then
				arg_229_1.typewritter.percent = 1

				arg_229_1.typewritter:SetDirty()
				arg_229_1:ShowNextGo(true)
			end
		end

		arg_229_1.nodeConfigList_ = {}

		arg_229_1:InitPlayNodeList()
	end,
	Play935011057 = function(arg_233_0, arg_233_1)
		arg_233_1.time_ = 0
		arg_233_1.frameCnt_ = 0
		arg_233_1.state_ = "playing"
		arg_233_1.curTalkId_ = 935011057
		arg_233_1.duration_ = 5

		SetActive(arg_233_1.tipsGo_, false)

		function arg_233_1.onSingleLineFinish_()
			arg_233_1.onSingleLineUpdate_ = nil
			arg_233_1.onSingleLineFinish_ = nil
			arg_233_1.state_ = "waiting"
		end

		function arg_233_1.playNext_(arg_235_0)
			if arg_235_0 == 1 then
				arg_233_0:Play935011058(arg_233_1)
			end
		end

		function arg_233_1.onSingleLineUpdate_(arg_236_0)
			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(arg_233_1.actors_["1070ui_story"]) and arg_233_1.var_.characterEffect1070ui_story == nil then
				arg_233_1.var_.characterEffect1070ui_story = arg_233_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_0 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_0 and not isNil(arg_233_1.actors_["1070ui_story"]) then
				if arg_233_1.var_.characterEffect1070ui_story and not isNil(arg_233_1.actors_["1070ui_story"]) then
					arg_233_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_233_1.time_ >= 0 + var_236_0 and arg_233_1.time_ < 0 + var_236_0 + arg_236_0 and not isNil(arg_233_1.actors_["1070ui_story"]) and arg_233_1.var_.characterEffect1070ui_story then
				arg_233_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_236_2 = arg_233_1.actors_["10039ui_story"]

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= 0 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect10039ui_story == nil then
				arg_233_1.var_.characterEffect10039ui_story = var_236_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_236_3 = 0.200000002980232

			if 0 <= arg_233_1.time_ and arg_233_1.time_ < 0 + var_236_3 and not isNil(var_236_2) then
				if arg_233_1.var_.characterEffect10039ui_story and not isNil(var_236_2) then
					arg_233_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_233_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_233_1.time_ - 0) / var_236_3)
				end
			end

			if arg_233_1.time_ >= 0 + var_236_3 and arg_233_1.time_ < 0 + var_236_3 + arg_236_0 and not isNil(var_236_2) and arg_233_1.var_.characterEffect10039ui_story then
				arg_233_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_233_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			local var_236_4 = 0
			local var_236_5 = 0.3

			if 0 < arg_233_1.time_ and arg_233_1.time_ <= var_236_4 + arg_236_0 then
				arg_233_1.talkMaxDuration = 0
				arg_233_1.dialogCg_.alpha = 1

				arg_233_1.dialog_:SetActive(true)
				SetActive(arg_233_1.leftNameGo_, true)

				arg_233_1.leftNameTxt_.text = arg_233_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_233_1.leftNameTxt_.transform)

				arg_233_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_233_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_233_1:RecordName(arg_233_1.leftNameTxt_.text)
				SetActive(arg_233_1.iconTrs_.gameObject, false)
				arg_233_1.callingController_:SetSelectedState("normal")

				local var_236_6 = arg_233_1:FormatText(arg_233_1:GetWordFromCfg(935011057).content)

				arg_233_1.text_.text = var_236_6

				LuaForUtil.ClearLinePrefixSymbol(arg_233_1.text_)

				local var_236_8 = 12 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_6) / 12)

				if (12 <= 0 and var_236_5 or var_236_5 * (utf8.len(var_236_6) / 12)) > 0 and var_236_5 < var_236_8 then
					arg_233_1.talkMaxDuration = var_236_8

					if var_236_8 + var_236_4 > arg_233_1.duration_ then
						arg_233_1.duration_ = var_236_8 + var_236_4
					end
				end

				arg_233_1.text_.text = var_236_6
				arg_233_1.typewritter.percent = 0

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(false)
				arg_233_1:RecordContent(arg_233_1.text_.text)
			end

			local var_236_9 = math.max(var_236_5, arg_233_1.talkMaxDuration)

			if var_236_4 <= arg_233_1.time_ and arg_233_1.time_ < var_236_4 + var_236_9 then
				arg_233_1.typewritter.percent = (arg_233_1.time_ - var_236_4) / var_236_9

				arg_233_1.typewritter:SetDirty()
			end

			if arg_233_1.time_ >= var_236_4 + var_236_9 and arg_233_1.time_ < var_236_4 + var_236_9 + arg_236_0 then
				arg_233_1.typewritter.percent = 1

				arg_233_1.typewritter:SetDirty()
				arg_233_1:ShowNextGo(true)
			end
		end

		arg_233_1.nodeConfigList_ = {}

		arg_233_1:InitPlayNodeList()
	end,
	Play935011058 = function(arg_237_0, arg_237_1)
		arg_237_1.time_ = 0
		arg_237_1.frameCnt_ = 0
		arg_237_1.state_ = "playing"
		arg_237_1.curTalkId_ = 935011058
		arg_237_1.duration_ = 5

		SetActive(arg_237_1.tipsGo_, false)

		function arg_237_1.onSingleLineFinish_()
			arg_237_1.onSingleLineUpdate_ = nil
			arg_237_1.onSingleLineFinish_ = nil
			arg_237_1.state_ = "waiting"
		end

		function arg_237_1.playNext_(arg_239_0)
			if arg_239_0 == 1 then
				arg_237_0:Play935011059(arg_237_1)
			end
		end

		function arg_237_1.onSingleLineUpdate_(arg_240_0)
			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(arg_237_1.actors_["10039ui_story"]) and arg_237_1.var_.characterEffect10039ui_story == nil then
				arg_237_1.var_.characterEffect10039ui_story = arg_237_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_0 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_0 and not isNil(arg_237_1.actors_["10039ui_story"]) then
				if arg_237_1.var_.characterEffect10039ui_story and not isNil(arg_237_1.actors_["10039ui_story"]) then
					arg_237_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_237_1.time_ >= 0 + var_240_0 and arg_237_1.time_ < 0 + var_240_0 + arg_240_0 and not isNil(arg_237_1.actors_["10039ui_story"]) and arg_237_1.var_.characterEffect10039ui_story then
				arg_237_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_240_2 = arg_237_1.actors_["1070ui_story"]

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= 0 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect1070ui_story == nil then
				arg_237_1.var_.characterEffect1070ui_story = var_240_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_240_3 = 0.200000002980232

			if 0 <= arg_237_1.time_ and arg_237_1.time_ < 0 + var_240_3 and not isNil(var_240_2) then
				if arg_237_1.var_.characterEffect1070ui_story and not isNil(var_240_2) then
					arg_237_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_237_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_237_1.time_ - 0) / var_240_3)
				end
			end

			if arg_237_1.time_ >= 0 + var_240_3 and arg_237_1.time_ < 0 + var_240_3 + arg_240_0 and not isNil(var_240_2) and arg_237_1.var_.characterEffect1070ui_story then
				arg_237_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_237_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_240_4 = 0
			local var_240_5 = 0.625

			if 0 < arg_237_1.time_ and arg_237_1.time_ <= var_240_4 + arg_240_0 then
				arg_237_1.talkMaxDuration = 0
				arg_237_1.dialogCg_.alpha = 1

				arg_237_1.dialog_:SetActive(true)
				SetActive(arg_237_1.leftNameGo_, true)

				arg_237_1.leftNameTxt_.text = arg_237_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_237_1.leftNameTxt_.transform)

				arg_237_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_237_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_237_1:RecordName(arg_237_1.leftNameTxt_.text)
				SetActive(arg_237_1.iconTrs_.gameObject, false)
				arg_237_1.callingController_:SetSelectedState("normal")

				local var_240_6 = arg_237_1:FormatText(arg_237_1:GetWordFromCfg(935011058).content)

				arg_237_1.text_.text = var_240_6

				LuaForUtil.ClearLinePrefixSymbol(arg_237_1.text_)

				local var_240_8 = 25 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_6) / 25)

				if (25 <= 0 and var_240_5 or var_240_5 * (utf8.len(var_240_6) / 25)) > 0 and var_240_5 < var_240_8 then
					arg_237_1.talkMaxDuration = var_240_8

					if var_240_8 + var_240_4 > arg_237_1.duration_ then
						arg_237_1.duration_ = var_240_8 + var_240_4
					end
				end

				arg_237_1.text_.text = var_240_6
				arg_237_1.typewritter.percent = 0

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(false)
				arg_237_1:RecordContent(arg_237_1.text_.text)
			end

			local var_240_9 = math.max(var_240_5, arg_237_1.talkMaxDuration)

			if var_240_4 <= arg_237_1.time_ and arg_237_1.time_ < var_240_4 + var_240_9 then
				arg_237_1.typewritter.percent = (arg_237_1.time_ - var_240_4) / var_240_9

				arg_237_1.typewritter:SetDirty()
			end

			if arg_237_1.time_ >= var_240_4 + var_240_9 and arg_237_1.time_ < var_240_4 + var_240_9 + arg_240_0 then
				arg_237_1.typewritter.percent = 1

				arg_237_1.typewritter:SetDirty()
				arg_237_1:ShowNextGo(true)
			end
		end

		arg_237_1.nodeConfigList_ = {}

		arg_237_1:InitPlayNodeList()
	end,
	Play935011059 = function(arg_241_0, arg_241_1)
		arg_241_1.time_ = 0
		arg_241_1.frameCnt_ = 0
		arg_241_1.state_ = "playing"
		arg_241_1.curTalkId_ = 935011059
		arg_241_1.duration_ = 5

		SetActive(arg_241_1.tipsGo_, false)

		function arg_241_1.onSingleLineFinish_()
			arg_241_1.onSingleLineUpdate_ = nil
			arg_241_1.onSingleLineFinish_ = nil
			arg_241_1.state_ = "waiting"
		end

		function arg_241_1.playNext_(arg_243_0)
			if arg_243_0 == 1 then
				arg_241_0:Play935011060(arg_241_1)
			end
		end

		function arg_241_1.onSingleLineUpdate_(arg_244_0)
			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(arg_241_1.actors_["1070ui_story"]) and arg_241_1.var_.characterEffect1070ui_story == nil then
				arg_241_1.var_.characterEffect1070ui_story = arg_241_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_0 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_0 and not isNil(arg_241_1.actors_["1070ui_story"]) then
				if arg_241_1.var_.characterEffect1070ui_story and not isNil(arg_241_1.actors_["1070ui_story"]) then
					arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_241_1.time_ >= 0 + var_244_0 and arg_241_1.time_ < 0 + var_244_0 + arg_244_0 and not isNil(arg_241_1.actors_["1070ui_story"]) and arg_241_1.var_.characterEffect1070ui_story then
				arg_241_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_244_2 = arg_241_1.actors_["10039ui_story"]

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect10039ui_story == nil then
				arg_241_1.var_.characterEffect10039ui_story = var_244_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_244_3 = 0.200000002980232

			if 0 <= arg_241_1.time_ and arg_241_1.time_ < 0 + var_244_3 and not isNil(var_244_2) then
				if arg_241_1.var_.characterEffect10039ui_story and not isNil(var_244_2) then
					arg_241_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_241_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_241_1.time_ - 0) / var_244_3)
				end
			end

			if arg_241_1.time_ >= 0 + var_244_3 and arg_241_1.time_ < 0 + var_244_3 + arg_244_0 and not isNil(var_244_2) and arg_241_1.var_.characterEffect10039ui_story then
				arg_241_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_241_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_1")
			end

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= 0 + arg_244_0 then
				arg_241_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva", "EmotionTimelineAnimator")
			end

			local var_244_4 = 0
			local var_244_5 = 0.45

			if 0 < arg_241_1.time_ and arg_241_1.time_ <= var_244_4 + arg_244_0 then
				arg_241_1.talkMaxDuration = 0
				arg_241_1.dialogCg_.alpha = 1

				arg_241_1.dialog_:SetActive(true)
				SetActive(arg_241_1.leftNameGo_, true)

				arg_241_1.leftNameTxt_.text = arg_241_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_241_1.leftNameTxt_.transform)

				arg_241_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_241_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_241_1:RecordName(arg_241_1.leftNameTxt_.text)
				SetActive(arg_241_1.iconTrs_.gameObject, false)
				arg_241_1.callingController_:SetSelectedState("normal")

				local var_244_6 = arg_241_1:FormatText(arg_241_1:GetWordFromCfg(935011059).content)

				arg_241_1.text_.text = var_244_6

				LuaForUtil.ClearLinePrefixSymbol(arg_241_1.text_)

				local var_244_8 = 18 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_6) / 18)

				if (18 <= 0 and var_244_5 or var_244_5 * (utf8.len(var_244_6) / 18)) > 0 and var_244_5 < var_244_8 then
					arg_241_1.talkMaxDuration = var_244_8

					if var_244_8 + var_244_4 > arg_241_1.duration_ then
						arg_241_1.duration_ = var_244_8 + var_244_4
					end
				end

				arg_241_1.text_.text = var_244_6
				arg_241_1.typewritter.percent = 0

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(false)
				arg_241_1:RecordContent(arg_241_1.text_.text)
			end

			local var_244_9 = math.max(var_244_5, arg_241_1.talkMaxDuration)

			if var_244_4 <= arg_241_1.time_ and arg_241_1.time_ < var_244_4 + var_244_9 then
				arg_241_1.typewritter.percent = (arg_241_1.time_ - var_244_4) / var_244_9

				arg_241_1.typewritter:SetDirty()
			end

			if arg_241_1.time_ >= var_244_4 + var_244_9 and arg_241_1.time_ < var_244_4 + var_244_9 + arg_244_0 then
				arg_241_1.typewritter.percent = 1

				arg_241_1.typewritter:SetDirty()
				arg_241_1:ShowNextGo(true)
			end
		end

		arg_241_1.nodeConfigList_ = {}

		arg_241_1:InitPlayNodeList()
	end,
	Play935011060 = function(arg_245_0, arg_245_1)
		arg_245_1.time_ = 0
		arg_245_1.frameCnt_ = 0
		arg_245_1.state_ = "playing"
		arg_245_1.curTalkId_ = 935011060
		arg_245_1.duration_ = 5

		SetActive(arg_245_1.tipsGo_, false)

		function arg_245_1.onSingleLineFinish_()
			arg_245_1.onSingleLineUpdate_ = nil
			arg_245_1.onSingleLineFinish_ = nil
			arg_245_1.state_ = "waiting"
		end

		function arg_245_1.playNext_(arg_247_0)
			if arg_247_0 == 1 then
				arg_245_0:Play935011061(arg_245_1)
			end
		end

		function arg_245_1.onSingleLineUpdate_(arg_248_0)
			if 0 < arg_245_1.time_ and arg_245_1.time_ <= 0 + arg_248_0 and not isNil(arg_245_1.actors_["1070ui_story"]) and arg_245_1.var_.characterEffect1070ui_story == nil then
				arg_245_1.var_.characterEffect1070ui_story = arg_245_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_248_0 = 0.200000002980232

			if 0 <= arg_245_1.time_ and arg_245_1.time_ < 0 + var_248_0 and not isNil(arg_245_1.actors_["1070ui_story"]) then
				if arg_245_1.var_.characterEffect1070ui_story and not isNil(arg_245_1.actors_["1070ui_story"]) then
					arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_245_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_245_1.time_ - 0) / var_248_0)
				end
			end

			if arg_245_1.time_ >= 0 + var_248_0 and arg_245_1.time_ < 0 + var_248_0 + arg_248_0 and not isNil(arg_245_1.actors_["1070ui_story"]) and arg_245_1.var_.characterEffect1070ui_story then
				arg_245_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_245_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_248_1 = 0
			local var_248_2 = 1

			if 0 < arg_245_1.time_ and arg_245_1.time_ <= var_248_1 + arg_248_0 then
				arg_245_1.talkMaxDuration = 0
				arg_245_1.dialogCg_.alpha = 1

				arg_245_1.dialog_:SetActive(true)
				SetActive(arg_245_1.leftNameGo_, false)

				arg_245_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_245_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_245_1:RecordName(arg_245_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_245_1.iconTrs_.gameObject, false)
				arg_245_1.callingController_:SetSelectedState("normal")

				local var_248_3 = arg_245_1:FormatText(arg_245_1:GetWordFromCfg(935011060).content)

				arg_245_1.text_.text = var_248_3

				LuaForUtil.ClearLinePrefixSymbol(arg_245_1.text_)

				local var_248_5 = 40 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 40)

				if (40 <= 0 and var_248_2 or var_248_2 * (utf8.len(var_248_3) / 40)) > 0 and var_248_2 < var_248_5 then
					arg_245_1.talkMaxDuration = var_248_5

					if var_248_5 + var_248_1 > arg_245_1.duration_ then
						arg_245_1.duration_ = var_248_5 + var_248_1
					end
				end

				arg_245_1.text_.text = var_248_3
				arg_245_1.typewritter.percent = 0

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(false)
				arg_245_1:RecordContent(arg_245_1.text_.text)
			end

			local var_248_6 = math.max(var_248_2, arg_245_1.talkMaxDuration)

			if var_248_1 <= arg_245_1.time_ and arg_245_1.time_ < var_248_1 + var_248_6 then
				arg_245_1.typewritter.percent = (arg_245_1.time_ - var_248_1) / var_248_6

				arg_245_1.typewritter:SetDirty()
			end

			if arg_245_1.time_ >= var_248_1 + var_248_6 and arg_245_1.time_ < var_248_1 + var_248_6 + arg_248_0 then
				arg_245_1.typewritter.percent = 1

				arg_245_1.typewritter:SetDirty()
				arg_245_1:ShowNextGo(true)
			end
		end

		arg_245_1.nodeConfigList_ = {}

		arg_245_1:InitPlayNodeList()
	end,
	Play935011061 = function(arg_249_0, arg_249_1)
		arg_249_1.time_ = 0
		arg_249_1.frameCnt_ = 0
		arg_249_1.state_ = "playing"
		arg_249_1.curTalkId_ = 935011061
		arg_249_1.duration_ = 5

		SetActive(arg_249_1.tipsGo_, false)

		function arg_249_1.onSingleLineFinish_()
			arg_249_1.onSingleLineUpdate_ = nil
			arg_249_1.onSingleLineFinish_ = nil
			arg_249_1.state_ = "waiting"
		end

		function arg_249_1.playNext_(arg_251_0)
			if arg_251_0 == 1 then
				arg_249_0:Play935011062(arg_249_1)
			end
		end

		function arg_249_1.onSingleLineUpdate_(arg_252_0)
			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 and not isNil(arg_249_1.actors_["1070ui_story"]) and arg_249_1.var_.characterEffect1070ui_story == nil then
				arg_249_1.var_.characterEffect1070ui_story = arg_249_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_252_0 = 0.200000002980232

			if 0 <= arg_249_1.time_ and arg_249_1.time_ < 0 + var_252_0 and not isNil(arg_249_1.actors_["1070ui_story"]) then
				if arg_249_1.var_.characterEffect1070ui_story and not isNil(arg_249_1.actors_["1070ui_story"]) then
					arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_249_1.time_ >= 0 + var_252_0 and arg_249_1.time_ < 0 + var_252_0 + arg_252_0 and not isNil(arg_249_1.actors_["1070ui_story"]) and arg_249_1.var_.characterEffect1070ui_story then
				arg_249_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action474")
			end

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= 0 + arg_252_0 then
				arg_249_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva", "EmotionTimelineAnimator")
			end

			local var_252_2 = 0
			local var_252_3 = 1.2

			if 0 < arg_249_1.time_ and arg_249_1.time_ <= var_252_2 + arg_252_0 then
				arg_249_1.talkMaxDuration = 0
				arg_249_1.dialogCg_.alpha = 1

				arg_249_1.dialog_:SetActive(true)
				SetActive(arg_249_1.leftNameGo_, true)

				arg_249_1.leftNameTxt_.text = arg_249_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_249_1.leftNameTxt_.transform)

				arg_249_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_249_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_249_1:RecordName(arg_249_1.leftNameTxt_.text)
				SetActive(arg_249_1.iconTrs_.gameObject, false)
				arg_249_1.callingController_:SetSelectedState("normal")

				local var_252_4 = arg_249_1:FormatText(arg_249_1:GetWordFromCfg(935011061).content)

				arg_249_1.text_.text = var_252_4

				LuaForUtil.ClearLinePrefixSymbol(arg_249_1.text_)

				local var_252_6 = 48 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_4) / 48)

				if (48 <= 0 and var_252_3 or var_252_3 * (utf8.len(var_252_4) / 48)) > 0 and var_252_3 < var_252_6 then
					arg_249_1.talkMaxDuration = var_252_6

					if var_252_6 + var_252_2 > arg_249_1.duration_ then
						arg_249_1.duration_ = var_252_6 + var_252_2
					end
				end

				arg_249_1.text_.text = var_252_4
				arg_249_1.typewritter.percent = 0

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(false)
				arg_249_1:RecordContent(arg_249_1.text_.text)
			end

			local var_252_7 = math.max(var_252_3, arg_249_1.talkMaxDuration)

			if var_252_2 <= arg_249_1.time_ and arg_249_1.time_ < var_252_2 + var_252_7 then
				arg_249_1.typewritter.percent = (arg_249_1.time_ - var_252_2) / var_252_7

				arg_249_1.typewritter:SetDirty()
			end

			if arg_249_1.time_ >= var_252_2 + var_252_7 and arg_249_1.time_ < var_252_2 + var_252_7 + arg_252_0 then
				arg_249_1.typewritter.percent = 1

				arg_249_1.typewritter:SetDirty()
				arg_249_1:ShowNextGo(true)
			end
		end

		arg_249_1.nodeConfigList_ = {}

		arg_249_1:InitPlayNodeList()
	end,
	Play935011062 = function(arg_253_0, arg_253_1)
		arg_253_1.time_ = 0
		arg_253_1.frameCnt_ = 0
		arg_253_1.state_ = "playing"
		arg_253_1.curTalkId_ = 935011062
		arg_253_1.duration_ = 5

		SetActive(arg_253_1.tipsGo_, false)

		function arg_253_1.onSingleLineFinish_()
			arg_253_1.onSingleLineUpdate_ = nil
			arg_253_1.onSingleLineFinish_ = nil
			arg_253_1.state_ = "waiting"
		end

		function arg_253_1.playNext_(arg_255_0)
			if arg_255_0 == 1 then
				arg_253_0:Play935011063(arg_253_1)
			end
		end

		function arg_253_1.onSingleLineUpdate_(arg_256_0)
			if 0 < arg_253_1.time_ and arg_253_1.time_ <= 0 + arg_256_0 then
				arg_253_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_256_0 = 0
			local var_256_1 = 1.15

			if 0 < arg_253_1.time_ and arg_253_1.time_ <= var_256_0 + arg_256_0 then
				arg_253_1.talkMaxDuration = 0
				arg_253_1.dialogCg_.alpha = 1

				arg_253_1.dialog_:SetActive(true)
				SetActive(arg_253_1.leftNameGo_, true)

				arg_253_1.leftNameTxt_.text = arg_253_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_253_1.leftNameTxt_.transform)

				arg_253_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_253_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_253_1:RecordName(arg_253_1.leftNameTxt_.text)
				SetActive(arg_253_1.iconTrs_.gameObject, false)
				arg_253_1.callingController_:SetSelectedState("normal")

				local var_256_2 = arg_253_1:FormatText(arg_253_1:GetWordFromCfg(935011062).content)

				arg_253_1.text_.text = var_256_2

				LuaForUtil.ClearLinePrefixSymbol(arg_253_1.text_)

				local var_256_4 = 46 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_2) / 46)

				if (46 <= 0 and var_256_1 or var_256_1 * (utf8.len(var_256_2) / 46)) > 0 and var_256_1 < var_256_4 then
					arg_253_1.talkMaxDuration = var_256_4

					if var_256_4 + var_256_0 > arg_253_1.duration_ then
						arg_253_1.duration_ = var_256_4 + var_256_0
					end
				end

				arg_253_1.text_.text = var_256_2
				arg_253_1.typewritter.percent = 0

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(false)
				arg_253_1:RecordContent(arg_253_1.text_.text)
			end

			local var_256_5 = math.max(var_256_1, arg_253_1.talkMaxDuration)

			if var_256_0 <= arg_253_1.time_ and arg_253_1.time_ < var_256_0 + var_256_5 then
				arg_253_1.typewritter.percent = (arg_253_1.time_ - var_256_0) / var_256_5

				arg_253_1.typewritter:SetDirty()
			end

			if arg_253_1.time_ >= var_256_0 + var_256_5 and arg_253_1.time_ < var_256_0 + var_256_5 + arg_256_0 then
				arg_253_1.typewritter.percent = 1

				arg_253_1.typewritter:SetDirty()
				arg_253_1:ShowNextGo(true)
			end
		end

		arg_253_1.nodeConfigList_ = {}

		arg_253_1:InitPlayNodeList()
	end,
	Play935011063 = function(arg_257_0, arg_257_1)
		arg_257_1.time_ = 0
		arg_257_1.frameCnt_ = 0
		arg_257_1.state_ = "playing"
		arg_257_1.curTalkId_ = 935011063
		arg_257_1.duration_ = 5

		SetActive(arg_257_1.tipsGo_, false)

		function arg_257_1.onSingleLineFinish_()
			arg_257_1.onSingleLineUpdate_ = nil
			arg_257_1.onSingleLineFinish_ = nil
			arg_257_1.state_ = "waiting"
		end

		function arg_257_1.playNext_(arg_259_0)
			if arg_259_0 == 1 then
				arg_257_0:Play935011064(arg_257_1)
			end
		end

		function arg_257_1.onSingleLineUpdate_(arg_260_0)
			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(arg_257_1.actors_["10039ui_story"]) and arg_257_1.var_.characterEffect10039ui_story == nil then
				arg_257_1.var_.characterEffect10039ui_story = arg_257_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_0 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_0 and not isNil(arg_257_1.actors_["10039ui_story"]) then
				if arg_257_1.var_.characterEffect10039ui_story and not isNil(arg_257_1.actors_["10039ui_story"]) then
					arg_257_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_257_1.time_ >= 0 + var_260_0 and arg_257_1.time_ < 0 + var_260_0 + arg_260_0 and not isNil(arg_257_1.actors_["10039ui_story"]) and arg_257_1.var_.characterEffect10039ui_story then
				arg_257_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_260_2 = arg_257_1.actors_["1070ui_story"]

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1070ui_story == nil then
				arg_257_1.var_.characterEffect1070ui_story = var_260_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_260_3 = 0.200000002980232

			if 0 <= arg_257_1.time_ and arg_257_1.time_ < 0 + var_260_3 and not isNil(var_260_2) then
				if arg_257_1.var_.characterEffect1070ui_story and not isNil(var_260_2) then
					arg_257_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_257_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_257_1.time_ - 0) / var_260_3)
				end
			end

			if arg_257_1.time_ >= 0 + var_260_3 and arg_257_1.time_ < 0 + var_260_3 + arg_260_0 and not isNil(var_260_2) and arg_257_1.var_.characterEffect1070ui_story then
				arg_257_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_257_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= 0 + arg_260_0 then
				arg_257_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva", "EmotionTimelineAnimator")
			end

			local var_260_4 = 0
			local var_260_5 = 0.75

			if 0 < arg_257_1.time_ and arg_257_1.time_ <= var_260_4 + arg_260_0 then
				arg_257_1.talkMaxDuration = 0
				arg_257_1.dialogCg_.alpha = 1

				arg_257_1.dialog_:SetActive(true)
				SetActive(arg_257_1.leftNameGo_, true)

				arg_257_1.leftNameTxt_.text = arg_257_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_257_1.leftNameTxt_.transform)

				arg_257_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_257_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_257_1:RecordName(arg_257_1.leftNameTxt_.text)
				SetActive(arg_257_1.iconTrs_.gameObject, false)
				arg_257_1.callingController_:SetSelectedState("normal")

				local var_260_6 = arg_257_1:FormatText(arg_257_1:GetWordFromCfg(935011063).content)

				arg_257_1.text_.text = var_260_6

				LuaForUtil.ClearLinePrefixSymbol(arg_257_1.text_)

				local var_260_8 = 30 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 30)

				if (30 <= 0 and var_260_5 or var_260_5 * (utf8.len(var_260_6) / 30)) > 0 and var_260_5 < var_260_8 then
					arg_257_1.talkMaxDuration = var_260_8

					if var_260_8 + var_260_4 > arg_257_1.duration_ then
						arg_257_1.duration_ = var_260_8 + var_260_4
					end
				end

				arg_257_1.text_.text = var_260_6
				arg_257_1.typewritter.percent = 0

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(false)
				arg_257_1:RecordContent(arg_257_1.text_.text)
			end

			local var_260_9 = math.max(var_260_5, arg_257_1.talkMaxDuration)

			if var_260_4 <= arg_257_1.time_ and arg_257_1.time_ < var_260_4 + var_260_9 then
				arg_257_1.typewritter.percent = (arg_257_1.time_ - var_260_4) / var_260_9

				arg_257_1.typewritter:SetDirty()
			end

			if arg_257_1.time_ >= var_260_4 + var_260_9 and arg_257_1.time_ < var_260_4 + var_260_9 + arg_260_0 then
				arg_257_1.typewritter.percent = 1

				arg_257_1.typewritter:SetDirty()
				arg_257_1:ShowNextGo(true)
			end
		end

		arg_257_1.nodeConfigList_ = {}

		arg_257_1:InitPlayNodeList()
	end,
	Play935011064 = function(arg_261_0, arg_261_1)
		arg_261_1.time_ = 0
		arg_261_1.frameCnt_ = 0
		arg_261_1.state_ = "playing"
		arg_261_1.curTalkId_ = 935011064
		arg_261_1.duration_ = 5

		SetActive(arg_261_1.tipsGo_, false)

		function arg_261_1.onSingleLineFinish_()
			arg_261_1.onSingleLineUpdate_ = nil
			arg_261_1.onSingleLineFinish_ = nil
			arg_261_1.state_ = "waiting"
		end

		function arg_261_1.playNext_(arg_263_0)
			if arg_263_0 == 1 then
				arg_261_0:Play935011065(arg_261_1)
			end
		end

		function arg_261_1.onSingleLineUpdate_(arg_264_0)
			if 0 < arg_261_1.time_ and arg_261_1.time_ <= 0 + arg_264_0 and not isNil(arg_261_1.actors_["10039ui_story"]) and arg_261_1.var_.characterEffect10039ui_story == nil then
				arg_261_1.var_.characterEffect10039ui_story = arg_261_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_264_0 = 0.200000002980232

			if 0 <= arg_261_1.time_ and arg_261_1.time_ < 0 + var_264_0 and not isNil(arg_261_1.actors_["10039ui_story"]) then
				if arg_261_1.var_.characterEffect10039ui_story and not isNil(arg_261_1.actors_["10039ui_story"]) then
					arg_261_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_261_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_261_1.time_ - 0) / var_264_0)
				end
			end

			if arg_261_1.time_ >= 0 + var_264_0 and arg_261_1.time_ < 0 + var_264_0 + arg_264_0 and not isNil(arg_261_1.actors_["10039ui_story"]) and arg_261_1.var_.characterEffect10039ui_story then
				arg_261_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_261_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			local var_264_1 = 0
			local var_264_2 = 0.55

			if 0 < arg_261_1.time_ and arg_261_1.time_ <= var_264_1 + arg_264_0 then
				arg_261_1.talkMaxDuration = 0
				arg_261_1.dialogCg_.alpha = 1

				arg_261_1.dialog_:SetActive(true)
				SetActive(arg_261_1.leftNameGo_, false)

				arg_261_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_261_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_261_1:RecordName(arg_261_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_261_1.iconTrs_.gameObject, false)
				arg_261_1.callingController_:SetSelectedState("normal")

				local var_264_3 = arg_261_1:FormatText(arg_261_1:GetWordFromCfg(935011064).content)

				arg_261_1.text_.text = var_264_3

				LuaForUtil.ClearLinePrefixSymbol(arg_261_1.text_)

				local var_264_5 = 22 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 22)

				if (22 <= 0 and var_264_2 or var_264_2 * (utf8.len(var_264_3) / 22)) > 0 and var_264_2 < var_264_5 then
					arg_261_1.talkMaxDuration = var_264_5

					if var_264_5 + var_264_1 > arg_261_1.duration_ then
						arg_261_1.duration_ = var_264_5 + var_264_1
					end
				end

				arg_261_1.text_.text = var_264_3
				arg_261_1.typewritter.percent = 0

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(false)
				arg_261_1:RecordContent(arg_261_1.text_.text)
			end

			local var_264_6 = math.max(var_264_2, arg_261_1.talkMaxDuration)

			if var_264_1 <= arg_261_1.time_ and arg_261_1.time_ < var_264_1 + var_264_6 then
				arg_261_1.typewritter.percent = (arg_261_1.time_ - var_264_1) / var_264_6

				arg_261_1.typewritter:SetDirty()
			end

			if arg_261_1.time_ >= var_264_1 + var_264_6 and arg_261_1.time_ < var_264_1 + var_264_6 + arg_264_0 then
				arg_261_1.typewritter.percent = 1

				arg_261_1.typewritter:SetDirty()
				arg_261_1:ShowNextGo(true)
			end
		end

		arg_261_1.nodeConfigList_ = {}

		arg_261_1:InitPlayNodeList()
	end,
	Play935011065 = function(arg_265_0, arg_265_1)
		arg_265_1.time_ = 0
		arg_265_1.frameCnt_ = 0
		arg_265_1.state_ = "playing"
		arg_265_1.curTalkId_ = 935011065
		arg_265_1.duration_ = 5

		SetActive(arg_265_1.tipsGo_, false)

		function arg_265_1.onSingleLineFinish_()
			arg_265_1.onSingleLineUpdate_ = nil
			arg_265_1.onSingleLineFinish_ = nil
			arg_265_1.state_ = "waiting"
		end

		function arg_265_1.playNext_(arg_267_0)
			if arg_267_0 == 1 then
				arg_265_0:Play935011066(arg_265_1)
			end
		end

		function arg_265_1.onSingleLineUpdate_(arg_268_0)
			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 and not isNil(arg_265_1.actors_["1070ui_story"]) and arg_265_1.var_.characterEffect1070ui_story == nil then
				arg_265_1.var_.characterEffect1070ui_story = arg_265_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_268_0 = 0.200000002980232

			if 0 <= arg_265_1.time_ and arg_265_1.time_ < 0 + var_268_0 and not isNil(arg_265_1.actors_["1070ui_story"]) then
				if arg_265_1.var_.characterEffect1070ui_story and not isNil(arg_265_1.actors_["1070ui_story"]) then
					arg_265_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_265_1.time_ >= 0 + var_268_0 and arg_265_1.time_ < 0 + var_268_0 + arg_268_0 and not isNil(arg_265_1.actors_["1070ui_story"]) and arg_265_1.var_.characterEffect1070ui_story then
				arg_265_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= 0 + arg_268_0 then
				arg_265_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_268_2 = 0
			local var_268_3 = 1

			if 0 < arg_265_1.time_ and arg_265_1.time_ <= var_268_2 + arg_268_0 then
				arg_265_1.talkMaxDuration = 0
				arg_265_1.dialogCg_.alpha = 1

				arg_265_1.dialog_:SetActive(true)
				SetActive(arg_265_1.leftNameGo_, true)

				arg_265_1.leftNameTxt_.text = arg_265_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_265_1.leftNameTxt_.transform)

				arg_265_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_265_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_265_1:RecordName(arg_265_1.leftNameTxt_.text)
				SetActive(arg_265_1.iconTrs_.gameObject, false)
				arg_265_1.callingController_:SetSelectedState("normal")

				local var_268_4 = arg_265_1:FormatText(arg_265_1:GetWordFromCfg(935011065).content)

				arg_265_1.text_.text = var_268_4

				LuaForUtil.ClearLinePrefixSymbol(arg_265_1.text_)

				local var_268_6 = 40 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 40)

				if (40 <= 0 and var_268_3 or var_268_3 * (utf8.len(var_268_4) / 40)) > 0 and var_268_3 < var_268_6 then
					arg_265_1.talkMaxDuration = var_268_6

					if var_268_6 + var_268_2 > arg_265_1.duration_ then
						arg_265_1.duration_ = var_268_6 + var_268_2
					end
				end

				arg_265_1.text_.text = var_268_4
				arg_265_1.typewritter.percent = 0

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(false)
				arg_265_1:RecordContent(arg_265_1.text_.text)
			end

			local var_268_7 = math.max(var_268_3, arg_265_1.talkMaxDuration)

			if var_268_2 <= arg_265_1.time_ and arg_265_1.time_ < var_268_2 + var_268_7 then
				arg_265_1.typewritter.percent = (arg_265_1.time_ - var_268_2) / var_268_7

				arg_265_1.typewritter:SetDirty()
			end

			if arg_265_1.time_ >= var_268_2 + var_268_7 and arg_265_1.time_ < var_268_2 + var_268_7 + arg_268_0 then
				arg_265_1.typewritter.percent = 1

				arg_265_1.typewritter:SetDirty()
				arg_265_1:ShowNextGo(true)
			end
		end

		arg_265_1.nodeConfigList_ = {}

		arg_265_1:InitPlayNodeList()
	end,
	Play935011066 = function(arg_269_0, arg_269_1)
		arg_269_1.time_ = 0
		arg_269_1.frameCnt_ = 0
		arg_269_1.state_ = "playing"
		arg_269_1.curTalkId_ = 935011066
		arg_269_1.duration_ = 5

		SetActive(arg_269_1.tipsGo_, false)

		function arg_269_1.onSingleLineFinish_()
			arg_269_1.onSingleLineUpdate_ = nil
			arg_269_1.onSingleLineFinish_ = nil
			arg_269_1.state_ = "waiting"
		end

		function arg_269_1.playNext_(arg_271_0)
			if arg_271_0 == 1 then
				arg_269_0:Play935011067(arg_269_1)
			end
		end

		function arg_269_1.onSingleLineUpdate_(arg_272_0)
			if 0 < arg_269_1.time_ and arg_269_1.time_ <= 0 + arg_272_0 then
				arg_269_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_272_0 = 0
			local var_272_1 = 1.175

			if 0 < arg_269_1.time_ and arg_269_1.time_ <= var_272_0 + arg_272_0 then
				arg_269_1.talkMaxDuration = 0
				arg_269_1.dialogCg_.alpha = 1

				arg_269_1.dialog_:SetActive(true)
				SetActive(arg_269_1.leftNameGo_, true)

				arg_269_1.leftNameTxt_.text = arg_269_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_269_1.leftNameTxt_.transform)

				arg_269_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_269_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_269_1:RecordName(arg_269_1.leftNameTxt_.text)
				SetActive(arg_269_1.iconTrs_.gameObject, false)
				arg_269_1.callingController_:SetSelectedState("normal")

				local var_272_2 = arg_269_1:FormatText(arg_269_1:GetWordFromCfg(935011066).content)

				arg_269_1.text_.text = var_272_2

				LuaForUtil.ClearLinePrefixSymbol(arg_269_1.text_)

				local var_272_4 = 47 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_2) / 47)

				if (47 <= 0 and var_272_1 or var_272_1 * (utf8.len(var_272_2) / 47)) > 0 and var_272_1 < var_272_4 then
					arg_269_1.talkMaxDuration = var_272_4

					if var_272_4 + var_272_0 > arg_269_1.duration_ then
						arg_269_1.duration_ = var_272_4 + var_272_0
					end
				end

				arg_269_1.text_.text = var_272_2
				arg_269_1.typewritter.percent = 0

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(false)
				arg_269_1:RecordContent(arg_269_1.text_.text)
			end

			local var_272_5 = math.max(var_272_1, arg_269_1.talkMaxDuration)

			if var_272_0 <= arg_269_1.time_ and arg_269_1.time_ < var_272_0 + var_272_5 then
				arg_269_1.typewritter.percent = (arg_269_1.time_ - var_272_0) / var_272_5

				arg_269_1.typewritter:SetDirty()
			end

			if arg_269_1.time_ >= var_272_0 + var_272_5 and arg_269_1.time_ < var_272_0 + var_272_5 + arg_272_0 then
				arg_269_1.typewritter.percent = 1

				arg_269_1.typewritter:SetDirty()
				arg_269_1:ShowNextGo(true)
			end
		end

		arg_269_1.nodeConfigList_ = {}

		arg_269_1:InitPlayNodeList()
	end,
	Play935011067 = function(arg_273_0, arg_273_1)
		arg_273_1.time_ = 0
		arg_273_1.frameCnt_ = 0
		arg_273_1.state_ = "playing"
		arg_273_1.curTalkId_ = 935011067
		arg_273_1.duration_ = 5

		SetActive(arg_273_1.tipsGo_, false)

		function arg_273_1.onSingleLineFinish_()
			arg_273_1.onSingleLineUpdate_ = nil
			arg_273_1.onSingleLineFinish_ = nil
			arg_273_1.state_ = "waiting"
		end

		function arg_273_1.playNext_(arg_275_0)
			if arg_275_0 == 1 then
				arg_273_0:Play935011068(arg_273_1)
			end
		end

		function arg_273_1.onSingleLineUpdate_(arg_276_0)
			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(arg_273_1.actors_["10039ui_story"]) and arg_273_1.var_.characterEffect10039ui_story == nil then
				arg_273_1.var_.characterEffect10039ui_story = arg_273_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_0 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_0 and not isNil(arg_273_1.actors_["10039ui_story"]) then
				if arg_273_1.var_.characterEffect10039ui_story and not isNil(arg_273_1.actors_["10039ui_story"]) then
					arg_273_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_273_1.time_ >= 0 + var_276_0 and arg_273_1.time_ < 0 + var_276_0 + arg_276_0 and not isNil(arg_273_1.actors_["10039ui_story"]) and arg_273_1.var_.characterEffect10039ui_story then
				arg_273_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_276_2 = arg_273_1.actors_["1070ui_story"]

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect1070ui_story == nil then
				arg_273_1.var_.characterEffect1070ui_story = var_276_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_276_3 = 0.200000002980232

			if 0 <= arg_273_1.time_ and arg_273_1.time_ < 0 + var_276_3 and not isNil(var_276_2) then
				if arg_273_1.var_.characterEffect1070ui_story and not isNil(var_276_2) then
					arg_273_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_273_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_273_1.time_ - 0) / var_276_3)
				end
			end

			if arg_273_1.time_ >= 0 + var_276_3 and arg_273_1.time_ < 0 + var_276_3 + arg_276_0 and not isNil(var_276_2) and arg_273_1.var_.characterEffect1070ui_story then
				arg_273_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_273_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action465")
			end

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= 0 + arg_276_0 then
				arg_273_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva", "EmotionTimelineAnimator")
			end

			local var_276_4 = 0
			local var_276_5 = 0.125

			if 0 < arg_273_1.time_ and arg_273_1.time_ <= var_276_4 + arg_276_0 then
				arg_273_1.talkMaxDuration = 0
				arg_273_1.dialogCg_.alpha = 1

				arg_273_1.dialog_:SetActive(true)
				SetActive(arg_273_1.leftNameGo_, true)

				arg_273_1.leftNameTxt_.text = arg_273_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_273_1.leftNameTxt_.transform)

				arg_273_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_273_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_273_1:RecordName(arg_273_1.leftNameTxt_.text)
				SetActive(arg_273_1.iconTrs_.gameObject, false)
				arg_273_1.callingController_:SetSelectedState("normal")

				local var_276_6 = arg_273_1:FormatText(arg_273_1:GetWordFromCfg(935011067).content)

				arg_273_1.text_.text = var_276_6

				LuaForUtil.ClearLinePrefixSymbol(arg_273_1.text_)

				local var_276_8 = 5 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_6) / 5)

				if (5 <= 0 and var_276_5 or var_276_5 * (utf8.len(var_276_6) / 5)) > 0 and var_276_5 < var_276_8 then
					arg_273_1.talkMaxDuration = var_276_8

					if var_276_8 + var_276_4 > arg_273_1.duration_ then
						arg_273_1.duration_ = var_276_8 + var_276_4
					end
				end

				arg_273_1.text_.text = var_276_6
				arg_273_1.typewritter.percent = 0

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(false)
				arg_273_1:RecordContent(arg_273_1.text_.text)
			end

			local var_276_9 = math.max(var_276_5, arg_273_1.talkMaxDuration)

			if var_276_4 <= arg_273_1.time_ and arg_273_1.time_ < var_276_4 + var_276_9 then
				arg_273_1.typewritter.percent = (arg_273_1.time_ - var_276_4) / var_276_9

				arg_273_1.typewritter:SetDirty()
			end

			if arg_273_1.time_ >= var_276_4 + var_276_9 and arg_273_1.time_ < var_276_4 + var_276_9 + arg_276_0 then
				arg_273_1.typewritter.percent = 1

				arg_273_1.typewritter:SetDirty()
				arg_273_1:ShowNextGo(true)
			end
		end

		arg_273_1.nodeConfigList_ = {}

		arg_273_1:InitPlayNodeList()
	end,
	Play935011068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 935011068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play935011069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(arg_277_1.actors_["1070ui_story"]) and arg_277_1.var_.characterEffect1070ui_story == nil then
				arg_277_1.var_.characterEffect1070ui_story = arg_277_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_0 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_0 and not isNil(arg_277_1.actors_["1070ui_story"]) then
				if arg_277_1.var_.characterEffect1070ui_story and not isNil(arg_277_1.actors_["1070ui_story"]) then
					arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_277_1.time_ >= 0 + var_280_0 and arg_277_1.time_ < 0 + var_280_0 + arg_280_0 and not isNil(arg_277_1.actors_["1070ui_story"]) and arg_277_1.var_.characterEffect1070ui_story then
				arg_277_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_280_2 = arg_277_1.actors_["10039ui_story"]

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect10039ui_story == nil then
				arg_277_1.var_.characterEffect10039ui_story = var_280_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_280_3 = 0.200000002980232

			if 0 <= arg_277_1.time_ and arg_277_1.time_ < 0 + var_280_3 and not isNil(var_280_2) then
				if arg_277_1.var_.characterEffect10039ui_story and not isNil(var_280_2) then
					arg_277_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_277_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_277_1.time_ - 0) / var_280_3)
				end
			end

			if arg_277_1.time_ >= 0 + var_280_3 and arg_277_1.time_ < 0 + var_280_3 + arg_280_0 and not isNil(var_280_2) and arg_277_1.var_.characterEffect10039ui_story then
				arg_277_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_277_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= 0 + arg_280_0 then
				arg_277_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action6_2")
			end

			local var_280_4 = 0
			local var_280_5 = 0.075

			if 0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, true)

				arg_277_1.leftNameTxt_.text = arg_277_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_277_1.leftNameTxt_.transform)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1.leftNameTxt_.text)
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:FormatText(arg_277_1:GetWordFromCfg(935011068).content)

				arg_277_1.text_.text = var_280_6

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_8 = 3 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_6) / 3)

				if (3 <= 0 and var_280_5 or var_280_5 * (utf8.len(var_280_6) / 3)) > 0 and var_280_5 < var_280_8 then
					arg_277_1.talkMaxDuration = var_280_8

					if var_280_8 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_8 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_6
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_9 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_9 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_9

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_9 and arg_277_1.time_ < var_280_4 + var_280_9 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end

		arg_277_1.nodeConfigList_ = {}

		arg_277_1:InitPlayNodeList()
	end,
	Play935011069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 935011069
		arg_281_1.duration_ = 5

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play935011070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(arg_281_1.actors_["10039ui_story"]) and arg_281_1.var_.characterEffect10039ui_story == nil then
				arg_281_1.var_.characterEffect10039ui_story = arg_281_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_0 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_0 and not isNil(arg_281_1.actors_["10039ui_story"]) then
				if arg_281_1.var_.characterEffect10039ui_story and not isNil(arg_281_1.actors_["10039ui_story"]) then
					arg_281_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= 0 + var_284_0 and arg_281_1.time_ < 0 + var_284_0 + arg_284_0 and not isNil(arg_281_1.actors_["10039ui_story"]) and arg_281_1.var_.characterEffect10039ui_story then
				arg_281_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_284_2 = arg_281_1.actors_["1070ui_story"]

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= 0 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1070ui_story == nil then
				arg_281_1.var_.characterEffect1070ui_story = var_284_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_3 = 0.200000002980232

			if 0 <= arg_281_1.time_ and arg_281_1.time_ < 0 + var_284_3 and not isNil(var_284_2) then
				if arg_281_1.var_.characterEffect1070ui_story and not isNil(var_284_2) then
					arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_281_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_281_1.time_ - 0) / var_284_3)
				end
			end

			if arg_281_1.time_ >= 0 + var_284_3 and arg_281_1.time_ < 0 + var_284_3 + arg_284_0 and not isNil(var_284_2) and arg_281_1.var_.characterEffect1070ui_story then
				arg_281_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_281_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_284_4 = 0
			local var_284_5 = 0.225

			if 0 < arg_281_1.time_ and arg_281_1.time_ <= var_284_4 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				arg_281_1.leftNameTxt_.text = arg_281_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_6 = arg_281_1:FormatText(arg_281_1:GetWordFromCfg(935011069).content)

				arg_281_1.text_.text = var_284_6

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_8 = 9 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_6) / 9)

				if (9 <= 0 and var_284_5 or var_284_5 * (utf8.len(var_284_6) / 9)) > 0 and var_284_5 < var_284_8 then
					arg_281_1.talkMaxDuration = var_284_8

					if var_284_8 + var_284_4 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_8 + var_284_4
					end
				end

				arg_281_1.text_.text = var_284_6
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)
				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_9 = math.max(var_284_5, arg_281_1.talkMaxDuration)

			if var_284_4 <= arg_281_1.time_ and arg_281_1.time_ < var_284_4 + var_284_9 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_4) / var_284_9

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_4 + var_284_9 and arg_281_1.time_ < var_284_4 + var_284_9 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end

		arg_281_1.nodeConfigList_ = {}

		arg_281_1:InitPlayNodeList()
	end,
	Play935011070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 935011070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play935011071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(arg_285_1.actors_["1070ui_story"]) and arg_285_1.var_.characterEffect1070ui_story == nil then
				arg_285_1.var_.characterEffect1070ui_story = arg_285_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_0 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_0 and not isNil(arg_285_1.actors_["1070ui_story"]) then
				if arg_285_1.var_.characterEffect1070ui_story and not isNil(arg_285_1.actors_["1070ui_story"]) then
					arg_285_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_285_1.time_ >= 0 + var_288_0 and arg_285_1.time_ < 0 + var_288_0 + arg_288_0 and not isNil(arg_285_1.actors_["1070ui_story"]) and arg_285_1.var_.characterEffect1070ui_story then
				arg_285_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_288_2 = arg_285_1.actors_["10039ui_story"]

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect10039ui_story == nil then
				arg_285_1.var_.characterEffect10039ui_story = var_288_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_3 = 0.200000002980232

			if 0 <= arg_285_1.time_ and arg_285_1.time_ < 0 + var_288_3 and not isNil(var_288_2) then
				if arg_285_1.var_.characterEffect10039ui_story and not isNil(var_288_2) then
					arg_285_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_285_1.time_ - 0) / var_288_3)
				end
			end

			if arg_285_1.time_ >= 0 + var_288_3 and arg_285_1.time_ < 0 + var_288_3 + arg_288_0 and not isNil(var_288_2) and arg_285_1.var_.characterEffect10039ui_story then
				arg_285_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= 0 + arg_288_0 then
				arg_285_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_1")
			end

			local var_288_4 = 0
			local var_288_5 = 0.075

			if 0 < arg_285_1.time_ and arg_285_1.time_ <= var_288_4 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, true)

				arg_285_1.leftNameTxt_.text = arg_285_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_285_1.leftNameTxt_.transform)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1.leftNameTxt_.text)
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_6 = arg_285_1:FormatText(arg_285_1:GetWordFromCfg(935011070).content)

				arg_285_1.text_.text = var_288_6

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_8 = 3 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 3)

				if (3 <= 0 and var_288_5 or var_288_5 * (utf8.len(var_288_6) / 3)) > 0 and var_288_5 < var_288_8 then
					arg_285_1.talkMaxDuration = var_288_8

					if var_288_8 + var_288_4 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_8 + var_288_4
					end
				end

				arg_285_1.text_.text = var_288_6
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_9 = math.max(var_288_5, arg_285_1.talkMaxDuration)

			if var_288_4 <= arg_285_1.time_ and arg_285_1.time_ < var_288_4 + var_288_9 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_4) / var_288_9

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_4 + var_288_9 and arg_285_1.time_ < var_288_4 + var_288_9 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end

		arg_285_1.nodeConfigList_ = {}

		arg_285_1:InitPlayNodeList()
	end,
	Play935011071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 935011071
		arg_289_1.duration_ = 5

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play935011072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(arg_289_1.actors_["10039ui_story"]) and arg_289_1.var_.characterEffect10039ui_story == nil then
				arg_289_1.var_.characterEffect10039ui_story = arg_289_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_0 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_0 and not isNil(arg_289_1.actors_["10039ui_story"]) then
				if arg_289_1.var_.characterEffect10039ui_story and not isNil(arg_289_1.actors_["10039ui_story"]) then
					arg_289_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_289_1.time_ >= 0 + var_292_0 and arg_289_1.time_ < 0 + var_292_0 + arg_292_0 and not isNil(arg_289_1.actors_["10039ui_story"]) and arg_289_1.var_.characterEffect10039ui_story then
				arg_289_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_292_2 = arg_289_1.actors_["1070ui_story"]

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1070ui_story == nil then
				arg_289_1.var_.characterEffect1070ui_story = var_292_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_3 = 0.200000002980232

			if 0 <= arg_289_1.time_ and arg_289_1.time_ < 0 + var_292_3 and not isNil(var_292_2) then
				if arg_289_1.var_.characterEffect1070ui_story and not isNil(var_292_2) then
					arg_289_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_289_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_289_1.time_ - 0) / var_292_3)
				end
			end

			if arg_289_1.time_ >= 0 + var_292_3 and arg_289_1.time_ < 0 + var_292_3 + arg_292_0 and not isNil(var_292_2) and arg_289_1.var_.characterEffect1070ui_story then
				arg_289_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_289_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action452")
			end

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= 0 + arg_292_0 then
				arg_289_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_292_4 = 0
			local var_292_5 = 0.925

			if 0 < arg_289_1.time_ and arg_289_1.time_ <= var_292_4 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0
				arg_289_1.dialogCg_.alpha = 1

				arg_289_1.dialog_:SetActive(true)
				SetActive(arg_289_1.leftNameGo_, true)

				arg_289_1.leftNameTxt_.text = arg_289_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, false)
				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_6 = arg_289_1:FormatText(arg_289_1:GetWordFromCfg(935011071).content)

				arg_289_1.text_.text = var_292_6

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_8 = 37 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_6) / 37)

				if (37 <= 0 and var_292_5 or var_292_5 * (utf8.len(var_292_6) / 37)) > 0 and var_292_5 < var_292_8 then
					arg_289_1.talkMaxDuration = var_292_8

					if var_292_8 + var_292_4 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_8 + var_292_4
					end
				end

				arg_289_1.text_.text = var_292_6
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)
				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_9 = math.max(var_292_5, arg_289_1.talkMaxDuration)

			if var_292_4 <= arg_289_1.time_ and arg_289_1.time_ < var_292_4 + var_292_9 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_4) / var_292_9

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_4 + var_292_9 and arg_289_1.time_ < var_292_4 + var_292_9 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end

		arg_289_1.nodeConfigList_ = {}

		arg_289_1:InitPlayNodeList()
	end,
	Play935011072 = function(arg_293_0, arg_293_1)
		arg_293_1.time_ = 0
		arg_293_1.frameCnt_ = 0
		arg_293_1.state_ = "playing"
		arg_293_1.curTalkId_ = 935011072
		arg_293_1.duration_ = 5

		SetActive(arg_293_1.tipsGo_, false)

		function arg_293_1.onSingleLineFinish_()
			arg_293_1.onSingleLineUpdate_ = nil
			arg_293_1.onSingleLineFinish_ = nil
			arg_293_1.state_ = "waiting"
		end

		function arg_293_1.playNext_(arg_295_0)
			if arg_295_0 == 1 then
				arg_293_0:Play935011073(arg_293_1)
			end
		end

		function arg_293_1.onSingleLineUpdate_(arg_296_0)
			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(arg_293_1.actors_["1070ui_story"]) and arg_293_1.var_.characterEffect1070ui_story == nil then
				arg_293_1.var_.characterEffect1070ui_story = arg_293_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_0 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_0 and not isNil(arg_293_1.actors_["1070ui_story"]) then
				if arg_293_1.var_.characterEffect1070ui_story and not isNil(arg_293_1.actors_["1070ui_story"]) then
					arg_293_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_293_1.time_ >= 0 + var_296_0 and arg_293_1.time_ < 0 + var_296_0 + arg_296_0 and not isNil(arg_293_1.actors_["1070ui_story"]) and arg_293_1.var_.characterEffect1070ui_story then
				arg_293_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_296_2 = arg_293_1.actors_["10039ui_story"]

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect10039ui_story == nil then
				arg_293_1.var_.characterEffect10039ui_story = var_296_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_296_3 = 0.200000002980232

			if 0 <= arg_293_1.time_ and arg_293_1.time_ < 0 + var_296_3 and not isNil(var_296_2) then
				if arg_293_1.var_.characterEffect10039ui_story and not isNil(var_296_2) then
					arg_293_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_293_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_293_1.time_ - 0) / var_296_3)
				end
			end

			if arg_293_1.time_ >= 0 + var_296_3 and arg_293_1.time_ < 0 + var_296_3 + arg_296_0 and not isNil(var_296_2) and arg_293_1.var_.characterEffect10039ui_story then
				arg_293_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_293_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= 0 + arg_296_0 then
				arg_293_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action5_2")
			end

			local var_296_4 = 0
			local var_296_5 = 0.125

			if 0 < arg_293_1.time_ and arg_293_1.time_ <= var_296_4 + arg_296_0 then
				arg_293_1.talkMaxDuration = 0
				arg_293_1.dialogCg_.alpha = 1

				arg_293_1.dialog_:SetActive(true)
				SetActive(arg_293_1.leftNameGo_, true)

				arg_293_1.leftNameTxt_.text = arg_293_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_293_1.leftNameTxt_.transform)

				arg_293_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_293_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_293_1:RecordName(arg_293_1.leftNameTxt_.text)
				SetActive(arg_293_1.iconTrs_.gameObject, false)
				arg_293_1.callingController_:SetSelectedState("normal")

				local var_296_6 = arg_293_1:FormatText(arg_293_1:GetWordFromCfg(935011072).content)

				arg_293_1.text_.text = var_296_6

				LuaForUtil.ClearLinePrefixSymbol(arg_293_1.text_)

				local var_296_8 = 5 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_6) / 5)

				if (5 <= 0 and var_296_5 or var_296_5 * (utf8.len(var_296_6) / 5)) > 0 and var_296_5 < var_296_8 then
					arg_293_1.talkMaxDuration = var_296_8

					if var_296_8 + var_296_4 > arg_293_1.duration_ then
						arg_293_1.duration_ = var_296_8 + var_296_4
					end
				end

				arg_293_1.text_.text = var_296_6
				arg_293_1.typewritter.percent = 0

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(false)
				arg_293_1:RecordContent(arg_293_1.text_.text)
			end

			local var_296_9 = math.max(var_296_5, arg_293_1.talkMaxDuration)

			if var_296_4 <= arg_293_1.time_ and arg_293_1.time_ < var_296_4 + var_296_9 then
				arg_293_1.typewritter.percent = (arg_293_1.time_ - var_296_4) / var_296_9

				arg_293_1.typewritter:SetDirty()
			end

			if arg_293_1.time_ >= var_296_4 + var_296_9 and arg_293_1.time_ < var_296_4 + var_296_9 + arg_296_0 then
				arg_293_1.typewritter.percent = 1

				arg_293_1.typewritter:SetDirty()
				arg_293_1:ShowNextGo(true)
			end
		end

		arg_293_1.nodeConfigList_ = {}

		arg_293_1:InitPlayNodeList()
	end,
	Play935011073 = function(arg_297_0, arg_297_1)
		arg_297_1.time_ = 0
		arg_297_1.frameCnt_ = 0
		arg_297_1.state_ = "playing"
		arg_297_1.curTalkId_ = 935011073
		arg_297_1.duration_ = 5

		SetActive(arg_297_1.tipsGo_, false)

		function arg_297_1.onSingleLineFinish_()
			arg_297_1.onSingleLineUpdate_ = nil
			arg_297_1.onSingleLineFinish_ = nil
			arg_297_1.state_ = "waiting"
		end

		function arg_297_1.playNext_(arg_299_0)
			if arg_299_0 == 1 then
				arg_297_0:Play935011074(arg_297_1)
			end
		end

		function arg_297_1.onSingleLineUpdate_(arg_300_0)
			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(arg_297_1.actors_["10039ui_story"]) and arg_297_1.var_.characterEffect10039ui_story == nil then
				arg_297_1.var_.characterEffect10039ui_story = arg_297_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_0 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_0 and not isNil(arg_297_1.actors_["10039ui_story"]) then
				if arg_297_1.var_.characterEffect10039ui_story and not isNil(arg_297_1.actors_["10039ui_story"]) then
					arg_297_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_297_1.time_ >= 0 + var_300_0 and arg_297_1.time_ < 0 + var_300_0 + arg_300_0 and not isNil(arg_297_1.actors_["10039ui_story"]) and arg_297_1.var_.characterEffect10039ui_story then
				arg_297_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_300_2 = arg_297_1.actors_["1070ui_story"]

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect1070ui_story == nil then
				arg_297_1.var_.characterEffect1070ui_story = var_300_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_300_3 = 0.200000002980232

			if 0 <= arg_297_1.time_ and arg_297_1.time_ < 0 + var_300_3 and not isNil(var_300_2) then
				if arg_297_1.var_.characterEffect1070ui_story and not isNil(var_300_2) then
					arg_297_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_297_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_297_1.time_ - 0) / var_300_3)
				end
			end

			if arg_297_1.time_ >= 0 + var_300_3 and arg_297_1.time_ < 0 + var_300_3 + arg_300_0 and not isNil(var_300_2) and arg_297_1.var_.characterEffect1070ui_story then
				arg_297_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_297_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= 0 + arg_300_0 then
				arg_297_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_300_4 = 0
			local var_300_5 = 0.525

			if 0 < arg_297_1.time_ and arg_297_1.time_ <= var_300_4 + arg_300_0 then
				arg_297_1.talkMaxDuration = 0
				arg_297_1.dialogCg_.alpha = 1

				arg_297_1.dialog_:SetActive(true)
				SetActive(arg_297_1.leftNameGo_, true)

				arg_297_1.leftNameTxt_.text = arg_297_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_297_1.leftNameTxt_.transform)

				arg_297_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_297_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_297_1:RecordName(arg_297_1.leftNameTxt_.text)
				SetActive(arg_297_1.iconTrs_.gameObject, false)
				arg_297_1.callingController_:SetSelectedState("normal")

				local var_300_6 = arg_297_1:FormatText(arg_297_1:GetWordFromCfg(935011073).content)

				arg_297_1.text_.text = var_300_6

				LuaForUtil.ClearLinePrefixSymbol(arg_297_1.text_)

				local var_300_8 = 21 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_6) / 21)

				if (21 <= 0 and var_300_5 or var_300_5 * (utf8.len(var_300_6) / 21)) > 0 and var_300_5 < var_300_8 then
					arg_297_1.talkMaxDuration = var_300_8

					if var_300_8 + var_300_4 > arg_297_1.duration_ then
						arg_297_1.duration_ = var_300_8 + var_300_4
					end
				end

				arg_297_1.text_.text = var_300_6
				arg_297_1.typewritter.percent = 0

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(false)
				arg_297_1:RecordContent(arg_297_1.text_.text)
			end

			local var_300_9 = math.max(var_300_5, arg_297_1.talkMaxDuration)

			if var_300_4 <= arg_297_1.time_ and arg_297_1.time_ < var_300_4 + var_300_9 then
				arg_297_1.typewritter.percent = (arg_297_1.time_ - var_300_4) / var_300_9

				arg_297_1.typewritter:SetDirty()
			end

			if arg_297_1.time_ >= var_300_4 + var_300_9 and arg_297_1.time_ < var_300_4 + var_300_9 + arg_300_0 then
				arg_297_1.typewritter.percent = 1

				arg_297_1.typewritter:SetDirty()
				arg_297_1:ShowNextGo(true)
			end
		end

		arg_297_1.nodeConfigList_ = {}

		arg_297_1:InitPlayNodeList()
	end,
	Play935011074 = function(arg_301_0, arg_301_1)
		arg_301_1.time_ = 0
		arg_301_1.frameCnt_ = 0
		arg_301_1.state_ = "playing"
		arg_301_1.curTalkId_ = 935011074
		arg_301_1.duration_ = 5

		SetActive(arg_301_1.tipsGo_, false)

		function arg_301_1.onSingleLineFinish_()
			arg_301_1.onSingleLineUpdate_ = nil
			arg_301_1.onSingleLineFinish_ = nil
			arg_301_1.state_ = "waiting"
		end

		function arg_301_1.playNext_(arg_303_0)
			if arg_303_0 == 1 then
				arg_301_0:Play935011075(arg_301_1)
			end
		end

		function arg_301_1.onSingleLineUpdate_(arg_304_0)
			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(arg_301_1.actors_["1070ui_story"]) and arg_301_1.var_.characterEffect1070ui_story == nil then
				arg_301_1.var_.characterEffect1070ui_story = arg_301_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_0 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_0 and not isNil(arg_301_1.actors_["1070ui_story"]) then
				if arg_301_1.var_.characterEffect1070ui_story and not isNil(arg_301_1.actors_["1070ui_story"]) then
					arg_301_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_301_1.time_ >= 0 + var_304_0 and arg_301_1.time_ < 0 + var_304_0 + arg_304_0 and not isNil(arg_301_1.actors_["1070ui_story"]) and arg_301_1.var_.characterEffect1070ui_story then
				arg_301_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_304_2 = arg_301_1.actors_["10039ui_story"]

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect10039ui_story == nil then
				arg_301_1.var_.characterEffect10039ui_story = var_304_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_304_3 = 0.200000002980232

			if 0 <= arg_301_1.time_ and arg_301_1.time_ < 0 + var_304_3 and not isNil(var_304_2) then
				if arg_301_1.var_.characterEffect10039ui_story and not isNil(var_304_2) then
					arg_301_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_301_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_301_1.time_ - 0) / var_304_3)
				end
			end

			if arg_301_1.time_ >= 0 + var_304_3 and arg_301_1.time_ < 0 + var_304_3 + arg_304_0 and not isNil(var_304_2) and arg_301_1.var_.characterEffect10039ui_story then
				arg_301_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_301_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= 0 + arg_304_0 then
				arg_301_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva", "EmotionTimelineAnimator")
			end

			local var_304_4 = 0
			local var_304_5 = 0.975

			if 0 < arg_301_1.time_ and arg_301_1.time_ <= var_304_4 + arg_304_0 then
				arg_301_1.talkMaxDuration = 0
				arg_301_1.dialogCg_.alpha = 1

				arg_301_1.dialog_:SetActive(true)
				SetActive(arg_301_1.leftNameGo_, true)

				arg_301_1.leftNameTxt_.text = arg_301_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_301_1.leftNameTxt_.transform)

				arg_301_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_301_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_301_1:RecordName(arg_301_1.leftNameTxt_.text)
				SetActive(arg_301_1.iconTrs_.gameObject, false)
				arg_301_1.callingController_:SetSelectedState("normal")

				local var_304_6 = arg_301_1:FormatText(arg_301_1:GetWordFromCfg(935011074).content)

				arg_301_1.text_.text = var_304_6

				LuaForUtil.ClearLinePrefixSymbol(arg_301_1.text_)

				local var_304_8 = 39 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_6) / 39)

				if (39 <= 0 and var_304_5 or var_304_5 * (utf8.len(var_304_6) / 39)) > 0 and var_304_5 < var_304_8 then
					arg_301_1.talkMaxDuration = var_304_8

					if var_304_8 + var_304_4 > arg_301_1.duration_ then
						arg_301_1.duration_ = var_304_8 + var_304_4
					end
				end

				arg_301_1.text_.text = var_304_6
				arg_301_1.typewritter.percent = 0

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(false)
				arg_301_1:RecordContent(arg_301_1.text_.text)
			end

			local var_304_9 = math.max(var_304_5, arg_301_1.talkMaxDuration)

			if var_304_4 <= arg_301_1.time_ and arg_301_1.time_ < var_304_4 + var_304_9 then
				arg_301_1.typewritter.percent = (arg_301_1.time_ - var_304_4) / var_304_9

				arg_301_1.typewritter:SetDirty()
			end

			if arg_301_1.time_ >= var_304_4 + var_304_9 and arg_301_1.time_ < var_304_4 + var_304_9 + arg_304_0 then
				arg_301_1.typewritter.percent = 1

				arg_301_1.typewritter:SetDirty()
				arg_301_1:ShowNextGo(true)
			end
		end

		arg_301_1.nodeConfigList_ = {}

		arg_301_1:InitPlayNodeList()
	end,
	Play935011075 = function(arg_305_0, arg_305_1)
		arg_305_1.time_ = 0
		arg_305_1.frameCnt_ = 0
		arg_305_1.state_ = "playing"
		arg_305_1.curTalkId_ = 935011075
		arg_305_1.duration_ = 5

		SetActive(arg_305_1.tipsGo_, false)

		function arg_305_1.onSingleLineFinish_()
			arg_305_1.onSingleLineUpdate_ = nil
			arg_305_1.onSingleLineFinish_ = nil
			arg_305_1.state_ = "waiting"
		end

		function arg_305_1.playNext_(arg_307_0)
			if arg_307_0 == 1 then
				arg_305_0:Play935011076(arg_305_1)
			end
		end

		function arg_305_1.onSingleLineUpdate_(arg_308_0)
			if 0 < arg_305_1.time_ and arg_305_1.time_ <= 0 + arg_308_0 then
				arg_305_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action447")
			end

			local var_308_0 = 0
			local var_308_1 = 0.85

			if 0 < arg_305_1.time_ and arg_305_1.time_ <= var_308_0 + arg_308_0 then
				arg_305_1.talkMaxDuration = 0
				arg_305_1.dialogCg_.alpha = 1

				arg_305_1.dialog_:SetActive(true)
				SetActive(arg_305_1.leftNameGo_, true)

				arg_305_1.leftNameTxt_.text = arg_305_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_305_1.leftNameTxt_.transform)

				arg_305_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_305_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_305_1:RecordName(arg_305_1.leftNameTxt_.text)
				SetActive(arg_305_1.iconTrs_.gameObject, false)
				arg_305_1.callingController_:SetSelectedState("normal")

				local var_308_2 = arg_305_1:FormatText(arg_305_1:GetWordFromCfg(935011075).content)

				arg_305_1.text_.text = var_308_2

				LuaForUtil.ClearLinePrefixSymbol(arg_305_1.text_)

				local var_308_4 = 34 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_2) / 34)

				if (34 <= 0 and var_308_1 or var_308_1 * (utf8.len(var_308_2) / 34)) > 0 and var_308_1 < var_308_4 then
					arg_305_1.talkMaxDuration = var_308_4

					if var_308_4 + var_308_0 > arg_305_1.duration_ then
						arg_305_1.duration_ = var_308_4 + var_308_0
					end
				end

				arg_305_1.text_.text = var_308_2
				arg_305_1.typewritter.percent = 0

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(false)
				arg_305_1:RecordContent(arg_305_1.text_.text)
			end

			local var_308_5 = math.max(var_308_1, arg_305_1.talkMaxDuration)

			if var_308_0 <= arg_305_1.time_ and arg_305_1.time_ < var_308_0 + var_308_5 then
				arg_305_1.typewritter.percent = (arg_305_1.time_ - var_308_0) / var_308_5

				arg_305_1.typewritter:SetDirty()
			end

			if arg_305_1.time_ >= var_308_0 + var_308_5 and arg_305_1.time_ < var_308_0 + var_308_5 + arg_308_0 then
				arg_305_1.typewritter.percent = 1

				arg_305_1.typewritter:SetDirty()
				arg_305_1:ShowNextGo(true)
			end
		end

		arg_305_1.nodeConfigList_ = {}

		arg_305_1:InitPlayNodeList()
	end,
	Play935011076 = function(arg_309_0, arg_309_1)
		arg_309_1.time_ = 0
		arg_309_1.frameCnt_ = 0
		arg_309_1.state_ = "playing"
		arg_309_1.curTalkId_ = 935011076
		arg_309_1.duration_ = 5

		SetActive(arg_309_1.tipsGo_, false)

		function arg_309_1.onSingleLineFinish_()
			arg_309_1.onSingleLineUpdate_ = nil
			arg_309_1.onSingleLineFinish_ = nil
			arg_309_1.state_ = "waiting"
		end

		function arg_309_1.playNext_(arg_311_0)
			if arg_311_0 == 1 then
				arg_309_0:Play935011077(arg_309_1)
			end
		end

		function arg_309_1.onSingleLineUpdate_(arg_312_0)
			if 0 < arg_309_1.time_ and arg_309_1.time_ <= 0 + arg_312_0 then
				arg_309_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva", "EmotionTimelineAnimator")
			end

			local var_312_0 = 0
			local var_312_1 = 0.725

			if 0 < arg_309_1.time_ and arg_309_1.time_ <= var_312_0 + arg_312_0 then
				arg_309_1.talkMaxDuration = 0
				arg_309_1.dialogCg_.alpha = 1

				arg_309_1.dialog_:SetActive(true)
				SetActive(arg_309_1.leftNameGo_, true)

				arg_309_1.leftNameTxt_.text = arg_309_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_309_1.leftNameTxt_.transform)

				arg_309_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_309_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_309_1:RecordName(arg_309_1.leftNameTxt_.text)
				SetActive(arg_309_1.iconTrs_.gameObject, false)
				arg_309_1.callingController_:SetSelectedState("normal")

				local var_312_2 = arg_309_1:FormatText(arg_309_1:GetWordFromCfg(935011076).content)

				arg_309_1.text_.text = var_312_2

				LuaForUtil.ClearLinePrefixSymbol(arg_309_1.text_)

				local var_312_4 = 29 <= 0 and var_312_1 or var_312_1 * (utf8.len(var_312_2) / 29)

				if (29 <= 0 and var_312_1 or var_312_1 * (utf8.len(var_312_2) / 29)) > 0 and var_312_1 < var_312_4 then
					arg_309_1.talkMaxDuration = var_312_4

					if var_312_4 + var_312_0 > arg_309_1.duration_ then
						arg_309_1.duration_ = var_312_4 + var_312_0
					end
				end

				arg_309_1.text_.text = var_312_2
				arg_309_1.typewritter.percent = 0

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(false)
				arg_309_1:RecordContent(arg_309_1.text_.text)
			end

			local var_312_5 = math.max(var_312_1, arg_309_1.talkMaxDuration)

			if var_312_0 <= arg_309_1.time_ and arg_309_1.time_ < var_312_0 + var_312_5 then
				arg_309_1.typewritter.percent = (arg_309_1.time_ - var_312_0) / var_312_5

				arg_309_1.typewritter:SetDirty()
			end

			if arg_309_1.time_ >= var_312_0 + var_312_5 and arg_309_1.time_ < var_312_0 + var_312_5 + arg_312_0 then
				arg_309_1.typewritter.percent = 1

				arg_309_1.typewritter:SetDirty()
				arg_309_1:ShowNextGo(true)
			end
		end

		arg_309_1.nodeConfigList_ = {}

		arg_309_1:InitPlayNodeList()
	end,
	Play935011077 = function(arg_313_0, arg_313_1)
		arg_313_1.time_ = 0
		arg_313_1.frameCnt_ = 0
		arg_313_1.state_ = "playing"
		arg_313_1.curTalkId_ = 935011077
		arg_313_1.duration_ = 5

		SetActive(arg_313_1.tipsGo_, false)

		function arg_313_1.onSingleLineFinish_()
			arg_313_1.onSingleLineUpdate_ = nil
			arg_313_1.onSingleLineFinish_ = nil
			arg_313_1.state_ = "waiting"
		end

		function arg_313_1.playNext_(arg_315_0)
			if arg_315_0 == 1 then
				arg_313_0:Play935011078(arg_313_1)
			end
		end

		function arg_313_1.onSingleLineUpdate_(arg_316_0)
			if 0 < arg_313_1.time_ and arg_313_1.time_ <= 0 + arg_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) and arg_313_1.var_.characterEffect1070ui_story == nil then
				arg_313_1.var_.characterEffect1070ui_story = arg_313_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_316_0 = 0.200000002980232

			if 0 <= arg_313_1.time_ and arg_313_1.time_ < 0 + var_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) then
				if arg_313_1.var_.characterEffect1070ui_story and not isNil(arg_313_1.actors_["1070ui_story"]) then
					arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_313_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_313_1.time_ - 0) / var_316_0)
				end
			end

			if arg_313_1.time_ >= 0 + var_316_0 and arg_313_1.time_ < 0 + var_316_0 + arg_316_0 and not isNil(arg_313_1.actors_["1070ui_story"]) and arg_313_1.var_.characterEffect1070ui_story then
				arg_313_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_313_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_316_1 = 0
			local var_316_2 = 1.275

			if 0 < arg_313_1.time_ and arg_313_1.time_ <= var_316_1 + arg_316_0 then
				arg_313_1.talkMaxDuration = 0
				arg_313_1.dialogCg_.alpha = 1

				arg_313_1.dialog_:SetActive(true)
				SetActive(arg_313_1.leftNameGo_, false)

				arg_313_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_313_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_313_1:RecordName(arg_313_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_313_1.iconTrs_.gameObject, false)
				arg_313_1.callingController_:SetSelectedState("normal")

				local var_316_3 = arg_313_1:FormatText(arg_313_1:GetWordFromCfg(935011077).content)

				arg_313_1.text_.text = var_316_3

				LuaForUtil.ClearLinePrefixSymbol(arg_313_1.text_)

				local var_316_5 = 51 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 51)

				if (51 <= 0 and var_316_2 or var_316_2 * (utf8.len(var_316_3) / 51)) > 0 and var_316_2 < var_316_5 then
					arg_313_1.talkMaxDuration = var_316_5

					if var_316_5 + var_316_1 > arg_313_1.duration_ then
						arg_313_1.duration_ = var_316_5 + var_316_1
					end
				end

				arg_313_1.text_.text = var_316_3
				arg_313_1.typewritter.percent = 0

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(false)
				arg_313_1:RecordContent(arg_313_1.text_.text)
			end

			local var_316_6 = math.max(var_316_2, arg_313_1.talkMaxDuration)

			if var_316_1 <= arg_313_1.time_ and arg_313_1.time_ < var_316_1 + var_316_6 then
				arg_313_1.typewritter.percent = (arg_313_1.time_ - var_316_1) / var_316_6

				arg_313_1.typewritter:SetDirty()
			end

			if arg_313_1.time_ >= var_316_1 + var_316_6 and arg_313_1.time_ < var_316_1 + var_316_6 + arg_316_0 then
				arg_313_1.typewritter.percent = 1

				arg_313_1.typewritter:SetDirty()
				arg_313_1:ShowNextGo(true)
			end
		end

		arg_313_1.nodeConfigList_ = {}

		arg_313_1:InitPlayNodeList()
	end,
	Play935011078 = function(arg_317_0, arg_317_1)
		arg_317_1.time_ = 0
		arg_317_1.frameCnt_ = 0
		arg_317_1.state_ = "playing"
		arg_317_1.curTalkId_ = 935011078
		arg_317_1.duration_ = 5

		SetActive(arg_317_1.tipsGo_, false)

		function arg_317_1.onSingleLineFinish_()
			arg_317_1.onSingleLineUpdate_ = nil
			arg_317_1.onSingleLineFinish_ = nil
			arg_317_1.state_ = "waiting"
		end

		function arg_317_1.playNext_(arg_319_0)
			if arg_319_0 == 1 then
				arg_317_0:Play935011079(arg_317_1)
			end
		end

		function arg_317_1.onSingleLineUpdate_(arg_320_0)
			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 and not isNil(arg_317_1.actors_["1070ui_story"]) and arg_317_1.var_.characterEffect1070ui_story == nil then
				arg_317_1.var_.characterEffect1070ui_story = arg_317_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_320_0 = 0.200000002980232

			if 0 <= arg_317_1.time_ and arg_317_1.time_ < 0 + var_320_0 and not isNil(arg_317_1.actors_["1070ui_story"]) then
				if arg_317_1.var_.characterEffect1070ui_story and not isNil(arg_317_1.actors_["1070ui_story"]) then
					arg_317_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_317_1.time_ >= 0 + var_320_0 and arg_317_1.time_ < 0 + var_320_0 + arg_320_0 and not isNil(arg_317_1.actors_["1070ui_story"]) and arg_317_1.var_.characterEffect1070ui_story then
				arg_317_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= 0 + arg_320_0 then
				arg_317_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva", "EmotionTimelineAnimator")
			end

			local var_320_2 = 0
			local var_320_3 = 0.15

			if 0 < arg_317_1.time_ and arg_317_1.time_ <= var_320_2 + arg_320_0 then
				arg_317_1.talkMaxDuration = 0
				arg_317_1.dialogCg_.alpha = 1

				arg_317_1.dialog_:SetActive(true)
				SetActive(arg_317_1.leftNameGo_, true)

				arg_317_1.leftNameTxt_.text = arg_317_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_317_1.leftNameTxt_.transform)

				arg_317_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_317_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_317_1:RecordName(arg_317_1.leftNameTxt_.text)
				SetActive(arg_317_1.iconTrs_.gameObject, false)
				arg_317_1.callingController_:SetSelectedState("normal")

				local var_320_4 = arg_317_1:FormatText(arg_317_1:GetWordFromCfg(935011078).content)

				arg_317_1.text_.text = var_320_4

				LuaForUtil.ClearLinePrefixSymbol(arg_317_1.text_)

				local var_320_6 = 6 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_4) / 6)

				if (6 <= 0 and var_320_3 or var_320_3 * (utf8.len(var_320_4) / 6)) > 0 and var_320_3 < var_320_6 then
					arg_317_1.talkMaxDuration = var_320_6

					if var_320_6 + var_320_2 > arg_317_1.duration_ then
						arg_317_1.duration_ = var_320_6 + var_320_2
					end
				end

				arg_317_1.text_.text = var_320_4
				arg_317_1.typewritter.percent = 0

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(false)
				arg_317_1:RecordContent(arg_317_1.text_.text)
			end

			local var_320_7 = math.max(var_320_3, arg_317_1.talkMaxDuration)

			if var_320_2 <= arg_317_1.time_ and arg_317_1.time_ < var_320_2 + var_320_7 then
				arg_317_1.typewritter.percent = (arg_317_1.time_ - var_320_2) / var_320_7

				arg_317_1.typewritter:SetDirty()
			end

			if arg_317_1.time_ >= var_320_2 + var_320_7 and arg_317_1.time_ < var_320_2 + var_320_7 + arg_320_0 then
				arg_317_1.typewritter.percent = 1

				arg_317_1.typewritter:SetDirty()
				arg_317_1:ShowNextGo(true)
			end
		end

		arg_317_1.nodeConfigList_ = {}

		arg_317_1:InitPlayNodeList()
	end,
	Play935011079 = function(arg_321_0, arg_321_1)
		arg_321_1.time_ = 0
		arg_321_1.frameCnt_ = 0
		arg_321_1.state_ = "playing"
		arg_321_1.curTalkId_ = 935011079
		arg_321_1.duration_ = 5

		SetActive(arg_321_1.tipsGo_, false)

		function arg_321_1.onSingleLineFinish_()
			arg_321_1.onSingleLineUpdate_ = nil
			arg_321_1.onSingleLineFinish_ = nil
			arg_321_1.state_ = "waiting"
		end

		function arg_321_1.playNext_(arg_323_0)
			if arg_323_0 == 1 then
				arg_321_0:Play935011080(arg_321_1)
			end
		end

		function arg_321_1.onSingleLineUpdate_(arg_324_0)
			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(arg_321_1.actors_["10039ui_story"]) and arg_321_1.var_.characterEffect10039ui_story == nil then
				arg_321_1.var_.characterEffect10039ui_story = arg_321_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_0 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_0 and not isNil(arg_321_1.actors_["10039ui_story"]) then
				if arg_321_1.var_.characterEffect10039ui_story and not isNil(arg_321_1.actors_["10039ui_story"]) then
					arg_321_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_321_1.time_ >= 0 + var_324_0 and arg_321_1.time_ < 0 + var_324_0 + arg_324_0 and not isNil(arg_321_1.actors_["10039ui_story"]) and arg_321_1.var_.characterEffect10039ui_story then
				arg_321_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_324_2 = arg_321_1.actors_["1070ui_story"]

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.characterEffect1070ui_story == nil then
				arg_321_1.var_.characterEffect1070ui_story = var_324_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_324_3 = 0.200000002980232

			if 0 <= arg_321_1.time_ and arg_321_1.time_ < 0 + var_324_3 and not isNil(var_324_2) then
				if arg_321_1.var_.characterEffect1070ui_story and not isNil(var_324_2) then
					arg_321_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_321_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_321_1.time_ - 0) / var_324_3)
				end
			end

			if arg_321_1.time_ >= 0 + var_324_3 and arg_321_1.time_ < 0 + var_324_3 + arg_324_0 and not isNil(var_324_2) and arg_321_1.var_.characterEffect1070ui_story then
				arg_321_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_321_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= 0 + arg_324_0 then
				arg_321_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva", "EmotionTimelineAnimator")
			end

			local var_324_4 = 0
			local var_324_5 = 0.375

			if 0 < arg_321_1.time_ and arg_321_1.time_ <= var_324_4 + arg_324_0 then
				arg_321_1.talkMaxDuration = 0
				arg_321_1.dialogCg_.alpha = 1

				arg_321_1.dialog_:SetActive(true)
				SetActive(arg_321_1.leftNameGo_, true)

				arg_321_1.leftNameTxt_.text = arg_321_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_321_1.leftNameTxt_.transform)

				arg_321_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_321_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_321_1:RecordName(arg_321_1.leftNameTxt_.text)
				SetActive(arg_321_1.iconTrs_.gameObject, false)
				arg_321_1.callingController_:SetSelectedState("normal")

				local var_324_6 = arg_321_1:FormatText(arg_321_1:GetWordFromCfg(935011079).content)

				arg_321_1.text_.text = var_324_6

				LuaForUtil.ClearLinePrefixSymbol(arg_321_1.text_)

				local var_324_8 = 15 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_6) / 15)

				if (15 <= 0 and var_324_5 or var_324_5 * (utf8.len(var_324_6) / 15)) > 0 and var_324_5 < var_324_8 then
					arg_321_1.talkMaxDuration = var_324_8

					if var_324_8 + var_324_4 > arg_321_1.duration_ then
						arg_321_1.duration_ = var_324_8 + var_324_4
					end
				end

				arg_321_1.text_.text = var_324_6
				arg_321_1.typewritter.percent = 0

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(false)
				arg_321_1:RecordContent(arg_321_1.text_.text)
			end

			local var_324_9 = math.max(var_324_5, arg_321_1.talkMaxDuration)

			if var_324_4 <= arg_321_1.time_ and arg_321_1.time_ < var_324_4 + var_324_9 then
				arg_321_1.typewritter.percent = (arg_321_1.time_ - var_324_4) / var_324_9

				arg_321_1.typewritter:SetDirty()
			end

			if arg_321_1.time_ >= var_324_4 + var_324_9 and arg_321_1.time_ < var_324_4 + var_324_9 + arg_324_0 then
				arg_321_1.typewritter.percent = 1

				arg_321_1.typewritter:SetDirty()
				arg_321_1:ShowNextGo(true)
			end
		end

		arg_321_1.nodeConfigList_ = {}

		arg_321_1:InitPlayNodeList()
	end,
	Play935011080 = function(arg_325_0, arg_325_1)
		arg_325_1.time_ = 0
		arg_325_1.frameCnt_ = 0
		arg_325_1.state_ = "playing"
		arg_325_1.curTalkId_ = 935011080
		arg_325_1.duration_ = 5

		SetActive(arg_325_1.tipsGo_, false)

		function arg_325_1.onSingleLineFinish_()
			arg_325_1.onSingleLineUpdate_ = nil
			arg_325_1.onSingleLineFinish_ = nil
			arg_325_1.state_ = "waiting"
		end

		function arg_325_1.playNext_(arg_327_0)
			if arg_327_0 == 1 then
				arg_325_0:Play935011081(arg_325_1)
			end
		end

		function arg_325_1.onSingleLineUpdate_(arg_328_0)
			if 0 < arg_325_1.time_ and arg_325_1.time_ <= 0 + arg_328_0 then
				arg_325_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva", "EmotionTimelineAnimator")
			end

			local var_328_0 = 0
			local var_328_1 = 1.3

			if 0 < arg_325_1.time_ and arg_325_1.time_ <= var_328_0 + arg_328_0 then
				arg_325_1.talkMaxDuration = 0
				arg_325_1.dialogCg_.alpha = 1

				arg_325_1.dialog_:SetActive(true)
				SetActive(arg_325_1.leftNameGo_, true)

				arg_325_1.leftNameTxt_.text = arg_325_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_325_1.leftNameTxt_.transform)

				arg_325_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_325_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_325_1:RecordName(arg_325_1.leftNameTxt_.text)
				SetActive(arg_325_1.iconTrs_.gameObject, false)
				arg_325_1.callingController_:SetSelectedState("normal")

				local var_328_2 = arg_325_1:FormatText(arg_325_1:GetWordFromCfg(935011080).content)

				arg_325_1.text_.text = var_328_2

				LuaForUtil.ClearLinePrefixSymbol(arg_325_1.text_)

				local var_328_4 = 52 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_2) / 52)

				if (52 <= 0 and var_328_1 or var_328_1 * (utf8.len(var_328_2) / 52)) > 0 and var_328_1 < var_328_4 then
					arg_325_1.talkMaxDuration = var_328_4

					if var_328_4 + var_328_0 > arg_325_1.duration_ then
						arg_325_1.duration_ = var_328_4 + var_328_0
					end
				end

				arg_325_1.text_.text = var_328_2
				arg_325_1.typewritter.percent = 0

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(false)
				arg_325_1:RecordContent(arg_325_1.text_.text)
			end

			local var_328_5 = math.max(var_328_1, arg_325_1.talkMaxDuration)

			if var_328_0 <= arg_325_1.time_ and arg_325_1.time_ < var_328_0 + var_328_5 then
				arg_325_1.typewritter.percent = (arg_325_1.time_ - var_328_0) / var_328_5

				arg_325_1.typewritter:SetDirty()
			end

			if arg_325_1.time_ >= var_328_0 + var_328_5 and arg_325_1.time_ < var_328_0 + var_328_5 + arg_328_0 then
				arg_325_1.typewritter.percent = 1

				arg_325_1.typewritter:SetDirty()
				arg_325_1:ShowNextGo(true)
			end
		end

		arg_325_1.nodeConfigList_ = {}

		arg_325_1:InitPlayNodeList()
	end,
	Play935011081 = function(arg_329_0, arg_329_1)
		arg_329_1.time_ = 0
		arg_329_1.frameCnt_ = 0
		arg_329_1.state_ = "playing"
		arg_329_1.curTalkId_ = 935011081
		arg_329_1.duration_ = 5

		SetActive(arg_329_1.tipsGo_, false)

		function arg_329_1.onSingleLineFinish_()
			arg_329_1.onSingleLineUpdate_ = nil
			arg_329_1.onSingleLineFinish_ = nil
			arg_329_1.state_ = "waiting"
		end

		function arg_329_1.playNext_(arg_331_0)
			if arg_331_0 == 1 then
				arg_329_0:Play935011082(arg_329_1)
			end
		end

		function arg_329_1.onSingleLineUpdate_(arg_332_0)
			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(arg_329_1.actors_["1070ui_story"]) and arg_329_1.var_.characterEffect1070ui_story == nil then
				arg_329_1.var_.characterEffect1070ui_story = arg_329_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_0 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_0 and not isNil(arg_329_1.actors_["1070ui_story"]) then
				if arg_329_1.var_.characterEffect1070ui_story and not isNil(arg_329_1.actors_["1070ui_story"]) then
					arg_329_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_329_1.time_ >= 0 + var_332_0 and arg_329_1.time_ < 0 + var_332_0 + arg_332_0 and not isNil(arg_329_1.actors_["1070ui_story"]) and arg_329_1.var_.characterEffect1070ui_story then
				arg_329_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_332_2 = arg_329_1.actors_["10039ui_story"]

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.characterEffect10039ui_story == nil then
				arg_329_1.var_.characterEffect10039ui_story = var_332_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_332_3 = 0.200000002980232

			if 0 <= arg_329_1.time_ and arg_329_1.time_ < 0 + var_332_3 and not isNil(var_332_2) then
				if arg_329_1.var_.characterEffect10039ui_story and not isNil(var_332_2) then
					arg_329_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_329_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_329_1.time_ - 0) / var_332_3)
				end
			end

			if arg_329_1.time_ >= 0 + var_332_3 and arg_329_1.time_ < 0 + var_332_3 + arg_332_0 and not isNil(var_332_2) and arg_329_1.var_.characterEffect10039ui_story then
				arg_329_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_329_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= 0 + arg_332_0 then
				arg_329_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva", "EmotionTimelineAnimator")
			end

			local var_332_4 = 0
			local var_332_5 = 0.225

			if 0 < arg_329_1.time_ and arg_329_1.time_ <= var_332_4 + arg_332_0 then
				arg_329_1.talkMaxDuration = 0
				arg_329_1.dialogCg_.alpha = 1

				arg_329_1.dialog_:SetActive(true)
				SetActive(arg_329_1.leftNameGo_, true)

				arg_329_1.leftNameTxt_.text = arg_329_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_329_1.leftNameTxt_.transform)

				arg_329_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_329_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_329_1:RecordName(arg_329_1.leftNameTxt_.text)
				SetActive(arg_329_1.iconTrs_.gameObject, false)
				arg_329_1.callingController_:SetSelectedState("normal")

				local var_332_6 = arg_329_1:FormatText(arg_329_1:GetWordFromCfg(935011081).content)

				arg_329_1.text_.text = var_332_6

				LuaForUtil.ClearLinePrefixSymbol(arg_329_1.text_)

				local var_332_8 = 9 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_6) / 9)

				if (9 <= 0 and var_332_5 or var_332_5 * (utf8.len(var_332_6) / 9)) > 0 and var_332_5 < var_332_8 then
					arg_329_1.talkMaxDuration = var_332_8

					if var_332_8 + var_332_4 > arg_329_1.duration_ then
						arg_329_1.duration_ = var_332_8 + var_332_4
					end
				end

				arg_329_1.text_.text = var_332_6
				arg_329_1.typewritter.percent = 0

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(false)
				arg_329_1:RecordContent(arg_329_1.text_.text)
			end

			local var_332_9 = math.max(var_332_5, arg_329_1.talkMaxDuration)

			if var_332_4 <= arg_329_1.time_ and arg_329_1.time_ < var_332_4 + var_332_9 then
				arg_329_1.typewritter.percent = (arg_329_1.time_ - var_332_4) / var_332_9

				arg_329_1.typewritter:SetDirty()
			end

			if arg_329_1.time_ >= var_332_4 + var_332_9 and arg_329_1.time_ < var_332_4 + var_332_9 + arg_332_0 then
				arg_329_1.typewritter.percent = 1

				arg_329_1.typewritter:SetDirty()
				arg_329_1:ShowNextGo(true)
			end
		end

		arg_329_1.nodeConfigList_ = {}

		arg_329_1:InitPlayNodeList()
	end,
	Play935011082 = function(arg_333_0, arg_333_1)
		arg_333_1.time_ = 0
		arg_333_1.frameCnt_ = 0
		arg_333_1.state_ = "playing"
		arg_333_1.curTalkId_ = 935011082
		arg_333_1.duration_ = 5

		SetActive(arg_333_1.tipsGo_, false)

		function arg_333_1.onSingleLineFinish_()
			arg_333_1.onSingleLineUpdate_ = nil
			arg_333_1.onSingleLineFinish_ = nil
			arg_333_1.state_ = "waiting"
		end

		function arg_333_1.playNext_(arg_335_0)
			if arg_335_0 == 1 then
				arg_333_0:Play935011083(arg_333_1)
			end
		end

		function arg_333_1.onSingleLineUpdate_(arg_336_0)
			if 0 < arg_333_1.time_ and arg_333_1.time_ <= 0 + arg_336_0 and not isNil(arg_333_1.actors_["1070ui_story"]) and arg_333_1.var_.characterEffect1070ui_story == nil then
				arg_333_1.var_.characterEffect1070ui_story = arg_333_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_336_0 = 0.200000002980232

			if 0 <= arg_333_1.time_ and arg_333_1.time_ < 0 + var_336_0 and not isNil(arg_333_1.actors_["1070ui_story"]) then
				if arg_333_1.var_.characterEffect1070ui_story and not isNil(arg_333_1.actors_["1070ui_story"]) then
					arg_333_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_333_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_333_1.time_ - 0) / var_336_0)
				end
			end

			if arg_333_1.time_ >= 0 + var_336_0 and arg_333_1.time_ < 0 + var_336_0 + arg_336_0 and not isNil(arg_333_1.actors_["1070ui_story"]) and arg_333_1.var_.characterEffect1070ui_story then
				arg_333_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_333_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_336_1 = 0
			local var_336_2 = 0.875

			if 0 < arg_333_1.time_ and arg_333_1.time_ <= var_336_1 + arg_336_0 then
				arg_333_1.talkMaxDuration = 0
				arg_333_1.dialogCg_.alpha = 1

				arg_333_1.dialog_:SetActive(true)
				SetActive(arg_333_1.leftNameGo_, false)

				arg_333_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_333_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_333_1:RecordName(arg_333_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_333_1.iconTrs_.gameObject, false)
				arg_333_1.callingController_:SetSelectedState("normal")

				local var_336_3 = arg_333_1:FormatText(arg_333_1:GetWordFromCfg(935011082).content)

				arg_333_1.text_.text = var_336_3

				LuaForUtil.ClearLinePrefixSymbol(arg_333_1.text_)

				local var_336_5 = 35 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 35)

				if (35 <= 0 and var_336_2 or var_336_2 * (utf8.len(var_336_3) / 35)) > 0 and var_336_2 < var_336_5 then
					arg_333_1.talkMaxDuration = var_336_5

					if var_336_5 + var_336_1 > arg_333_1.duration_ then
						arg_333_1.duration_ = var_336_5 + var_336_1
					end
				end

				arg_333_1.text_.text = var_336_3
				arg_333_1.typewritter.percent = 0

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(false)
				arg_333_1:RecordContent(arg_333_1.text_.text)
			end

			local var_336_6 = math.max(var_336_2, arg_333_1.talkMaxDuration)

			if var_336_1 <= arg_333_1.time_ and arg_333_1.time_ < var_336_1 + var_336_6 then
				arg_333_1.typewritter.percent = (arg_333_1.time_ - var_336_1) / var_336_6

				arg_333_1.typewritter:SetDirty()
			end

			if arg_333_1.time_ >= var_336_1 + var_336_6 and arg_333_1.time_ < var_336_1 + var_336_6 + arg_336_0 then
				arg_333_1.typewritter.percent = 1

				arg_333_1.typewritter:SetDirty()
				arg_333_1:ShowNextGo(true)
			end
		end

		arg_333_1.nodeConfigList_ = {}

		arg_333_1:InitPlayNodeList()
	end,
	Play935011083 = function(arg_337_0, arg_337_1)
		arg_337_1.time_ = 0
		arg_337_1.frameCnt_ = 0
		arg_337_1.state_ = "playing"
		arg_337_1.curTalkId_ = 935011083
		arg_337_1.duration_ = 5

		SetActive(arg_337_1.tipsGo_, false)

		function arg_337_1.onSingleLineFinish_()
			arg_337_1.onSingleLineUpdate_ = nil
			arg_337_1.onSingleLineFinish_ = nil
			arg_337_1.state_ = "waiting"
		end

		function arg_337_1.playNext_(arg_339_0)
			if arg_339_0 == 1 then
				arg_337_0:Play935011084(arg_337_1)
			end
		end

		function arg_337_1.onSingleLineUpdate_(arg_340_0)
			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 and not isNil(arg_337_1.actors_["1070ui_story"]) and arg_337_1.var_.characterEffect1070ui_story == nil then
				arg_337_1.var_.characterEffect1070ui_story = arg_337_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_340_0 = 0.200000002980232

			if 0 <= arg_337_1.time_ and arg_337_1.time_ < 0 + var_340_0 and not isNil(arg_337_1.actors_["1070ui_story"]) then
				if arg_337_1.var_.characterEffect1070ui_story and not isNil(arg_337_1.actors_["1070ui_story"]) then
					arg_337_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_337_1.time_ >= 0 + var_340_0 and arg_337_1.time_ < 0 + var_340_0 + arg_340_0 and not isNil(arg_337_1.actors_["1070ui_story"]) and arg_337_1.var_.characterEffect1070ui_story then
				arg_337_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_2")
			end

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= 0 + arg_340_0 then
				arg_337_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva", "EmotionTimelineAnimator")
			end

			local var_340_2 = 0
			local var_340_3 = 0.825

			if 0 < arg_337_1.time_ and arg_337_1.time_ <= var_340_2 + arg_340_0 then
				arg_337_1.talkMaxDuration = 0
				arg_337_1.dialogCg_.alpha = 1

				arg_337_1.dialog_:SetActive(true)
				SetActive(arg_337_1.leftNameGo_, true)

				arg_337_1.leftNameTxt_.text = arg_337_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_337_1.leftNameTxt_.transform)

				arg_337_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_337_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_337_1:RecordName(arg_337_1.leftNameTxt_.text)
				SetActive(arg_337_1.iconTrs_.gameObject, false)
				arg_337_1.callingController_:SetSelectedState("normal")

				local var_340_4 = arg_337_1:FormatText(arg_337_1:GetWordFromCfg(935011083).content)

				arg_337_1.text_.text = var_340_4

				LuaForUtil.ClearLinePrefixSymbol(arg_337_1.text_)

				local var_340_6 = 33 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_4) / 33)

				if (33 <= 0 and var_340_3 or var_340_3 * (utf8.len(var_340_4) / 33)) > 0 and var_340_3 < var_340_6 then
					arg_337_1.talkMaxDuration = var_340_6

					if var_340_6 + var_340_2 > arg_337_1.duration_ then
						arg_337_1.duration_ = var_340_6 + var_340_2
					end
				end

				arg_337_1.text_.text = var_340_4
				arg_337_1.typewritter.percent = 0

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(false)
				arg_337_1:RecordContent(arg_337_1.text_.text)
			end

			local var_340_7 = math.max(var_340_3, arg_337_1.talkMaxDuration)

			if var_340_2 <= arg_337_1.time_ and arg_337_1.time_ < var_340_2 + var_340_7 then
				arg_337_1.typewritter.percent = (arg_337_1.time_ - var_340_2) / var_340_7

				arg_337_1.typewritter:SetDirty()
			end

			if arg_337_1.time_ >= var_340_2 + var_340_7 and arg_337_1.time_ < var_340_2 + var_340_7 + arg_340_0 then
				arg_337_1.typewritter.percent = 1

				arg_337_1.typewritter:SetDirty()
				arg_337_1:ShowNextGo(true)
			end
		end

		arg_337_1.nodeConfigList_ = {}

		arg_337_1:InitPlayNodeList()
	end,
	Play935011084 = function(arg_341_0, arg_341_1)
		arg_341_1.time_ = 0
		arg_341_1.frameCnt_ = 0
		arg_341_1.state_ = "playing"
		arg_341_1.curTalkId_ = 935011084
		arg_341_1.duration_ = 5

		SetActive(arg_341_1.tipsGo_, false)

		function arg_341_1.onSingleLineFinish_()
			arg_341_1.onSingleLineUpdate_ = nil
			arg_341_1.onSingleLineFinish_ = nil
			arg_341_1.state_ = "waiting"
		end

		function arg_341_1.playNext_(arg_343_0)
			if arg_343_0 == 1 then
				arg_341_0:Play935011085(arg_341_1)
			end
		end

		function arg_341_1.onSingleLineUpdate_(arg_344_0)
			if 0 < arg_341_1.time_ and arg_341_1.time_ <= 0 + arg_344_0 and not isNil(arg_341_1.actors_["1070ui_story"]) and arg_341_1.var_.characterEffect1070ui_story == nil then
				arg_341_1.var_.characterEffect1070ui_story = arg_341_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_344_0 = 0.200000002980232

			if 0 <= arg_341_1.time_ and arg_341_1.time_ < 0 + var_344_0 and not isNil(arg_341_1.actors_["1070ui_story"]) then
				if arg_341_1.var_.characterEffect1070ui_story and not isNil(arg_341_1.actors_["1070ui_story"]) then
					arg_341_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_341_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_341_1.time_ - 0) / var_344_0)
				end
			end

			if arg_341_1.time_ >= 0 + var_344_0 and arg_341_1.time_ < 0 + var_344_0 + arg_344_0 and not isNil(arg_341_1.actors_["1070ui_story"]) and arg_341_1.var_.characterEffect1070ui_story then
				arg_341_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_341_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_344_1 = 0
			local var_344_2 = 1.35

			if 0 < arg_341_1.time_ and arg_341_1.time_ <= var_344_1 + arg_344_0 then
				arg_341_1.talkMaxDuration = 0
				arg_341_1.dialogCg_.alpha = 1

				arg_341_1.dialog_:SetActive(true)
				SetActive(arg_341_1.leftNameGo_, false)

				arg_341_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_341_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_341_1:RecordName(arg_341_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_341_1.iconTrs_.gameObject, false)
				arg_341_1.callingController_:SetSelectedState("normal")

				local var_344_3 = arg_341_1:FormatText(arg_341_1:GetWordFromCfg(935011084).content)

				arg_341_1.text_.text = var_344_3

				LuaForUtil.ClearLinePrefixSymbol(arg_341_1.text_)

				local var_344_5 = 54 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 54)

				if (54 <= 0 and var_344_2 or var_344_2 * (utf8.len(var_344_3) / 54)) > 0 and var_344_2 < var_344_5 then
					arg_341_1.talkMaxDuration = var_344_5

					if var_344_5 + var_344_1 > arg_341_1.duration_ then
						arg_341_1.duration_ = var_344_5 + var_344_1
					end
				end

				arg_341_1.text_.text = var_344_3
				arg_341_1.typewritter.percent = 0

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(false)
				arg_341_1:RecordContent(arg_341_1.text_.text)
			end

			local var_344_6 = math.max(var_344_2, arg_341_1.talkMaxDuration)

			if var_344_1 <= arg_341_1.time_ and arg_341_1.time_ < var_344_1 + var_344_6 then
				arg_341_1.typewritter.percent = (arg_341_1.time_ - var_344_1) / var_344_6

				arg_341_1.typewritter:SetDirty()
			end

			if arg_341_1.time_ >= var_344_1 + var_344_6 and arg_341_1.time_ < var_344_1 + var_344_6 + arg_344_0 then
				arg_341_1.typewritter.percent = 1

				arg_341_1.typewritter:SetDirty()
				arg_341_1:ShowNextGo(true)
			end
		end

		arg_341_1.nodeConfigList_ = {}

		arg_341_1:InitPlayNodeList()
	end,
	Play935011085 = function(arg_345_0, arg_345_1)
		arg_345_1.time_ = 0
		arg_345_1.frameCnt_ = 0
		arg_345_1.state_ = "playing"
		arg_345_1.curTalkId_ = 935011085
		arg_345_1.duration_ = 5

		SetActive(arg_345_1.tipsGo_, false)

		function arg_345_1.onSingleLineFinish_()
			arg_345_1.onSingleLineUpdate_ = nil
			arg_345_1.onSingleLineFinish_ = nil
			arg_345_1.state_ = "waiting"
		end

		function arg_345_1.playNext_(arg_347_0)
			if arg_347_0 == 1 then
				arg_345_0:Play935011086(arg_345_1)
			end
		end

		function arg_345_1.onSingleLineUpdate_(arg_348_0)
			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 and not isNil(arg_345_1.actors_["10039ui_story"]) and arg_345_1.var_.characterEffect10039ui_story == nil then
				arg_345_1.var_.characterEffect10039ui_story = arg_345_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_348_0 = 0.200000002980232

			if 0 <= arg_345_1.time_ and arg_345_1.time_ < 0 + var_348_0 and not isNil(arg_345_1.actors_["10039ui_story"]) then
				if arg_345_1.var_.characterEffect10039ui_story and not isNil(arg_345_1.actors_["10039ui_story"]) then
					arg_345_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_345_1.time_ >= 0 + var_348_0 and arg_345_1.time_ < 0 + var_348_0 + arg_348_0 and not isNil(arg_345_1.actors_["10039ui_story"]) and arg_345_1.var_.characterEffect10039ui_story then
				arg_345_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action426")
			end

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= 0 + arg_348_0 then
				arg_345_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0202cva", "EmotionTimelineAnimator")
			end

			local var_348_2 = 0
			local var_348_3 = 0.5

			if 0 < arg_345_1.time_ and arg_345_1.time_ <= var_348_2 + arg_348_0 then
				arg_345_1.talkMaxDuration = 0
				arg_345_1.dialogCg_.alpha = 1

				arg_345_1.dialog_:SetActive(true)
				SetActive(arg_345_1.leftNameGo_, true)

				arg_345_1.leftNameTxt_.text = arg_345_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_345_1.leftNameTxt_.transform)

				arg_345_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_345_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_345_1:RecordName(arg_345_1.leftNameTxt_.text)
				SetActive(arg_345_1.iconTrs_.gameObject, false)
				arg_345_1.callingController_:SetSelectedState("normal")

				local var_348_4 = arg_345_1:FormatText(arg_345_1:GetWordFromCfg(935011085).content)

				arg_345_1.text_.text = var_348_4

				LuaForUtil.ClearLinePrefixSymbol(arg_345_1.text_)

				local var_348_6 = 20 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 20)

				if (20 <= 0 and var_348_3 or var_348_3 * (utf8.len(var_348_4) / 20)) > 0 and var_348_3 < var_348_6 then
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

		arg_345_1.nodeConfigList_ = {}

		arg_345_1:InitPlayNodeList()
	end,
	Play935011086 = function(arg_349_0, arg_349_1)
		arg_349_1.time_ = 0
		arg_349_1.frameCnt_ = 0
		arg_349_1.state_ = "playing"
		arg_349_1.curTalkId_ = 935011086
		arg_349_1.duration_ = 5

		SetActive(arg_349_1.tipsGo_, false)

		function arg_349_1.onSingleLineFinish_()
			arg_349_1.onSingleLineUpdate_ = nil
			arg_349_1.onSingleLineFinish_ = nil
			arg_349_1.state_ = "waiting"
		end

		function arg_349_1.playNext_(arg_351_0)
			if arg_351_0 == 1 then
				arg_349_0:Play935011087(arg_349_1)
			end
		end

		function arg_349_1.onSingleLineUpdate_(arg_352_0)
			if 0 < arg_349_1.time_ and arg_349_1.time_ <= 0 + arg_352_0 then
				arg_349_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_352_0 = 0
			local var_352_1 = 0.725

			if 0 < arg_349_1.time_ and arg_349_1.time_ <= var_352_0 + arg_352_0 then
				arg_349_1.talkMaxDuration = 0
				arg_349_1.dialogCg_.alpha = 1

				arg_349_1.dialog_:SetActive(true)
				SetActive(arg_349_1.leftNameGo_, true)

				arg_349_1.leftNameTxt_.text = arg_349_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_349_1.leftNameTxt_.transform)

				arg_349_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_349_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_349_1:RecordName(arg_349_1.leftNameTxt_.text)
				SetActive(arg_349_1.iconTrs_.gameObject, false)
				arg_349_1.callingController_:SetSelectedState("normal")

				local var_352_2 = arg_349_1:FormatText(arg_349_1:GetWordFromCfg(935011086).content)

				arg_349_1.text_.text = var_352_2

				LuaForUtil.ClearLinePrefixSymbol(arg_349_1.text_)

				local var_352_4 = 29 <= 0 and var_352_1 or var_352_1 * (utf8.len(var_352_2) / 29)

				if (29 <= 0 and var_352_1 or var_352_1 * (utf8.len(var_352_2) / 29)) > 0 and var_352_1 < var_352_4 then
					arg_349_1.talkMaxDuration = var_352_4

					if var_352_4 + var_352_0 > arg_349_1.duration_ then
						arg_349_1.duration_ = var_352_4 + var_352_0
					end
				end

				arg_349_1.text_.text = var_352_2
				arg_349_1.typewritter.percent = 0

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(false)
				arg_349_1:RecordContent(arg_349_1.text_.text)
			end

			local var_352_5 = math.max(var_352_1, arg_349_1.talkMaxDuration)

			if var_352_0 <= arg_349_1.time_ and arg_349_1.time_ < var_352_0 + var_352_5 then
				arg_349_1.typewritter.percent = (arg_349_1.time_ - var_352_0) / var_352_5

				arg_349_1.typewritter:SetDirty()
			end

			if arg_349_1.time_ >= var_352_0 + var_352_5 and arg_349_1.time_ < var_352_0 + var_352_5 + arg_352_0 then
				arg_349_1.typewritter.percent = 1

				arg_349_1.typewritter:SetDirty()
				arg_349_1:ShowNextGo(true)
			end
		end

		arg_349_1.nodeConfigList_ = {}

		arg_349_1:InitPlayNodeList()
	end,
	Play935011087 = function(arg_353_0, arg_353_1)
		arg_353_1.time_ = 0
		arg_353_1.frameCnt_ = 0
		arg_353_1.state_ = "playing"
		arg_353_1.curTalkId_ = 935011087
		arg_353_1.duration_ = 5

		SetActive(arg_353_1.tipsGo_, false)

		function arg_353_1.onSingleLineFinish_()
			arg_353_1.onSingleLineUpdate_ = nil
			arg_353_1.onSingleLineFinish_ = nil
			arg_353_1.state_ = "waiting"
		end

		function arg_353_1.playNext_(arg_355_0)
			if arg_355_0 == 1 then
				arg_353_0:Play935011088(arg_353_1)
			end
		end

		function arg_353_1.onSingleLineUpdate_(arg_356_0)
			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= 0 + arg_356_0 then
				arg_353_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action6_2")
			end

			local var_356_0 = 0
			local var_356_1 = 0.825

			if 0 < arg_353_1.time_ and arg_353_1.time_ <= var_356_0 + arg_356_0 then
				arg_353_1.talkMaxDuration = 0
				arg_353_1.dialogCg_.alpha = 1

				arg_353_1.dialog_:SetActive(true)
				SetActive(arg_353_1.leftNameGo_, true)

				arg_353_1.leftNameTxt_.text = arg_353_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_353_1.leftNameTxt_.transform)

				arg_353_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_353_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_353_1:RecordName(arg_353_1.leftNameTxt_.text)
				SetActive(arg_353_1.iconTrs_.gameObject, false)
				arg_353_1.callingController_:SetSelectedState("normal")

				local var_356_2 = arg_353_1:FormatText(arg_353_1:GetWordFromCfg(935011087).content)

				arg_353_1.text_.text = var_356_2

				LuaForUtil.ClearLinePrefixSymbol(arg_353_1.text_)

				local var_356_4 = 33 <= 0 and var_356_1 or var_356_1 * (utf8.len(var_356_2) / 33)

				if (33 <= 0 and var_356_1 or var_356_1 * (utf8.len(var_356_2) / 33)) > 0 and var_356_1 < var_356_4 then
					arg_353_1.talkMaxDuration = var_356_4

					if var_356_4 + var_356_0 > arg_353_1.duration_ then
						arg_353_1.duration_ = var_356_4 + var_356_0
					end
				end

				arg_353_1.text_.text = var_356_2
				arg_353_1.typewritter.percent = 0

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(false)
				arg_353_1:RecordContent(arg_353_1.text_.text)
			end

			local var_356_5 = math.max(var_356_1, arg_353_1.talkMaxDuration)

			if var_356_0 <= arg_353_1.time_ and arg_353_1.time_ < var_356_0 + var_356_5 then
				arg_353_1.typewritter.percent = (arg_353_1.time_ - var_356_0) / var_356_5

				arg_353_1.typewritter:SetDirty()
			end

			if arg_353_1.time_ >= var_356_0 + var_356_5 and arg_353_1.time_ < var_356_0 + var_356_5 + arg_356_0 then
				arg_353_1.typewritter.percent = 1

				arg_353_1.typewritter:SetDirty()
				arg_353_1:ShowNextGo(true)
			end
		end

		arg_353_1.nodeConfigList_ = {}

		arg_353_1:InitPlayNodeList()
	end,
	Play935011088 = function(arg_357_0, arg_357_1)
		arg_357_1.time_ = 0
		arg_357_1.frameCnt_ = 0
		arg_357_1.state_ = "playing"
		arg_357_1.curTalkId_ = 935011088
		arg_357_1.duration_ = 5

		SetActive(arg_357_1.tipsGo_, false)

		function arg_357_1.onSingleLineFinish_()
			arg_357_1.onSingleLineUpdate_ = nil
			arg_357_1.onSingleLineFinish_ = nil
			arg_357_1.state_ = "waiting"
		end

		function arg_357_1.playNext_(arg_359_0)
			if arg_359_0 == 1 then
				arg_357_0:Play935011089(arg_357_1)
			end
		end

		function arg_357_1.onSingleLineUpdate_(arg_360_0)
			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(arg_357_1.actors_["1070ui_story"]) and arg_357_1.var_.characterEffect1070ui_story == nil then
				arg_357_1.var_.characterEffect1070ui_story = arg_357_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_0 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_0 and not isNil(arg_357_1.actors_["1070ui_story"]) then
				if arg_357_1.var_.characterEffect1070ui_story and not isNil(arg_357_1.actors_["1070ui_story"]) then
					arg_357_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_357_1.time_ >= 0 + var_360_0 and arg_357_1.time_ < 0 + var_360_0 + arg_360_0 and not isNil(arg_357_1.actors_["1070ui_story"]) and arg_357_1.var_.characterEffect1070ui_story then
				arg_357_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_360_2 = arg_357_1.actors_["10039ui_story"]

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect10039ui_story == nil then
				arg_357_1.var_.characterEffect10039ui_story = var_360_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_360_3 = 0.200000002980232

			if 0 <= arg_357_1.time_ and arg_357_1.time_ < 0 + var_360_3 and not isNil(var_360_2) then
				if arg_357_1.var_.characterEffect10039ui_story and not isNil(var_360_2) then
					arg_357_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_357_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_357_1.time_ - 0) / var_360_3)
				end
			end

			if arg_357_1.time_ >= 0 + var_360_3 and arg_357_1.time_ < 0 + var_360_3 + arg_360_0 and not isNil(var_360_2) and arg_357_1.var_.characterEffect10039ui_story then
				arg_357_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_357_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= 0 + arg_360_0 then
				arg_357_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action3_1")
			end

			local var_360_4 = 0
			local var_360_5 = 0.075

			if 0 < arg_357_1.time_ and arg_357_1.time_ <= var_360_4 + arg_360_0 then
				arg_357_1.talkMaxDuration = 0
				arg_357_1.dialogCg_.alpha = 1

				arg_357_1.dialog_:SetActive(true)
				SetActive(arg_357_1.leftNameGo_, true)

				arg_357_1.leftNameTxt_.text = arg_357_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_357_1.leftNameTxt_.transform)

				arg_357_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_357_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_357_1:RecordName(arg_357_1.leftNameTxt_.text)
				SetActive(arg_357_1.iconTrs_.gameObject, false)
				arg_357_1.callingController_:SetSelectedState("normal")

				local var_360_6 = arg_357_1:FormatText(arg_357_1:GetWordFromCfg(935011088).content)

				arg_357_1.text_.text = var_360_6

				LuaForUtil.ClearLinePrefixSymbol(arg_357_1.text_)

				local var_360_8 = 3 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_6) / 3)

				if (3 <= 0 and var_360_5 or var_360_5 * (utf8.len(var_360_6) / 3)) > 0 and var_360_5 < var_360_8 then
					arg_357_1.talkMaxDuration = var_360_8

					if var_360_8 + var_360_4 > arg_357_1.duration_ then
						arg_357_1.duration_ = var_360_8 + var_360_4
					end
				end

				arg_357_1.text_.text = var_360_6
				arg_357_1.typewritter.percent = 0

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(false)
				arg_357_1:RecordContent(arg_357_1.text_.text)
			end

			local var_360_9 = math.max(var_360_5, arg_357_1.talkMaxDuration)

			if var_360_4 <= arg_357_1.time_ and arg_357_1.time_ < var_360_4 + var_360_9 then
				arg_357_1.typewritter.percent = (arg_357_1.time_ - var_360_4) / var_360_9

				arg_357_1.typewritter:SetDirty()
			end

			if arg_357_1.time_ >= var_360_4 + var_360_9 and arg_357_1.time_ < var_360_4 + var_360_9 + arg_360_0 then
				arg_357_1.typewritter.percent = 1

				arg_357_1.typewritter:SetDirty()
				arg_357_1:ShowNextGo(true)
			end
		end

		arg_357_1.nodeConfigList_ = {}

		arg_357_1:InitPlayNodeList()
	end,
	Play935011089 = function(arg_361_0, arg_361_1)
		arg_361_1.time_ = 0
		arg_361_1.frameCnt_ = 0
		arg_361_1.state_ = "playing"
		arg_361_1.curTalkId_ = 935011089
		arg_361_1.duration_ = 5

		SetActive(arg_361_1.tipsGo_, false)

		function arg_361_1.onSingleLineFinish_()
			arg_361_1.onSingleLineUpdate_ = nil
			arg_361_1.onSingleLineFinish_ = nil
			arg_361_1.state_ = "waiting"
		end

		function arg_361_1.playNext_(arg_363_0)
			if arg_363_0 == 1 then
				arg_361_0:Play935011090(arg_361_1)
			end
		end

		function arg_361_1.onSingleLineUpdate_(arg_364_0)
			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 and not isNil(arg_361_1.actors_["1070ui_story"]) and arg_361_1.var_.characterEffect1070ui_story == nil then
				arg_361_1.var_.characterEffect1070ui_story = arg_361_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_364_0 = 0.200000002980232

			if 0 <= arg_361_1.time_ and arg_361_1.time_ < 0 + var_364_0 and not isNil(arg_361_1.actors_["1070ui_story"]) then
				if arg_361_1.var_.characterEffect1070ui_story and not isNil(arg_361_1.actors_["1070ui_story"]) then
					arg_361_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_361_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_361_1.time_ - 0) / var_364_0)
				end
			end

			if arg_361_1.time_ >= 0 + var_364_0 and arg_361_1.time_ < 0 + var_364_0 + arg_364_0 and not isNil(arg_361_1.actors_["1070ui_story"]) and arg_361_1.var_.characterEffect1070ui_story then
				arg_361_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_361_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= 0 + arg_364_0 then
				arg_361_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action435")
			end

			local var_364_1 = 0
			local var_364_2 = 0.8

			if 0 < arg_361_1.time_ and arg_361_1.time_ <= var_364_1 + arg_364_0 then
				arg_361_1.talkMaxDuration = 0
				arg_361_1.dialogCg_.alpha = 1

				arg_361_1.dialog_:SetActive(true)
				SetActive(arg_361_1.leftNameGo_, false)

				arg_361_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_361_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_361_1:RecordName(arg_361_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_361_1.iconTrs_.gameObject, false)
				arg_361_1.callingController_:SetSelectedState("normal")

				local var_364_3 = arg_361_1:FormatText(arg_361_1:GetWordFromCfg(935011089).content)

				arg_361_1.text_.text = var_364_3

				LuaForUtil.ClearLinePrefixSymbol(arg_361_1.text_)

				local var_364_5 = 32 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 32)

				if (32 <= 0 and var_364_2 or var_364_2 * (utf8.len(var_364_3) / 32)) > 0 and var_364_2 < var_364_5 then
					arg_361_1.talkMaxDuration = var_364_5

					if var_364_5 + var_364_1 > arg_361_1.duration_ then
						arg_361_1.duration_ = var_364_5 + var_364_1
					end
				end

				arg_361_1.text_.text = var_364_3
				arg_361_1.typewritter.percent = 0

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(false)
				arg_361_1:RecordContent(arg_361_1.text_.text)
			end

			local var_364_6 = math.max(var_364_2, arg_361_1.talkMaxDuration)

			if var_364_1 <= arg_361_1.time_ and arg_361_1.time_ < var_364_1 + var_364_6 then
				arg_361_1.typewritter.percent = (arg_361_1.time_ - var_364_1) / var_364_6

				arg_361_1.typewritter:SetDirty()
			end

			if arg_361_1.time_ >= var_364_1 + var_364_6 and arg_361_1.time_ < var_364_1 + var_364_6 + arg_364_0 then
				arg_361_1.typewritter.percent = 1

				arg_361_1.typewritter:SetDirty()
				arg_361_1:ShowNextGo(true)
			end
		end

		arg_361_1.nodeConfigList_ = {}

		arg_361_1:InitPlayNodeList()
	end,
	Play935011090 = function(arg_365_0, arg_365_1)
		arg_365_1.time_ = 0
		arg_365_1.frameCnt_ = 0
		arg_365_1.state_ = "playing"
		arg_365_1.curTalkId_ = 935011090
		arg_365_1.duration_ = 5

		SetActive(arg_365_1.tipsGo_, false)

		function arg_365_1.onSingleLineFinish_()
			arg_365_1.onSingleLineUpdate_ = nil
			arg_365_1.onSingleLineFinish_ = nil
			arg_365_1.state_ = "waiting"
		end

		function arg_365_1.playNext_(arg_367_0)
			if arg_367_0 == 1 then
				arg_365_0:Play935011091(arg_365_1)
			end
		end

		function arg_365_1.onSingleLineUpdate_(arg_368_0)
			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 and not isNil(arg_365_1.actors_["1070ui_story"]) and arg_365_1.var_.characterEffect1070ui_story == nil then
				arg_365_1.var_.characterEffect1070ui_story = arg_365_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_368_0 = 0.200000002980232

			if 0 <= arg_365_1.time_ and arg_365_1.time_ < 0 + var_368_0 and not isNil(arg_365_1.actors_["1070ui_story"]) then
				if arg_365_1.var_.characterEffect1070ui_story and not isNil(arg_365_1.actors_["1070ui_story"]) then
					arg_365_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_365_1.time_ >= 0 + var_368_0 and arg_365_1.time_ < 0 + var_368_0 + arg_368_0 and not isNil(arg_365_1.actors_["1070ui_story"]) and arg_365_1.var_.characterEffect1070ui_story then
				arg_365_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= 0 + arg_368_0 then
				arg_365_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_368_2 = 0
			local var_368_3 = 0.825

			if 0 < arg_365_1.time_ and arg_365_1.time_ <= var_368_2 + arg_368_0 then
				arg_365_1.talkMaxDuration = 0
				arg_365_1.dialogCg_.alpha = 1

				arg_365_1.dialog_:SetActive(true)
				SetActive(arg_365_1.leftNameGo_, true)

				arg_365_1.leftNameTxt_.text = arg_365_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_365_1.leftNameTxt_.transform)

				arg_365_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_365_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_365_1:RecordName(arg_365_1.leftNameTxt_.text)
				SetActive(arg_365_1.iconTrs_.gameObject, false)
				arg_365_1.callingController_:SetSelectedState("normal")

				local var_368_4 = arg_365_1:FormatText(arg_365_1:GetWordFromCfg(935011090).content)

				arg_365_1.text_.text = var_368_4

				LuaForUtil.ClearLinePrefixSymbol(arg_365_1.text_)

				local var_368_6 = 33 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_4) / 33)

				if (33 <= 0 and var_368_3 or var_368_3 * (utf8.len(var_368_4) / 33)) > 0 and var_368_3 < var_368_6 then
					arg_365_1.talkMaxDuration = var_368_6

					if var_368_6 + var_368_2 > arg_365_1.duration_ then
						arg_365_1.duration_ = var_368_6 + var_368_2
					end
				end

				arg_365_1.text_.text = var_368_4
				arg_365_1.typewritter.percent = 0

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(false)
				arg_365_1:RecordContent(arg_365_1.text_.text)
			end

			local var_368_7 = math.max(var_368_3, arg_365_1.talkMaxDuration)

			if var_368_2 <= arg_365_1.time_ and arg_365_1.time_ < var_368_2 + var_368_7 then
				arg_365_1.typewritter.percent = (arg_365_1.time_ - var_368_2) / var_368_7

				arg_365_1.typewritter:SetDirty()
			end

			if arg_365_1.time_ >= var_368_2 + var_368_7 and arg_365_1.time_ < var_368_2 + var_368_7 + arg_368_0 then
				arg_365_1.typewritter.percent = 1

				arg_365_1.typewritter:SetDirty()
				arg_365_1:ShowNextGo(true)
			end
		end

		arg_365_1.nodeConfigList_ = {}

		arg_365_1:InitPlayNodeList()
	end,
	Play935011091 = function(arg_369_0, arg_369_1)
		arg_369_1.time_ = 0
		arg_369_1.frameCnt_ = 0
		arg_369_1.state_ = "playing"
		arg_369_1.curTalkId_ = 935011091
		arg_369_1.duration_ = 5

		SetActive(arg_369_1.tipsGo_, false)

		function arg_369_1.onSingleLineFinish_()
			arg_369_1.onSingleLineUpdate_ = nil
			arg_369_1.onSingleLineFinish_ = nil
			arg_369_1.state_ = "waiting"
		end

		function arg_369_1.playNext_(arg_371_0)
			if arg_371_0 == 1 then
				arg_369_0:Play935011092(arg_369_1)
			end
		end

		function arg_369_1.onSingleLineUpdate_(arg_372_0)
			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(arg_369_1.actors_["10039ui_story"]) and arg_369_1.var_.characterEffect10039ui_story == nil then
				arg_369_1.var_.characterEffect10039ui_story = arg_369_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_0 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_0 and not isNil(arg_369_1.actors_["10039ui_story"]) then
				if arg_369_1.var_.characterEffect10039ui_story and not isNil(arg_369_1.actors_["10039ui_story"]) then
					arg_369_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_369_1.time_ >= 0 + var_372_0 and arg_369_1.time_ < 0 + var_372_0 + arg_372_0 and not isNil(arg_369_1.actors_["10039ui_story"]) and arg_369_1.var_.characterEffect10039ui_story then
				arg_369_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_372_2 = arg_369_1.actors_["1070ui_story"]

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.characterEffect1070ui_story == nil then
				arg_369_1.var_.characterEffect1070ui_story = var_372_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_372_3 = 0.200000002980232

			if 0 <= arg_369_1.time_ and arg_369_1.time_ < 0 + var_372_3 and not isNil(var_372_2) then
				if arg_369_1.var_.characterEffect1070ui_story and not isNil(var_372_2) then
					arg_369_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_369_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_369_1.time_ - 0) / var_372_3)
				end
			end

			if arg_369_1.time_ >= 0 + var_372_3 and arg_369_1.time_ < 0 + var_372_3 + arg_372_0 and not isNil(var_372_2) and arg_369_1.var_.characterEffect1070ui_story then
				arg_369_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_369_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= 0 + arg_372_0 then
				arg_369_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039action/10039action5_1")
			end

			local var_372_4 = 0
			local var_372_5 = 0.25

			if 0 < arg_369_1.time_ and arg_369_1.time_ <= var_372_4 + arg_372_0 then
				arg_369_1.talkMaxDuration = 0
				arg_369_1.dialogCg_.alpha = 1

				arg_369_1.dialog_:SetActive(true)
				SetActive(arg_369_1.leftNameGo_, true)

				arg_369_1.leftNameTxt_.text = arg_369_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_369_1.leftNameTxt_.transform)

				arg_369_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_369_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_369_1:RecordName(arg_369_1.leftNameTxt_.text)
				SetActive(arg_369_1.iconTrs_.gameObject, false)
				arg_369_1.callingController_:SetSelectedState("normal")

				local var_372_6 = arg_369_1:FormatText(arg_369_1:GetWordFromCfg(935011091).content)

				arg_369_1.text_.text = var_372_6

				LuaForUtil.ClearLinePrefixSymbol(arg_369_1.text_)

				local var_372_8 = 10 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_6) / 10)

				if (10 <= 0 and var_372_5 or var_372_5 * (utf8.len(var_372_6) / 10)) > 0 and var_372_5 < var_372_8 then
					arg_369_1.talkMaxDuration = var_372_8

					if var_372_8 + var_372_4 > arg_369_1.duration_ then
						arg_369_1.duration_ = var_372_8 + var_372_4
					end
				end

				arg_369_1.text_.text = var_372_6
				arg_369_1.typewritter.percent = 0

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(false)
				arg_369_1:RecordContent(arg_369_1.text_.text)
			end

			local var_372_9 = math.max(var_372_5, arg_369_1.talkMaxDuration)

			if var_372_4 <= arg_369_1.time_ and arg_369_1.time_ < var_372_4 + var_372_9 then
				arg_369_1.typewritter.percent = (arg_369_1.time_ - var_372_4) / var_372_9

				arg_369_1.typewritter:SetDirty()
			end

			if arg_369_1.time_ >= var_372_4 + var_372_9 and arg_369_1.time_ < var_372_4 + var_372_9 + arg_372_0 then
				arg_369_1.typewritter.percent = 1

				arg_369_1.typewritter:SetDirty()
				arg_369_1:ShowNextGo(true)
			end
		end

		arg_369_1.nodeConfigList_ = {}

		arg_369_1:InitPlayNodeList()
	end,
	Play935011092 = function(arg_373_0, arg_373_1)
		arg_373_1.time_ = 0
		arg_373_1.frameCnt_ = 0
		arg_373_1.state_ = "playing"
		arg_373_1.curTalkId_ = 935011092
		arg_373_1.duration_ = 5

		SetActive(arg_373_1.tipsGo_, false)

		function arg_373_1.onSingleLineFinish_()
			arg_373_1.onSingleLineUpdate_ = nil
			arg_373_1.onSingleLineFinish_ = nil
			arg_373_1.state_ = "waiting"
		end

		function arg_373_1.playNext_(arg_375_0)
			if arg_375_0 == 1 then
				arg_373_0:Play935011093(arg_373_1)
			end
		end

		function arg_373_1.onSingleLineUpdate_(arg_376_0)
			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(arg_373_1.actors_["1070ui_story"]) and arg_373_1.var_.characterEffect1070ui_story == nil then
				arg_373_1.var_.characterEffect1070ui_story = arg_373_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_0 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_0 and not isNil(arg_373_1.actors_["1070ui_story"]) then
				if arg_373_1.var_.characterEffect1070ui_story and not isNil(arg_373_1.actors_["1070ui_story"]) then
					arg_373_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_373_1.time_ >= 0 + var_376_0 and arg_373_1.time_ < 0 + var_376_0 + arg_376_0 and not isNil(arg_373_1.actors_["1070ui_story"]) and arg_373_1.var_.characterEffect1070ui_story then
				arg_373_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_376_2 = arg_373_1.actors_["10039ui_story"]

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.characterEffect10039ui_story == nil then
				arg_373_1.var_.characterEffect10039ui_story = var_376_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_376_3 = 0.200000002980232

			if 0 <= arg_373_1.time_ and arg_373_1.time_ < 0 + var_376_3 and not isNil(var_376_2) then
				if arg_373_1.var_.characterEffect10039ui_story and not isNil(var_376_2) then
					arg_373_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_373_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_373_1.time_ - 0) / var_376_3)
				end
			end

			if arg_373_1.time_ >= 0 + var_376_3 and arg_373_1.time_ < 0 + var_376_3 + arg_376_0 and not isNil(var_376_2) and arg_373_1.var_.characterEffect10039ui_story then
				arg_373_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_373_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action457")
			end

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= 0 + arg_376_0 then
				arg_373_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva", "EmotionTimelineAnimator")
			end

			local var_376_4 = 0
			local var_376_5 = 0.525

			if 0 < arg_373_1.time_ and arg_373_1.time_ <= var_376_4 + arg_376_0 then
				arg_373_1.talkMaxDuration = 0
				arg_373_1.dialogCg_.alpha = 1

				arg_373_1.dialog_:SetActive(true)
				SetActive(arg_373_1.leftNameGo_, true)

				arg_373_1.leftNameTxt_.text = arg_373_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_373_1.leftNameTxt_.transform)

				arg_373_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_373_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_373_1:RecordName(arg_373_1.leftNameTxt_.text)
				SetActive(arg_373_1.iconTrs_.gameObject, false)
				arg_373_1.callingController_:SetSelectedState("normal")

				local var_376_6 = arg_373_1:FormatText(arg_373_1:GetWordFromCfg(935011092).content)

				arg_373_1.text_.text = var_376_6

				LuaForUtil.ClearLinePrefixSymbol(arg_373_1.text_)

				local var_376_8 = 21 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_6) / 21)

				if (21 <= 0 and var_376_5 or var_376_5 * (utf8.len(var_376_6) / 21)) > 0 and var_376_5 < var_376_8 then
					arg_373_1.talkMaxDuration = var_376_8

					if var_376_8 + var_376_4 > arg_373_1.duration_ then
						arg_373_1.duration_ = var_376_8 + var_376_4
					end
				end

				arg_373_1.text_.text = var_376_6
				arg_373_1.typewritter.percent = 0

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(false)
				arg_373_1:RecordContent(arg_373_1.text_.text)
			end

			local var_376_9 = math.max(var_376_5, arg_373_1.talkMaxDuration)

			if var_376_4 <= arg_373_1.time_ and arg_373_1.time_ < var_376_4 + var_376_9 then
				arg_373_1.typewritter.percent = (arg_373_1.time_ - var_376_4) / var_376_9

				arg_373_1.typewritter:SetDirty()
			end

			if arg_373_1.time_ >= var_376_4 + var_376_9 and arg_373_1.time_ < var_376_4 + var_376_9 + arg_376_0 then
				arg_373_1.typewritter.percent = 1

				arg_373_1.typewritter:SetDirty()
				arg_373_1:ShowNextGo(true)
			end
		end

		arg_373_1.nodeConfigList_ = {}

		arg_373_1:InitPlayNodeList()
	end,
	Play935011093 = function(arg_377_0, arg_377_1)
		arg_377_1.time_ = 0
		arg_377_1.frameCnt_ = 0
		arg_377_1.state_ = "playing"
		arg_377_1.curTalkId_ = 935011093
		arg_377_1.duration_ = 5

		SetActive(arg_377_1.tipsGo_, false)

		function arg_377_1.onSingleLineFinish_()
			arg_377_1.onSingleLineUpdate_ = nil
			arg_377_1.onSingleLineFinish_ = nil
			arg_377_1.state_ = "waiting"
		end

		function arg_377_1.playNext_(arg_379_0)
			if arg_379_0 == 1 then
				arg_377_0:Play935011094(arg_377_1)
			end
		end

		function arg_377_1.onSingleLineUpdate_(arg_380_0)
			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(arg_377_1.actors_["10039ui_story"]) and arg_377_1.var_.characterEffect10039ui_story == nil then
				arg_377_1.var_.characterEffect10039ui_story = arg_377_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_0 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_0 and not isNil(arg_377_1.actors_["10039ui_story"]) then
				if arg_377_1.var_.characterEffect10039ui_story and not isNil(arg_377_1.actors_["10039ui_story"]) then
					arg_377_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_377_1.time_ >= 0 + var_380_0 and arg_377_1.time_ < 0 + var_380_0 + arg_380_0 and not isNil(arg_377_1.actors_["10039ui_story"]) and arg_377_1.var_.characterEffect10039ui_story then
				arg_377_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_380_2 = arg_377_1.actors_["1070ui_story"]

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.characterEffect1070ui_story == nil then
				arg_377_1.var_.characterEffect1070ui_story = var_380_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_380_3 = 0.200000002980232

			if 0 <= arg_377_1.time_ and arg_377_1.time_ < 0 + var_380_3 and not isNil(var_380_2) then
				if arg_377_1.var_.characterEffect1070ui_story and not isNil(var_380_2) then
					arg_377_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_377_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_377_1.time_ - 0) / var_380_3)
				end
			end

			if arg_377_1.time_ >= 0 + var_380_3 and arg_377_1.time_ < 0 + var_380_3 + arg_380_0 and not isNil(var_380_2) and arg_377_1.var_.characterEffect1070ui_story then
				arg_377_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_377_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= 0 + arg_380_0 then
				arg_377_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva", "EmotionTimelineAnimator")
			end

			local var_380_4 = 0
			local var_380_5 = 0.075

			if 0 < arg_377_1.time_ and arg_377_1.time_ <= var_380_4 + arg_380_0 then
				arg_377_1.talkMaxDuration = 0
				arg_377_1.dialogCg_.alpha = 1

				arg_377_1.dialog_:SetActive(true)
				SetActive(arg_377_1.leftNameGo_, true)

				arg_377_1.leftNameTxt_.text = arg_377_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_377_1.leftNameTxt_.transform)

				arg_377_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_377_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_377_1:RecordName(arg_377_1.leftNameTxt_.text)
				SetActive(arg_377_1.iconTrs_.gameObject, false)
				arg_377_1.callingController_:SetSelectedState("normal")

				local var_380_6 = arg_377_1:FormatText(arg_377_1:GetWordFromCfg(935011093).content)

				arg_377_1.text_.text = var_380_6

				LuaForUtil.ClearLinePrefixSymbol(arg_377_1.text_)

				local var_380_8 = 3 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_6) / 3)

				if (3 <= 0 and var_380_5 or var_380_5 * (utf8.len(var_380_6) / 3)) > 0 and var_380_5 < var_380_8 then
					arg_377_1.talkMaxDuration = var_380_8

					if var_380_8 + var_380_4 > arg_377_1.duration_ then
						arg_377_1.duration_ = var_380_8 + var_380_4
					end
				end

				arg_377_1.text_.text = var_380_6
				arg_377_1.typewritter.percent = 0

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(false)
				arg_377_1:RecordContent(arg_377_1.text_.text)
			end

			local var_380_9 = math.max(var_380_5, arg_377_1.talkMaxDuration)

			if var_380_4 <= arg_377_1.time_ and arg_377_1.time_ < var_380_4 + var_380_9 then
				arg_377_1.typewritter.percent = (arg_377_1.time_ - var_380_4) / var_380_9

				arg_377_1.typewritter:SetDirty()
			end

			if arg_377_1.time_ >= var_380_4 + var_380_9 and arg_377_1.time_ < var_380_4 + var_380_9 + arg_380_0 then
				arg_377_1.typewritter.percent = 1

				arg_377_1.typewritter:SetDirty()
				arg_377_1:ShowNextGo(true)
			end
		end

		arg_377_1.nodeConfigList_ = {}

		arg_377_1:InitPlayNodeList()
	end,
	Play935011094 = function(arg_381_0, arg_381_1)
		arg_381_1.time_ = 0
		arg_381_1.frameCnt_ = 0
		arg_381_1.state_ = "playing"
		arg_381_1.curTalkId_ = 935011094
		arg_381_1.duration_ = 5

		SetActive(arg_381_1.tipsGo_, false)

		function arg_381_1.onSingleLineFinish_()
			arg_381_1.onSingleLineUpdate_ = nil
			arg_381_1.onSingleLineFinish_ = nil
			arg_381_1.state_ = "waiting"
		end

		function arg_381_1.playNext_(arg_383_0)
			if arg_383_0 == 1 then
				arg_381_0:Play935011095(arg_381_1)
			end
		end

		function arg_381_1.onSingleLineUpdate_(arg_384_0)
			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(arg_381_1.actors_["1070ui_story"]) and arg_381_1.var_.characterEffect1070ui_story == nil then
				arg_381_1.var_.characterEffect1070ui_story = arg_381_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_0 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_0 and not isNil(arg_381_1.actors_["1070ui_story"]) then
				if arg_381_1.var_.characterEffect1070ui_story and not isNil(arg_381_1.actors_["1070ui_story"]) then
					arg_381_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_381_1.time_ >= 0 + var_384_0 and arg_381_1.time_ < 0 + var_384_0 + arg_384_0 and not isNil(arg_381_1.actors_["1070ui_story"]) and arg_381_1.var_.characterEffect1070ui_story then
				arg_381_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_384_2 = arg_381_1.actors_["10039ui_story"]

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect10039ui_story == nil then
				arg_381_1.var_.characterEffect10039ui_story = var_384_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_384_3 = 0.200000002980232

			if 0 <= arg_381_1.time_ and arg_381_1.time_ < 0 + var_384_3 and not isNil(var_384_2) then
				if arg_381_1.var_.characterEffect10039ui_story and not isNil(var_384_2) then
					arg_381_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_381_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_381_1.time_ - 0) / var_384_3)
				end
			end

			if arg_381_1.time_ >= 0 + var_384_3 and arg_381_1.time_ < 0 + var_384_3 + arg_384_0 and not isNil(var_384_2) and arg_381_1.var_.characterEffect10039ui_story then
				arg_381_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_381_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= 0 + arg_384_0 then
				arg_381_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva", "EmotionTimelineAnimator")
			end

			local var_384_4 = 0
			local var_384_5 = 0.775

			if 0 < arg_381_1.time_ and arg_381_1.time_ <= var_384_4 + arg_384_0 then
				arg_381_1.talkMaxDuration = 0
				arg_381_1.dialogCg_.alpha = 1

				arg_381_1.dialog_:SetActive(true)
				SetActive(arg_381_1.leftNameGo_, true)

				arg_381_1.leftNameTxt_.text = arg_381_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_381_1.leftNameTxt_.transform)

				arg_381_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_381_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_381_1:RecordName(arg_381_1.leftNameTxt_.text)
				SetActive(arg_381_1.iconTrs_.gameObject, false)
				arg_381_1.callingController_:SetSelectedState("normal")

				local var_384_6 = arg_381_1:FormatText(arg_381_1:GetWordFromCfg(935011094).content)

				arg_381_1.text_.text = var_384_6

				LuaForUtil.ClearLinePrefixSymbol(arg_381_1.text_)

				local var_384_8 = 31 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_6) / 31)

				if (31 <= 0 and var_384_5 or var_384_5 * (utf8.len(var_384_6) / 31)) > 0 and var_384_5 < var_384_8 then
					arg_381_1.talkMaxDuration = var_384_8

					if var_384_8 + var_384_4 > arg_381_1.duration_ then
						arg_381_1.duration_ = var_384_8 + var_384_4
					end
				end

				arg_381_1.text_.text = var_384_6
				arg_381_1.typewritter.percent = 0

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(false)
				arg_381_1:RecordContent(arg_381_1.text_.text)
			end

			local var_384_9 = math.max(var_384_5, arg_381_1.talkMaxDuration)

			if var_384_4 <= arg_381_1.time_ and arg_381_1.time_ < var_384_4 + var_384_9 then
				arg_381_1.typewritter.percent = (arg_381_1.time_ - var_384_4) / var_384_9

				arg_381_1.typewritter:SetDirty()
			end

			if arg_381_1.time_ >= var_384_4 + var_384_9 and arg_381_1.time_ < var_384_4 + var_384_9 + arg_384_0 then
				arg_381_1.typewritter.percent = 1

				arg_381_1.typewritter:SetDirty()
				arg_381_1:ShowNextGo(true)
			end
		end

		arg_381_1.nodeConfigList_ = {}

		arg_381_1:InitPlayNodeList()
	end,
	Play935011095 = function(arg_385_0, arg_385_1)
		arg_385_1.time_ = 0
		arg_385_1.frameCnt_ = 0
		arg_385_1.state_ = "playing"
		arg_385_1.curTalkId_ = 935011095
		arg_385_1.duration_ = 5

		SetActive(arg_385_1.tipsGo_, false)

		function arg_385_1.onSingleLineFinish_()
			arg_385_1.onSingleLineUpdate_ = nil
			arg_385_1.onSingleLineFinish_ = nil
			arg_385_1.state_ = "waiting"
		end

		function arg_385_1.playNext_(arg_387_0)
			if arg_387_0 == 1 then
				arg_385_0:Play935011096(arg_385_1)
			end
		end

		function arg_385_1.onSingleLineUpdate_(arg_388_0)
			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(arg_385_1.actors_["10039ui_story"]) and arg_385_1.var_.characterEffect10039ui_story == nil then
				arg_385_1.var_.characterEffect10039ui_story = arg_385_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_0 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_0 and not isNil(arg_385_1.actors_["10039ui_story"]) then
				if arg_385_1.var_.characterEffect10039ui_story and not isNil(arg_385_1.actors_["10039ui_story"]) then
					arg_385_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_385_1.time_ >= 0 + var_388_0 and arg_385_1.time_ < 0 + var_388_0 + arg_388_0 and not isNil(arg_385_1.actors_["10039ui_story"]) and arg_385_1.var_.characterEffect10039ui_story then
				arg_385_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_388_2 = arg_385_1.actors_["1070ui_story"]

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.characterEffect1070ui_story == nil then
				arg_385_1.var_.characterEffect1070ui_story = var_388_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_388_3 = 0.200000002980232

			if 0 <= arg_385_1.time_ and arg_385_1.time_ < 0 + var_388_3 and not isNil(var_388_2) then
				if arg_385_1.var_.characterEffect1070ui_story and not isNil(var_388_2) then
					arg_385_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_385_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_385_1.time_ - 0) / var_388_3)
				end
			end

			if arg_385_1.time_ >= 0 + var_388_3 and arg_385_1.time_ < 0 + var_388_3 + arg_388_0 and not isNil(var_388_2) and arg_385_1.var_.characterEffect1070ui_story then
				arg_385_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_385_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action452")
			end

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= 0 + arg_388_0 then
				arg_385_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva", "EmotionTimelineAnimator")
			end

			local var_388_4 = 0
			local var_388_5 = 0.6

			if 0 < arg_385_1.time_ and arg_385_1.time_ <= var_388_4 + arg_388_0 then
				arg_385_1.talkMaxDuration = 0
				arg_385_1.dialogCg_.alpha = 1

				arg_385_1.dialog_:SetActive(true)
				SetActive(arg_385_1.leftNameGo_, true)

				arg_385_1.leftNameTxt_.text = arg_385_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_385_1.leftNameTxt_.transform)

				arg_385_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_385_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_385_1:RecordName(arg_385_1.leftNameTxt_.text)
				SetActive(arg_385_1.iconTrs_.gameObject, false)
				arg_385_1.callingController_:SetSelectedState("normal")

				local var_388_6 = arg_385_1:FormatText(arg_385_1:GetWordFromCfg(935011095).content)

				arg_385_1.text_.text = var_388_6

				LuaForUtil.ClearLinePrefixSymbol(arg_385_1.text_)

				local var_388_8 = 24 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_6) / 24)

				if (24 <= 0 and var_388_5 or var_388_5 * (utf8.len(var_388_6) / 24)) > 0 and var_388_5 < var_388_8 then
					arg_385_1.talkMaxDuration = var_388_8

					if var_388_8 + var_388_4 > arg_385_1.duration_ then
						arg_385_1.duration_ = var_388_8 + var_388_4
					end
				end

				arg_385_1.text_.text = var_388_6
				arg_385_1.typewritter.percent = 0

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(false)
				arg_385_1:RecordContent(arg_385_1.text_.text)
			end

			local var_388_9 = math.max(var_388_5, arg_385_1.talkMaxDuration)

			if var_388_4 <= arg_385_1.time_ and arg_385_1.time_ < var_388_4 + var_388_9 then
				arg_385_1.typewritter.percent = (arg_385_1.time_ - var_388_4) / var_388_9

				arg_385_1.typewritter:SetDirty()
			end

			if arg_385_1.time_ >= var_388_4 + var_388_9 and arg_385_1.time_ < var_388_4 + var_388_9 + arg_388_0 then
				arg_385_1.typewritter.percent = 1

				arg_385_1.typewritter:SetDirty()
				arg_385_1:ShowNextGo(true)
			end
		end

		arg_385_1.nodeConfigList_ = {}

		arg_385_1:InitPlayNodeList()
	end,
	Play935011096 = function(arg_389_0, arg_389_1)
		arg_389_1.time_ = 0
		arg_389_1.frameCnt_ = 0
		arg_389_1.state_ = "playing"
		arg_389_1.curTalkId_ = 935011096
		arg_389_1.duration_ = 5

		SetActive(arg_389_1.tipsGo_, false)

		function arg_389_1.onSingleLineFinish_()
			arg_389_1.onSingleLineUpdate_ = nil
			arg_389_1.onSingleLineFinish_ = nil
			arg_389_1.state_ = "waiting"
		end

		function arg_389_1.playNext_(arg_391_0)
			if arg_391_0 == 1 then
				arg_389_0:Play935011097(arg_389_1)
			end
		end

		function arg_389_1.onSingleLineUpdate_(arg_392_0)
			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(arg_389_1.actors_["1070ui_story"]) and arg_389_1.var_.characterEffect1070ui_story == nil then
				arg_389_1.var_.characterEffect1070ui_story = arg_389_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_0 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_0 and not isNil(arg_389_1.actors_["1070ui_story"]) then
				if arg_389_1.var_.characterEffect1070ui_story and not isNil(arg_389_1.actors_["1070ui_story"]) then
					arg_389_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_389_1.time_ >= 0 + var_392_0 and arg_389_1.time_ < 0 + var_392_0 + arg_392_0 and not isNil(arg_389_1.actors_["1070ui_story"]) and arg_389_1.var_.characterEffect1070ui_story then
				arg_389_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_392_2 = arg_389_1.actors_["10039ui_story"]

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.characterEffect10039ui_story == nil then
				arg_389_1.var_.characterEffect10039ui_story = var_392_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_392_3 = 0.200000002980232

			if 0 <= arg_389_1.time_ and arg_389_1.time_ < 0 + var_392_3 and not isNil(var_392_2) then
				if arg_389_1.var_.characterEffect10039ui_story and not isNil(var_392_2) then
					arg_389_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_389_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_389_1.time_ - 0) / var_392_3)
				end
			end

			if arg_389_1.time_ >= 0 + var_392_3 and arg_389_1.time_ < 0 + var_392_3 + arg_392_0 and not isNil(var_392_2) and arg_389_1.var_.characterEffect10039ui_story then
				arg_389_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_389_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action4_1")
			end

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= 0 + arg_392_0 then
				arg_389_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva", "EmotionTimelineAnimator")
			end

			local var_392_4 = 0
			local var_392_5 = 1.1

			if 0 < arg_389_1.time_ and arg_389_1.time_ <= var_392_4 + arg_392_0 then
				arg_389_1.talkMaxDuration = 0
				arg_389_1.dialogCg_.alpha = 1

				arg_389_1.dialog_:SetActive(true)
				SetActive(arg_389_1.leftNameGo_, true)

				arg_389_1.leftNameTxt_.text = arg_389_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_389_1.leftNameTxt_.transform)

				arg_389_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_389_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_389_1:RecordName(arg_389_1.leftNameTxt_.text)
				SetActive(arg_389_1.iconTrs_.gameObject, false)
				arg_389_1.callingController_:SetSelectedState("normal")

				local var_392_6 = arg_389_1:FormatText(arg_389_1:GetWordFromCfg(935011096).content)

				arg_389_1.text_.text = var_392_6

				LuaForUtil.ClearLinePrefixSymbol(arg_389_1.text_)

				local var_392_8 = 44 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_6) / 44)

				if (44 <= 0 and var_392_5 or var_392_5 * (utf8.len(var_392_6) / 44)) > 0 and var_392_5 < var_392_8 then
					arg_389_1.talkMaxDuration = var_392_8

					if var_392_8 + var_392_4 > arg_389_1.duration_ then
						arg_389_1.duration_ = var_392_8 + var_392_4
					end
				end

				arg_389_1.text_.text = var_392_6
				arg_389_1.typewritter.percent = 0

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(false)
				arg_389_1:RecordContent(arg_389_1.text_.text)
			end

			local var_392_9 = math.max(var_392_5, arg_389_1.talkMaxDuration)

			if var_392_4 <= arg_389_1.time_ and arg_389_1.time_ < var_392_4 + var_392_9 then
				arg_389_1.typewritter.percent = (arg_389_1.time_ - var_392_4) / var_392_9

				arg_389_1.typewritter:SetDirty()
			end

			if arg_389_1.time_ >= var_392_4 + var_392_9 and arg_389_1.time_ < var_392_4 + var_392_9 + arg_392_0 then
				arg_389_1.typewritter.percent = 1

				arg_389_1.typewritter:SetDirty()
				arg_389_1:ShowNextGo(true)
			end
		end

		arg_389_1.nodeConfigList_ = {}

		arg_389_1:InitPlayNodeList()
	end,
	Play935011097 = function(arg_393_0, arg_393_1)
		arg_393_1.time_ = 0
		arg_393_1.frameCnt_ = 0
		arg_393_1.state_ = "playing"
		arg_393_1.curTalkId_ = 935011097
		arg_393_1.duration_ = 5

		SetActive(arg_393_1.tipsGo_, false)

		function arg_393_1.onSingleLineFinish_()
			arg_393_1.onSingleLineUpdate_ = nil
			arg_393_1.onSingleLineFinish_ = nil
			arg_393_1.state_ = "waiting"
		end

		function arg_393_1.playNext_(arg_395_0)
			if arg_395_0 == 1 then
				arg_393_0:Play935011098(arg_393_1)
			end
		end

		function arg_393_1.onSingleLineUpdate_(arg_396_0)
			if 0 < arg_393_1.time_ and arg_393_1.time_ <= 0 + arg_396_0 and not isNil(arg_393_1.actors_["1070ui_story"]) and arg_393_1.var_.characterEffect1070ui_story == nil then
				arg_393_1.var_.characterEffect1070ui_story = arg_393_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_396_0 = 0.200000002980232

			if 0 <= arg_393_1.time_ and arg_393_1.time_ < 0 + var_396_0 and not isNil(arg_393_1.actors_["1070ui_story"]) then
				if arg_393_1.var_.characterEffect1070ui_story and not isNil(arg_393_1.actors_["1070ui_story"]) then
					arg_393_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_393_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_393_1.time_ - 0) / var_396_0)
				end
			end

			if arg_393_1.time_ >= 0 + var_396_0 and arg_393_1.time_ < 0 + var_396_0 + arg_396_0 and not isNil(arg_393_1.actors_["1070ui_story"]) and arg_393_1.var_.characterEffect1070ui_story then
				arg_393_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_393_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_396_1 = 0
			local var_396_2 = 0.825

			if 0 < arg_393_1.time_ and arg_393_1.time_ <= var_396_1 + arg_396_0 then
				arg_393_1.talkMaxDuration = 0
				arg_393_1.dialogCg_.alpha = 1

				arg_393_1.dialog_:SetActive(true)
				SetActive(arg_393_1.leftNameGo_, false)

				arg_393_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_393_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_393_1:RecordName(arg_393_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_393_1.iconTrs_.gameObject, false)
				arg_393_1.callingController_:SetSelectedState("normal")

				local var_396_3 = arg_393_1:FormatText(arg_393_1:GetWordFromCfg(935011097).content)

				arg_393_1.text_.text = var_396_3

				LuaForUtil.ClearLinePrefixSymbol(arg_393_1.text_)

				local var_396_5 = 33 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 33)

				if (33 <= 0 and var_396_2 or var_396_2 * (utf8.len(var_396_3) / 33)) > 0 and var_396_2 < var_396_5 then
					arg_393_1.talkMaxDuration = var_396_5

					if var_396_5 + var_396_1 > arg_393_1.duration_ then
						arg_393_1.duration_ = var_396_5 + var_396_1
					end
				end

				arg_393_1.text_.text = var_396_3
				arg_393_1.typewritter.percent = 0

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(false)
				arg_393_1:RecordContent(arg_393_1.text_.text)
			end

			local var_396_6 = math.max(var_396_2, arg_393_1.talkMaxDuration)

			if var_396_1 <= arg_393_1.time_ and arg_393_1.time_ < var_396_1 + var_396_6 then
				arg_393_1.typewritter.percent = (arg_393_1.time_ - var_396_1) / var_396_6

				arg_393_1.typewritter:SetDirty()
			end

			if arg_393_1.time_ >= var_396_1 + var_396_6 and arg_393_1.time_ < var_396_1 + var_396_6 + arg_396_0 then
				arg_393_1.typewritter.percent = 1

				arg_393_1.typewritter:SetDirty()
				arg_393_1:ShowNextGo(true)
			end
		end

		arg_393_1.nodeConfigList_ = {}

		arg_393_1:InitPlayNodeList()
	end,
	Play935011098 = function(arg_397_0, arg_397_1)
		arg_397_1.time_ = 0
		arg_397_1.frameCnt_ = 0
		arg_397_1.state_ = "playing"
		arg_397_1.curTalkId_ = 935011098
		arg_397_1.duration_ = 5

		SetActive(arg_397_1.tipsGo_, false)

		function arg_397_1.onSingleLineFinish_()
			arg_397_1.onSingleLineUpdate_ = nil
			arg_397_1.onSingleLineFinish_ = nil
			arg_397_1.state_ = "waiting"
		end

		function arg_397_1.playNext_(arg_399_0)
			if arg_399_0 == 1 then
				arg_397_0:Play935011099(arg_397_1)
			end
		end

		function arg_397_1.onSingleLineUpdate_(arg_400_0)
			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 and not isNil(arg_397_1.actors_["1070ui_story"]) and arg_397_1.var_.characterEffect1070ui_story == nil then
				arg_397_1.var_.characterEffect1070ui_story = arg_397_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_400_0 = 0.200000002980232

			if 0 <= arg_397_1.time_ and arg_397_1.time_ < 0 + var_400_0 and not isNil(arg_397_1.actors_["1070ui_story"]) then
				if arg_397_1.var_.characterEffect1070ui_story and not isNil(arg_397_1.actors_["1070ui_story"]) then
					arg_397_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_397_1.time_ >= 0 + var_400_0 and arg_397_1.time_ < 0 + var_400_0 + arg_400_0 and not isNil(arg_397_1.actors_["1070ui_story"]) and arg_397_1.var_.characterEffect1070ui_story then
				arg_397_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action446")
			end

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= 0 + arg_400_0 then
				arg_397_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva", "EmotionTimelineAnimator")
			end

			local var_400_2 = 0
			local var_400_3 = 0.65

			if 0 < arg_397_1.time_ and arg_397_1.time_ <= var_400_2 + arg_400_0 then
				arg_397_1.talkMaxDuration = 0
				arg_397_1.dialogCg_.alpha = 1

				arg_397_1.dialog_:SetActive(true)
				SetActive(arg_397_1.leftNameGo_, true)

				arg_397_1.leftNameTxt_.text = arg_397_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_397_1.leftNameTxt_.transform)

				arg_397_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_397_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_397_1:RecordName(arg_397_1.leftNameTxt_.text)
				SetActive(arg_397_1.iconTrs_.gameObject, false)
				arg_397_1.callingController_:SetSelectedState("normal")

				local var_400_4 = arg_397_1:FormatText(arg_397_1:GetWordFromCfg(935011098).content)

				arg_397_1.text_.text = var_400_4

				LuaForUtil.ClearLinePrefixSymbol(arg_397_1.text_)

				local var_400_6 = 26 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 26)

				if (26 <= 0 and var_400_3 or var_400_3 * (utf8.len(var_400_4) / 26)) > 0 and var_400_3 < var_400_6 then
					arg_397_1.talkMaxDuration = var_400_6

					if var_400_6 + var_400_2 > arg_397_1.duration_ then
						arg_397_1.duration_ = var_400_6 + var_400_2
					end
				end

				arg_397_1.text_.text = var_400_4
				arg_397_1.typewritter.percent = 0

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(false)
				arg_397_1:RecordContent(arg_397_1.text_.text)
			end

			local var_400_7 = math.max(var_400_3, arg_397_1.talkMaxDuration)

			if var_400_2 <= arg_397_1.time_ and arg_397_1.time_ < var_400_2 + var_400_7 then
				arg_397_1.typewritter.percent = (arg_397_1.time_ - var_400_2) / var_400_7

				arg_397_1.typewritter:SetDirty()
			end

			if arg_397_1.time_ >= var_400_2 + var_400_7 and arg_397_1.time_ < var_400_2 + var_400_7 + arg_400_0 then
				arg_397_1.typewritter.percent = 1

				arg_397_1.typewritter:SetDirty()
				arg_397_1:ShowNextGo(true)
			end
		end

		arg_397_1.nodeConfigList_ = {}

		arg_397_1:InitPlayNodeList()
	end,
	Play935011099 = function(arg_401_0, arg_401_1)
		arg_401_1.time_ = 0
		arg_401_1.frameCnt_ = 0
		arg_401_1.state_ = "playing"
		arg_401_1.curTalkId_ = 935011099
		arg_401_1.duration_ = 5

		SetActive(arg_401_1.tipsGo_, false)

		function arg_401_1.onSingleLineFinish_()
			arg_401_1.onSingleLineUpdate_ = nil
			arg_401_1.onSingleLineFinish_ = nil
			arg_401_1.state_ = "waiting"
		end

		function arg_401_1.playNext_(arg_403_0)
			if arg_403_0 == 1 then
				arg_401_0:Play935011100(arg_401_1)
			end
		end

		function arg_401_1.onSingleLineUpdate_(arg_404_0)
			if 0 < arg_401_1.time_ and arg_401_1.time_ <= 0 + arg_404_0 then
				arg_401_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva", "EmotionTimelineAnimator")
			end

			local var_404_0 = 0
			local var_404_1 = 0.9

			if 0 < arg_401_1.time_ and arg_401_1.time_ <= var_404_0 + arg_404_0 then
				arg_401_1.talkMaxDuration = 0
				arg_401_1.dialogCg_.alpha = 1

				arg_401_1.dialog_:SetActive(true)
				SetActive(arg_401_1.leftNameGo_, true)

				arg_401_1.leftNameTxt_.text = arg_401_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_401_1.leftNameTxt_.transform)

				arg_401_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_401_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_401_1:RecordName(arg_401_1.leftNameTxt_.text)
				SetActive(arg_401_1.iconTrs_.gameObject, false)
				arg_401_1.callingController_:SetSelectedState("normal")

				local var_404_2 = arg_401_1:FormatText(arg_401_1:GetWordFromCfg(935011099).content)

				arg_401_1.text_.text = var_404_2

				LuaForUtil.ClearLinePrefixSymbol(arg_401_1.text_)

				local var_404_4 = 36 <= 0 and var_404_1 or var_404_1 * (utf8.len(var_404_2) / 36)

				if (36 <= 0 and var_404_1 or var_404_1 * (utf8.len(var_404_2) / 36)) > 0 and var_404_1 < var_404_4 then
					arg_401_1.talkMaxDuration = var_404_4

					if var_404_4 + var_404_0 > arg_401_1.duration_ then
						arg_401_1.duration_ = var_404_4 + var_404_0
					end
				end

				arg_401_1.text_.text = var_404_2
				arg_401_1.typewritter.percent = 0

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(false)
				arg_401_1:RecordContent(arg_401_1.text_.text)
			end

			local var_404_5 = math.max(var_404_1, arg_401_1.talkMaxDuration)

			if var_404_0 <= arg_401_1.time_ and arg_401_1.time_ < var_404_0 + var_404_5 then
				arg_401_1.typewritter.percent = (arg_401_1.time_ - var_404_0) / var_404_5

				arg_401_1.typewritter:SetDirty()
			end

			if arg_401_1.time_ >= var_404_0 + var_404_5 and arg_401_1.time_ < var_404_0 + var_404_5 + arg_404_0 then
				arg_401_1.typewritter.percent = 1

				arg_401_1.typewritter:SetDirty()
				arg_401_1:ShowNextGo(true)
			end
		end

		arg_401_1.nodeConfigList_ = {}

		arg_401_1:InitPlayNodeList()
	end,
	Play935011100 = function(arg_405_0, arg_405_1)
		arg_405_1.time_ = 0
		arg_405_1.frameCnt_ = 0
		arg_405_1.state_ = "playing"
		arg_405_1.curTalkId_ = 935011100
		arg_405_1.duration_ = 5

		SetActive(arg_405_1.tipsGo_, false)

		function arg_405_1.onSingleLineFinish_()
			arg_405_1.onSingleLineUpdate_ = nil
			arg_405_1.onSingleLineFinish_ = nil
			arg_405_1.state_ = "waiting"
		end

		function arg_405_1.playNext_(arg_407_0)
			if arg_407_0 == 1 then
				arg_405_0:Play935011101(arg_405_1)
			end
		end

		function arg_405_1.onSingleLineUpdate_(arg_408_0)
			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070actionlink/1070action467")
			end

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= 0 + arg_408_0 then
				arg_405_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1301cva", "EmotionTimelineAnimator")
			end

			local var_408_0 = 0
			local var_408_1 = 0.375

			if 0 < arg_405_1.time_ and arg_405_1.time_ <= var_408_0 + arg_408_0 then
				arg_405_1.talkMaxDuration = 0
				arg_405_1.dialogCg_.alpha = 1

				arg_405_1.dialog_:SetActive(true)
				SetActive(arg_405_1.leftNameGo_, true)

				arg_405_1.leftNameTxt_.text = arg_405_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_405_1.leftNameTxt_.transform)

				arg_405_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_405_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_405_1:RecordName(arg_405_1.leftNameTxt_.text)
				SetActive(arg_405_1.iconTrs_.gameObject, false)
				arg_405_1.callingController_:SetSelectedState("normal")

				local var_408_2 = arg_405_1:FormatText(arg_405_1:GetWordFromCfg(935011100).content)

				arg_405_1.text_.text = var_408_2

				LuaForUtil.ClearLinePrefixSymbol(arg_405_1.text_)

				local var_408_4 = 15 <= 0 and var_408_1 or var_408_1 * (utf8.len(var_408_2) / 15)

				if (15 <= 0 and var_408_1 or var_408_1 * (utf8.len(var_408_2) / 15)) > 0 and var_408_1 < var_408_4 then
					arg_405_1.talkMaxDuration = var_408_4

					if var_408_4 + var_408_0 > arg_405_1.duration_ then
						arg_405_1.duration_ = var_408_4 + var_408_0
					end
				end

				arg_405_1.text_.text = var_408_2
				arg_405_1.typewritter.percent = 0

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(false)
				arg_405_1:RecordContent(arg_405_1.text_.text)
			end

			local var_408_5 = math.max(var_408_1, arg_405_1.talkMaxDuration)

			if var_408_0 <= arg_405_1.time_ and arg_405_1.time_ < var_408_0 + var_408_5 then
				arg_405_1.typewritter.percent = (arg_405_1.time_ - var_408_0) / var_408_5

				arg_405_1.typewritter:SetDirty()
			end

			if arg_405_1.time_ >= var_408_0 + var_408_5 and arg_405_1.time_ < var_408_0 + var_408_5 + arg_408_0 then
				arg_405_1.typewritter.percent = 1

				arg_405_1.typewritter:SetDirty()
				arg_405_1:ShowNextGo(true)
			end
		end

		arg_405_1.nodeConfigList_ = {}

		arg_405_1:InitPlayNodeList()
	end,
	Play935011101 = function(arg_409_0, arg_409_1)
		arg_409_1.time_ = 0
		arg_409_1.frameCnt_ = 0
		arg_409_1.state_ = "playing"
		arg_409_1.curTalkId_ = 935011101
		arg_409_1.duration_ = 5

		SetActive(arg_409_1.tipsGo_, false)

		function arg_409_1.onSingleLineFinish_()
			arg_409_1.onSingleLineUpdate_ = nil
			arg_409_1.onSingleLineFinish_ = nil
			arg_409_1.state_ = "waiting"
		end

		function arg_409_1.playNext_(arg_411_0)
			if arg_411_0 == 1 then
				arg_409_0:Play935011102(arg_409_1)
			end
		end

		function arg_409_1.onSingleLineUpdate_(arg_412_0)
			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(arg_409_1.actors_["10039ui_story"]) and arg_409_1.var_.characterEffect10039ui_story == nil then
				arg_409_1.var_.characterEffect10039ui_story = arg_409_1.actors_["10039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_0 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_0 and not isNil(arg_409_1.actors_["10039ui_story"]) then
				if arg_409_1.var_.characterEffect10039ui_story and not isNil(arg_409_1.actors_["10039ui_story"]) then
					arg_409_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_409_1.time_ >= 0 + var_412_0 and arg_409_1.time_ < 0 + var_412_0 + arg_412_0 and not isNil(arg_409_1.actors_["10039ui_story"]) and arg_409_1.var_.characterEffect10039ui_story then
				arg_409_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_412_2 = arg_409_1.actors_["1070ui_story"]

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1070ui_story == nil then
				arg_409_1.var_.characterEffect1070ui_story = var_412_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_412_3 = 0.200000002980232

			if 0 <= arg_409_1.time_ and arg_409_1.time_ < 0 + var_412_3 and not isNil(var_412_2) then
				if arg_409_1.var_.characterEffect1070ui_story and not isNil(var_412_2) then
					arg_409_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_409_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_409_1.time_ - 0) / var_412_3)
				end
			end

			if arg_409_1.time_ >= 0 + var_412_3 and arg_409_1.time_ < 0 + var_412_3 + arg_412_0 and not isNil(var_412_2) and arg_409_1.var_.characterEffect1070ui_story then
				arg_409_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_409_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= 0 + arg_412_0 then
				arg_409_1:PlayTimeline("10039ui_story", "StoryTimeline/CharAction/story10039/story10039actionlink/10039action426")
			end

			local var_412_4 = 0
			local var_412_5 = 0.65

			if 0 < arg_409_1.time_ and arg_409_1.time_ <= var_412_4 + arg_412_0 then
				arg_409_1.talkMaxDuration = 0
				arg_409_1.dialogCg_.alpha = 1

				arg_409_1.dialog_:SetActive(true)
				SetActive(arg_409_1.leftNameGo_, true)

				arg_409_1.leftNameTxt_.text = arg_409_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_409_1.leftNameTxt_.transform)

				arg_409_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_409_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_409_1:RecordName(arg_409_1.leftNameTxt_.text)
				SetActive(arg_409_1.iconTrs_.gameObject, false)
				arg_409_1.callingController_:SetSelectedState("normal")

				local var_412_6 = arg_409_1:FormatText(arg_409_1:GetWordFromCfg(935011101).content)

				arg_409_1.text_.text = var_412_6

				LuaForUtil.ClearLinePrefixSymbol(arg_409_1.text_)

				local var_412_8 = 26 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_6) / 26)

				if (26 <= 0 and var_412_5 or var_412_5 * (utf8.len(var_412_6) / 26)) > 0 and var_412_5 < var_412_8 then
					arg_409_1.talkMaxDuration = var_412_8

					if var_412_8 + var_412_4 > arg_409_1.duration_ then
						arg_409_1.duration_ = var_412_8 + var_412_4
					end
				end

				arg_409_1.text_.text = var_412_6
				arg_409_1.typewritter.percent = 0

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(false)
				arg_409_1:RecordContent(arg_409_1.text_.text)
			end

			local var_412_9 = math.max(var_412_5, arg_409_1.talkMaxDuration)

			if var_412_4 <= arg_409_1.time_ and arg_409_1.time_ < var_412_4 + var_412_9 then
				arg_409_1.typewritter.percent = (arg_409_1.time_ - var_412_4) / var_412_9

				arg_409_1.typewritter:SetDirty()
			end

			if arg_409_1.time_ >= var_412_4 + var_412_9 and arg_409_1.time_ < var_412_4 + var_412_9 + arg_412_0 then
				arg_409_1.typewritter.percent = 1

				arg_409_1.typewritter:SetDirty()
				arg_409_1:ShowNextGo(true)
			end
		end

		arg_409_1.nodeConfigList_ = {}

		arg_409_1:InitPlayNodeList()
	end,
	Play935011102 = function(arg_413_0, arg_413_1)
		arg_413_1.time_ = 0
		arg_413_1.frameCnt_ = 0
		arg_413_1.state_ = "playing"
		arg_413_1.curTalkId_ = 935011102
		arg_413_1.duration_ = 5

		SetActive(arg_413_1.tipsGo_, false)

		function arg_413_1.onSingleLineFinish_()
			arg_413_1.onSingleLineUpdate_ = nil
			arg_413_1.onSingleLineFinish_ = nil
			arg_413_1.state_ = "waiting"
		end

		function arg_413_1.playNext_(arg_415_0)
			if arg_415_0 == 1 then
				arg_413_0:Play935011103(arg_413_1)
			end
		end

		function arg_413_1.onSingleLineUpdate_(arg_416_0)
			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(arg_413_1.actors_["1070ui_story"]) and arg_413_1.var_.characterEffect1070ui_story == nil then
				arg_413_1.var_.characterEffect1070ui_story = arg_413_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_0 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_0 and not isNil(arg_413_1.actors_["1070ui_story"]) then
				if arg_413_1.var_.characterEffect1070ui_story and not isNil(arg_413_1.actors_["1070ui_story"]) then
					arg_413_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_413_1.time_ >= 0 + var_416_0 and arg_413_1.time_ < 0 + var_416_0 + arg_416_0 and not isNil(arg_413_1.actors_["1070ui_story"]) and arg_413_1.var_.characterEffect1070ui_story then
				arg_413_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_416_2 = arg_413_1.actors_["10039ui_story"]

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.characterEffect10039ui_story == nil then
				arg_413_1.var_.characterEffect10039ui_story = var_416_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_416_3 = 0.200000002980232

			if 0 <= arg_413_1.time_ and arg_413_1.time_ < 0 + var_416_3 and not isNil(var_416_2) then
				if arg_413_1.var_.characterEffect10039ui_story and not isNil(var_416_2) then
					arg_413_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_413_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_413_1.time_ - 0) / var_416_3)
				end
			end

			if arg_413_1.time_ >= 0 + var_416_3 and arg_413_1.time_ < 0 + var_416_3 + arg_416_0 and not isNil(var_416_2) and arg_413_1.var_.characterEffect10039ui_story then
				arg_413_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_413_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/story1070/story1070action/1070action7_2")
			end

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= 0 + arg_416_0 then
				arg_413_1:PlayTimeline("1070ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva", "EmotionTimelineAnimator")
			end

			local var_416_4 = 0
			local var_416_5 = 0.875

			if 0 < arg_413_1.time_ and arg_413_1.time_ <= var_416_4 + arg_416_0 then
				arg_413_1.talkMaxDuration = 0
				arg_413_1.dialogCg_.alpha = 1

				arg_413_1.dialog_:SetActive(true)
				SetActive(arg_413_1.leftNameGo_, true)

				arg_413_1.leftNameTxt_.text = arg_413_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_413_1.leftNameTxt_.transform)

				arg_413_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_413_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_413_1:RecordName(arg_413_1.leftNameTxt_.text)
				SetActive(arg_413_1.iconTrs_.gameObject, false)
				arg_413_1.callingController_:SetSelectedState("normal")

				local var_416_6 = arg_413_1:FormatText(arg_413_1:GetWordFromCfg(935011102).content)

				arg_413_1.text_.text = var_416_6

				LuaForUtil.ClearLinePrefixSymbol(arg_413_1.text_)

				local var_416_8 = 35 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_6) / 35)

				if (35 <= 0 and var_416_5 or var_416_5 * (utf8.len(var_416_6) / 35)) > 0 and var_416_5 < var_416_8 then
					arg_413_1.talkMaxDuration = var_416_8

					if var_416_8 + var_416_4 > arg_413_1.duration_ then
						arg_413_1.duration_ = var_416_8 + var_416_4
					end
				end

				arg_413_1.text_.text = var_416_6
				arg_413_1.typewritter.percent = 0

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(false)
				arg_413_1:RecordContent(arg_413_1.text_.text)
			end

			local var_416_9 = math.max(var_416_5, arg_413_1.talkMaxDuration)

			if var_416_4 <= arg_413_1.time_ and arg_413_1.time_ < var_416_4 + var_416_9 then
				arg_413_1.typewritter.percent = (arg_413_1.time_ - var_416_4) / var_416_9

				arg_413_1.typewritter:SetDirty()
			end

			if arg_413_1.time_ >= var_416_4 + var_416_9 and arg_413_1.time_ < var_416_4 + var_416_9 + arg_416_0 then
				arg_413_1.typewritter.percent = 1

				arg_413_1.typewritter:SetDirty()
				arg_413_1:ShowNextGo(true)
			end
		end

		arg_413_1.nodeConfigList_ = {}

		arg_413_1:InitPlayNodeList()
	end,
	Play935011103 = function(arg_417_0, arg_417_1)
		arg_417_1.time_ = 0
		arg_417_1.frameCnt_ = 0
		arg_417_1.state_ = "playing"
		arg_417_1.curTalkId_ = 935011103
		arg_417_1.duration_ = 5

		SetActive(arg_417_1.tipsGo_, false)

		function arg_417_1.onSingleLineFinish_()
			arg_417_1.onSingleLineUpdate_ = nil
			arg_417_1.onSingleLineFinish_ = nil
			arg_417_1.state_ = "waiting"
		end

		function arg_417_1.playNext_(arg_419_0)
			if arg_419_0 == 1 then
				arg_417_0:Play935011104(arg_417_1)
			end
		end

		function arg_417_1.onSingleLineUpdate_(arg_420_0)
			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 then
				arg_417_1.var_.moveOldPos10039ui_story = arg_417_1.actors_["10039ui_story"].transform.localPosition
			end

			local var_420_0 = 0.001

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_0 then
				arg_417_1.actors_["10039ui_story"].transform.localPosition = Vector3.Lerp(arg_417_1.var_.moveOldPos10039ui_story, Vector3.New(0, 100, 0), (arg_417_1.time_ - 0) / var_420_0)
				arg_417_1.actors_["10039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10039ui_story"].transform.position).z)
				arg_417_1.actors_["10039ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10039ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10039ui_story"].transform.localEulerAngles = arg_417_1.actors_["10039ui_story"].transform.localEulerAngles
			end

			if arg_417_1.time_ >= 0 + var_420_0 and arg_417_1.time_ < 0 + var_420_0 + arg_420_0 then
				arg_417_1.actors_["10039ui_story"].transform.localPosition = Vector3.New(0, 100, 0)
				arg_417_1.actors_["10039ui_story"].transform.forward = Vector3.New((manager.ui.mainCamera.transform.position - arg_417_1.actors_["10039ui_story"].transform.position).x, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10039ui_story"].transform.position).y, (manager.ui.mainCamera.transform.position - arg_417_1.actors_["10039ui_story"].transform.position).z)
				arg_417_1.actors_["10039ui_story"].transform.localEulerAngles.z = 0
				arg_417_1.actors_["10039ui_story"].transform.localEulerAngles.x = 0
				arg_417_1.actors_["10039ui_story"].transform.localEulerAngles = arg_417_1.actors_["10039ui_story"].transform.localEulerAngles
			end

			local var_420_1 = arg_417_1.actors_["10039ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10039ui_story == nil then
				arg_417_1.var_.characterEffect10039ui_story = var_420_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_2 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_2 and not isNil(var_420_1) then
				if arg_417_1.var_.characterEffect10039ui_story and not isNil(var_420_1) then
					arg_417_1.var_.characterEffect10039ui_story.fillFlat = false
				end
			end

			if arg_417_1.time_ >= 0 + var_420_2 and arg_417_1.time_ < 0 + var_420_2 + arg_420_0 and not isNil(var_420_1) and arg_417_1.var_.characterEffect10039ui_story then
				arg_417_1.var_.characterEffect10039ui_story.fillFlat = false
			end

			local var_420_4 = arg_417_1.actors_["1070ui_story"]

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= 0 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect1070ui_story == nil then
				arg_417_1.var_.characterEffect1070ui_story = var_420_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_420_5 = 0.200000002980232

			if 0 <= arg_417_1.time_ and arg_417_1.time_ < 0 + var_420_5 and not isNil(var_420_4) then
				if arg_417_1.var_.characterEffect1070ui_story and not isNil(var_420_4) then
					arg_417_1.var_.characterEffect1070ui_story.fillFlat = true
					arg_417_1.var_.characterEffect1070ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_417_1.time_ - 0) / var_420_5)
				end
			end

			if arg_417_1.time_ >= 0 + var_420_5 and arg_417_1.time_ < 0 + var_420_5 + arg_420_0 and not isNil(var_420_4) and arg_417_1.var_.characterEffect1070ui_story then
				arg_417_1.var_.characterEffect1070ui_story.fillFlat = true
				arg_417_1.var_.characterEffect1070ui_story.fillRatio = 0.5
			end

			local var_420_6 = 0
			local var_420_7 = 0.85

			if 0 < arg_417_1.time_ and arg_417_1.time_ <= var_420_6 + arg_420_0 then
				arg_417_1.talkMaxDuration = 0
				arg_417_1.dialogCg_.alpha = 1

				arg_417_1.dialog_:SetActive(true)
				SetActive(arg_417_1.leftNameGo_, true)

				arg_417_1.leftNameTxt_.text = arg_417_1:FormatText(StoryNameCfg[472].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_417_1.leftNameTxt_.transform)

				arg_417_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_417_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_417_1:RecordName(arg_417_1.leftNameTxt_.text)
				SetActive(arg_417_1.iconTrs_.gameObject, true)
				arg_417_1.iconController_:SetSelectedState("hero")

				arg_417_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10039")

				arg_417_1.callingController_:SetSelectedState("normal")

				arg_417_1.keyicon_.color = Color.New(1, 1, 1)
				arg_417_1.icon_.color = Color.New(1, 1, 1)

				local var_420_8 = arg_417_1:FormatText(arg_417_1:GetWordFromCfg(935011103).content)

				arg_417_1.text_.text = var_420_8

				LuaForUtil.ClearLinePrefixSymbol(arg_417_1.text_)

				local var_420_10 = 34 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_8) / 34)

				if (34 <= 0 and var_420_7 or var_420_7 * (utf8.len(var_420_8) / 34)) > 0 and var_420_7 < var_420_10 then
					arg_417_1.talkMaxDuration = var_420_10

					if var_420_10 + var_420_6 > arg_417_1.duration_ then
						arg_417_1.duration_ = var_420_10 + var_420_6
					end
				end

				arg_417_1.text_.text = var_420_8
				arg_417_1.typewritter.percent = 0

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(false)
				arg_417_1:RecordContent(arg_417_1.text_.text)
			end

			local var_420_11 = math.max(var_420_7, arg_417_1.talkMaxDuration)

			if var_420_6 <= arg_417_1.time_ and arg_417_1.time_ < var_420_6 + var_420_11 then
				arg_417_1.typewritter.percent = (arg_417_1.time_ - var_420_6) / var_420_11

				arg_417_1.typewritter:SetDirty()
			end

			if arg_417_1.time_ >= var_420_6 + var_420_11 and arg_417_1.time_ < var_420_6 + var_420_11 + arg_420_0 then
				arg_417_1.typewritter.percent = 1

				arg_417_1.typewritter:SetDirty()
				arg_417_1:ShowNextGo(true)
			end
		end

		arg_417_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "10039ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_417_1:InitPlayNodeList()
	end,
	Play935011104 = function(arg_421_0, arg_421_1)
		arg_421_1.time_ = 0
		arg_421_1.frameCnt_ = 0
		arg_421_1.state_ = "playing"
		arg_421_1.curTalkId_ = 935011104
		arg_421_1.duration_ = 5

		SetActive(arg_421_1.tipsGo_, false)

		function arg_421_1.onSingleLineFinish_()
			arg_421_1.onSingleLineUpdate_ = nil
			arg_421_1.onSingleLineFinish_ = nil
			arg_421_1.state_ = "waiting"
		end

		function arg_421_1.playNext_(arg_423_0)
			if arg_423_0 == 1 then
				arg_421_0:Play935011105(arg_421_1)
			end
		end

		function arg_421_1.onSingleLineUpdate_(arg_424_0)
			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(arg_421_1.actors_["1070ui_story"]) and arg_421_1.var_.characterEffect1070ui_story == nil then
				arg_421_1.var_.characterEffect1070ui_story = arg_421_1.actors_["1070ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_0 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_0 and not isNil(arg_421_1.actors_["1070ui_story"]) then
				if arg_421_1.var_.characterEffect1070ui_story and not isNil(arg_421_1.actors_["1070ui_story"]) then
					arg_421_1.var_.characterEffect1070ui_story.fillFlat = false
				end
			end

			if arg_421_1.time_ >= 0 + var_424_0 and arg_421_1.time_ < 0 + var_424_0 + arg_424_0 and not isNil(arg_421_1.actors_["1070ui_story"]) and arg_421_1.var_.characterEffect1070ui_story then
				arg_421_1.var_.characterEffect1070ui_story.fillFlat = false
			end

			local var_424_2 = arg_421_1.actors_["10039ui_story"]

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.characterEffect10039ui_story == nil then
				arg_421_1.var_.characterEffect10039ui_story = var_424_2:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_424_3 = 0.200000002980232

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_3 and not isNil(var_424_2) then
				if arg_421_1.var_.characterEffect10039ui_story and not isNil(var_424_2) then
					arg_421_1.var_.characterEffect10039ui_story.fillFlat = true
					arg_421_1.var_.characterEffect10039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (arg_421_1.time_ - 0) / var_424_3)
				end
			end

			if arg_421_1.time_ >= 0 + var_424_3 and arg_421_1.time_ < 0 + var_424_3 + arg_424_0 and not isNil(var_424_2) and arg_421_1.var_.characterEffect10039ui_story then
				arg_421_1.var_.characterEffect10039ui_story.fillFlat = true
				arg_421_1.var_.characterEffect10039ui_story.fillRatio = 0.5
			end

			local var_424_4 = arg_421_1.actors_["1070ui_story"].transform

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= 0 + arg_424_0 then
				arg_421_1.var_.moveOldPos1070ui_story = var_424_4.localPosition
			end

			local var_424_5 = 0.001

			if 0 <= arg_421_1.time_ and arg_421_1.time_ < 0 + var_424_5 then
				var_424_4.localPosition = Vector3.Lerp(arg_421_1.var_.moveOldPos1070ui_story, Vector3.New(0, 100, 0), (arg_421_1.time_ - 0) / var_424_5)
				var_424_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_4.position).x, (manager.ui.mainCamera.transform.position - var_424_4.position).y, (manager.ui.mainCamera.transform.position - var_424_4.position).z)
				var_424_4.localEulerAngles.z = 0
				var_424_4.localEulerAngles.x = 0
				var_424_4.localEulerAngles = var_424_4.localEulerAngles
			end

			if arg_421_1.time_ >= 0 + var_424_5 and arg_421_1.time_ < 0 + var_424_5 + arg_424_0 then
				var_424_4.localPosition = Vector3.New(0, 100, 0)
				var_424_4.forward = Vector3.New((manager.ui.mainCamera.transform.position - var_424_4.position).x, (manager.ui.mainCamera.transform.position - var_424_4.position).y, (manager.ui.mainCamera.transform.position - var_424_4.position).z)
				var_424_4.localEulerAngles.z = 0
				var_424_4.localEulerAngles.x = 0
				var_424_4.localEulerAngles = var_424_4.localEulerAngles
			end

			local var_424_6 = 0
			local var_424_7 = 0.4

			if 0 < arg_421_1.time_ and arg_421_1.time_ <= var_424_6 + arg_424_0 then
				arg_421_1.talkMaxDuration = 0
				arg_421_1.dialogCg_.alpha = 1

				arg_421_1.dialog_:SetActive(true)
				SetActive(arg_421_1.leftNameGo_, true)

				arg_421_1.leftNameTxt_.text = arg_421_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_421_1.leftNameTxt_.transform)

				arg_421_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_421_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_421_1:RecordName(arg_421_1.leftNameTxt_.text)
				SetActive(arg_421_1.iconTrs_.gameObject, true)
				arg_421_1.iconController_:SetSelectedState("hero")

				arg_421_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_2")

				arg_421_1.callingController_:SetSelectedState("normal")

				arg_421_1.keyicon_.color = Color.New(1, 1, 1)
				arg_421_1.icon_.color = Color.New(1, 1, 1)

				local var_424_8 = arg_421_1:FormatText(arg_421_1:GetWordFromCfg(935011104).content)

				arg_421_1.text_.text = var_424_8

				LuaForUtil.ClearLinePrefixSymbol(arg_421_1.text_)

				local var_424_10 = 16 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_8) / 16)

				if (16 <= 0 and var_424_7 or var_424_7 * (utf8.len(var_424_8) / 16)) > 0 and var_424_7 < var_424_10 then
					arg_421_1.talkMaxDuration = var_424_10

					if var_424_10 + var_424_6 > arg_421_1.duration_ then
						arg_421_1.duration_ = var_424_10 + var_424_6
					end
				end

				arg_421_1.text_.text = var_424_8
				arg_421_1.typewritter.percent = 0

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(false)
				arg_421_1:RecordContent(arg_421_1.text_.text)
			end

			local var_424_11 = math.max(var_424_7, arg_421_1.talkMaxDuration)

			if var_424_6 <= arg_421_1.time_ and arg_421_1.time_ < var_424_6 + var_424_11 then
				arg_421_1.typewritter.percent = (arg_421_1.time_ - var_424_6) / var_424_11

				arg_421_1.typewritter:SetDirty()
			end

			if arg_421_1.time_ >= var_424_6 + var_424_11 and arg_421_1.time_ < var_424_6 + var_424_11 + arg_424_0 then
				arg_421_1.typewritter.percent = 1

				arg_421_1.typewritter:SetDirty()
				arg_421_1:ShowNextGo(true)
			end
		end

		arg_421_1.nodeConfigList_ = {
			{
				assetPath = "",
				actorName = "1070ui_story",
				changeDisplayLayer = false,
				needEase = false,
				duration = 0.034000001847744,
				className = "StoryMoveNode",
				startTime = 0,
				actorType = StoryPlayerConst.ACTOR_TYPE.Tpose
			}
		}

		arg_421_1:InitPlayNodeList()
	end,
	Play935011105 = function(arg_425_0, arg_425_1)
		arg_425_1.time_ = 0
		arg_425_1.frameCnt_ = 0
		arg_425_1.state_ = "playing"
		arg_425_1.curTalkId_ = 935011105
		arg_425_1.duration_ = 5

		SetActive(arg_425_1.tipsGo_, false)

		function arg_425_1.onSingleLineFinish_()
			arg_425_1.onSingleLineUpdate_ = nil
			arg_425_1.onSingleLineFinish_ = nil
			arg_425_1.state_ = "waiting"
			arg_425_1.auto_ = false
		end

		function arg_425_1.playNext_(arg_427_0)
			arg_425_1.onStoryFinished_()
		end

		function arg_425_1.onSingleLineUpdate_(arg_428_0)
			local var_428_0 = 0.475

			if 0 < arg_425_1.time_ and arg_425_1.time_ <= 0 + arg_428_0 then
				arg_425_1.talkMaxDuration = 0
				arg_425_1.dialogCg_.alpha = 1

				arg_425_1.dialog_:SetActive(true)
				SetActive(arg_425_1.leftNameGo_, true)

				arg_425_1.leftNameTxt_.text = arg_425_1:FormatText(StoryNameCfg[318].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_425_1.leftNameTxt_.transform)

				arg_425_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_425_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_425_1:RecordName(arg_425_1.leftNameTxt_.text)
				SetActive(arg_425_1.iconTrs_.gameObject, true)
				arg_425_1.iconController_:SetSelectedState("hero")

				arg_425_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1070_split_1")

				arg_425_1.callingController_:SetSelectedState("normal")

				arg_425_1.keyicon_.color = Color.New(1, 1, 1)
				arg_425_1.icon_.color = Color.New(1, 1, 1)

				local var_428_1 = arg_425_1:FormatText(arg_425_1:GetWordFromCfg(935011105).content)

				arg_425_1.text_.text = var_428_1

				LuaForUtil.ClearLinePrefixSymbol(arg_425_1.text_)

				local var_428_3 = 19 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 19)

				if (19 <= 0 and var_428_0 or var_428_0 * (utf8.len(var_428_1) / 19)) > 0 and var_428_0 < var_428_3 then
					arg_425_1.talkMaxDuration = var_428_3

					if var_428_3 + 0 > arg_425_1.duration_ then
						arg_425_1.duration_ = var_428_3 + 0
					end
				end

				arg_425_1.text_.text = var_428_1
				arg_425_1.typewritter.percent = 0

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(false)
				arg_425_1:RecordContent(arg_425_1.text_.text)
			end

			local var_428_4 = math.max(var_428_0, arg_425_1.talkMaxDuration)

			if 0 <= arg_425_1.time_ and arg_425_1.time_ < 0 + var_428_4 then
				arg_425_1.typewritter.percent = (arg_425_1.time_ - 0) / var_428_4

				arg_425_1.typewritter:SetDirty()
			end

			if arg_425_1.time_ >= 0 + var_428_4 and arg_425_1.time_ < 0 + var_428_4 + arg_428_0 then
				arg_425_1.typewritter.percent = 1

				arg_425_1.typewritter:SetDirty()
				arg_425_1:ShowNextGo(true)
			end
		end

		arg_425_1.nodeConfigList_ = {}

		arg_425_1:InitPlayNodeList()
	end,
	assets = {
		"TextureConfig/Background/ST2003a",
		"TextureConfig/Background/ST2003"
	},
	voices = {}
}
